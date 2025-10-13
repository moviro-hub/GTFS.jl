# Auto-generated file - Enum validation functions
# Generated from GTFS specification parsing

"""
Enum Validation Functions

This module provides validation functions for GTFS enum fields.
All functions return true if the value is valid, false otherwise.
Missing values are always considered valid (presence validation is handled separately).

Usage:
    validate_routes_route_type("0")  # true
    validate_routes_route_type("99") # false
    validate_enum("routes.txt", "route_type", "0")  # generic validator
"""

# Dictionary of valid enum values
const ENUM_VALID_VALUES = Dict{Tuple{String, String}, Vector{String}}(
    ("agency.txt", "cemv_support") => ["1", "2"],
    ("stops.txt", "location_type") => ["1", "2", "3", "4"],
    ("stops.txt", "wheelchair_boarding") => ["1", "2", "1", "2", "1", "2"],
    ("stops.txt", "stop_access") => ["0", "1"],
    ("routes.txt", "route_type") => ["0", "1", "2", "3", "4", "5", "6", "7", "11", "12"],
    ("routes.txt", "continuous_pickup") => ["0", "2", "3"],
    ("routes.txt", "continuous_drop_off") => ["0", "2", "3"],
    ("routes.txt", "cemv_support") => ["1", "2"],
    ("trips.txt", "direction_id") => ["0", "1"],
    ("trips.txt", "wheelchair_accessible") => ["1", "2"],
    ("trips.txt", "bikes_allowed") => ["1", "2"],
    ("trips.txt", "cars_allowed") => ["1", "2"],
    ("stop_times.txt", "pickup_type") => ["1", "2", "3"],
    ("stop_times.txt", "drop_off_type") => ["1", "2", "3"],
    ("stop_times.txt", "continuous_pickup") => ["0", "2", "3"],
    ("stop_times.txt", "continuous_drop_off") => ["0", "2", "3"],
    ("stop_times.txt", "timepoint") => ["0", "1"],
    ("calendar.txt", "monday") => ["1", "0"],
    ("calendar_dates.txt", "exception_type") => ["1", "2"],
    ("fare_attributes.txt", "payment_method") => ["0", "1"],
    ("fare_attributes.txt", "transfers") => ["0", "1", "2"],
    ("rider_categories.txt", "is_default_fare_category") => ["1"],
    ("fare_media.txt", "fare_media_type") => ["0", "1", "2", "3", "4"],
    ("fare_transfer_rules.txt", "duration_limit_type") => ["0", "1", "2", "3"],
    ("fare_transfer_rules.txt", "fare_transfer_type") => ["0", "1", "2"],
    ("frequencies.txt", "exact_times") => ["1"],
    ("transfers.txt", "transfer_type") => ["1", "2", "3", "4", "5"],
    ("pathways.txt", "pathway_mode") => ["1", "2", "3", "4", "5", "6", "7"],
    ("booking_rules.txt", "booking_type") => ["0", "1", "2"],
    ("attributions.txt", "is_producer") => ["1"]
)

