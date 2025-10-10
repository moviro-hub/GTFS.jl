"""
GTFS.jl - Validation module for GTFS Schedule data

This module provides comprehensive validation functions to ensure GTFS feeds
comply with the official GTFS Schedule specification.
"""

# DataFrames.DataFrames imported in main module

# Safe boolean helpers for handling missing and nothing values
function safe_in(value, collection)
    if ismissing(value)
        # Check if missing is in the collection by iterating
        return any(x -> ismissing(x), collection)
    elseif value === nothing
        return any(x -> x === nothing, collection)
    else
        result = value in collection
        return ismissing(result) ? false : result
    end
end

function safe_not_in(value, collection)
    return !safe_in(value, collection)
end

safe_any(collection) = any(x -> !ismissing(x) && x !== nothing && x, collection)
safe_all(collection) = all(x -> ismissing(x) || x === nothing || x, collection)
safe_equals(a, b) = (ismissing(a) || ismissing(b) || a === nothing || b === nothing) ? false : (a == b)
safe_not_equals(a, b) = (ismissing(a) || ismissing(b) || a === nothing || b === nothing) ? false : (a != b)
safe_greater(a, b) = (ismissing(a) || ismissing(b) || a === nothing || b === nothing) ? false : (a > b)

"""
    validate(gtfs::GTFSSchedule; max_errors_per_file::Int=100) -> ValidationResult

Perform comprehensive validation of a GTFS Schedule dataset.

# Arguments
- `gtfs::GTFSSchedule`: GTFS dataset to validate
- `max_errors_per_file::Int`: Maximum number of errors to report per file (default: 100)

# Returns
- `ValidationResult`: Detailed validation results with errors and errors

# Example
```julia
gtfs = read_gtfs("transit_feed.zip")
result = validate(gtfs)
if result.is_valid
    println("GTFS feed is valid!")
else
    println("Validation failed:")
    println(result)
end

# Limit errors per file
result = validate(gtfs; max_errors_per_file=50)
```
"""
function validate(gtfs::GTFSSchedule; max_errors_per_file::Int=100)
    errors = ValidationMessage[]

    # Run all validation checks
    append!(errors, validate_required_files(gtfs))
    append!(errors, validate_required_fields(gtfs))
    append!(errors, validate_conditional_requirements(gtfs; max_errors_per_file=max_errors_per_file))
    append!(errors, validate_field_types(gtfs))
    append!(errors, validate_foreign_keys(gtfs))
    append!(errors, validate_enums(gtfs))
    append!(errors, validate_data_consistency(gtfs))

    return ValidationResult(errors)
end

"""
    validate_required_files(gtfs::GTFSSchedule) -> Vector{ValidationMessage}

Validate that all required files are present and not empty.
"""
function validate_required_files(gtfs::GTFSSchedule)
    errors = ValidationMessage[]

    # Check required files
    required_files = [
        ("agency.txt", gtfs.agency),
        ("stops.txt", gtfs.stops),
        ("routes.txt", gtfs.routes),
        ("trips.txt", gtfs.trips),
        ("stop_times.txt", gtfs.stop_times)
    ]

    for (filename, df) in required_files
        if df === nothing
            push!(errors, ValidationMessage(filename, nothing, "Required file is missing", :error))
        elseif DataFrames.nrow(df) == 0
            push!(errors, ValidationMessage(filename, nothing, "Required file is empty", :error))
        end
    end

    # Check conditionally required files
    if safe_all([gtfs.calendar === nothing, gtfs.calendar_dates === nothing])
        push!(errors, ValidationMessage("calendar", nothing, "At least one of calendar.txt or calendar_dates.txt must be present", :error))
    end

    return errors
end

"""
    validate_required_fields(gtfs::GTFSSchedule) -> Vector{ValidationMessage}

Validate that all required fields are present in each file.
"""
function validate_required_fields(gtfs::GTFSSchedule)
    errors = ValidationMessage[]

    # Check required fields for each file
    for (filename, field_defs) in FIELD_DEFINITIONS
        df = _get_dataframe(gtfs, filename)
        if df === nothing
            continue  # Skip if file is not present
        end

        for (field_name, (_, presence, _)) in field_defs
            if presence == "Required" && safe_not_in(field_name, DataFrames.names(df))
                push!(errors, ValidationMessage(filename, field_name, "Required field is missing", :error))
            end
        end
    end

    return errors
