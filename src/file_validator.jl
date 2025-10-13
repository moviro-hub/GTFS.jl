# Auto-generated file - File presence validation functions
# Generated from GTFS specification parsing

"""
File Presence Validation Functions

This module provides validation functions for GTFS file presence requirements.
Validates files based on GTFS specification requirements:
- Required files: Must always be present
- Conditionally required files: Must be present when conditions are met
- Conditionally forbidden files: Must not be present when conditions are met
- Optional files: No validation required

Usage:
    result = validate_file_presence(gtfs)
    if result.is_valid
        println("All file requirements satisfied")
    else
        for msg in result.messages
            if msg.severity == :error
                println("ERROR: ", msg.message)
            end
        end
    end
"""

"""
    validate_file_presence(gtfs::GTFSSchedule)

Comprehensive file presence validation for GTFS feed.
Validates all files based on GTFS specification requirements including:
- Required files (must be present)
- Conditionally required files (must be present when conditions are met)
- Conditionally forbidden files (must not be present when conditions are met)
- Optional files (no validation)

Returns ValidationResult with all validation messages.
"""
function validate_file_presence(gtfs::GTFSSchedule)
    messages = ValidationMessage[]

    # Validate required files
    push!(messages, validate_file_agency(gtfs))
    push!(messages, validate_file_routes(gtfs))
    push!(messages, validate_file_trips(gtfs))
    push!(messages, validate_file_stop_times(gtfs))

    # Validate conditionally required files
    push!(messages, validate_file_stops(gtfs))
    push!(messages, validate_file_calendar(gtfs))
    push!(messages, validate_file_calendar_dates(gtfs))
    push!(messages, validate_file_levels(gtfs))
    push!(messages, validate_file_feed_info(gtfs))

    # Validate conditionally forbidden files
    push!(messages, validate_file_networks(gtfs))
    push!(messages, validate_file_route_networks(gtfs))

    # Optional files (no validation needed)
    # Files: fare_attributes.txt, fare_rules.txt, timeframes.txt, rider_categories.txt, fare_media.txt, fare_products.txt, fare_leg_rules.txt, fare_leg_join_rules.txt, fare_transfer_rules.txt, areas.txt, stop_areas.txt, shapes.txt, frequencies.txt, transfers.txt, pathways.txt, location_groups.txt, location_group_stops.txt, locations.geojson, booking_rules.txt, translations.txt, attributions.txt

    # Determine overall validity
    error_count = count(msg -> msg.severity == :error, messages)
    warning_count = count(msg -> msg.severity == :warning, messages)
    is_valid = error_count == 0

    # Generate summary
    summary = "File presence validation: $(error_count) errors, $(warning_count) warnings"
    if is_valid
        summary *= " - All file presence requirements satisfied"
    else
        summary *= " - File presence validation failed"
    end

    return ValidationResult(is_valid, messages, summary)
end

# Individual file validation functions

"""
    validate_file_agency(gtfs::GTFSSchedule)

Validate presence of agency.txt based on GTFS specification requirements.
Base requirement: Required
Returns ValidationMessage with validation result.
"""
function validate_file_agency(gtfs::GTFSSchedule)
    filename = "agency.txt"
    file_field = :agency
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Required file - must always be present
    if !file_exists
        return ValidationMessage(filename, nothing, "Required file 'agency.txt' is missing", :error)
    end
    return ValidationMessage(filename, nothing, "Required file 'agency.txt' is present", :info)
end

"""
    validate_file_stops(gtfs::GTFSSchedule)

Validate presence of stops.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_file_stops(gtfs::GTFSSchedule)
    filename = "stops.txt"
    file_field = :stops
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # File relation 1: required when all conditions met
    if gtfs.locations !== nothing && gtfs.locations !== nothing
        conditions_met = true
        push!(condition_descriptions, "File relation 1 met")
    end

    if conditions_met
        # File is conditionally required and conditions are met
        if !file_exists
            return ValidationMessage(filename, nothing, "Conditionally required file 'stops.txt' is missing (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, nothing, "Conditionally required file 'stops.txt' is present (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, nothing, "File 'stops.txt' conditions not met - no validation required", :info)
    end
end

"""
    validate_file_routes(gtfs::GTFSSchedule)

