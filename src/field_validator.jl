# Auto-generated file - Field presence validation functions
# Generated from GTFS specification parsing

"""
Field Presence Validation Functions

This module provides validation functions for GTFS field presence requirements.
Validates fields based on GTFS specification requirements:
- Required fields: Must have no missing values
- Conditionally required fields: Must have no missing values when conditions are met
- Conditionally forbidden fields: Must be empty when conditions are met
- Optional fields: No validation required

Usage:
    result = validate_field_presence(gtfs)
    if result.is_valid
        println("All field requirements satisfied")
    else
        for msg in result.messages
            if msg.severity == :error
                println("ERROR: ", msg.message)
            end
        end
    end
"""

"""
    validate_field_presence(gtfs::GTFSSchedule)

Comprehensive field presence validation for GTFS feed.
Validates all fields based on GTFS specification requirements including:
- Required fields (must have no missing values)
- Conditionally required fields (must have no missing values when conditions are met)
- Conditionally forbidden fields (must be empty when conditions are met)
- Optional fields (no validation)

Returns ValidationResult with all validation messages.
"""
function validate_field_presence(gtfs::GTFSSchedule)
    messages = ValidationMessage[]

    # Validate fields in stops.txt
    append!(messages, validate_fields_stops(gtfs))

    # Validate fields in routes.txt
    append!(messages, validate_fields_routes(gtfs))

    # Validate fields in stop_times.txt
    append!(messages, validate_fields_stop_times(gtfs))

    # Validate fields in timeframes.txt
    append!(messages, validate_fields_timeframes(gtfs))

    # Validate fields in fare_leg_join_rules.txt
    append!(messages, validate_fields_fare_leg_join_rules(gtfs))

    # Validate fields in fare_transfer_rules.txt
    append!(messages, validate_fields_fare_transfer_rules(gtfs))

    # Validate fields in transfers.txt
    append!(messages, validate_fields_transfers(gtfs))

    # Validate fields in booking_rules.txt
    append!(messages, validate_fields_booking_rules(gtfs))

    # Validate fields in translations.txt
    append!(messages, validate_fields_translations(gtfs))

    # Determine overall validity
    error_count = count(msg -> msg.severity == :error, messages)
    warning_count = count(msg -> msg.severity == :warning, messages)
    is_valid = error_count == 0

    # Generate summary
    summary = "Field presence validation: $(error_count) errors, $(warning_count) warnings"
    if is_valid
        summary *= " - All field presence requirements satisfied"
    else
        summary *= " - Field presence validation failed"
    end

    return ValidationResult(is_valid, messages, summary)
end

# File-level field validation functions

"""
    validate_fields_stops(gtfs::GTFSSchedule)

Validate all fields in stops.txt based on GTFS specification requirements.
Returns Vector{ValidationMessage} with validation results for all fields.
"""
function validate_fields_stops(gtfs::GTFSSchedule)
    messages = ValidationMessage[]

    push!(messages, validate_field_stops_stop_name(gtfs))
    push!(messages, validate_field_stops_stop_name(gtfs))
    push!(messages, validate_field_stops_stop_lat(gtfs))
    push!(messages, validate_field_stops_stop_lat(gtfs))
    push!(messages, validate_field_stops_stop_lon(gtfs))
    push!(messages, validate_field_stops_stop_lon(gtfs))
    push!(messages, validate_field_stops_parent_station(gtfs))
    push!(messages, validate_field_stops_parent_station(gtfs))
    push!(messages, validate_field_stops_parent_station(gtfs))
    push!(messages, validate_field_stops_stop_access(gtfs))
    push!(messages, validate_field_stops_stop_access(gtfs))

    return messages
end

"""
    validate_fields_routes(gtfs::GTFSSchedule)

Validate all fields in routes.txt based on GTFS specification requirements.
Returns Vector{ValidationMessage} with validation results for all fields.
"""
function validate_fields_routes(gtfs::GTFSSchedule)
    messages = ValidationMessage[]

    push!(messages, validate_field_routes_route_short_name(gtfs))
    push!(messages, validate_field_routes_route_long_name(gtfs))
    push!(messages, validate_field_routes_continuous_pickup(gtfs))
    push!(messages, validate_field_routes_continuous_drop_off(gtfs))

    return messages
end

"""
    validate_fields_stop_times(gtfs::GTFSSchedule)

Validate all fields in stop_times.txt based on GTFS specification requirements.
Returns Vector{ValidationMessage} with validation results for all fields.
"""
function validate_fields_stop_times(gtfs::GTFSSchedule)
    messages = ValidationMessage[]

    push!(messages, validate_field_stop_times_arrival_time(gtfs))
    push!(messages, validate_field_stop_times_arrival_time(gtfs))
    push!(messages, validate_field_stop_times_arrival_time(gtfs))
    push!(messages, validate_field_stop_times_departure_time(gtfs))
    push!(messages, validate_field_stop_times_departure_time(gtfs))
    push!(messages, validate_field_stop_times_stop_id(gtfs))
    push!(messages, validate_field_stop_times_stop_id(gtfs))
    push!(messages, validate_field_stop_times_location_group_id(gtfs))
    push!(messages, validate_field_stop_times_location_id(gtfs))
    push!(messages, validate_field_stop_times_start_pickup_drop_off_window(gtfs))
    push!(messages, validate_field_stop_times_start_pickup_drop_off_window(gtfs))
    push!(messages, validate_field_stop_times_start_pickup_drop_off_window(gtfs))
    push!(messages, validate_field_stop_times_end_pickup_drop_off_window(gtfs))
    push!(messages, validate_field_stop_times_end_pickup_drop_off_window(gtfs))
    push!(messages, validate_field_stop_times_end_pickup_drop_off_window(gtfs))
    push!(messages, validate_field_stop_times_pickup_type(gtfs))
    push!(messages, validate_field_stop_times_pickup_type(gtfs))
    push!(messages, validate_field_stop_times_drop_off_type(gtfs))
    push!(messages, validate_field_stop_times_continuous_pickup(gtfs))
    push!(messages, validate_field_stop_times_continuous_drop_off(gtfs))

    return messages
end