end

"""
    validate_conditional_requirements(gtfs::GTFSSchedule; max_errors_per_file::Int=100) -> Vector{ValidationMessage}

Validate all conditional field requirements based on GTFS specification using declarative rules.
All violations generate errors as per GTFS specification requirements.
"""
function validate_conditional_requirements(gtfs::GTFSSchedule; max_errors_per_file::Int=100)
    errors = ValidationMessage[]

    # Run all conditional validation types
    append!(errors, validate_field_conditional_rules(gtfs, max_errors_per_file))
    append!(errors, validate_cross_file_conditional_rules(gtfs, max_errors_per_file))
    append!(errors, validate_file_level_conditional_rules(gtfs))
    append!(errors, validate_conditionally_forbidden(gtfs, max_errors_per_file))

    return errors
end

"""
    validate_field_conditional_rules(gtfs::GTFSSchedule, max_errors_per_file::Int=100) -> Vector{ValidationMessage}

Validate field-level conditional rules within single files.
"""
function validate_field_conditional_rules(gtfs::GTFSSchedule, max_errors_per_file::Int=100)
    errors = ValidationMessage[]
    error_counts = Dict{String, Int}()

    for (file, field, condition_type, condition_field, condition_values, message) in CONDITIONAL_FIELD_RULES
        df = _get_dataframe(gtfs, file)
        if df === nothing
            continue
        end

        # Check error limit for this file
        if get(error_counts, file, 0) >= max_errors_per_file
            continue
        end

        if condition_type == :required_when
            errors = _validate_required_when(df, file, field, condition_field, condition_values, message, errors, error_counts, max_errors_per_file)
        elseif condition_type == :forbidden_when
            errors = _validate_forbidden_when(df, file, field, condition_field, condition_values, message, errors, error_counts, max_errors_per_file)
        elseif condition_type == :at_least_one
            errors = _validate_at_least_one(df, file, field, message, errors, error_counts, max_errors_per_file)
        elseif condition_type == :required_when_multiple_records
            errors = _validate_required_when_multiple_records(df, file, field, message, errors, error_counts, max_errors_per_file)
        elseif condition_type == :required_when_multiple_agencies
            errors = _validate_required_when_multiple_agencies(gtfs, file, field, message, errors, error_counts, max_errors_per_file)
        end
    end

    return errors
end

"""
    validate_cross_file_conditional_rules(gtfs::GTFSSchedule, max_errors_per_file::Int=100) -> Vector{ValidationMessage}

Validate cross-file conditional rules where field presence depends on data in other files.
"""
function validate_cross_file_conditional_rules(gtfs::GTFSSchedule, max_errors_per_file::Int=100)
    errors = ValidationMessage[]
    error_counts = Dict{String, Int}()

    for (target_file, target_field, condition_file, condition_type, condition_field, message) in CROSS_FILE_CONDITIONAL_RULES
        target_df = _get_dataframe(gtfs, target_file)
        if target_df === nothing
            continue
        end

        # Check error limit for this file
        if get(error_counts, target_file, 0) >= max_errors_per_file
            continue
        end

        if condition_type == :required_when_multiple_records
            condition_df = _get_dataframe(gtfs, condition_file)
            if condition_df !== nothing && DataFrames.nrow(condition_df) > 1
                # Check if target field is missing or empty in target file when condition file has multiple records
                if safe_not_in(target_field, DataFrames.names(target_df))
                    push!(errors, ValidationMessage(target_file, target_field, message, :error))
                    error_counts[target_file] = get(error_counts, target_file, 0) + 1
                else
                    # Check if any rows have empty values for the required field
                    has_empty_values = false
                    for row in eachrow(target_df)
                        field_value = get(row, Symbol(target_field), nothing)
                        if ismissing(field_value) || field_value === nothing || field_value == ""
                            has_empty_values = true
                            break
                        end
                    end
                    if has_empty_values
                        push!(errors, ValidationMessage(target_file, target_field, message, :error))
                        error_counts[target_file] = get(error_counts, target_file, 0) + 1
                    end
                end
            end
        elseif condition_type == :required_when_field_present
            errors = _validate_required_when_field_present(gtfs, target_file, target_field, condition_file, condition_field, message, errors, error_counts, max_errors_per_file)
        elseif condition_type == :required_when_file_exists
            condition_df = _get_dataframe(gtfs, condition_file)
            if condition_df !== nothing
                errors = _validate_field_missing_in_file(target_df, target_file, target_field, message, errors, error_counts, max_errors_per_file)
            end
        end
    end

    return errors