Validate presence of routes.txt based on GTFS specification requirements.
Base requirement: Required
Returns ValidationMessage with validation result.
"""
function validate_file_routes(gtfs::GTFSSchedule)
    filename = "routes.txt"
    file_field = :routes
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Required file - must always be present
    if !file_exists
        return ValidationMessage(filename, nothing, "Required file 'routes.txt' is missing", :error)
    end
    return ValidationMessage(filename, nothing, "Required file 'routes.txt' is present", :info)
end

"""
    validate_file_trips(gtfs::GTFSSchedule)

Validate presence of trips.txt based on GTFS specification requirements.
Base requirement: Required
Returns ValidationMessage with validation result.
"""
function validate_file_trips(gtfs::GTFSSchedule)
    filename = "trips.txt"
    file_field = :trips
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Required file - must always be present
    if !file_exists
        return ValidationMessage(filename, nothing, "Required file 'trips.txt' is missing", :error)
    end
    return ValidationMessage(filename, nothing, "Required file 'trips.txt' is present", :info)
end

"""
    validate_file_stop_times(gtfs::GTFSSchedule)

Validate presence of stop_times.txt based on GTFS specification requirements.
Base requirement: Required
Returns ValidationMessage with validation result.
"""
function validate_file_stop_times(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    file_field = :stop_times
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Required file - must always be present
    if !file_exists
        return ValidationMessage(filename, nothing, "Required file 'stop_times.txt' is missing", :error)
    end
    return ValidationMessage(filename, nothing, "Required file 'stop_times.txt' is present", :info)
end

"""
    validate_file_calendar(gtfs::GTFSSchedule)