"""
    validate_fields_timeframes(gtfs::GTFSSchedule)

Validate all fields in timeframes.txt based on GTFS specification requirements.
Returns Vector{ValidationMessage} with validation results for all fields.
"""
function validate_fields_timeframes(gtfs::GTFSSchedule)
    messages = ValidationMessage[]

    push!(messages, validate_field_timeframes_start_time(gtfs))
    push!(messages, validate_field_timeframes_end_time(gtfs))

    return messages
end

"""
    validate_fields_fare_leg_join_rules(gtfs::GTFSSchedule)

Validate all fields in fare_leg_join_rules.txt based on GTFS specification requirements.
Returns Vector{ValidationMessage} with validation results for all fields.
"""
function validate_fields_fare_leg_join_rules(gtfs::GTFSSchedule)
    messages = ValidationMessage[]

    push!(messages, validate_field_fare_leg_join_rules_from_stop_id(gtfs))
    push!(messages, validate_field_fare_leg_join_rules_to_stop_id(gtfs))

    return messages
end

"""
    validate_fields_fare_transfer_rules(gtfs::GTFSSchedule)

Validate all fields in fare_transfer_rules.txt based on GTFS specification requirements.
Returns Vector{ValidationMessage} with validation results for all fields.
"""
function validate_fields_fare_transfer_rules(gtfs::GTFSSchedule)
    messages = ValidationMessage[]

    push!(messages, validate_field_fare_transfer_rules_transfer_count(gtfs))
    push!(messages, validate_field_fare_transfer_rules_transfer_count(gtfs))
    push!(messages, validate_field_fare_transfer_rules_duration_limit_type(gtfs))
    push!(messages, validate_field_fare_transfer_rules_duration_limit_type(gtfs))

    return messages
end

"""
    validate_fields_transfers(gtfs::GTFSSchedule)

Validate all fields in transfers.txt based on GTFS specification requirements.
Returns Vector{ValidationMessage} with validation results for all fields.
"""
function validate_fields_transfers(gtfs::GTFSSchedule)
    messages = ValidationMessage[]

    push!(messages, validate_field_transfers_from_stop_id(gtfs))
    push!(messages, validate_field_transfers_from_stop_id(gtfs))
    push!(messages, validate_field_transfers_to_stop_id(gtfs))
    push!(messages, validate_field_transfers_to_stop_id(gtfs))
    push!(messages, validate_field_transfers_from_trip_id(gtfs))
    push!(messages, validate_field_transfers_to_trip_id(gtfs))

    return messages
end

"""
    validate_fields_booking_rules(gtfs::GTFSSchedule)

Validate all fields in booking_rules.txt based on GTFS specification requirements.
Returns Vector{ValidationMessage} with validation results for all fields.
"""
function validate_fields_booking_rules(gtfs::GTFSSchedule)
    messages = ValidationMessage[]

    push!(messages, validate_field_booking_rules_prior_notice_duration_min(gtfs))
    push!(messages, validate_field_booking_rules_prior_notice_duration_max(gtfs))
    push!(messages, validate_field_booking_rules_prior_notice_duration_max(gtfs))
    push!(messages, validate_field_booking_rules_prior_notice_last_day(gtfs))
    push!(messages, validate_field_booking_rules_prior_notice_last_time(gtfs))
    push!(messages, validate_field_booking_rules_prior_notice_start_day(gtfs))
    push!(messages, validate_field_booking_rules_prior_notice_start_day(gtfs))
    push!(messages, validate_field_booking_rules_prior_notice_start_time(gtfs))
    push!(messages, validate_field_booking_rules_prior_notice_service_id(gtfs))

    return messages
end

"""
    validate_fields_translations(gtfs::GTFSSchedule)

Validate all fields in translations.txt based on GTFS specification requirements.
Returns Vector{ValidationMessage} with validation results for all fields.
"""
function validate_fields_translations(gtfs::GTFSSchedule)
    messages = ValidationMessage[]

    push!(messages, validate_field_translations_record_id(gtfs))
    push!(messages, validate_field_translations_record_id(gtfs))
    push!(messages, validate_field_translations_record_id(gtfs))
    push!(messages, validate_field_translations_record_sub_id(gtfs))
    push!(messages, validate_field_translations_record_sub_id(gtfs))
    push!(messages, validate_field_translations_record_sub_id(gtfs))
    push!(messages, validate_field_translations_field_value(gtfs))
    push!(messages, validate_field_translations_field_value(gtfs))
    push!(messages, validate_field_translations_field_value(gtfs))

    return messages
end

# Individual field validation functions