end

"""
    validate_file_level_conditional_rules(gtfs::GTFSSchedule) -> Vector{ValidationMessage}

Validate file-level conditional rules where entire files are conditionally required.
"""
function validate_file_level_conditional_rules(gtfs::GTFSSchedule)
    errors = ValidationMessage[]

    for rule in FILE_LEVEL_CONDITIONAL_RULES
        if length(rule) == 4
            (files, condition_type, related_files, message) = rule
        else
            continue
        end

        if condition_type == :at_least_one
            # Check if at least one file exists
            files_exist = [_get_dataframe(gtfs, file) !== nothing for file in files]
            if !safe_any(files_exist)
                push!(errors, ValidationMessage(files[1], nothing, message, :error))
            end
        elseif condition_type == :required_if_exists
            # Check if required file exists when related files exist
            related_exists = all([_get_dataframe(gtfs, file) !== nothing for file in related_files])
            if related_exists && _get_dataframe(gtfs, files) === nothing
                push!(errors, ValidationMessage(files, nothing, message, :error))
            end
        elseif condition_type == :required_if_pathways_exist
            # Special case for levels.txt when pathways.txt exists and references level_id
            pathways_df = _get_dataframe(gtfs, "pathways.txt")
            if pathways_df !== nothing && safe_in("level_id", DataFrames.names(pathways_df))
                levels_df = _get_dataframe(gtfs, "levels.txt")
                if levels_df === nothing
                    push!(errors, ValidationMessage("levels.txt", nothing, message, :error))
                end
            end
        elseif condition_type == :required_if_referenced
            # Check if file is required when referenced in other files
            for related_file in related_files
                related_df = _get_dataframe(gtfs, related_file)
                if related_df !== nothing
                    # Check if the file is actually referenced
                    is_referenced = false
                    if files == "location_groups.txt"
                        # Check if stop_times.txt references location groups
                        if safe_in("location_group_id", DataFrames.names(related_df))
                            # Check if any rows actually have location_group_id values
                            for row in eachrow(related_df)
                                if haskey(row, :location_group_id) && !ismissing(row.location_group_id) && row.location_group_id !== nothing && row.location_group_id != ""
                                    is_referenced = true
                                    break
                                end
                            end
                        end
                    end

                    if is_referenced && _get_dataframe(gtfs, files) === nothing
                        push!(errors, ValidationMessage(files, nothing, message, :error))
                    end
                    break
                end
            end
        end
    end

    return errors
end

"""
    validate_conditionally_forbidden(gtfs::GTFSSchedule, max_errors_per_file::Int=100) -> Vector{ValidationMessage}

Validate conditionally forbidden rules where fields should not be present under certain conditions.
"""
function validate_conditionally_forbidden(gtfs::GTFSSchedule, max_errors_per_file::Int=100)
    errors = ValidationMessage[]
    error_counts = Dict{String, Int}()

    for (file, field, condition_type, condition_field, condition_values, message) in CONDITIONALLY_FORBIDDEN_RULES
        df = _get_dataframe(gtfs, file)
        if df === nothing
            continue
        end

        # Check error limit for this file
        if get(error_counts, file, 0) >= max_errors_per_file
            continue
        end

        if condition_type == :forbidden_when
            errors = _validate_forbidden_when(df, file, field, condition_field, condition_values, message, errors, error_counts, max_errors_per_file)
        elseif condition_type == :forbidden_when_conflicts
            errors = _validate_forbidden_when_conflicts(gtfs, file, field, condition_field, message, errors, error_counts, max_errors_per_file)
        end
    end

    return errors
end

"""
    validate_field_types(gtfs::GTFSSchedule) -> Vector{ValidationMessage}

Validate that field values conform to their specified types.
"""
function validate_field_types(gtfs::GTFSSchedule)
    errors = ValidationMessage[]

    for (filename, field_defs) in FIELD_DEFINITIONS
        df = _get_dataframe(gtfs, filename)
        if df === nothing
            continue
        end

        for (field_name, (field_type, _, _)) in field_defs
            if safe_not_in(field_name, DataFrames.names(df))
                continue
            end

            # Validate based on field type
            for (row_idx, row) in enumerate(eachrow(df))
                value = get(row, Symbol(field_name), missing)
                if ismissing(value) || value === nothing
                    continue  # Skip missing values (handled by required field validation)
                end

                error_msg = _validate_field_value(value, field_type, field_name)
                if error_msg !== nothing
                    push!(errors, ValidationMessage(filename, field_name, "Row $row_idx: $error_msg", :error))
                end
            end
        end
    end

    return errors