Validate presence of calendar.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_file_calendar(gtfs::GTFSSchedule)
    filename = "calendar.txt"
    file_field = :calendar
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # File relation 1: required when all conditions met
    if gtfs.calendar_dates !== nothing
        conditions_met = true
        push!(condition_descriptions, "File relation 1 met")
    end

    if conditions_met
        # File is conditionally required and conditions are met
        if !file_exists
            return ValidationMessage(filename, nothing, "Conditionally required file 'calendar.txt' is missing (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, nothing, "Conditionally required file 'calendar.txt' is present (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, nothing, "File 'calendar.txt' conditions not met - no validation required", :info)
    end
end

"""
    validate_file_calendar_dates(gtfs::GTFSSchedule)

Validate presence of calendar_dates.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_file_calendar_dates(gtfs::GTFSSchedule)
    filename = "calendar_dates.txt"
    file_field = :calendar_dates
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # File relation 1: required when all conditions met
    if gtfs.calendar === nothing && gtfs.calendar_dates === nothing
        conditions_met = true
        push!(condition_descriptions, "File relation 1 met")
    end

    if conditions_met
        # File is conditionally required and conditions are met
        if !file_exists
            return ValidationMessage(filename, nothing, "Conditionally required file 'calendar_dates.txt' is missing (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, nothing, "Conditionally required file 'calendar_dates.txt' is present (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, nothing, "File 'calendar_dates.txt' conditions not met - no validation required", :info)
    end
end

"""
    validate_file_fare_attributes(gtfs::GTFSSchedule)

Validate presence of fare_attributes.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_fare_attributes(gtfs::GTFSSchedule)
    filename = "fare_attributes.txt"
    file_field = :fare_attributes
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'fare_attributes.txt' validation skipped", :info)
end

"""
    validate_file_fare_rules(gtfs::GTFSSchedule)

Validate presence of fare_rules.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_fare_rules(gtfs::GTFSSchedule)
    filename = "fare_rules.txt"
    file_field = :fare_rules
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'fare_rules.txt' validation skipped", :info)
end

"""
    validate_file_timeframes(gtfs::GTFSSchedule)

Validate presence of timeframes.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_timeframes(gtfs::GTFSSchedule)
    filename = "timeframes.txt"
    file_field = :timeframes
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'timeframes.txt' validation skipped", :info)
end

"""
    validate_file_rider_categories(gtfs::GTFSSchedule)

Validate presence of rider_categories.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_rider_categories(gtfs::GTFSSchedule)
    filename = "rider_categories.txt"
    file_field = :rider_categories
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'rider_categories.txt' validation skipped", :info)
end

"""
    validate_file_fare_media(gtfs::GTFSSchedule)

Validate presence of fare_media.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_fare_media(gtfs::GTFSSchedule)
    filename = "fare_media.txt"
    file_field = :fare_media
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'fare_media.txt' validation skipped", :info)
end

"""
    validate_file_fare_products(gtfs::GTFSSchedule)

Validate presence of fare_products.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_fare_products(gtfs::GTFSSchedule)
    filename = "fare_products.txt"
    file_field = :fare_products
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'fare_products.txt' validation skipped", :info)
end

"""
    validate_file_fare_leg_rules(gtfs::GTFSSchedule)

Validate presence of fare_leg_rules.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_fare_leg_rules(gtfs::GTFSSchedule)
    filename = "fare_leg_rules.txt"
    file_field = :fare_leg_rules
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'fare_leg_rules.txt' validation skipped", :info)
end

"""
    validate_file_fare_leg_join_rules(gtfs::GTFSSchedule)

Validate presence of fare_leg_join_rules.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_fare_leg_join_rules(gtfs::GTFSSchedule)
    filename = "fare_leg_join_rules.txt"
    file_field = :fare_leg_join_rules
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'fare_leg_join_rules.txt' validation skipped", :info)
end

"""
    validate_file_fare_transfer_rules(gtfs::GTFSSchedule)

Validate presence of fare_transfer_rules.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_fare_transfer_rules(gtfs::GTFSSchedule)
    filename = "fare_transfer_rules.txt"
    file_field = :fare_transfer_rules
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'fare_transfer_rules.txt' validation skipped", :info)
end

"""
    validate_file_areas(gtfs::GTFSSchedule)

Validate presence of areas.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_areas(gtfs::GTFSSchedule)
    filename = "areas.txt"
    file_field = :areas
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'areas.txt' validation skipped", :info)
end

"""
    validate_file_stop_areas(gtfs::GTFSSchedule)

Validate presence of stop_areas.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_stop_areas(gtfs::GTFSSchedule)
    filename = "stop_areas.txt"
    file_field = :stop_areas
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'stop_areas.txt' validation skipped", :info)
end

"""
    validate_file_networks(gtfs::GTFSSchedule)

Validate presence of networks.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_file_networks(gtfs::GTFSSchedule)
    filename = "networks.txt"
    file_field = :networks
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # File relation 1: forbidden when all conditions met
    if gtfs.routes !== nothing
        conditions_met = true
        push!(condition_descriptions, "File relation 1 met")
    end

    if conditions_met
        # File is conditionally forbidden and conditions are met
        if file_exists
            return ValidationMessage(filename, nothing, "Conditionally forbidden file 'networks.txt' is present (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, nothing, "Conditionally forbidden file 'networks.txt' is correctly absent (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, nothing, "File 'networks.txt' conditions not met - no validation required", :info)
    end
end

"""
    validate_file_route_networks(gtfs::GTFSSchedule)

Validate presence of route_networks.txt based on GTFS specification requirements.
Base requirement: Conditionally Forbidden
Returns ValidationMessage with validation result.
"""
function validate_file_route_networks(gtfs::GTFSSchedule)
    filename = "route_networks.txt"
    file_field = :route_networks
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # File relation 1: forbidden when all conditions met
    if gtfs.routes !== nothing
        conditions_met = true
        push!(condition_descriptions, "File relation 1 met")
    end

    if conditions_met
        # File is conditionally forbidden and conditions are met
        if file_exists
            return ValidationMessage(filename, nothing, "Conditionally forbidden file 'route_networks.txt' is present (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, nothing, "Conditionally forbidden file 'route_networks.txt' is correctly absent (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, nothing, "File 'route_networks.txt' conditions not met - no validation required", :info)
    end
end

"""
    validate_file_shapes(gtfs::GTFSSchedule)

Validate presence of shapes.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_shapes(gtfs::GTFSSchedule)
    filename = "shapes.txt"
    file_field = :shapes
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'shapes.txt' validation skipped", :info)
end

"""
    validate_file_frequencies(gtfs::GTFSSchedule)

Validate presence of frequencies.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_frequencies(gtfs::GTFSSchedule)
    filename = "frequencies.txt"
    file_field = :frequencies
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'frequencies.txt' validation skipped", :info)
end

"""
    validate_file_transfers(gtfs::GTFSSchedule)

Validate presence of transfers.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_transfers(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    file_field = :transfers
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'transfers.txt' validation skipped", :info)
end

"""
    validate_file_pathways(gtfs::GTFSSchedule)

Validate presence of pathways.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_pathways(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    file_field = :pathways
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'pathways.txt' validation skipped", :info)
end

"""
    validate_file_levels(gtfs::GTFSSchedule)

Validate presence of levels.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_file_levels(gtfs::GTFSSchedule)
    filename = "levels.txt"
    file_field = :levels
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # File relation 1: required when all conditions met
    if hasproperty(gtfs, :pathways) && gtfs.pathways !== nothing && hasproperty(gtfs.pathways, :pathway_mode) && any(row -> row.pathway_mode == "5", eachrow(gtfs.pathways))
        conditions_met = true
        push!(condition_descriptions, "File relation 1 met")
    end

    if conditions_met
        # File is conditionally required and conditions are met
        if !file_exists
            return ValidationMessage(filename, nothing, "Conditionally required file 'levels.txt' is missing (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, nothing, "Conditionally required file 'levels.txt' is present (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, nothing, "File 'levels.txt' conditions not met - no validation required", :info)
    end
end

"""
    validate_file_location_groups(gtfs::GTFSSchedule)

Validate presence of location_groups.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_location_groups(gtfs::GTFSSchedule)
    filename = "location_groups.txt"
    file_field = :location_groups
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'location_groups.txt' validation skipped", :info)
end

"""
    validate_file_location_group_stops(gtfs::GTFSSchedule)

Validate presence of location_group_stops.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_location_group_stops(gtfs::GTFSSchedule)
    filename = "location_group_stops.txt"
    file_field = :location_group_stops
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'location_group_stops.txt' validation skipped", :info)
end

"""
    validate_file_locations(gtfs::GTFSSchedule)

Validate presence of locations.geojson based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_locations(gtfs::GTFSSchedule)
    filename = "locations.geojson"
    file_field = :locations
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'locations.geojson' validation skipped", :info)
end

"""
    validate_file_booking_rules(gtfs::GTFSSchedule)

Validate presence of booking_rules.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_booking_rules(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    file_field = :booking_rules
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'booking_rules.txt' validation skipped", :info)
end

"""
    validate_file_translations(gtfs::GTFSSchedule)

Validate presence of translations.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_translations(gtfs::GTFSSchedule)
    filename = "translations.txt"
    file_field = :translations
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'translations.txt' validation skipped", :info)
end

"""
    validate_file_feed_info(gtfs::GTFSSchedule)

Validate presence of feed_info.txt based on GTFS specification requirements.
Base requirement: Conditionally Required
Returns ValidationMessage with validation result.
"""
function validate_file_feed_info(gtfs::GTFSSchedule)
    filename = "feed_info.txt"
    file_field = :feed_info
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Conditionally required/forbidden - check conditions
    conditions_met = false
    condition_descriptions = String[]

    # File relation 1: required when all conditions met
    if gtfs.translations !== nothing
        conditions_met = true
        push!(condition_descriptions, "File relation 1 met")
    end

    if conditions_met
        # File is conditionally required and conditions are met
        if !file_exists
            return ValidationMessage(filename, nothing, "Conditionally required file 'feed_info.txt' is missing (conditions: $(join(condition_descriptions, ", ")))", :error)
        else
            return ValidationMessage(filename, nothing, "Conditionally required file 'feed_info.txt' is present (conditions: $(join(condition_descriptions, ", ")))", :info)
        end
    else
        # Conditions not met - no validation needed
        return ValidationMessage(filename, nothing, "File 'feed_info.txt' conditions not met - no validation required", :info)
    end
end

"""
    validate_file_attributions(gtfs::GTFSSchedule)

Validate presence of attributions.txt based on GTFS specification requirements.
Base requirement: Optional
Returns ValidationMessage with validation result.
"""
function validate_file_attributions(gtfs::GTFSSchedule)
    filename = "attributions.txt"
    file_field = :attributions
    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing

    # Optional file - no validation needed
    return ValidationMessage(filename, nothing, "Optional file 'attributions.txt' validation skipped", :info)
end