"""
    validate_enum(file::String, field::String, value)

Generic enum validator that looks up valid values in ENUM_VALID_VALUES dictionary.
Returns true if value is valid for the given file and field, false otherwise.
Handles missing values by returning true.
"""
function validate_enum(file::String, field::String, value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Look up valid values
    key = (file, field)
    if !haskey(ENUM_VALID_VALUES, key)
        return true  # No validation defined, assume valid
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ENUM_VALID_VALUES[key]
    return str_value in valid_values
end

# Specific validation functions for each enum field

"""
    validate_agency_cemv_support(value)

Validate enum value for cemv_support in agency.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_agency_cemv_support(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "2"]
    return str_value in valid_values
end

"""
    validate_stops_location_type(value)

Validate enum value for location_type in stops.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_stops_location_type(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "2", "3", "4"]
    return str_value in valid_values
end

"""
    validate_stops_wheelchair_boarding(value)

Validate enum value for wheelchair_boarding in stops.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_stops_wheelchair_boarding(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "2", "1", "2", "1", "2"]
    return str_value in valid_values
end

"""
    validate_stops_stop_access(value)

Validate enum value for stop_access in stops.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_stops_stop_access(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "1"]
    return str_value in valid_values
end

"""
    validate_routes_route_type(value)

Validate enum value for route_type in routes.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_routes_route_type(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "1", "2", "3", "4", "5", "6", "7", "11", "12"]
    return str_value in valid_values
end

"""
    validate_routes_continuous_pickup(value)

Validate enum value for continuous_pickup in routes.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_routes_continuous_pickup(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "2", "3"]
    return str_value in valid_values
end

"""
    validate_routes_continuous_drop_off(value)

Validate enum value for continuous_drop_off in routes.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_routes_continuous_drop_off(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "2", "3"]
    return str_value in valid_values
end

"""
    validate_routes_cemv_support(value)

Validate enum value for cemv_support in routes.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_routes_cemv_support(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "2"]
    return str_value in valid_values
end

"""
    validate_trips_direction_id(value)

Validate enum value for direction_id in trips.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_trips_direction_id(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "1"]
    return str_value in valid_values
end

"""
    validate_trips_wheelchair_accessible(value)

Validate enum value for wheelchair_accessible in trips.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_trips_wheelchair_accessible(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "2"]
    return str_value in valid_values
end

"""
    validate_trips_bikes_allowed(value)

Validate enum value for bikes_allowed in trips.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_trips_bikes_allowed(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "2"]
    return str_value in valid_values
end

"""
    validate_trips_cars_allowed(value)

Validate enum value for cars_allowed in trips.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_trips_cars_allowed(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "2"]
    return str_value in valid_values
end

"""
    validate_stop_times_pickup_type(value)

Validate enum value for pickup_type in stop_times.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_stop_times_pickup_type(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "2", "3"]
    return str_value in valid_values
end

"""
    validate_stop_times_drop_off_type(value)

Validate enum value for drop_off_type in stop_times.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_stop_times_drop_off_type(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "2", "3"]
    return str_value in valid_values
end

"""
    validate_stop_times_continuous_pickup(value)

Validate enum value for continuous_pickup in stop_times.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_stop_times_continuous_pickup(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "2", "3"]
    return str_value in valid_values
end

"""
    validate_stop_times_continuous_drop_off(value)

Validate enum value for continuous_drop_off in stop_times.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_stop_times_continuous_drop_off(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "2", "3"]
    return str_value in valid_values
end

"""
    validate_stop_times_timepoint(value)

Validate enum value for timepoint in stop_times.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_stop_times_timepoint(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "1"]
    return str_value in valid_values
end

"""
    validate_calendar_monday(value)

Validate enum value for monday in calendar.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_calendar_monday(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "0"]
    return str_value in valid_values
end

"""
    validate_calendar_dates_exception_type(value)

Validate enum value for exception_type in calendar_dates.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_calendar_dates_exception_type(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "2"]
    return str_value in valid_values
end

"""
    validate_fare_attributes_payment_method(value)

Validate enum value for payment_method in fare_attributes.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_fare_attributes_payment_method(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "1"]
    return str_value in valid_values
end

"""
    validate_fare_attributes_transfers(value)

Validate enum value for transfers in fare_attributes.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_fare_attributes_transfers(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "1", "2"]
    return str_value in valid_values
end

"""
    validate_rider_categories_is_default_fare_category(value)

Validate enum value for is_default_fare_category in rider_categories.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_rider_categories_is_default_fare_category(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1"]
    return str_value in valid_values
end

"""
    validate_fare_media_fare_media_type(value)

Validate enum value for fare_media_type in fare_media.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_fare_media_fare_media_type(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "1", "2", "3", "4"]
    return str_value in valid_values
end

"""
    validate_fare_transfer_rules_duration_limit_type(value)

Validate enum value for duration_limit_type in fare_transfer_rules.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_fare_transfer_rules_duration_limit_type(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "1", "2", "3"]
    return str_value in valid_values
end

"""
    validate_fare_transfer_rules_fare_transfer_type(value)

Validate enum value for fare_transfer_type in fare_transfer_rules.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_fare_transfer_rules_fare_transfer_type(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "1", "2"]
    return str_value in valid_values
end

"""
    validate_frequencies_exact_times(value)

Validate enum value for exact_times in frequencies.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_frequencies_exact_times(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1"]
    return str_value in valid_values
end

"""
    validate_transfers_transfer_type(value)

Validate enum value for transfer_type in transfers.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_transfers_transfer_type(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "2", "3", "4", "5"]
    return str_value in valid_values
end

"""
    validate_pathways_pathway_mode(value)

Validate enum value for pathway_mode in pathways.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_pathways_pathway_mode(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1", "2", "3", "4", "5", "6", "7"]
    return str_value in valid_values
end

"""
    validate_booking_rules_booking_type(value)

Validate enum value for booking_type in booking_rules.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_booking_rules_booking_type(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["0", "1", "2"]
    return str_value in valid_values
end

"""
    validate_attributions_is_producer(value)

Validate enum value for is_producer in attributions.txt.
Returns true if value is valid, false otherwise.
Handles missing values by returning true.
"""
function validate_attributions_is_producer(value)
    # Handle missing values
    if ismissing(value)
        return true
    end

    # Convert to string for comparison
    str_value = string(value)

    # Check against valid values
    valid_values = ["1"]
    return str_value in valid_values
end