end

"""
    validate_foreign_keys(gtfs::GTFSSchedule) -> Vector{ValidationMessage}

Validate referential integrity between GTFS tables.
"""
function validate_foreign_keys(gtfs::GTFSSchedule)
    errors = ValidationMessage[]

    # Validate trips.route_id references routes.route_id
    if gtfs.trips !== nothing && gtfs.routes !== nothing
        valid_route_ids = Set(gtfs.routes.route_id)
        for row in eachrow(gtfs.trips)
            route_id = row.route_id
            if safe_not_in(route_id, valid_route_ids)
                push!(errors, ValidationMessage("trips.txt", "route_id", "References non-existent route_id: $route_id", :error))
            end
        end
    end

    # Validate stop_times.trip_id references trips.trip_id
    if gtfs.stop_times !== nothing && gtfs.trips !== nothing
        valid_trip_ids = Set(gtfs.trips.trip_id)
        for row in eachrow(gtfs.stop_times)
            trip_id = row.trip_id
            if safe_not_in(trip_id, valid_trip_ids)
                push!(errors, ValidationMessage("stop_times.txt", "trip_id", "References non-existent trip_id: $trip_id", :error))
            end
        end
    end

    # Validate stop_times.stop_id references stops.stop_id
    if gtfs.stop_times !== nothing && gtfs.stops !== nothing
        valid_stop_ids = Set(gtfs.stops.stop_id)
        for row in eachrow(gtfs.stop_times)
            stop_id = row.stop_id
            if safe_not_in(stop_id, valid_stop_ids)
                push!(errors, ValidationMessage("stop_times.txt", "stop_id", "References non-existent stop_id: $stop_id", :error))
            end
        end
    end

    # Validate stops.parent_station references stops.stop_id
    if gtfs.stops !== nothing
        valid_stop_ids = Set(gtfs.stops.stop_id)
        for row in eachrow(gtfs.stops)
            parent_station = get(row, :parent_station, nothing)
            # parent_station is optional and can be missing, nothing, or empty string
            if parent_station !== nothing && !ismissing(parent_station) && parent_station != "" && safe_not_in(parent_station, valid_stop_ids)
                push!(errors, ValidationMessage("stops.txt", "parent_station", "References non-existent stop_id: $parent_station", :error))
            end
        end
    end

    return errors
end

"""
    validate_enums(gtfs::GTFSSchedule) -> Vector{ValidationMessage}

Validate that enum fields contain only valid values.
"""
function validate_enums(gtfs::GTFSSchedule)
    errors = ValidationMessage[]

    for (filename, field_defs) in FIELD_DEFINITIONS
        df = _get_dataframe(gtfs, filename)
        if df === nothing
            continue
        end

        for (field_name, (field_type, _, _)) in field_defs
            if safe_not_in(field_name, DataFrames.names(df)) || safe_not_in(field_name, keys(ENUM_VALUES))
                continue
            end

            valid_values = ENUM_VALUES[field_name]
            for (row_idx, row) in enumerate(eachrow(df))
                value = get(row, Symbol(field_name), missing)
                if ismissing(value) || value === nothing
                    continue
                end

                if safe_not_in(value, valid_values)
                    push!(errors, ValidationMessage(filename, field_name, "Row $row_idx: Invalid enum value '$value'. Valid values: $valid_values", :error))
                end
            end
        end
    end

    return errors
end