"""
    validate_field_stops_stop_name(gtfs::GTFSSchedule)

Validate presence of field 'stop_name' in stops.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_stops_stop_name(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_name"
    file_field = :stops

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return ValidationMessage(filename, field_name, "File 'stops.txt' does not exist, cannot validate field 'stop_name'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_name)
        return ValidationMessage(filename, field_name, "Field 'stop_name' does not exist in file 'stops.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stops.stop_name

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "0", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "1", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: required when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "2", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'stop_name' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'stop_name' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'stop_name' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stops_stop_lat(gtfs::GTFSSchedule)

Validate presence of field 'stop_lat' in stops.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_stops_stop_lat(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_lat"
    file_field = :stops

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return ValidationMessage(filename, field_name, "File 'stops.txt' does not exist, cannot validate field 'stop_lat'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_lat)
        return ValidationMessage(filename, field_name, "Field 'stop_lat' does not exist in file 'stops.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stops.stop_lat

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "0", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "1", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: required when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "2", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'stop_lat' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'stop_lat' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'stop_lat' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stops_stop_lon(gtfs::GTFSSchedule)

Validate presence of field 'stop_lon' in stops.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_stops_stop_lon(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_lon"
    file_field = :stops

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return ValidationMessage(filename, field_name, "File 'stops.txt' does not exist, cannot validate field 'stop_lon'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_lon)
        return ValidationMessage(filename, field_name, "Field 'stop_lon' does not exist in file 'stops.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stops.stop_lon

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "0", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "1", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: required when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "2", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'stop_lon' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'stop_lon' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'stop_lon' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stops_parent_station(gtfs::GTFSSchedule)

Validate presence of field 'parent_station' in stops.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_stops_parent_station(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "parent_station"
    file_field = :stops

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return ValidationMessage(filename, field_name, "File 'stops.txt' does not exist, cannot validate field 'parent_station'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :parent_station)
        return ValidationMessage(filename, field_name, "Field 'parent_station' does not exist in file 'stops.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stops.parent_station

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "2", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "3", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: required when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "4", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'parent_station' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'parent_station' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'parent_station' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stops_stop_access(gtfs::GTFSSchedule)

Validate presence of field 'stop_access' in stops.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_stops_stop_access(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_access"
    file_field = :stops

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return ValidationMessage(filename, field_name, "File 'stops.txt' does not exist, cannot validate field 'stop_access'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_access)
        return ValidationMessage(filename, field_name, "Field 'stop_access' does not exist in file 'stops.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stops.stop_access

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "1", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: forbidden when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "2", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: forbidden when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "3", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    # Condition 4: forbidden when conditions met
    if hasproperty(gtfs, :stops) && gtfs.stops !== nothing && hasproperty(gtfs.stops, :location_type) && any(row -> !ismissing(row.location_type) && row.location_type == "4", eachrow(gtfs.stops))
        conditions_met = true
        push!(condition_descriptions, "Condition 4 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'stop_access' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'stop_access' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'stop_access' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_routes_route_short_name(gtfs::GTFSSchedule)

Validate presence of field 'route_short_name' in routes.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_routes_route_short_name(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "route_short_name"
    file_field = :routes

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return ValidationMessage(filename, field_name, "File 'routes.txt' does not exist, cannot validate field 'route_short_name'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :route_short_name)
        return ValidationMessage(filename, field_name, "Field 'route_short_name' does not exist in file 'routes.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.routes.route_short_name

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :routes) && gtfs.routes !== nothing && hasproperty(gtfs.routes, :route_long_name) && any(row -> !ismissing(row.route_long_name) && row.route_long_name == "defined", eachrow(gtfs.routes))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'route_short_name' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'route_short_name' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'route_short_name' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_routes_route_long_name(gtfs::GTFSSchedule)

Validate presence of field 'route_long_name' in routes.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_routes_route_long_name(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "route_long_name"
    file_field = :routes

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return ValidationMessage(filename, field_name, "File 'routes.txt' does not exist, cannot validate field 'route_long_name'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :route_long_name)
        return ValidationMessage(filename, field_name, "Field 'route_long_name' does not exist in file 'routes.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.routes.route_long_name

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :routes) && gtfs.routes !== nothing && hasproperty(gtfs.routes, :route_short_name) && any(row -> !ismissing(row.route_short_name) && row.route_short_name == "defined", eachrow(gtfs.routes))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'route_long_name' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'route_long_name' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'route_long_name' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_routes_continuous_pickup(gtfs::GTFSSchedule)

Validate presence of field 'continuous_pickup' in routes.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_routes_continuous_pickup(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "continuous_pickup"
    file_field = :routes

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return ValidationMessage(filename, field_name, "File 'routes.txt' does not exist, cannot validate field 'continuous_pickup'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :continuous_pickup)
        return ValidationMessage(filename, field_name, "Field 'continuous_pickup' does not exist in file 'routes.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.routes.continuous_pickup

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :routes) && gtfs.routes !== nothing && hasproperty(gtfs.routes, :_1) && any(row -> !ismissing(row._1) && row._1 == "1", eachrow(gtfs.routes))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :start_pickup_drop_off_window) && any(row -> !ismissing(row.start_pickup_drop_off_window) && row.start_pickup_drop_off_window == "1", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :end_pickup_drop_off_window) && any(row -> !ismissing(row.end_pickup_drop_off_window) && row.end_pickup_drop_off_window == "1", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'continuous_pickup' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'continuous_pickup' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'continuous_pickup' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_routes_continuous_drop_off(gtfs::GTFSSchedule)

Validate presence of field 'continuous_drop_off' in routes.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_routes_continuous_drop_off(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "continuous_drop_off"
    file_field = :routes

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return ValidationMessage(filename, field_name, "File 'routes.txt' does not exist, cannot validate field 'continuous_drop_off'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :continuous_drop_off)
        return ValidationMessage(filename, field_name, "Field 'continuous_drop_off' does not exist in file 'routes.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.routes.continuous_drop_off

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :routes) && gtfs.routes !== nothing && hasproperty(gtfs.routes, :_1) && any(row -> !ismissing(row._1) && row._1 == "1", eachrow(gtfs.routes))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :start_pickup_drop_off_window) && any(row -> !ismissing(row.start_pickup_drop_off_window) && row.start_pickup_drop_off_window == "1", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :end_pickup_drop_off_window) && any(row -> !ismissing(row.end_pickup_drop_off_window) && row.end_pickup_drop_off_window == "1", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'continuous_drop_off' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'continuous_drop_off' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'continuous_drop_off' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stop_times_arrival_time(gtfs::GTFSSchedule)

Validate presence of field 'arrival_time' in stop_times.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_stop_times_arrival_time(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "arrival_time"
    file_field = :stop_times

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return ValidationMessage(filename, field_name, "File 'stop_times.txt' does not exist, cannot validate field 'arrival_time'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :arrival_time)
        return ValidationMessage(filename, field_name, "Field 'arrival_time' does not exist in file 'stop_times.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stop_times.arrival_time

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :stop_sequence) && any(row -> !ismissing(row.stop_sequence) && row.stop_sequence == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'arrival_time' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'arrival_time' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'arrival_time' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stop_times_departure_time(gtfs::GTFSSchedule)

Validate presence of field 'departure_time' in stop_times.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_stop_times_departure_time(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "departure_time"
    file_field = :stop_times

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return ValidationMessage(filename, field_name, "File 'stop_times.txt' does not exist, cannot validate field 'departure_time'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :departure_time)
        return ValidationMessage(filename, field_name, "Field 'departure_time' does not exist in file 'stop_times.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stop_times.departure_time

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :timepoint) && any(row -> !ismissing(row.timepoint) && row.timepoint == "1", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'departure_time' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'departure_time' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'departure_time' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stop_times_stop_id(gtfs::GTFSSchedule)

Validate presence of field 'stop_id' in stop_times.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_stop_times_stop_id(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "stop_id"
    file_field = :stop_times

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return ValidationMessage(filename, field_name, "File 'stop_times.txt' does not exist, cannot validate field 'stop_id'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :stop_id)
        return ValidationMessage(filename, field_name, "Field 'stop_id' does not exist in file 'stop_times.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stop_times.stop_id

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :location_group_id) && any(row -> !ismissing(row.location_group_id) && row.location_group_id == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :location_id) && any(row -> !ismissing(row.location_id) && row.location_id == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'stop_id' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'stop_id' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'stop_id' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stop_times_location_group_id(gtfs::GTFSSchedule)

Validate presence of field 'location_group_id' in stop_times.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_stop_times_location_group_id(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "location_group_id"
    file_field = :stop_times

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return ValidationMessage(filename, field_name, "File 'stop_times.txt' does not exist, cannot validate field 'location_group_id'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :location_group_id)
        return ValidationMessage(filename, field_name, "Field 'location_group_id' does not exist in file 'stop_times.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stop_times.location_group_id

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :stop_id) && any(row -> !ismissing(row.stop_id) && row.stop_id == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :location_id) && any(row -> !ismissing(row.location_id) && row.location_id == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'location_group_id' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'location_group_id' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'location_group_id' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stop_times_location_id(gtfs::GTFSSchedule)

Validate presence of field 'location_id' in stop_times.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_stop_times_location_id(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "location_id"
    file_field = :stop_times

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return ValidationMessage(filename, field_name, "File 'stop_times.txt' does not exist, cannot validate field 'location_id'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :location_id)
        return ValidationMessage(filename, field_name, "Field 'location_id' does not exist in file 'stop_times.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stop_times.location_id

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :stop_id) && any(row -> !ismissing(row.stop_id) && row.stop_id == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :location_group_id) && any(row -> !ismissing(row.location_group_id) && row.location_group_id == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'location_id' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'location_id' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'location_id' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stop_times_start_pickup_drop_off_window(gtfs::GTFSSchedule)

Validate presence of field 'start_pickup_drop_off_window' in stop_times.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_stop_times_start_pickup_drop_off_window(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "start_pickup_drop_off_window"
    file_field = :stop_times

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return ValidationMessage(filename, field_name, "File 'stop_times.txt' does not exist, cannot validate field 'start_pickup_drop_off_window'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :start_pickup_drop_off_window)
        return ValidationMessage(filename, field_name, "Field 'start_pickup_drop_off_window' does not exist in file 'stop_times.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stop_times.start_pickup_drop_off_window

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :location_group_id) && any(row -> !ismissing(row.location_group_id) && row.location_group_id == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :location_id) && any(row -> !ismissing(row.location_id) && row.location_id == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'start_pickup_drop_off_window' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'start_pickup_drop_off_window' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'start_pickup_drop_off_window' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stop_times_end_pickup_drop_off_window(gtfs::GTFSSchedule)

Validate presence of field 'end_pickup_drop_off_window' in stop_times.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_stop_times_end_pickup_drop_off_window(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "end_pickup_drop_off_window"
    file_field = :stop_times

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return ValidationMessage(filename, field_name, "File 'stop_times.txt' does not exist, cannot validate field 'end_pickup_drop_off_window'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :end_pickup_drop_off_window)
        return ValidationMessage(filename, field_name, "Field 'end_pickup_drop_off_window' does not exist in file 'stop_times.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stop_times.end_pickup_drop_off_window

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :location_group_id) && any(row -> !ismissing(row.location_group_id) && row.location_group_id == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :location_id) && any(row -> !ismissing(row.location_id) && row.location_id == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'end_pickup_drop_off_window' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'end_pickup_drop_off_window' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'end_pickup_drop_off_window' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stop_times_pickup_type(gtfs::GTFSSchedule)

Validate presence of field 'pickup_type' in stop_times.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_stop_times_pickup_type(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "pickup_type"
    file_field = :stop_times

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return ValidationMessage(filename, field_name, "File 'stop_times.txt' does not exist, cannot validate field 'pickup_type'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :pickup_type)
        return ValidationMessage(filename, field_name, "Field 'pickup_type' does not exist in file 'stop_times.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stop_times.pickup_type

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :pickup_type) && any(row -> !ismissing(row.pickup_type) && row.pickup_type == "0", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :start_pickup_drop_off_window) && any(row -> !ismissing(row.start_pickup_drop_off_window) && row.start_pickup_drop_off_window == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :end_pickup_drop_off_window) && any(row -> !ismissing(row.end_pickup_drop_off_window) && row.end_pickup_drop_off_window == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'pickup_type' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'pickup_type' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'pickup_type' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stop_times_drop_off_type(gtfs::GTFSSchedule)

Validate presence of field 'drop_off_type' in stop_times.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_stop_times_drop_off_type(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "drop_off_type"
    file_field = :stop_times

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return ValidationMessage(filename, field_name, "File 'stop_times.txt' does not exist, cannot validate field 'drop_off_type'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :drop_off_type)
        return ValidationMessage(filename, field_name, "Field 'drop_off_type' does not exist in file 'stop_times.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stop_times.drop_off_type

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :drop_off_type) && any(row -> !ismissing(row.drop_off_type) && row.drop_off_type == "0", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :start_pickup_drop_off_window) && any(row -> !ismissing(row.start_pickup_drop_off_window) && row.start_pickup_drop_off_window == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :end_pickup_drop_off_window) && any(row -> !ismissing(row.end_pickup_drop_off_window) && row.end_pickup_drop_off_window == "defined", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'drop_off_type' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'drop_off_type' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'drop_off_type' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stop_times_continuous_pickup(gtfs::GTFSSchedule)

Validate presence of field 'continuous_pickup' in stop_times.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_stop_times_continuous_pickup(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "continuous_pickup"
    file_field = :stop_times

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return ValidationMessage(filename, field_name, "File 'stop_times.txt' does not exist, cannot validate field 'continuous_pickup'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :continuous_pickup)
        return ValidationMessage(filename, field_name, "Field 'continuous_pickup' does not exist in file 'stop_times.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stop_times.continuous_pickup

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :_1) && any(row -> !ismissing(row._1) && row._1 == "1", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :start_pickup_drop_off_window) && any(row -> !ismissing(row.start_pickup_drop_off_window) && row.start_pickup_drop_off_window == "1", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :end_pickup_drop_off_window) && any(row -> !ismissing(row.end_pickup_drop_off_window) && row.end_pickup_drop_off_window == "1", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'continuous_pickup' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'continuous_pickup' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'continuous_pickup' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_stop_times_continuous_drop_off(gtfs::GTFSSchedule)

Validate presence of field 'continuous_drop_off' in stop_times.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_stop_times_continuous_drop_off(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "continuous_drop_off"
    file_field = :stop_times

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return ValidationMessage(filename, field_name, "File 'stop_times.txt' does not exist, cannot validate field 'continuous_drop_off'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :continuous_drop_off)
        return ValidationMessage(filename, field_name, "Field 'continuous_drop_off' does not exist in file 'stop_times.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.stop_times.continuous_drop_off

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :_1) && any(row -> !ismissing(row._1) && row._1 == "1", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :start_pickup_drop_off_window) && any(row -> !ismissing(row.start_pickup_drop_off_window) && row.start_pickup_drop_off_window == "1", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: forbidden when conditions met
    if hasproperty(gtfs, :stop_times) && gtfs.stop_times !== nothing && hasproperty(gtfs.stop_times, :end_pickup_drop_off_window) && any(row -> !ismissing(row.end_pickup_drop_off_window) && row.end_pickup_drop_off_window == "1", eachrow(gtfs.stop_times))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'continuous_drop_off' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'continuous_drop_off' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'continuous_drop_off' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_timeframes_start_time(gtfs::GTFSSchedule)

Validate presence of field 'start_time' in timeframes.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_timeframes_start_time(gtfs::GTFSSchedule)
    filename = "timeframes.txt"
    field_name = "start_time"
    file_field = :timeframes

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.timeframes === nothing
        return ValidationMessage(filename, field_name, "File 'timeframes.txt' does not exist, cannot validate field 'start_time'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.timeframes, :start_time)
        return ValidationMessage(filename, field_name, "Field 'start_time' does not exist in file 'timeframes.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.timeframes.start_time

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :timeframes) && gtfs.timeframes !== nothing && hasproperty(gtfs.timeframes, :end_time) && any(row -> !ismissing(row.end_time) && row.end_time == "defined", eachrow(gtfs.timeframes))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'start_time' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'start_time' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'start_time' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_timeframes_end_time(gtfs::GTFSSchedule)

Validate presence of field 'end_time' in timeframes.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_timeframes_end_time(gtfs::GTFSSchedule)
    filename = "timeframes.txt"
    field_name = "end_time"
    file_field = :timeframes

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.timeframes === nothing
        return ValidationMessage(filename, field_name, "File 'timeframes.txt' does not exist, cannot validate field 'end_time'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.timeframes, :end_time)
        return ValidationMessage(filename, field_name, "Field 'end_time' does not exist in file 'timeframes.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.timeframes.end_time

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :timeframes) && gtfs.timeframes !== nothing && hasproperty(gtfs.timeframes, :start_time) && any(row -> !ismissing(row.start_time) && row.start_time == "defined", eachrow(gtfs.timeframes))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'end_time' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'end_time' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'end_time' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_fare_leg_join_rules_from_stop_id(gtfs::GTFSSchedule)

Validate presence of field 'from_stop_id' in fare_leg_join_rules.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_fare_leg_join_rules_from_stop_id(gtfs::GTFSSchedule)
    filename = "fare_leg_join_rules.txt"
    field_name = "from_stop_id"
    file_field = :fare_leg_join_rules

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_join_rules === nothing
        return ValidationMessage(filename, field_name, "File 'fare_leg_join_rules.txt' does not exist, cannot validate field 'from_stop_id'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_join_rules, :from_stop_id)
        return ValidationMessage(filename, field_name, "Field 'from_stop_id' does not exist in file 'fare_leg_join_rules.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.fare_leg_join_rules.from_stop_id

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :fare_leg_join_rules) && gtfs.fare_leg_join_rules !== nothing && hasproperty(gtfs.fare_leg_join_rules, :to_stop_id) && any(row -> !ismissing(row.to_stop_id) && row.to_stop_id == "defined", eachrow(gtfs.fare_leg_join_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'from_stop_id' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'from_stop_id' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'from_stop_id' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_fare_leg_join_rules_to_stop_id(gtfs::GTFSSchedule)

Validate presence of field 'to_stop_id' in fare_leg_join_rules.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_fare_leg_join_rules_to_stop_id(gtfs::GTFSSchedule)
    filename = "fare_leg_join_rules.txt"
    field_name = "to_stop_id"
    file_field = :fare_leg_join_rules

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_join_rules === nothing
        return ValidationMessage(filename, field_name, "File 'fare_leg_join_rules.txt' does not exist, cannot validate field 'to_stop_id'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_join_rules, :to_stop_id)
        return ValidationMessage(filename, field_name, "Field 'to_stop_id' does not exist in file 'fare_leg_join_rules.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.fare_leg_join_rules.to_stop_id

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :fare_leg_join_rules) && gtfs.fare_leg_join_rules !== nothing && hasproperty(gtfs.fare_leg_join_rules, :from_stop_id) && any(row -> !ismissing(row.from_stop_id) && row.from_stop_id == "defined", eachrow(gtfs.fare_leg_join_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'to_stop_id' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'to_stop_id' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'to_stop_id' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_fare_transfer_rules_transfer_count(gtfs::GTFSSchedule)

Validate presence of field 'transfer_count' in fare_transfer_rules.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_fare_transfer_rules_transfer_count(gtfs::GTFSSchedule)
    filename = "fare_transfer_rules.txt"
    field_name = "transfer_count"
    file_field = :fare_transfer_rules

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_transfer_rules === nothing
        return ValidationMessage(filename, field_name, "File 'fare_transfer_rules.txt' does not exist, cannot validate field 'transfer_count'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_transfer_rules, :transfer_count)
        return ValidationMessage(filename, field_name, "Field 'transfer_count' does not exist in file 'fare_transfer_rules.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.fare_transfer_rules.transfer_count

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :fare_transfer_rules) && gtfs.fare_transfer_rules !== nothing && hasproperty(gtfs.fare_transfer_rules, :from_leg_group_id) && any(row -> !ismissing(row.from_leg_group_id) && row.from_leg_group_id == "defined", eachrow(gtfs.fare_transfer_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: forbidden when conditions met
    if hasproperty(gtfs, :fare_transfer_rules) && gtfs.fare_transfer_rules !== nothing && hasproperty(gtfs.fare_transfer_rules, :to_leg_group_id) && any(row -> !ismissing(row.to_leg_group_id) && row.to_leg_group_id == "defined", eachrow(gtfs.fare_transfer_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'transfer_count' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'transfer_count' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'transfer_count' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_fare_transfer_rules_duration_limit_type(gtfs::GTFSSchedule)

Validate presence of field 'duration_limit_type' in fare_transfer_rules.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_fare_transfer_rules_duration_limit_type(gtfs::GTFSSchedule)
    filename = "fare_transfer_rules.txt"
    field_name = "duration_limit_type"
    file_field = :fare_transfer_rules

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_transfer_rules === nothing
        return ValidationMessage(filename, field_name, "File 'fare_transfer_rules.txt' does not exist, cannot validate field 'duration_limit_type'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_transfer_rules, :duration_limit_type)
        return ValidationMessage(filename, field_name, "Field 'duration_limit_type' does not exist in file 'fare_transfer_rules.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.fare_transfer_rules.duration_limit_type

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :fare_transfer_rules) && gtfs.fare_transfer_rules !== nothing && hasproperty(gtfs.fare_transfer_rules, :duration_limit) && any(row -> !ismissing(row.duration_limit) && row.duration_limit == "defined", eachrow(gtfs.fare_transfer_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'duration_limit_type' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'duration_limit_type' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'duration_limit_type' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_transfers_from_stop_id(gtfs::GTFSSchedule)

Validate presence of field 'from_stop_id' in transfers.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_transfers_from_stop_id(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    field_name = "from_stop_id"
    file_field = :transfers

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.transfers === nothing
        return ValidationMessage(filename, field_name, "File 'transfers.txt' does not exist, cannot validate field 'from_stop_id'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.transfers, :from_stop_id)
        return ValidationMessage(filename, field_name, "Field 'from_stop_id' does not exist in file 'transfers.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.transfers.from_stop_id

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :transfer_type) && any(row -> !ismissing(row.transfer_type) && row.transfer_type == "1", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :transfer_type) && any(row -> !ismissing(row.transfer_type) && row.transfer_type == "2", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :transfer_type) && any(row -> !ismissing(row.transfer_type) && row.transfer_type == "3", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    # Condition 4: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_1) && any(row -> !ismissing(row._1) && row._1 == "1", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 4 met")
    end

    # Condition 5: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_1) && any(row -> !ismissing(row._1) && row._1 == "2", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 5 met")
    end

    # Condition 6: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_1) && any(row -> !ismissing(row._1) && row._1 == "3", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 6 met")
    end

    # Condition 7: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_2) && any(row -> !ismissing(row._2) && row._2 == "1", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 7 met")
    end

    # Condition 8: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_2) && any(row -> !ismissing(row._2) && row._2 == "2", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 8 met")
    end

    # Condition 9: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_2) && any(row -> !ismissing(row._2) && row._2 == "3", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 9 met")
    end

    # Condition 10: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_3) && any(row -> !ismissing(row._3) && row._3 == "1", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 10 met")
    end

    # Condition 11: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_3) && any(row -> !ismissing(row._3) && row._3 == "2", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 11 met")
    end

    # Condition 12: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_3) && any(row -> !ismissing(row._3) && row._3 == "3", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 12 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'from_stop_id' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'from_stop_id' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'from_stop_id' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_transfers_to_stop_id(gtfs::GTFSSchedule)

Validate presence of field 'to_stop_id' in transfers.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_transfers_to_stop_id(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    field_name = "to_stop_id"
    file_field = :transfers

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.transfers === nothing
        return ValidationMessage(filename, field_name, "File 'transfers.txt' does not exist, cannot validate field 'to_stop_id'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.transfers, :to_stop_id)
        return ValidationMessage(filename, field_name, "Field 'to_stop_id' does not exist in file 'transfers.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.transfers.to_stop_id

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :transfer_type) && any(row -> !ismissing(row.transfer_type) && row.transfer_type == "1", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :transfer_type) && any(row -> !ismissing(row.transfer_type) && row.transfer_type == "2", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :transfer_type) && any(row -> !ismissing(row.transfer_type) && row.transfer_type == "3", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    # Condition 4: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_1) && any(row -> !ismissing(row._1) && row._1 == "1", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 4 met")
    end

    # Condition 5: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_1) && any(row -> !ismissing(row._1) && row._1 == "2", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 5 met")
    end

    # Condition 6: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_1) && any(row -> !ismissing(row._1) && row._1 == "3", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 6 met")
    end

    # Condition 7: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_2) && any(row -> !ismissing(row._2) && row._2 == "1", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 7 met")
    end

    # Condition 8: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_2) && any(row -> !ismissing(row._2) && row._2 == "2", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 8 met")
    end

    # Condition 9: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_2) && any(row -> !ismissing(row._2) && row._2 == "3", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 9 met")
    end

    # Condition 10: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_3) && any(row -> !ismissing(row._3) && row._3 == "1", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 10 met")
    end

    # Condition 11: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_3) && any(row -> !ismissing(row._3) && row._3 == "2", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 11 met")
    end

    # Condition 12: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_3) && any(row -> !ismissing(row._3) && row._3 == "3", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 12 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'to_stop_id' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'to_stop_id' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'to_stop_id' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_transfers_from_trip_id(gtfs::GTFSSchedule)

Validate presence of field 'from_trip_id' in transfers.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_transfers_from_trip_id(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    field_name = "from_trip_id"
    file_field = :transfers

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.transfers === nothing
        return ValidationMessage(filename, field_name, "File 'transfers.txt' does not exist, cannot validate field 'from_trip_id'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.transfers, :from_trip_id)
        return ValidationMessage(filename, field_name, "Field 'from_trip_id' does not exist in file 'transfers.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.transfers.from_trip_id

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :transfer_type) && any(row -> !ismissing(row.transfer_type) && row.transfer_type == "4", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :transfer_type) && any(row -> !ismissing(row.transfer_type) && row.transfer_type == "5", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_4) && any(row -> !ismissing(row._4) && row._4 == "4", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    # Condition 4: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_4) && any(row -> !ismissing(row._4) && row._4 == "5", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 4 met")
    end

    # Condition 5: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_5) && any(row -> !ismissing(row._5) && row._5 == "4", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 5 met")
    end

    # Condition 6: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_5) && any(row -> !ismissing(row._5) && row._5 == "5", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 6 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'from_trip_id' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'from_trip_id' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'from_trip_id' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_transfers_to_trip_id(gtfs::GTFSSchedule)

Validate presence of field 'to_trip_id' in transfers.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_transfers_to_trip_id(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    field_name = "to_trip_id"
    file_field = :transfers

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.transfers === nothing
        return ValidationMessage(filename, field_name, "File 'transfers.txt' does not exist, cannot validate field 'to_trip_id'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.transfers, :to_trip_id)
        return ValidationMessage(filename, field_name, "Field 'to_trip_id' does not exist in file 'transfers.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.transfers.to_trip_id

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :transfer_type) && any(row -> !ismissing(row.transfer_type) && row.transfer_type == "4", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :transfer_type) && any(row -> !ismissing(row.transfer_type) && row.transfer_type == "5", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    # Condition 3: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_4) && any(row -> !ismissing(row._4) && row._4 == "4", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 3 met")
    end

    # Condition 4: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_4) && any(row -> !ismissing(row._4) && row._4 == "5", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 4 met")
    end

    # Condition 5: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_5) && any(row -> !ismissing(row._5) && row._5 == "4", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 5 met")
    end

    # Condition 6: required when conditions met
    if hasproperty(gtfs, :transfers) && gtfs.transfers !== nothing && hasproperty(gtfs.transfers, :_5) && any(row -> !ismissing(row._5) && row._5 == "5", eachrow(gtfs.transfers))
        conditions_met = true
        push!(condition_descriptions, "Condition 6 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'to_trip_id' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'to_trip_id' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'to_trip_id' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_booking_rules_prior_notice_duration_min(gtfs::GTFSSchedule)

Validate presence of field 'prior_notice_duration_min' in booking_rules.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_booking_rules_prior_notice_duration_min(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_duration_min"
    file_field = :booking_rules

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return ValidationMessage(filename, field_name, "File 'booking_rules.txt' does not exist, cannot validate field 'prior_notice_duration_min'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_duration_min)
        return ValidationMessage(filename, field_name, "Field 'prior_notice_duration_min' does not exist in file 'booking_rules.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_duration_min

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :booking_rules) && gtfs.booking_rules !== nothing && hasproperty(gtfs.booking_rules, :booking_type) && any(row -> !ismissing(row.booking_type) && row.booking_type == "1", eachrow(gtfs.booking_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'prior_notice_duration_min' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'prior_notice_duration_min' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'prior_notice_duration_min' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_booking_rules_prior_notice_duration_max(gtfs::GTFSSchedule)

Validate presence of field 'prior_notice_duration_max' in booking_rules.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_booking_rules_prior_notice_duration_max(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_duration_max"
    file_field = :booking_rules

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return ValidationMessage(filename, field_name, "File 'booking_rules.txt' does not exist, cannot validate field 'prior_notice_duration_max'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_duration_max)
        return ValidationMessage(filename, field_name, "Field 'prior_notice_duration_max' does not exist in file 'booking_rules.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_duration_max

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :booking_rules) && gtfs.booking_rules !== nothing && hasproperty(gtfs.booking_rules, :booking_type) && any(row -> !ismissing(row.booking_type) && row.booking_type == "0", eachrow(gtfs.booking_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: forbidden when conditions met
    if hasproperty(gtfs, :booking_rules) && gtfs.booking_rules !== nothing && hasproperty(gtfs.booking_rules, :booking_type) && any(row -> !ismissing(row.booking_type) && row.booking_type == "2", eachrow(gtfs.booking_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'prior_notice_duration_max' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'prior_notice_duration_max' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'prior_notice_duration_max' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_booking_rules_prior_notice_last_day(gtfs::GTFSSchedule)

Validate presence of field 'prior_notice_last_day' in booking_rules.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_booking_rules_prior_notice_last_day(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_last_day"
    file_field = :booking_rules

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return ValidationMessage(filename, field_name, "File 'booking_rules.txt' does not exist, cannot validate field 'prior_notice_last_day'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_last_day)
        return ValidationMessage(filename, field_name, "Field 'prior_notice_last_day' does not exist in file 'booking_rules.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_last_day

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :booking_rules) && gtfs.booking_rules !== nothing && hasproperty(gtfs.booking_rules, :booking_type) && any(row -> !ismissing(row.booking_type) && row.booking_type == "2", eachrow(gtfs.booking_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'prior_notice_last_day' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'prior_notice_last_day' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'prior_notice_last_day' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_booking_rules_prior_notice_last_time(gtfs::GTFSSchedule)

Validate presence of field 'prior_notice_last_time' in booking_rules.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_booking_rules_prior_notice_last_time(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_last_time"
    file_field = :booking_rules

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return ValidationMessage(filename, field_name, "File 'booking_rules.txt' does not exist, cannot validate field 'prior_notice_last_time'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_last_time)
        return ValidationMessage(filename, field_name, "Field 'prior_notice_last_time' does not exist in file 'booking_rules.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_last_time

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :booking_rules) && gtfs.booking_rules !== nothing && hasproperty(gtfs.booking_rules, :prior_notice_last_day) && any(row -> !ismissing(row.prior_notice_last_day) && row.prior_notice_last_day == "defined", eachrow(gtfs.booking_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'prior_notice_last_time' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'prior_notice_last_time' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'prior_notice_last_time' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_booking_rules_prior_notice_start_day(gtfs::GTFSSchedule)

Validate presence of field 'prior_notice_start_day' in booking_rules.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_booking_rules_prior_notice_start_day(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_start_day"
    file_field = :booking_rules

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return ValidationMessage(filename, field_name, "File 'booking_rules.txt' does not exist, cannot validate field 'prior_notice_start_day'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_start_day)
        return ValidationMessage(filename, field_name, "Field 'prior_notice_start_day' does not exist in file 'booking_rules.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_start_day

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :booking_rules) && gtfs.booking_rules !== nothing && hasproperty(gtfs.booking_rules, :booking_type) && any(row -> !ismissing(row.booking_type) && row.booking_type == "0", eachrow(gtfs.booking_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'prior_notice_start_day' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'prior_notice_start_day' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'prior_notice_start_day' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_booking_rules_prior_notice_start_time(gtfs::GTFSSchedule)

Validate presence of field 'prior_notice_start_time' in booking_rules.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_booking_rules_prior_notice_start_time(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_start_time"
    file_field = :booking_rules

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return ValidationMessage(filename, field_name, "File 'booking_rules.txt' does not exist, cannot validate field 'prior_notice_start_time'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_start_time)
        return ValidationMessage(filename, field_name, "Field 'prior_notice_start_time' does not exist in file 'booking_rules.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_start_time

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :booking_rules) && gtfs.booking_rules !== nothing && hasproperty(gtfs.booking_rules, :prior_notice_start_day) && any(row -> !ismissing(row.prior_notice_start_day) && row.prior_notice_start_day == "defined", eachrow(gtfs.booking_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'prior_notice_start_time' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'prior_notice_start_time' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'prior_notice_start_time' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_booking_rules_prior_notice_service_id(gtfs::GTFSSchedule)

Validate presence of field 'prior_notice_service_id' in booking_rules.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_field_booking_rules_prior_notice_service_id(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_service_id"
    file_field = :booking_rules

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return ValidationMessage(filename, field_name, "File 'booking_rules.txt' does not exist, cannot validate field 'prior_notice_service_id'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_service_id)
        return ValidationMessage(filename, field_name, "Field 'prior_notice_service_id' does not exist in file 'booking_rules.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_service_id

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: forbidden when conditions met
    if hasproperty(gtfs, :booking_rules) && gtfs.booking_rules !== nothing && hasproperty(gtfs.booking_rules, :booking_type) && any(row -> !ismissing(row.booking_type) && row.booking_type == "2", eachrow(gtfs.booking_rules))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    if conditions_met
        # Field is conditionally forbidden and conditions are met
        non_missing_count = count(!ismissing, field_data)
        if non_missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'prior_notice_service_id' has $non_missing_count non-missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally forbidden field 'prior_notice_service_id' is correctly empty (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'prior_notice_service_id' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_translations_record_id(gtfs::GTFSSchedule)

Validate presence of field 'record_id' in translations.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_translations_record_id(gtfs::GTFSSchedule)
    filename = "translations.txt"
    field_name = "record_id"
    file_field = :translations

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.translations === nothing
        return ValidationMessage(filename, field_name, "File 'translations.txt' does not exist, cannot validate field 'record_id'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.translations, :record_id)
        return ValidationMessage(filename, field_name, "Field 'record_id' does not exist in file 'translations.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.translations.record_id

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :translations) && gtfs.translations !== nothing && hasproperty(gtfs.translations, :table_name) && any(row -> !ismissing(row.table_name) && row.table_name == "defined", eachrow(gtfs.translations))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :translations) && gtfs.translations !== nothing && hasproperty(gtfs.translations, :feed_info) && any(row -> !ismissing(row.feed_info) && row.feed_info == "defined", eachrow(gtfs.translations))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'record_id' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'record_id' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'record_id' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_translations_record_sub_id(gtfs::GTFSSchedule)

Validate presence of field 'record_sub_id' in translations.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_translations_record_sub_id(gtfs::GTFSSchedule)
    filename = "translations.txt"
    field_name = "record_sub_id"
    file_field = :translations

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.translations === nothing
        return ValidationMessage(filename, field_name, "File 'translations.txt' does not exist, cannot validate field 'record_sub_id'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.translations, :record_sub_id)
        return ValidationMessage(filename, field_name, "Field 'record_sub_id' does not exist in file 'translations.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.translations.record_sub_id

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :translations) && gtfs.translations !== nothing && hasproperty(gtfs.translations, :table_name) && any(row -> !ismissing(row.table_name) && row.table_name == "defined", eachrow(gtfs.translations))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :translations) && gtfs.translations !== nothing && hasproperty(gtfs.translations, :feed_info) && any(row -> !ismissing(row.feed_info) && row.feed_info == "defined", eachrow(gtfs.translations))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'record_sub_id' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'record_sub_id' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'record_sub_id' conditions not met - no validation required", :info)
    end
end

"""
    validate_field_translations_field_value(gtfs::GTFSSchedule)