"""
    validate_data_consistency(gtfs::GTFSSchedule) -> Vector{ValidationMessage}

Validate data consistency and business logic rules.
"""
function validate_data_consistency(gtfs::GTFSSchedule)
    errors = ValidationMessage[]

    # Validate that stop_sequence increases along each trip (but need not be consecutive)
    if gtfs.stop_times !== nothing
        # Group by trip_id for efficiency (avoid filtering 2.4M rows 99k times)
        grouped_stops = DataFrames.groupby(gtfs.stop_times, :trip_id)

        for trip_group in grouped_stops
            trip_id = trip_group.trip_id[1]  # All rows have same trip_id
            sort!(trip_group, :stop_sequence)

            actual_sequence = trip_group.stop_sequence

            # Check if any stop_sequence values are missing
            if safe_any(ismissing.(actual_sequence))
                push!(errors, ValidationMessage("stop_times.txt", "stop_sequence", "Trip $trip_id has missing stop_sequence values", :error))
            else
                # Check if sequences are strictly increasing (GTFS spec: must increase but need not be consecutive)
                for i in 2:length(actual_sequence)
                    if !ismissing(actual_sequence[i-1]) && !ismissing(actual_sequence[i]) && actual_sequence[i-1] >= actual_sequence[i]
                        push!(errors, ValidationMessage("stop_times.txt", "stop_sequence", "Trip $trip_id has non-increasing stop_sequence values", :error))
                        break  # Only report one error per trip
                    end
                end
            end
        end
    end

    # Validate that arrival_time <= departure_time for each stop
    if gtfs.stop_times !== nothing
        for (row_idx, row) in enumerate(eachrow(gtfs.stop_times))
            arrival_time = get(row, :arrival_time, nothing)
            departure_time = get(row, :departure_time, nothing)

            if arrival_time !== nothing && departure_time !== nothing &&
               !ismissing(arrival_time) && !ismissing(departure_time)
                # Compare times safely (handling missing values)
                if safe_greater(arrival_time, departure_time)
                    push!(errors, ValidationMessage("stop_times.txt", "arrival_time/departure_time", "Row $row_idx: arrival_time > departure_time", :error))
                end
            end
        end
    end

    return errors
end

# Helper functions

"""
    _get_dataframe(gtfs::GTFSSchedule, filename::String) -> Union{DataFrames.DataFrame, Nothing}

Get the DataFrames.DataFrame for a given filename from the GTFS struct.
"""
function _get_dataframe(gtfs::GTFSSchedule, filename::String)
    filename_map = Dict(
        "agency.txt" => gtfs.agency,
        "stops.txt" => gtfs.stops,
        "routes.txt" => gtfs.routes,
        "trips.txt" => gtfs.trips,
        "stop_times.txt" => gtfs.stop_times,
        "calendar.txt" => gtfs.calendar,
        "calendar_dates.txt" => gtfs.calendar_dates,
        "fare_attributes.txt" => gtfs.fare_attributes,
        "fare_rules.txt" => gtfs.fare_rules,
        "shapes.txt" => gtfs.shapes,
        "frequencies.txt" => gtfs.frequencies,
        "transfers.txt" => gtfs.transfers,
        "pathways.txt" => gtfs.pathways,
        "levels.txt" => gtfs.levels,
        "feed_info.txt" => gtfs.feed_info,
        "translations.txt" => gtfs.translations,
        "attributions.txt" => gtfs.attributions,
        # Fares v2 files
        "fare_media.txt" => gtfs.fare_media,
        "fare_products.txt" => gtfs.fare_products,
        "fare_leg_rules.txt" => gtfs.fare_leg_rules,
        "fare_leg_join_rules.txt" => gtfs.fare_leg_join_rules,
        "fare_transfer_rules.txt" => gtfs.fare_transfer_rules,
        "timeframes.txt" => gtfs.timeframes,
        "rider_categories.txt" => gtfs.rider_categories,
        # Additional optional files
        "areas.txt" => gtfs.areas,
        "stop_areas.txt" => gtfs.stop_areas,
        "networks.txt" => gtfs.networks,
        "route_networks.txt" => gtfs.route_networks,
        "location_groups.txt" => gtfs.location_groups,
        "location_group_stops.txt" => gtfs.location_group_stops,
        "locations.geojson" => gtfs.locations_geojson,
        "booking_rules.txt" => gtfs.booking_rules
    )

    return get(filename_map, filename, nothing)
end

"""
    _validate_field_value(value, field_type::String, field_name::String) -> Union{String, Nothing}

Validate a single field value against its type specification.
Returns error message if invalid, nothing if valid.
"""
function _validate_field_value(value, field_type::String, field_name::String)
    if field_type == "Color"
        if !occursin(TYPE_PATTERNS["Color"], string(value))
            return "Invalid color format. Must be 6-digit hexadecimal (e.g., 'FFFFFF')"
        end
    elseif field_type == "Date"
        if !occursin(TYPE_PATTERNS["Date"], string(value))
            return "Invalid date format. Must be YYYYMMDD"
        end
    elseif field_type == "Time"
        if !occursin(TYPE_PATTERNS["Time"], string(value))
            return "Invalid time format. Must be HH:MM:SS"
        end
    elseif field_type == "Email"
        if !occursin(TYPE_PATTERNS["Email"], string(value))
            return "Invalid email format"
        end
    elseif field_type == "URL"
        if !occursin(TYPE_PATTERNS["URL"], string(value))
            return "Invalid URL format"
        end
    elseif field_type == "Latitude"
        if !occursin(TYPE_PATTERNS["Latitude"], string(value))
            return "Invalid latitude. Must be between -90 and 90"
        end
    elseif field_type == "Longitude"
        if !occursin(TYPE_PATTERNS["Longitude"], string(value))
            return "Invalid longitude. Must be between -180 and 180"
        end
    elseif field_type == "Non-negative integer"
        try
            int_val = parse(Int, string(value))
            if int_val < 0
                return "Must be non-negative integer"
            end
        catch
            return "Must be a valid integer"
        end
    elseif field_type == "Non-negative float"
        try
            float_val = parse(Float64, string(value))
            if float_val < 0
                return "Must be non-negative float"
            end
        catch
            return "Must be a valid float"
        end
    end

    return nothing
end

# Helper functions for conditional validation

"""
    _validate_required_when(df, file, field, condition_field, condition_values, message, errors, error_counts, max_errors_per_file)

Helper function to validate required_when conditions.
"""
function _validate_required_when(df, file, field, condition_field, condition_values, message, errors, error_counts, max_errors_per_file)
    if get(error_counts, file, 0) >= max_errors_per_file
        return errors
    end

    # Check if the condition field exists in the DataFrame
    if !safe_in(condition_field, DataFrames.names(df))
        return errors  # Skip validation if condition field doesn't exist
    end

    for (row_idx, row) in enumerate(eachrow(df))
        if get(error_counts, file, 0) >= max_errors_per_file
            break
        end

        condition_value = get(row, Symbol(condition_field), nothing)
        # Handle missing values properly
        condition_matches = if ismissing(condition_value)
            safe_in(missing, condition_values)
        else
            safe_in(condition_value, condition_values)
        end

        if condition_matches
            field_value = get(row, Symbol(field), missing)
            if ismissing(field_value) || field_value === nothing
                push!(errors, ValidationMessage(file, field, "$message (row $row_idx)", :error))
                error_counts[file] = get(error_counts, file, 0) + 1
            end
        end
    end

    return errors
end

"""
    _validate_forbidden_when(df, file, field, condition_field, condition_values, message, errors, error_counts, max_errors_per_file)

Helper function to validate forbidden_when conditions.
"""
function _validate_forbidden_when(df, file, field, condition_field, condition_values, message, errors, error_counts, max_errors_per_file)
    if get(error_counts, file, 0) >= max_errors_per_file
        return errors
    end

    # Check if the condition field exists in the DataFrame
    if !safe_in(condition_field, DataFrames.names(df))
        return errors  # Skip validation if condition field doesn't exist
    end

    for (row_idx, row) in enumerate(eachrow(df))
        if get(error_counts, file, 0) >= max_errors_per_file
            break
        end

        condition_value = get(row, Symbol(condition_field), nothing)
        # Handle missing values properly
        condition_matches = if ismissing(condition_value)
            safe_in(missing, condition_values)
        else
            safe_in(condition_value, condition_values)
        end

        if condition_matches
            field_value = get(row, Symbol(field), missing)
            if !ismissing(field_value) && field_value !== nothing
                push!(errors, ValidationMessage(file, field, "$message (row $row_idx)", :error))
                error_counts[file] = get(error_counts, file, 0) + 1
            end
        end
    end

    return errors
end