Validate presence of field 'field_value' in translations.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_field_translations_field_value(gtfs::GTFSSchedule)
    filename = "translations.txt"
    field_name = "field_value"
    file_field = :translations

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.translations === nothing
        return ValidationMessage(filename, field_name, "File 'translations.txt' does not exist, cannot validate field 'field_value'", :warning)
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.translations, :field_value)
        return ValidationMessage(filename, field_name, "Field 'field_value' does not exist in file 'translations.txt'", :warning)
    end

    # Get field data
    field_data = gtfs.translations.field_value

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # Condition 1: required when conditions met
    if hasproperty(gtfs, :translations) && gtfs.translations !== nothing && hasproperty(gtfs.translations, :table_name) && any(row -> !ismissing(row.table_name) && row.table_name == "defined", eachrow(gtfs.translations))
        conditions_met = true
        push!(condition_descriptions, "Condition 1 met")
    end

    # Condition 2: required when conditions met
    if hasproperty(gtfs, :translations) && gtfs.translations !== nothing && hasproperty(gtfs.translations, :feed_info) && any(row -> !ismissing(row.feed_info) && row.feed_info == "defined", eachrow(gtfs.translations))
        conditions_met = true
        push!(condition_descriptions, "Condition 2 met")
    end

    if conditions_met
        # Field is conditionally required and conditions are met
        missing_count = count(ismissing, field_data)
        if missing_count > 0
            return ValidationMessage(filename, field_name, "Conditionally required field 'field_value' has $missing_count missing values (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, field_name, "Conditionally required field 'field_value' has no missing values (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, field_name, "Field 'field_value' conditions not met - no validation required", :info)
    end
end