"""
    _validate_at_least_one(df, file, fields, message, errors, error_counts, max_errors_per_file)

Helper function to validate at_least_one conditions.
"""
function _validate_at_least_one(df, file, fields, message, errors, error_counts, max_errors_per_file)
    if get(error_counts, file, 0) >= max_errors_per_file
        return errors
    end

    for (row_idx, row) in enumerate(eachrow(df))
        if get(error_counts, file, 0) >= max_errors_per_file
            break
        end

        all_missing = true
        for field in fields
            field_value = get(row, Symbol(field), missing)
            if !ismissing(field_value) && field_value !== nothing
                all_missing = false
                break
            end
        end

        if all_missing === true
            field_names = isa(fields, Vector) ? join(fields, "/") : string(fields)
            push!(errors, ValidationMessage(file, field_names, "$message (row $row_idx)", :error))
            error_counts[file] = get(error_counts, file, 0) + 1
        end
    end

    return errors
end

"""
    _validate_required_when_multiple_records(df, file, field, message, errors, error_counts, max_errors_per_file)

Helper function to validate required_when_multiple_records conditions.
"""
function _validate_required_when_multiple_records(df, file, field, message, errors, error_counts, max_errors_per_file)
    if DataFrames.nrow(df) > 1
        if safe_not_in(field, DataFrames.names(df))
            push!(errors, ValidationMessage(file, field, message, :error))
            error_counts[file] = get(error_counts, file, 0) + 1
        end
    end

    return errors
end

"""
    _validate_required_when_multiple_agencies(gtfs, file, field, message, errors, error_counts, max_errors_per_file)

Helper function to validate required_when_multiple_agencies conditions.
"""
function _validate_required_when_multiple_agencies(gtfs, file, field, message, errors, error_counts, max_errors_per_file)
    if gtfs.agency !== nothing && DataFrames.nrow(gtfs.agency) > 1
        df = _get_dataframe(gtfs, file)
        if df !== nothing && safe_not_in(field, DataFrames.names(df))
            push!(errors, ValidationMessage(file, field, message, :error))
            error_counts[file] = get(error_counts, file, 0) + 1
        end
    end

    return errors
end

"""
    _validate_field_missing_in_file(df, file, field, message, errors, error_counts, max_errors_per_file)

Helper function to validate when a field is missing in a file.
"""
function _validate_field_missing_in_file(df, file, field, message, errors, error_counts, max_errors_per_file)
    if safe_not_in(field, DataFrames.names(df))
        push!(errors, ValidationMessage(file, field, message, :error))
        error_counts[file] = get(error_counts, file, 0) + 1
    end

    return errors
end

"""
    _validate_required_when_field_present(gtfs, target_file, target_field, condition_file, condition_field, message, errors, error_counts, max_errors_per_file)

Helper function to validate when a field is required based on another file's field presence.
"""
function _validate_required_when_field_present(gtfs, target_file, target_field, condition_file, condition_field, message, errors, error_counts, max_errors_per_file)
    condition_df = _get_dataframe(gtfs, condition_file)
    if condition_df === nothing
        return errors
    end

    if safe_in(condition_field, DataFrames.names(condition_df))
        # Check if any rows actually have non-empty values for the condition field
        has_non_empty_values = false
        for row in eachrow(condition_df)
            field_value = get(row, Symbol(condition_field), nothing)
            if !ismissing(field_value) && field_value !== nothing && field_value != ""
                has_non_empty_values = true
                break
            end
        end

        # Only require the target field if the condition field has actual values
        if has_non_empty_values
            target_df = _get_dataframe(gtfs, target_file)
            if target_df !== nothing
                errors = _validate_field_missing_in_file(target_df, target_file, target_field, message, errors, error_counts, max_errors_per_file)
            end
        end
    end

    return errors
end

"""
    _validate_forbidden_when_conflicts(gtfs, file, field, condition_field, message, errors, error_counts, max_errors_per_file)

Helper function to validate forbidden_when_conflicts conditions.
"""
function _validate_forbidden_when_conflicts(gtfs, file, field, condition_field, message, errors, error_counts, max_errors_per_file)
    # Check for actual conflicts between files
    df = _get_dataframe(gtfs, file)
    if df === nothing
        return errors
    end

    # Check if the field exists in the target file
    if safe_in(field, DataFrames.names(df))
        # Check if the field also exists in the condition file (routes.txt)
        condition_df = _get_dataframe(gtfs, "routes.txt")
        if condition_df !== nothing && safe_in(condition_field, DataFrames.names(condition_df))
            # Only warn if both files have the field (actual conflict)
            push!(errors, ValidationMessage(file, field, message, :error))
            error_counts[file] = get(error_counts, file, 0) + 1
        end
    end

    return errors
end
