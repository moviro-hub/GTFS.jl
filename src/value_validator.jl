# Auto-generated file - Field value validation functions
# Generated from GTFS specification parsing

"""
Field Value Validation Functions

This module provides validation functions for GTFS field values.
All functions validate the format and type of field values based on GTFS specifications.

Usage:
    validate_field_values(gtfs)  # Validate all field values
    validate_value_stops_stop_lat(gtfs)  # Validate specific field
"""

# Individual field value validation functions

"""
    validate_value_agency_agency_id(gtfs::GTFSSchedule)

Validate values of field 'agency_id' in agency.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_agency_agency_id(gtfs::GTFSSchedule)
    filename = "agency.txt"
    field_name = "agency_id"
    file_field = :agency
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.agency === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.agency, :agency_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.agency.agency_id

    return validation_errors
end

"""
    validate_value_agency_agency_name(gtfs::GTFSSchedule)

Validate values of field 'agency_name' in agency.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_agency_agency_name(gtfs::GTFSSchedule)
    filename = "agency.txt"
    field_name = "agency_name"
    file_field = :agency
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.agency === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.agency, :agency_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.agency.agency_name

    return validation_errors
end

"""
    validate_value_agency_agency_url(gtfs::GTFSSchedule)

Validate values of field 'agency_url' in agency.txt based on GTFS field type 'URL'.
Returns Vector{String} with validation error messages.
"""
function validate_value_agency_agency_url(gtfs::GTFSSchedule)
    filename = "agency.txt"
    field_name = "agency_url"
    file_field = :agency
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.agency === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.agency, :agency_url)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.agency.agency_url

# Validate URL format
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^https?://", val_str)
            push!(validation_errors, "Row $idx: Invalid URL '$val_str' (must start with http:// or https://)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_agency_agency_timezone(gtfs::GTFSSchedule)

Validate values of field 'agency_timezone' in agency.txt based on GTFS field type 'Timezone'.
Returns Vector{String} with validation error messages.
"""
function validate_value_agency_agency_timezone(gtfs::GTFSSchedule)
    filename = "agency.txt"
    field_name = "agency_timezone"
    file_field = :agency
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.agency === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.agency, :agency_timezone)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.agency.agency_timezone

# Validate time format (HH:MM:SS)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{1,2}:\d{2}:\d{2}$", val_str)
            push!(validation_errors, "Row $idx: Invalid time format '$val_str' (expected HH:MM:SS)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_agency_agency_lang(gtfs::GTFSSchedule)

Validate values of field 'agency_lang' in agency.txt based on GTFS field type 'Language code'.
Returns Vector{String} with validation error messages.
"""
function validate_value_agency_agency_lang(gtfs::GTFSSchedule)
    filename = "agency.txt"
    field_name = "agency_lang"
    file_field = :agency
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.agency === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.agency, :agency_lang)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.agency.agency_lang

    return validation_errors
end

"""
    validate_value_agency_agency_phone(gtfs::GTFSSchedule)

Validate values of field 'agency_phone' in agency.txt based on GTFS field type 'Phone number'.
Returns Vector{String} with validation error messages.
"""
function validate_value_agency_agency_phone(gtfs::GTFSSchedule)
    filename = "agency.txt"
    field_name = "agency_phone"
    file_field = :agency
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.agency === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.agency, :agency_phone)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.agency.agency_phone

    return validation_errors
end

"""
    validate_value_agency_agency_fare_url(gtfs::GTFSSchedule)

Validate values of field 'agency_fare_url' in agency.txt based on GTFS field type 'URL'.
Returns Vector{String} with validation error messages.
"""
function validate_value_agency_agency_fare_url(gtfs::GTFSSchedule)
    filename = "agency.txt"
    field_name = "agency_fare_url"
    file_field = :agency
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.agency === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.agency, :agency_fare_url)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.agency.agency_fare_url

# Validate URL format
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^https?://", val_str)
            push!(validation_errors, "Row $idx: Invalid URL '$val_str' (must start with http:// or https://)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_agency_agency_email(gtfs::GTFSSchedule)

Validate values of field 'agency_email' in agency.txt based on GTFS field type 'Email'.
Returns Vector{String} with validation error messages.
"""
function validate_value_agency_agency_email(gtfs::GTFSSchedule)
    filename = "agency.txt"
    field_name = "agency_email"
    file_field = :agency
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.agency === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.agency, :agency_email)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.agency.agency_email

    return validation_errors
end

"""
    validate_value_agency_cemv_support(gtfs::GTFSSchedule)

Validate values of field 'cemv_support' in agency.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_agency_cemv_support(gtfs::GTFSSchedule)
    filename = "agency.txt"
    field_name = "cemv_support"
    file_field = :agency
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.agency === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.agency, :cemv_support)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.agency.cemv_support

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_stops_stop_id(gtfs::GTFSSchedule)

Validate values of field 'stop_id' in stops.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_stop_id(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_id"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.stop_id

    return validation_errors
end

"""
    validate_value_stops_stop_code(gtfs::GTFSSchedule)

Validate values of field 'stop_code' in stops.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_stop_code(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_code"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_code)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.stop_code

    return validation_errors
end

"""
    validate_value_stops_stop_name(gtfs::GTFSSchedule)

Validate values of field 'stop_name' in stops.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_stop_name(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_name"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.stop_name

    return validation_errors
end

"""
    validate_value_stops_tts_stop_name(gtfs::GTFSSchedule)

Validate values of field 'tts_stop_name' in stops.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_tts_stop_name(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "tts_stop_name"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :tts_stop_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.tts_stop_name

    return validation_errors
end

"""
    validate_value_stops_stop_desc(gtfs::GTFSSchedule)

Validate values of field 'stop_desc' in stops.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_stop_desc(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_desc"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_desc)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.stop_desc

    return validation_errors
end

"""
    validate_value_stops_stop_lat(gtfs::GTFSSchedule)

Validate values of field 'stop_lat' in stops.txt based on GTFS field type 'Latitude'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_stop_lat(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_lat"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_lat)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.stop_lat

# Validate latitude range (-90 to 90)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            lat = Float64(val)
            if lat < -90.0 || lat > 90.0
                push!(validation_errors, "Row $idx: Latitude $lat out of range (must be between -90 and 90)")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid latitude value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_stops_stop_lon(gtfs::GTFSSchedule)

Validate values of field 'stop_lon' in stops.txt based on GTFS field type 'Longitude'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_stop_lon(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_lon"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_lon)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.stop_lon

# Validate longitude range (-180 to 180)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            lon = Float64(val)
            if lon < -180.0 || lon > 180.0
                push!(validation_errors, "Row $idx: Longitude $lon out of range (must be between -180 and 180)")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid longitude value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_stops_zone_id(gtfs::GTFSSchedule)

Validate values of field 'zone_id' in stops.txt based on GTFS field type 'ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_zone_id(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "zone_id"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :zone_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.zone_id

    return validation_errors
end

"""
    validate_value_stops_stop_url(gtfs::GTFSSchedule)

Validate values of field 'stop_url' in stops.txt based on GTFS field type 'URL'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_stop_url(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_url"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_url)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.stop_url

# Validate URL format
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^https?://", val_str)
            push!(validation_errors, "Row $idx: Invalid URL '$val_str' (must start with http:// or https://)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_stops_location_type(gtfs::GTFSSchedule)

Validate values of field 'location_type' in stops.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_location_type(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "location_type"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :location_type)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.location_type

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_stops_parent_station(gtfs::GTFSSchedule)

Validate values of field 'parent_station' in stops.txt based on GTFS field type 'Foreign ID referencing `stops.stop_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_parent_station(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "parent_station"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :parent_station)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.parent_station

    return validation_errors
end

"""
    validate_value_stops_stop_timezone(gtfs::GTFSSchedule)

Validate values of field 'stop_timezone' in stops.txt based on GTFS field type 'Timezone'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_stop_timezone(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_timezone"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_timezone)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.stop_timezone

# Validate time format (HH:MM:SS)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{1,2}:\d{2}:\d{2}$", val_str)
            push!(validation_errors, "Row $idx: Invalid time format '$val_str' (expected HH:MM:SS)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_stops_wheelchair_boarding(gtfs::GTFSSchedule)

Validate values of field 'wheelchair_boarding' in stops.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_wheelchair_boarding(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "wheelchair_boarding"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :wheelchair_boarding)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.wheelchair_boarding

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_stops_level_id(gtfs::GTFSSchedule)

Validate values of field 'level_id' in stops.txt based on GTFS field type 'Foreign ID referencing `levels.level_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_level_id(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "level_id"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :level_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.level_id

    return validation_errors
end

"""
    validate_value_stops_platform_code(gtfs::GTFSSchedule)

Validate values of field 'platform_code' in stops.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_platform_code(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "platform_code"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :platform_code)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.platform_code

    return validation_errors
end

"""
    validate_value_stops_stop_access(gtfs::GTFSSchedule)

Validate values of field 'stop_access' in stops.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stops_stop_access(gtfs::GTFSSchedule)
    filename = "stops.txt"
    field_name = "stop_access"
    file_field = :stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stops, :stop_access)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stops.stop_access

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_routes_route_id(gtfs::GTFSSchedule)

Validate values of field 'route_id' in routes.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_route_id(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "route_id"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :route_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.route_id

    return validation_errors
end

"""
    validate_value_routes_agency_id(gtfs::GTFSSchedule)

Validate values of field 'agency_id' in routes.txt based on GTFS field type 'Foreign ID referencing `agency.agency_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_agency_id(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "agency_id"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :agency_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.agency_id

    return validation_errors
end

"""
    validate_value_routes_route_short_name(gtfs::GTFSSchedule)

Validate values of field 'route_short_name' in routes.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_route_short_name(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "route_short_name"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :route_short_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.route_short_name

    return validation_errors
end

"""
    validate_value_routes_route_long_name(gtfs::GTFSSchedule)

Validate values of field 'route_long_name' in routes.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_route_long_name(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "route_long_name"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :route_long_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.route_long_name

    return validation_errors
end

"""
    validate_value_routes_route_desc(gtfs::GTFSSchedule)

Validate values of field 'route_desc' in routes.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_route_desc(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "route_desc"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :route_desc)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.route_desc

    return validation_errors
end

"""
    validate_value_routes_route_type(gtfs::GTFSSchedule)

Validate values of field 'route_type' in routes.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_route_type(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "route_type"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :route_type)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.route_type

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_routes_route_url(gtfs::GTFSSchedule)

Validate values of field 'route_url' in routes.txt based on GTFS field type 'URL'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_route_url(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "route_url"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :route_url)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.route_url

# Validate URL format
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^https?://", val_str)
            push!(validation_errors, "Row $idx: Invalid URL '$val_str' (must start with http:// or https://)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_routes_route_color(gtfs::GTFSSchedule)

Validate values of field 'route_color' in routes.txt based on GTFS field type 'Color'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_route_color(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "route_color"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :route_color)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.route_color

# Validate color format (#RRGGBB)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^[0-9A-Fa-f]{6}$", val_str)
            push!(validation_errors, "Row $idx: Invalid color '$val_str' (expected 6-digit hex without #)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_routes_route_text_color(gtfs::GTFSSchedule)

Validate values of field 'route_text_color' in routes.txt based on GTFS field type 'Color'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_route_text_color(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "route_text_color"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :route_text_color)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.route_text_color

# Validate color format (#RRGGBB)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^[0-9A-Fa-f]{6}$", val_str)
            push!(validation_errors, "Row $idx: Invalid color '$val_str' (expected 6-digit hex without #)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_routes_route_sort_order(gtfs::GTFSSchedule)

Validate values of field 'route_sort_order' in routes.txt based on GTFS field type 'Non-negative integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_route_sort_order(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "route_sort_order"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :route_sort_order)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.route_sort_order

# Validate non-negative integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            int_val = Int(val)
            if int_val < 0
                push!(validation_errors, "Row $idx: Value $int_val must be non-negative")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_routes_continuous_pickup(gtfs::GTFSSchedule)

Validate values of field 'continuous_pickup' in routes.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_continuous_pickup(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "continuous_pickup"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :continuous_pickup)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.continuous_pickup

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_routes_continuous_drop_off(gtfs::GTFSSchedule)

Validate values of field 'continuous_drop_off' in routes.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_continuous_drop_off(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "continuous_drop_off"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :continuous_drop_off)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.continuous_drop_off

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_routes_network_id(gtfs::GTFSSchedule)

Validate values of field 'network_id' in routes.txt based on GTFS field type 'ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_network_id(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "network_id"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :network_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.network_id

    return validation_errors
end

"""
    validate_value_routes_cemv_support(gtfs::GTFSSchedule)

Validate values of field 'cemv_support' in routes.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_routes_cemv_support(gtfs::GTFSSchedule)
    filename = "routes.txt"
    field_name = "cemv_support"
    file_field = :routes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.routes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.routes, :cemv_support)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.routes.cemv_support

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_trips_route_id(gtfs::GTFSSchedule)

Validate values of field 'route_id' in trips.txt based on GTFS field type 'Foreign ID referencing `routes.route_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_trips_route_id(gtfs::GTFSSchedule)
    filename = "trips.txt"
    field_name = "route_id"
    file_field = :trips
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.trips === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.trips, :route_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.trips.route_id

    return validation_errors
end

"""
    validate_value_trips_service_id(gtfs::GTFSSchedule)

Validate values of field 'service_id' in trips.txt based on GTFS field type 'Foreign ID referencing `calendar.service_id` or `calendar_dates.service_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_trips_service_id(gtfs::GTFSSchedule)
    filename = "trips.txt"
    field_name = "service_id"
    file_field = :trips
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.trips === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.trips, :service_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.trips.service_id

# Validate date format (YYYYMMDD)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{8}$", val_str)
            push!(validation_errors, "Row $idx: Invalid date format '$val_str' (expected YYYYMMDD)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_trips_trip_id(gtfs::GTFSSchedule)

Validate values of field 'trip_id' in trips.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_trips_trip_id(gtfs::GTFSSchedule)
    filename = "trips.txt"
    field_name = "trip_id"
    file_field = :trips
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.trips === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.trips, :trip_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.trips.trip_id

    return validation_errors
end

"""
    validate_value_trips_trip_headsign(gtfs::GTFSSchedule)

Validate values of field 'trip_headsign' in trips.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_trips_trip_headsign(gtfs::GTFSSchedule)
    filename = "trips.txt"
    field_name = "trip_headsign"
    file_field = :trips
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.trips === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.trips, :trip_headsign)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.trips.trip_headsign

    return validation_errors
end

"""
    validate_value_trips_trip_short_name(gtfs::GTFSSchedule)

Validate values of field 'trip_short_name' in trips.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_trips_trip_short_name(gtfs::GTFSSchedule)
    filename = "trips.txt"
    field_name = "trip_short_name"
    file_field = :trips
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.trips === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.trips, :trip_short_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.trips.trip_short_name

    return validation_errors
end

"""
    validate_value_trips_direction_id(gtfs::GTFSSchedule)

Validate values of field 'direction_id' in trips.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_trips_direction_id(gtfs::GTFSSchedule)
    filename = "trips.txt"
    field_name = "direction_id"
    file_field = :trips
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.trips === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.trips, :direction_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.trips.direction_id

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_trips_block_id(gtfs::GTFSSchedule)

Validate values of field 'block_id' in trips.txt based on GTFS field type 'ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_trips_block_id(gtfs::GTFSSchedule)
    filename = "trips.txt"
    field_name = "block_id"
    file_field = :trips
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.trips === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.trips, :block_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.trips.block_id

    return validation_errors
end

"""
    validate_value_trips_shape_id(gtfs::GTFSSchedule)

Validate values of field 'shape_id' in trips.txt based on GTFS field type 'Foreign ID referencing `shapes.shape_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_trips_shape_id(gtfs::GTFSSchedule)
    filename = "trips.txt"
    field_name = "shape_id"
    file_field = :trips
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.trips === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.trips, :shape_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.trips.shape_id

    return validation_errors
end

"""
    validate_value_trips_wheelchair_accessible(gtfs::GTFSSchedule)

Validate values of field 'wheelchair_accessible' in trips.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_trips_wheelchair_accessible(gtfs::GTFSSchedule)
    filename = "trips.txt"
    field_name = "wheelchair_accessible"
    file_field = :trips
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.trips === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.trips, :wheelchair_accessible)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.trips.wheelchair_accessible

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_trips_bikes_allowed(gtfs::GTFSSchedule)

Validate values of field 'bikes_allowed' in trips.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_trips_bikes_allowed(gtfs::GTFSSchedule)
    filename = "trips.txt"
    field_name = "bikes_allowed"
    file_field = :trips
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.trips === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.trips, :bikes_allowed)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.trips.bikes_allowed

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_trips_cars_allowed(gtfs::GTFSSchedule)

Validate values of field 'cars_allowed' in trips.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_trips_cars_allowed(gtfs::GTFSSchedule)
    filename = "trips.txt"
    field_name = "cars_allowed"
    file_field = :trips
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.trips === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.trips, :cars_allowed)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.trips.cars_allowed

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_stop_times_trip_id(gtfs::GTFSSchedule)

Validate values of field 'trip_id' in stop_times.txt based on GTFS field type 'Foreign ID referencing `trips.trip_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_trip_id(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "trip_id"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :trip_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.trip_id

    return validation_errors
end

"""
    validate_value_stop_times_arrival_time(gtfs::GTFSSchedule)

Validate values of field 'arrival_time' in stop_times.txt based on GTFS field type 'Time'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_arrival_time(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "arrival_time"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :arrival_time)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.arrival_time

# Validate time format (HH:MM:SS)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{1,2}:\d{2}:\d{2}$", val_str)
            push!(validation_errors, "Row $idx: Invalid time format '$val_str' (expected HH:MM:SS)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_stop_times_departure_time(gtfs::GTFSSchedule)

Validate values of field 'departure_time' in stop_times.txt based on GTFS field type 'Time'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_departure_time(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "departure_time"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :departure_time)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.departure_time

# Validate time format (HH:MM:SS)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{1,2}:\d{2}:\d{2}$", val_str)
            push!(validation_errors, "Row $idx: Invalid time format '$val_str' (expected HH:MM:SS)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_stop_times_stop_id(gtfs::GTFSSchedule)

Validate values of field 'stop_id' in stop_times.txt based on GTFS field type 'Foreign ID referencing `stops.stop_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_stop_id(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "stop_id"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :stop_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.stop_id

    return validation_errors
end

"""
    validate_value_stop_times_location_group_id(gtfs::GTFSSchedule)

Validate values of field 'location_group_id' in stop_times.txt based on GTFS field type 'Foreign ID referencing `location_groups.location_group_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_location_group_id(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "location_group_id"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :location_group_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.location_group_id

    return validation_errors
end

"""
    validate_value_stop_times_location_id(gtfs::GTFSSchedule)

Validate values of field 'location_id' in stop_times.txt based on GTFS field type 'Foreign ID referencing `id` from `locations.geojson`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_location_id(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "location_id"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :location_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.location_id

    return validation_errors
end

"""
    validate_value_stop_times_stop_sequence(gtfs::GTFSSchedule)

Validate values of field 'stop_sequence' in stop_times.txt based on GTFS field type 'Non-negative integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_stop_sequence(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "stop_sequence"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :stop_sequence)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.stop_sequence

# Validate non-negative integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            int_val = Int(val)
            if int_val < 0
                push!(validation_errors, "Row $idx: Value $int_val must be non-negative")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_stop_times_stop_headsign(gtfs::GTFSSchedule)

Validate values of field 'stop_headsign' in stop_times.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_stop_headsign(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "stop_headsign"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :stop_headsign)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.stop_headsign

    return validation_errors
end

"""
    validate_value_stop_times_start_pickup_drop_off_window(gtfs::GTFSSchedule)

Validate values of field 'start_pickup_drop_off_window' in stop_times.txt based on GTFS field type 'Time'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_start_pickup_drop_off_window(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "start_pickup_drop_off_window"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :start_pickup_drop_off_window)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.start_pickup_drop_off_window

# Validate time format (HH:MM:SS)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{1,2}:\d{2}:\d{2}$", val_str)
            push!(validation_errors, "Row $idx: Invalid time format '$val_str' (expected HH:MM:SS)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_stop_times_end_pickup_drop_off_window(gtfs::GTFSSchedule)

Validate values of field 'end_pickup_drop_off_window' in stop_times.txt based on GTFS field type 'Time'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_end_pickup_drop_off_window(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "end_pickup_drop_off_window"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :end_pickup_drop_off_window)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.end_pickup_drop_off_window

# Validate time format (HH:MM:SS)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{1,2}:\d{2}:\d{2}$", val_str)
            push!(validation_errors, "Row $idx: Invalid time format '$val_str' (expected HH:MM:SS)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_stop_times_pickup_type(gtfs::GTFSSchedule)

Validate values of field 'pickup_type' in stop_times.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_pickup_type(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "pickup_type"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :pickup_type)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.pickup_type

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_stop_times_drop_off_type(gtfs::GTFSSchedule)

Validate values of field 'drop_off_type' in stop_times.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_drop_off_type(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "drop_off_type"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :drop_off_type)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.drop_off_type

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_stop_times_continuous_pickup(gtfs::GTFSSchedule)

Validate values of field 'continuous_pickup' in stop_times.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_continuous_pickup(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "continuous_pickup"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :continuous_pickup)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.continuous_pickup

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_stop_times_continuous_drop_off(gtfs::GTFSSchedule)

Validate values of field 'continuous_drop_off' in stop_times.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_continuous_drop_off(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "continuous_drop_off"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :continuous_drop_off)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.continuous_drop_off

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_stop_times_shape_dist_traveled(gtfs::GTFSSchedule)

Validate values of field 'shape_dist_traveled' in stop_times.txt based on GTFS field type 'Non-negative float'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_shape_dist_traveled(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "shape_dist_traveled"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :shape_dist_traveled)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.shape_dist_traveled

# Validate non-negative float
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            float_val = Float64(val)
            if float_val < 0.0
                push!(validation_errors, "Row $idx: Value $float_val must be non-negative")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid float value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_stop_times_timepoint(gtfs::GTFSSchedule)

Validate values of field 'timepoint' in stop_times.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_timepoint(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "timepoint"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :timepoint)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.timepoint

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_stop_times_pickup_booking_rule_id(gtfs::GTFSSchedule)

Validate values of field 'pickup_booking_rule_id' in stop_times.txt based on GTFS field type 'Foreign ID referencing `booking_rules.booking_rule_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_pickup_booking_rule_id(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "pickup_booking_rule_id"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :pickup_booking_rule_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.pickup_booking_rule_id

    return validation_errors
end

"""
    validate_value_stop_times_drop_off_booking_rule_id(gtfs::GTFSSchedule)

Validate values of field 'drop_off_booking_rule_id' in stop_times.txt based on GTFS field type 'Foreign ID referencing `booking_rules.booking_rule_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_times_drop_off_booking_rule_id(gtfs::GTFSSchedule)
    filename = "stop_times.txt"
    field_name = "drop_off_booking_rule_id"
    file_field = :stop_times
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_times === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_times, :drop_off_booking_rule_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_times.drop_off_booking_rule_id

    return validation_errors
end

"""
    validate_value_calendar_service_id(gtfs::GTFSSchedule)

Validate values of field 'service_id' in calendar.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_service_id(gtfs::GTFSSchedule)
    filename = "calendar.txt"
    field_name = "service_id"
    file_field = :calendar
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar, :service_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar.service_id

    return validation_errors
end

"""
    validate_value_calendar_monday(gtfs::GTFSSchedule)

Validate values of field 'monday' in calendar.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_monday(gtfs::GTFSSchedule)
    filename = "calendar.txt"
    field_name = "monday"
    file_field = :calendar
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar, :monday)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar.monday

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_calendar_tuesday(gtfs::GTFSSchedule)

Validate values of field 'tuesday' in calendar.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_tuesday(gtfs::GTFSSchedule)
    filename = "calendar.txt"
    field_name = "tuesday"
    file_field = :calendar
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar, :tuesday)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar.tuesday

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_calendar_wednesday(gtfs::GTFSSchedule)

Validate values of field 'wednesday' in calendar.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_wednesday(gtfs::GTFSSchedule)
    filename = "calendar.txt"
    field_name = "wednesday"
    file_field = :calendar
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar, :wednesday)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar.wednesday

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_calendar_thursday(gtfs::GTFSSchedule)

Validate values of field 'thursday' in calendar.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_thursday(gtfs::GTFSSchedule)
    filename = "calendar.txt"
    field_name = "thursday"
    file_field = :calendar
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar, :thursday)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar.thursday

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_calendar_friday(gtfs::GTFSSchedule)

Validate values of field 'friday' in calendar.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_friday(gtfs::GTFSSchedule)
    filename = "calendar.txt"
    field_name = "friday"
    file_field = :calendar
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar, :friday)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar.friday

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_calendar_saturday(gtfs::GTFSSchedule)

Validate values of field 'saturday' in calendar.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_saturday(gtfs::GTFSSchedule)
    filename = "calendar.txt"
    field_name = "saturday"
    file_field = :calendar
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar, :saturday)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar.saturday

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_calendar_sunday(gtfs::GTFSSchedule)

Validate values of field 'sunday' in calendar.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_sunday(gtfs::GTFSSchedule)
    filename = "calendar.txt"
    field_name = "sunday"
    file_field = :calendar
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar, :sunday)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar.sunday

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_calendar_start_date(gtfs::GTFSSchedule)

Validate values of field 'start_date' in calendar.txt based on GTFS field type 'Date'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_start_date(gtfs::GTFSSchedule)
    filename = "calendar.txt"
    field_name = "start_date"
    file_field = :calendar
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar, :start_date)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar.start_date

# Validate date format (YYYYMMDD)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{8}$", val_str)
            push!(validation_errors, "Row $idx: Invalid date format '$val_str' (expected YYYYMMDD)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_calendar_end_date(gtfs::GTFSSchedule)

Validate values of field 'end_date' in calendar.txt based on GTFS field type 'Date'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_end_date(gtfs::GTFSSchedule)
    filename = "calendar.txt"
    field_name = "end_date"
    file_field = :calendar
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar, :end_date)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar.end_date

# Validate date format (YYYYMMDD)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{8}$", val_str)
            push!(validation_errors, "Row $idx: Invalid date format '$val_str' (expected YYYYMMDD)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_calendar_dates_service_id(gtfs::GTFSSchedule)

Validate values of field 'service_id' in calendar_dates.txt based on GTFS field type 'Foreign ID referencing `calendar.service_id` or ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_dates_service_id(gtfs::GTFSSchedule)
    filename = "calendar_dates.txt"
    field_name = "service_id"
    file_field = :calendar_dates
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar_dates === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar_dates, :service_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar_dates.service_id

    return validation_errors
end

"""
    validate_value_calendar_dates_date(gtfs::GTFSSchedule)

Validate values of field 'date' in calendar_dates.txt based on GTFS field type 'Date'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_dates_date(gtfs::GTFSSchedule)
    filename = "calendar_dates.txt"
    field_name = "date"
    file_field = :calendar_dates
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar_dates === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar_dates, :date)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar_dates.date

# Validate date format (YYYYMMDD)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{8}$", val_str)
            push!(validation_errors, "Row $idx: Invalid date format '$val_str' (expected YYYYMMDD)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_calendar_dates_exception_type(gtfs::GTFSSchedule)

Validate values of field 'exception_type' in calendar_dates.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_calendar_dates_exception_type(gtfs::GTFSSchedule)
    filename = "calendar_dates.txt"
    field_name = "exception_type"
    file_field = :calendar_dates
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.calendar_dates === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.calendar_dates, :exception_type)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.calendar_dates.exception_type

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_fare_attributes_fare_id(gtfs::GTFSSchedule)

Validate values of field 'fare_id' in fare_attributes.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_attributes_fare_id(gtfs::GTFSSchedule)
    filename = "fare_attributes.txt"
    field_name = "fare_id"
    file_field = :fare_attributes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_attributes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_attributes, :fare_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_attributes.fare_id

    return validation_errors
end

"""
    validate_value_fare_attributes_price(gtfs::GTFSSchedule)

Validate values of field 'price' in fare_attributes.txt based on GTFS field type 'Non-negative float'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_attributes_price(gtfs::GTFSSchedule)
    filename = "fare_attributes.txt"
    field_name = "price"
    file_field = :fare_attributes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_attributes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_attributes, :price)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_attributes.price

# Validate non-negative float
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            float_val = Float64(val)
            if float_val < 0.0
                push!(validation_errors, "Row $idx: Value $float_val must be non-negative")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid float value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_fare_attributes_currency_type(gtfs::GTFSSchedule)

Validate values of field 'currency_type' in fare_attributes.txt based on GTFS field type 'Currency code'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_attributes_currency_type(gtfs::GTFSSchedule)
    filename = "fare_attributes.txt"
    field_name = "currency_type"
    file_field = :fare_attributes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_attributes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_attributes, :currency_type)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_attributes.currency_type

    return validation_errors
end

"""
    validate_value_fare_attributes_payment_method(gtfs::GTFSSchedule)

Validate values of field 'payment_method' in fare_attributes.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_attributes_payment_method(gtfs::GTFSSchedule)
    filename = "fare_attributes.txt"
    field_name = "payment_method"
    file_field = :fare_attributes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_attributes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_attributes, :payment_method)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_attributes.payment_method

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_fare_attributes_transfers(gtfs::GTFSSchedule)

Validate values of field 'transfers' in fare_attributes.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_attributes_transfers(gtfs::GTFSSchedule)
    filename = "fare_attributes.txt"
    field_name = "transfers"
    file_field = :fare_attributes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_attributes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_attributes, :transfers)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_attributes.transfers

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_fare_attributes_agency_id(gtfs::GTFSSchedule)

Validate values of field 'agency_id' in fare_attributes.txt based on GTFS field type 'Foreign ID referencing `agency.agency_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_attributes_agency_id(gtfs::GTFSSchedule)
    filename = "fare_attributes.txt"
    field_name = "agency_id"
    file_field = :fare_attributes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_attributes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_attributes, :agency_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_attributes.agency_id

    return validation_errors
end

"""
    validate_value_fare_attributes_transfer_duration(gtfs::GTFSSchedule)

Validate values of field 'transfer_duration' in fare_attributes.txt based on GTFS field type 'Non-negative integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_attributes_transfer_duration(gtfs::GTFSSchedule)
    filename = "fare_attributes.txt"
    field_name = "transfer_duration"
    file_field = :fare_attributes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_attributes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_attributes, :transfer_duration)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_attributes.transfer_duration

# Validate non-negative integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            int_val = Int(val)
            if int_val < 0
                push!(validation_errors, "Row $idx: Value $int_val must be non-negative")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_fare_rules_fare_id(gtfs::GTFSSchedule)

Validate values of field 'fare_id' in fare_rules.txt based on GTFS field type 'Foreign ID referencing `fare_attributes.fare_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_rules_fare_id(gtfs::GTFSSchedule)
    filename = "fare_rules.txt"
    field_name = "fare_id"
    file_field = :fare_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_rules, :fare_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_rules.fare_id

    return validation_errors
end

"""
    validate_value_fare_rules_route_id(gtfs::GTFSSchedule)

Validate values of field 'route_id' in fare_rules.txt based on GTFS field type 'Foreign ID referencing `routes.route_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_rules_route_id(gtfs::GTFSSchedule)
    filename = "fare_rules.txt"
    field_name = "route_id"
    file_field = :fare_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_rules, :route_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_rules.route_id

    return validation_errors
end

"""
    validate_value_fare_rules_origin_id(gtfs::GTFSSchedule)

Validate values of field 'origin_id' in fare_rules.txt based on GTFS field type 'Foreign ID referencing `stops.zone_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_rules_origin_id(gtfs::GTFSSchedule)
    filename = "fare_rules.txt"
    field_name = "origin_id"
    file_field = :fare_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_rules, :origin_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_rules.origin_id

    return validation_errors
end

"""
    validate_value_fare_rules_destination_id(gtfs::GTFSSchedule)

Validate values of field 'destination_id' in fare_rules.txt based on GTFS field type 'Foreign ID referencing `stops.zone_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_rules_destination_id(gtfs::GTFSSchedule)
    filename = "fare_rules.txt"
    field_name = "destination_id"
    file_field = :fare_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_rules, :destination_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_rules.destination_id

    return validation_errors
end

"""
    validate_value_fare_rules_contains_id(gtfs::GTFSSchedule)

Validate values of field 'contains_id' in fare_rules.txt based on GTFS field type 'Foreign ID referencing `stops.zone_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_rules_contains_id(gtfs::GTFSSchedule)
    filename = "fare_rules.txt"
    field_name = "contains_id"
    file_field = :fare_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_rules, :contains_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_rules.contains_id

    return validation_errors
end

"""
    validate_value_timeframes_timeframe_group_id(gtfs::GTFSSchedule)

Validate values of field 'timeframe_group_id' in timeframes.txt based on GTFS field type 'ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_timeframes_timeframe_group_id(gtfs::GTFSSchedule)
    filename = "timeframes.txt"
    field_name = "timeframe_group_id"
    file_field = :timeframes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.timeframes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.timeframes, :timeframe_group_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.timeframes.timeframe_group_id

    return validation_errors
end

"""
    validate_value_timeframes_start_time(gtfs::GTFSSchedule)

Validate values of field 'start_time' in timeframes.txt based on GTFS field type 'Time'.
Returns Vector{String} with validation error messages.
"""
function validate_value_timeframes_start_time(gtfs::GTFSSchedule)
    filename = "timeframes.txt"
    field_name = "start_time"
    file_field = :timeframes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.timeframes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.timeframes, :start_time)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.timeframes.start_time

# Validate time format (HH:MM:SS)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{1,2}:\d{2}:\d{2}$", val_str)
            push!(validation_errors, "Row $idx: Invalid time format '$val_str' (expected HH:MM:SS)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_timeframes_end_time(gtfs::GTFSSchedule)

Validate values of field 'end_time' in timeframes.txt based on GTFS field type 'Time'.
Returns Vector{String} with validation error messages.
"""
function validate_value_timeframes_end_time(gtfs::GTFSSchedule)
    filename = "timeframes.txt"
    field_name = "end_time"
    file_field = :timeframes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.timeframes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.timeframes, :end_time)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.timeframes.end_time

# Validate time format (HH:MM:SS)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{1,2}:\d{2}:\d{2}$", val_str)
            push!(validation_errors, "Row $idx: Invalid time format '$val_str' (expected HH:MM:SS)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_timeframes_service_id(gtfs::GTFSSchedule)

Validate values of field 'service_id' in timeframes.txt based on GTFS field type 'Foreign ID referencing `calendar.service_id` or `calendar_dates.service_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_timeframes_service_id(gtfs::GTFSSchedule)
    filename = "timeframes.txt"
    field_name = "service_id"
    file_field = :timeframes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.timeframes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.timeframes, :service_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.timeframes.service_id

# Validate date format (YYYYMMDD)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{8}$", val_str)
            push!(validation_errors, "Row $idx: Invalid date format '$val_str' (expected YYYYMMDD)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_rider_categories_rider_category_id(gtfs::GTFSSchedule)

Validate values of field 'rider_category_id' in rider_categories.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_rider_categories_rider_category_id(gtfs::GTFSSchedule)
    filename = "rider_categories.txt"
    field_name = "rider_category_id"
    file_field = :rider_categories
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.rider_categories === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.rider_categories, :rider_category_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.rider_categories.rider_category_id

    return validation_errors
end

"""
    validate_value_rider_categories_rider_category_name(gtfs::GTFSSchedule)

Validate values of field 'rider_category_name' in rider_categories.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_rider_categories_rider_category_name(gtfs::GTFSSchedule)
    filename = "rider_categories.txt"
    field_name = "rider_category_name"
    file_field = :rider_categories
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.rider_categories === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.rider_categories, :rider_category_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.rider_categories.rider_category_name

    return validation_errors
end

"""
    validate_value_rider_categories_is_default_fare_category(gtfs::GTFSSchedule)

Validate values of field 'is_default_fare_category' in rider_categories.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_rider_categories_is_default_fare_category(gtfs::GTFSSchedule)
    filename = "rider_categories.txt"
    field_name = "is_default_fare_category"
    file_field = :rider_categories
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.rider_categories === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.rider_categories, :is_default_fare_category)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.rider_categories.is_default_fare_category

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_rider_categories_eligibility_url(gtfs::GTFSSchedule)

Validate values of field 'eligibility_url' in rider_categories.txt based on GTFS field type 'URL'.
Returns Vector{String} with validation error messages.
"""
function validate_value_rider_categories_eligibility_url(gtfs::GTFSSchedule)
    filename = "rider_categories.txt"
    field_name = "eligibility_url"
    file_field = :rider_categories
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.rider_categories === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.rider_categories, :eligibility_url)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.rider_categories.eligibility_url

# Validate URL format
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^https?://", val_str)
            push!(validation_errors, "Row $idx: Invalid URL '$val_str' (must start with http:// or https://)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_fare_media_fare_media_id(gtfs::GTFSSchedule)

Validate values of field 'fare_media_id' in fare_media.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_media_fare_media_id(gtfs::GTFSSchedule)
    filename = "fare_media.txt"
    field_name = "fare_media_id"
    file_field = :fare_media
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_media === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_media, :fare_media_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_media.fare_media_id

    return validation_errors
end

"""
    validate_value_fare_media_fare_media_name(gtfs::GTFSSchedule)

Validate values of field 'fare_media_name' in fare_media.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_media_fare_media_name(gtfs::GTFSSchedule)
    filename = "fare_media.txt"
    field_name = "fare_media_name"
    file_field = :fare_media
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_media === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_media, :fare_media_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_media.fare_media_name

    return validation_errors
end

"""
    validate_value_fare_media_fare_media_type(gtfs::GTFSSchedule)

Validate values of field 'fare_media_type' in fare_media.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_media_fare_media_type(gtfs::GTFSSchedule)
    filename = "fare_media.txt"
    field_name = "fare_media_type"
    file_field = :fare_media
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_media === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_media, :fare_media_type)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_media.fare_media_type

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_fare_products_fare_product_id(gtfs::GTFSSchedule)

Validate values of field 'fare_product_id' in fare_products.txt based on GTFS field type 'ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_products_fare_product_id(gtfs::GTFSSchedule)
    filename = "fare_products.txt"
    field_name = "fare_product_id"
    file_field = :fare_products
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_products === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_products, :fare_product_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_products.fare_product_id

    return validation_errors
end

"""
    validate_value_fare_products_fare_product_name(gtfs::GTFSSchedule)

Validate values of field 'fare_product_name' in fare_products.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_products_fare_product_name(gtfs::GTFSSchedule)
    filename = "fare_products.txt"
    field_name = "fare_product_name"
    file_field = :fare_products
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_products === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_products, :fare_product_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_products.fare_product_name

    return validation_errors
end

"""
    validate_value_fare_products_rider_category_id(gtfs::GTFSSchedule)

Validate values of field 'rider_category_id' in fare_products.txt based on GTFS field type 'Foreign ID referencing `rider_categories.rider_category_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_products_rider_category_id(gtfs::GTFSSchedule)
    filename = "fare_products.txt"
    field_name = "rider_category_id"
    file_field = :fare_products
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_products === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_products, :rider_category_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_products.rider_category_id

    return validation_errors
end

"""
    validate_value_fare_products_fare_media_id(gtfs::GTFSSchedule)

Validate values of field 'fare_media_id' in fare_products.txt based on GTFS field type 'Foreign ID referencing `fare_media.fare_media_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_products_fare_media_id(gtfs::GTFSSchedule)
    filename = "fare_products.txt"
    field_name = "fare_media_id"
    file_field = :fare_products
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_products === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_products, :fare_media_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_products.fare_media_id

    return validation_errors
end

"""
    validate_value_fare_products_amount(gtfs::GTFSSchedule)

Validate values of field 'amount' in fare_products.txt based on GTFS field type 'Currency amount'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_products_amount(gtfs::GTFSSchedule)
    filename = "fare_products.txt"
    field_name = "amount"
    file_field = :fare_products
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_products === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_products, :amount)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_products.amount

    return validation_errors
end

"""
    validate_value_fare_products_currency(gtfs::GTFSSchedule)

Validate values of field 'currency' in fare_products.txt based on GTFS field type 'Currency code'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_products_currency(gtfs::GTFSSchedule)
    filename = "fare_products.txt"
    field_name = "currency"
    file_field = :fare_products
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_products === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_products, :currency)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_products.currency

    return validation_errors
end

"""
    validate_value_fare_leg_rules_leg_group_id(gtfs::GTFSSchedule)

Validate values of field 'leg_group_id' in fare_leg_rules.txt based on GTFS field type 'ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_leg_rules_leg_group_id(gtfs::GTFSSchedule)
    filename = "fare_leg_rules.txt"
    field_name = "leg_group_id"
    file_field = :fare_leg_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_rules, :leg_group_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_leg_rules.leg_group_id

    return validation_errors
end

"""
    validate_value_fare_leg_rules_network_id(gtfs::GTFSSchedule)

Validate values of field 'network_id' in fare_leg_rules.txt based on GTFS field type 'Foreign ID referencing `routes.network_id` or `networks.network_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_leg_rules_network_id(gtfs::GTFSSchedule)
    filename = "fare_leg_rules.txt"
    field_name = "network_id"
    file_field = :fare_leg_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_rules, :network_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_leg_rules.network_id

    return validation_errors
end

"""
    validate_value_fare_leg_rules_from_area_id(gtfs::GTFSSchedule)

Validate values of field 'from_area_id' in fare_leg_rules.txt based on GTFS field type 'Foreign ID referencing `areas.area_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_leg_rules_from_area_id(gtfs::GTFSSchedule)
    filename = "fare_leg_rules.txt"
    field_name = "from_area_id"
    file_field = :fare_leg_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_rules, :from_area_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_leg_rules.from_area_id

    return validation_errors
end

"""
    validate_value_fare_leg_rules_to_area_id(gtfs::GTFSSchedule)

Validate values of field 'to_area_id' in fare_leg_rules.txt based on GTFS field type 'Foreign ID referencing `areas.area_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_leg_rules_to_area_id(gtfs::GTFSSchedule)
    filename = "fare_leg_rules.txt"
    field_name = "to_area_id"
    file_field = :fare_leg_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_rules, :to_area_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_leg_rules.to_area_id

    return validation_errors
end

"""
    validate_value_fare_leg_rules_from_timeframe_group_id(gtfs::GTFSSchedule)

Validate values of field 'from_timeframe_group_id' in fare_leg_rules.txt based on GTFS field type 'Foreign ID referencing `timeframes.timeframe_group_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_leg_rules_from_timeframe_group_id(gtfs::GTFSSchedule)
    filename = "fare_leg_rules.txt"
    field_name = "from_timeframe_group_id"
    file_field = :fare_leg_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_rules, :from_timeframe_group_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_leg_rules.from_timeframe_group_id

    return validation_errors
end

"""
    validate_value_fare_leg_rules_to_timeframe_group_id(gtfs::GTFSSchedule)

Validate values of field 'to_timeframe_group_id' in fare_leg_rules.txt based on GTFS field type 'Foreign ID referencing `timeframes.timeframe_group_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_leg_rules_to_timeframe_group_id(gtfs::GTFSSchedule)
    filename = "fare_leg_rules.txt"
    field_name = "to_timeframe_group_id"
    file_field = :fare_leg_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_rules, :to_timeframe_group_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_leg_rules.to_timeframe_group_id

    return validation_errors
end

"""
    validate_value_fare_leg_rules_fare_product_id(gtfs::GTFSSchedule)

Validate values of field 'fare_product_id' in fare_leg_rules.txt based on GTFS field type 'Foreign ID referencing `fare_products.fare_product_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_leg_rules_fare_product_id(gtfs::GTFSSchedule)
    filename = "fare_leg_rules.txt"
    field_name = "fare_product_id"
    file_field = :fare_leg_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_rules, :fare_product_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_leg_rules.fare_product_id

    return validation_errors
end

"""
    validate_value_fare_leg_rules_rule_priority(gtfs::GTFSSchedule)

Validate values of field 'rule_priority' in fare_leg_rules.txt based on GTFS field type 'Non-negative integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_leg_rules_rule_priority(gtfs::GTFSSchedule)
    filename = "fare_leg_rules.txt"
    field_name = "rule_priority"
    file_field = :fare_leg_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_rules, :rule_priority)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_leg_rules.rule_priority

# Validate non-negative integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            int_val = Int(val)
            if int_val < 0
                push!(validation_errors, "Row $idx: Value $int_val must be non-negative")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_fare_leg_join_rules_from_network_id(gtfs::GTFSSchedule)

Validate values of field 'from_network_id' in fare_leg_join_rules.txt based on GTFS field type 'Foreign ID referencing `routes.network_id` or `networks.network_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_leg_join_rules_from_network_id(gtfs::GTFSSchedule)
    filename = "fare_leg_join_rules.txt"
    field_name = "from_network_id"
    file_field = :fare_leg_join_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_join_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_join_rules, :from_network_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_leg_join_rules.from_network_id

    return validation_errors
end

"""
    validate_value_fare_leg_join_rules_to_network_id(gtfs::GTFSSchedule)

Validate values of field 'to_network_id' in fare_leg_join_rules.txt based on GTFS field type 'Foreign ID referencing `routes.network_id` or `networks.network_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_leg_join_rules_to_network_id(gtfs::GTFSSchedule)
    filename = "fare_leg_join_rules.txt"
    field_name = "to_network_id"
    file_field = :fare_leg_join_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_join_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_join_rules, :to_network_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_leg_join_rules.to_network_id

    return validation_errors
end

"""
    validate_value_fare_leg_join_rules_from_stop_id(gtfs::GTFSSchedule)

Validate values of field 'from_stop_id' in fare_leg_join_rules.txt based on GTFS field type 'Foreign ID referencing `stops.stop_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_leg_join_rules_from_stop_id(gtfs::GTFSSchedule)
    filename = "fare_leg_join_rules.txt"
    field_name = "from_stop_id"
    file_field = :fare_leg_join_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_join_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_join_rules, :from_stop_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_leg_join_rules.from_stop_id

    return validation_errors
end

"""
    validate_value_fare_leg_join_rules_to_stop_id(gtfs::GTFSSchedule)

Validate values of field 'to_stop_id' in fare_leg_join_rules.txt based on GTFS field type 'Foreign ID referencing `stops.stop_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_leg_join_rules_to_stop_id(gtfs::GTFSSchedule)
    filename = "fare_leg_join_rules.txt"
    field_name = "to_stop_id"
    file_field = :fare_leg_join_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_leg_join_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_leg_join_rules, :to_stop_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_leg_join_rules.to_stop_id

    return validation_errors
end

"""
    validate_value_fare_transfer_rules_from_leg_group_id(gtfs::GTFSSchedule)

Validate values of field 'from_leg_group_id' in fare_transfer_rules.txt based on GTFS field type 'Foreign ID referencing `fare_leg_rules.leg_group_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_transfer_rules_from_leg_group_id(gtfs::GTFSSchedule)
    filename = "fare_transfer_rules.txt"
    field_name = "from_leg_group_id"
    file_field = :fare_transfer_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_transfer_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_transfer_rules, :from_leg_group_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_transfer_rules.from_leg_group_id

    return validation_errors
end

"""
    validate_value_fare_transfer_rules_to_leg_group_id(gtfs::GTFSSchedule)

Validate values of field 'to_leg_group_id' in fare_transfer_rules.txt based on GTFS field type 'Foreign ID referencing `fare_leg_rules.leg_group_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_transfer_rules_to_leg_group_id(gtfs::GTFSSchedule)
    filename = "fare_transfer_rules.txt"
    field_name = "to_leg_group_id"
    file_field = :fare_transfer_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_transfer_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_transfer_rules, :to_leg_group_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_transfer_rules.to_leg_group_id

    return validation_errors
end

"""
    validate_value_fare_transfer_rules_transfer_count(gtfs::GTFSSchedule)

Validate values of field 'transfer_count' in fare_transfer_rules.txt based on GTFS field type 'Non-zero integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_transfer_rules_transfer_count(gtfs::GTFSSchedule)
    filename = "fare_transfer_rules.txt"
    field_name = "transfer_count"
    file_field = :fare_transfer_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_transfer_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_transfer_rules, :transfer_count)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_transfer_rules.transfer_count

# Validate integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            Int(val)
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_fare_transfer_rules_duration_limit(gtfs::GTFSSchedule)

Validate values of field 'duration_limit' in fare_transfer_rules.txt based on GTFS field type 'Positive integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_transfer_rules_duration_limit(gtfs::GTFSSchedule)
    filename = "fare_transfer_rules.txt"
    field_name = "duration_limit"
    file_field = :fare_transfer_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_transfer_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_transfer_rules, :duration_limit)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_transfer_rules.duration_limit

# Validate positive integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            int_val = Int(val)
            if int_val <= 0
                push!(validation_errors, "Row $idx: Value $int_val must be positive")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_fare_transfer_rules_duration_limit_type(gtfs::GTFSSchedule)

Validate values of field 'duration_limit_type' in fare_transfer_rules.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_transfer_rules_duration_limit_type(gtfs::GTFSSchedule)
    filename = "fare_transfer_rules.txt"
    field_name = "duration_limit_type"
    file_field = :fare_transfer_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_transfer_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_transfer_rules, :duration_limit_type)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_transfer_rules.duration_limit_type

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_fare_transfer_rules_fare_transfer_type(gtfs::GTFSSchedule)

Validate values of field 'fare_transfer_type' in fare_transfer_rules.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_transfer_rules_fare_transfer_type(gtfs::GTFSSchedule)
    filename = "fare_transfer_rules.txt"
    field_name = "fare_transfer_type"
    file_field = :fare_transfer_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_transfer_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_transfer_rules, :fare_transfer_type)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_transfer_rules.fare_transfer_type

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_fare_transfer_rules_fare_product_id(gtfs::GTFSSchedule)

Validate values of field 'fare_product_id' in fare_transfer_rules.txt based on GTFS field type 'Foreign ID referencing `fare_products.fare_product_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_fare_transfer_rules_fare_product_id(gtfs::GTFSSchedule)
    filename = "fare_transfer_rules.txt"
    field_name = "fare_product_id"
    file_field = :fare_transfer_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.fare_transfer_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.fare_transfer_rules, :fare_product_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.fare_transfer_rules.fare_product_id

    return validation_errors
end

"""
    validate_value_areas_area_id(gtfs::GTFSSchedule)

Validate values of field 'area_id' in areas.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_areas_area_id(gtfs::GTFSSchedule)
    filename = "areas.txt"
    field_name = "area_id"
    file_field = :areas
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.areas === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.areas, :area_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.areas.area_id

    return validation_errors
end

"""
    validate_value_areas_area_name(gtfs::GTFSSchedule)

Validate values of field 'area_name' in areas.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_areas_area_name(gtfs::GTFSSchedule)
    filename = "areas.txt"
    field_name = "area_name"
    file_field = :areas
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.areas === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.areas, :area_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.areas.area_name

    return validation_errors
end

"""
    validate_value_stop_areas_area_id(gtfs::GTFSSchedule)

Validate values of field 'area_id' in stop_areas.txt based on GTFS field type 'Foreign ID referencing `areas.area_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_areas_area_id(gtfs::GTFSSchedule)
    filename = "stop_areas.txt"
    field_name = "area_id"
    file_field = :stop_areas
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_areas === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_areas, :area_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_areas.area_id

    return validation_errors
end

"""
    validate_value_stop_areas_stop_id(gtfs::GTFSSchedule)

Validate values of field 'stop_id' in stop_areas.txt based on GTFS field type 'Foreign ID referencing `stops.stop_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_stop_areas_stop_id(gtfs::GTFSSchedule)
    filename = "stop_areas.txt"
    field_name = "stop_id"
    file_field = :stop_areas
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.stop_areas === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.stop_areas, :stop_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.stop_areas.stop_id

    return validation_errors
end

"""
    validate_value_networks_network_id(gtfs::GTFSSchedule)

Validate values of field 'network_id' in networks.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_networks_network_id(gtfs::GTFSSchedule)
    filename = "networks.txt"
    field_name = "network_id"
    file_field = :networks
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.networks === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.networks, :network_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.networks.network_id

    return validation_errors
end

"""
    validate_value_networks_network_name(gtfs::GTFSSchedule)

Validate values of field 'network_name' in networks.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_networks_network_name(gtfs::GTFSSchedule)
    filename = "networks.txt"
    field_name = "network_name"
    file_field = :networks
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.networks === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.networks, :network_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.networks.network_name

    return validation_errors
end

"""
    validate_value_route_networks_network_id(gtfs::GTFSSchedule)

Validate values of field 'network_id' in route_networks.txt based on GTFS field type 'Foreign ID referencing `networks.network_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_route_networks_network_id(gtfs::GTFSSchedule)
    filename = "route_networks.txt"
    field_name = "network_id"
    file_field = :route_networks
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.route_networks === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.route_networks, :network_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.route_networks.network_id

    return validation_errors
end

"""
    validate_value_route_networks_route_id(gtfs::GTFSSchedule)

Validate values of field 'route_id' in route_networks.txt based on GTFS field type 'Foreign ID referencing `routes.route_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_route_networks_route_id(gtfs::GTFSSchedule)
    filename = "route_networks.txt"
    field_name = "route_id"
    file_field = :route_networks
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.route_networks === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.route_networks, :route_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.route_networks.route_id

    return validation_errors
end

"""
    validate_value_shapes_shape_id(gtfs::GTFSSchedule)

Validate values of field 'shape_id' in shapes.txt based on GTFS field type 'ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_shapes_shape_id(gtfs::GTFSSchedule)
    filename = "shapes.txt"
    field_name = "shape_id"
    file_field = :shapes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.shapes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.shapes, :shape_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.shapes.shape_id

    return validation_errors
end

"""
    validate_value_shapes_shape_pt_lat(gtfs::GTFSSchedule)

Validate values of field 'shape_pt_lat' in shapes.txt based on GTFS field type 'Latitude'.
Returns Vector{String} with validation error messages.
"""
function validate_value_shapes_shape_pt_lat(gtfs::GTFSSchedule)
    filename = "shapes.txt"
    field_name = "shape_pt_lat"
    file_field = :shapes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.shapes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.shapes, :shape_pt_lat)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.shapes.shape_pt_lat

# Validate latitude range (-90 to 90)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            lat = Float64(val)
            if lat < -90.0 || lat > 90.0
                push!(validation_errors, "Row $idx: Latitude $lat out of range (must be between -90 and 90)")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid latitude value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_shapes_shape_pt_lon(gtfs::GTFSSchedule)

Validate values of field 'shape_pt_lon' in shapes.txt based on GTFS field type 'Longitude'.
Returns Vector{String} with validation error messages.
"""
function validate_value_shapes_shape_pt_lon(gtfs::GTFSSchedule)
    filename = "shapes.txt"
    field_name = "shape_pt_lon"
    file_field = :shapes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.shapes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.shapes, :shape_pt_lon)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.shapes.shape_pt_lon

# Validate longitude range (-180 to 180)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            lon = Float64(val)
            if lon < -180.0 || lon > 180.0
                push!(validation_errors, "Row $idx: Longitude $lon out of range (must be between -180 and 180)")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid longitude value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_shapes_shape_pt_sequence(gtfs::GTFSSchedule)

Validate values of field 'shape_pt_sequence' in shapes.txt based on GTFS field type 'Non-negative integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_shapes_shape_pt_sequence(gtfs::GTFSSchedule)
    filename = "shapes.txt"
    field_name = "shape_pt_sequence"
    file_field = :shapes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.shapes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.shapes, :shape_pt_sequence)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.shapes.shape_pt_sequence

# Validate non-negative integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            int_val = Int(val)
            if int_val < 0
                push!(validation_errors, "Row $idx: Value $int_val must be non-negative")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_shapes_shape_dist_traveled(gtfs::GTFSSchedule)

Validate values of field 'shape_dist_traveled' in shapes.txt based on GTFS field type 'Non-negative float'.
Returns Vector{String} with validation error messages.
"""
function validate_value_shapes_shape_dist_traveled(gtfs::GTFSSchedule)
    filename = "shapes.txt"
    field_name = "shape_dist_traveled"
    file_field = :shapes
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.shapes === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.shapes, :shape_dist_traveled)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.shapes.shape_dist_traveled

# Validate non-negative float
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            float_val = Float64(val)
            if float_val < 0.0
                push!(validation_errors, "Row $idx: Value $float_val must be non-negative")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid float value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_frequencies_trip_id(gtfs::GTFSSchedule)

Validate values of field 'trip_id' in frequencies.txt based on GTFS field type 'Foreign ID referencing `trips.trip_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_frequencies_trip_id(gtfs::GTFSSchedule)
    filename = "frequencies.txt"
    field_name = "trip_id"
    file_field = :frequencies
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.frequencies === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.frequencies, :trip_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.frequencies.trip_id

    return validation_errors
end

"""
    validate_value_frequencies_start_time(gtfs::GTFSSchedule)

Validate values of field 'start_time' in frequencies.txt based on GTFS field type 'Time'.
Returns Vector{String} with validation error messages.
"""
function validate_value_frequencies_start_time(gtfs::GTFSSchedule)
    filename = "frequencies.txt"
    field_name = "start_time"
    file_field = :frequencies
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.frequencies === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.frequencies, :start_time)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.frequencies.start_time

# Validate time format (HH:MM:SS)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{1,2}:\d{2}:\d{2}$", val_str)
            push!(validation_errors, "Row $idx: Invalid time format '$val_str' (expected HH:MM:SS)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_frequencies_end_time(gtfs::GTFSSchedule)

Validate values of field 'end_time' in frequencies.txt based on GTFS field type 'Time'.
Returns Vector{String} with validation error messages.
"""
function validate_value_frequencies_end_time(gtfs::GTFSSchedule)
    filename = "frequencies.txt"
    field_name = "end_time"
    file_field = :frequencies
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.frequencies === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.frequencies, :end_time)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.frequencies.end_time

# Validate time format (HH:MM:SS)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{1,2}:\d{2}:\d{2}$", val_str)
            push!(validation_errors, "Row $idx: Invalid time format '$val_str' (expected HH:MM:SS)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_frequencies_headway_secs(gtfs::GTFSSchedule)

Validate values of field 'headway_secs' in frequencies.txt based on GTFS field type 'Positive integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_frequencies_headway_secs(gtfs::GTFSSchedule)
    filename = "frequencies.txt"
    field_name = "headway_secs"
    file_field = :frequencies
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.frequencies === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.frequencies, :headway_secs)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.frequencies.headway_secs

# Validate positive integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            int_val = Int(val)
            if int_val <= 0
                push!(validation_errors, "Row $idx: Value $int_val must be positive")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_frequencies_exact_times(gtfs::GTFSSchedule)

Validate values of field 'exact_times' in frequencies.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_frequencies_exact_times(gtfs::GTFSSchedule)
    filename = "frequencies.txt"
    field_name = "exact_times"
    file_field = :frequencies
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.frequencies === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.frequencies, :exact_times)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.frequencies.exact_times

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_transfers_from_stop_id(gtfs::GTFSSchedule)

Validate values of field 'from_stop_id' in transfers.txt based on GTFS field type 'Foreign ID referencing `stops.stop_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_transfers_from_stop_id(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    field_name = "from_stop_id"
    file_field = :transfers
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.transfers === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.transfers, :from_stop_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.transfers.from_stop_id

    return validation_errors
end

"""
    validate_value_transfers_to_stop_id(gtfs::GTFSSchedule)

Validate values of field 'to_stop_id' in transfers.txt based on GTFS field type 'Foreign ID referencing `stops.stop_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_transfers_to_stop_id(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    field_name = "to_stop_id"
    file_field = :transfers
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.transfers === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.transfers, :to_stop_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.transfers.to_stop_id

    return validation_errors
end

"""
    validate_value_transfers_from_route_id(gtfs::GTFSSchedule)

Validate values of field 'from_route_id' in transfers.txt based on GTFS field type 'Foreign ID referencing `routes.route_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_transfers_from_route_id(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    field_name = "from_route_id"
    file_field = :transfers
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.transfers === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.transfers, :from_route_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.transfers.from_route_id

    return validation_errors
end

"""
    validate_value_transfers_to_route_id(gtfs::GTFSSchedule)

Validate values of field 'to_route_id' in transfers.txt based on GTFS field type 'Foreign ID referencing `routes.route_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_transfers_to_route_id(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    field_name = "to_route_id"
    file_field = :transfers
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.transfers === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.transfers, :to_route_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.transfers.to_route_id

    return validation_errors
end

"""
    validate_value_transfers_from_trip_id(gtfs::GTFSSchedule)

Validate values of field 'from_trip_id' in transfers.txt based on GTFS field type 'Foreign ID referencing `trips.trip_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_transfers_from_trip_id(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    field_name = "from_trip_id"
    file_field = :transfers
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.transfers === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.transfers, :from_trip_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.transfers.from_trip_id

    return validation_errors
end

"""
    validate_value_transfers_to_trip_id(gtfs::GTFSSchedule)

Validate values of field 'to_trip_id' in transfers.txt based on GTFS field type 'Foreign ID referencing `trips.trip_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_transfers_to_trip_id(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    field_name = "to_trip_id"
    file_field = :transfers
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.transfers === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.transfers, :to_trip_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.transfers.to_trip_id

    return validation_errors
end

"""
    validate_value_transfers_transfer_type(gtfs::GTFSSchedule)

Validate values of field 'transfer_type' in transfers.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_transfers_transfer_type(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    field_name = "transfer_type"
    file_field = :transfers
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.transfers === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.transfers, :transfer_type)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.transfers.transfer_type

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_transfers_min_transfer_time(gtfs::GTFSSchedule)

Validate values of field 'min_transfer_time' in transfers.txt based on GTFS field type 'Non-negative integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_transfers_min_transfer_time(gtfs::GTFSSchedule)
    filename = "transfers.txt"
    field_name = "min_transfer_time"
    file_field = :transfers
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.transfers === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.transfers, :min_transfer_time)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.transfers.min_transfer_time

# Validate non-negative integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            int_val = Int(val)
            if int_val < 0
                push!(validation_errors, "Row $idx: Value $int_val must be non-negative")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_pathways_pathway_id(gtfs::GTFSSchedule)

Validate values of field 'pathway_id' in pathways.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_pathways_pathway_id(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    field_name = "pathway_id"
    file_field = :pathways
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.pathways === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.pathways, :pathway_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.pathways.pathway_id

    return validation_errors
end

"""
    validate_value_pathways_from_stop_id(gtfs::GTFSSchedule)

Validate values of field 'from_stop_id' in pathways.txt based on GTFS field type 'Foreign ID referencing `stops.stop_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_pathways_from_stop_id(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    field_name = "from_stop_id"
    file_field = :pathways
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.pathways === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.pathways, :from_stop_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.pathways.from_stop_id

    return validation_errors
end

"""
    validate_value_pathways_to_stop_id(gtfs::GTFSSchedule)

Validate values of field 'to_stop_id' in pathways.txt based on GTFS field type 'Foreign ID referencing `stops.stop_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_pathways_to_stop_id(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    field_name = "to_stop_id"
    file_field = :pathways
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.pathways === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.pathways, :to_stop_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.pathways.to_stop_id

    return validation_errors
end

"""
    validate_value_pathways_pathway_mode(gtfs::GTFSSchedule)

Validate values of field 'pathway_mode' in pathways.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_pathways_pathway_mode(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    field_name = "pathway_mode"
    file_field = :pathways
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.pathways === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.pathways, :pathway_mode)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.pathways.pathway_mode

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_pathways_is_bidirectional(gtfs::GTFSSchedule)

Validate values of field 'is_bidirectional' in pathways.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_pathways_is_bidirectional(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    field_name = "is_bidirectional"
    file_field = :pathways
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.pathways === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.pathways, :is_bidirectional)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.pathways.is_bidirectional

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_pathways_length(gtfs::GTFSSchedule)

Validate values of field 'length' in pathways.txt based on GTFS field type 'Non-negative float'.
Returns Vector{String} with validation error messages.
"""
function validate_value_pathways_length(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    field_name = "length"
    file_field = :pathways
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.pathways === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.pathways, :length)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.pathways.length

# Validate non-negative float
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            float_val = Float64(val)
            if float_val < 0.0
                push!(validation_errors, "Row $idx: Value $float_val must be non-negative")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid float value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_pathways_traversal_time(gtfs::GTFSSchedule)

Validate values of field 'traversal_time' in pathways.txt based on GTFS field type 'Positive integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_pathways_traversal_time(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    field_name = "traversal_time"
    file_field = :pathways
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.pathways === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.pathways, :traversal_time)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.pathways.traversal_time

# Validate positive integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            int_val = Int(val)
            if int_val <= 0
                push!(validation_errors, "Row $idx: Value $int_val must be positive")
            end
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_pathways_stair_count(gtfs::GTFSSchedule)

Validate values of field 'stair_count' in pathways.txt based on GTFS field type 'Non-null integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_pathways_stair_count(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    field_name = "stair_count"
    file_field = :pathways
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.pathways === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.pathways, :stair_count)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.pathways.stair_count

# Validate integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            Int(val)
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_pathways_max_slope(gtfs::GTFSSchedule)

Validate values of field 'max_slope' in pathways.txt based on GTFS field type 'Float'.
Returns Vector{String} with validation error messages.
"""
function validate_value_pathways_max_slope(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    field_name = "max_slope"
    file_field = :pathways
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.pathways === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.pathways, :max_slope)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.pathways.max_slope

# Validate float
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            Float64(val)
        catch
            push!(validation_errors, "Row $idx: Invalid float value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_pathways_min_width(gtfs::GTFSSchedule)

Validate values of field 'min_width' in pathways.txt based on GTFS field type 'Positive float'.
Returns Vector{String} with validation error messages.
"""
function validate_value_pathways_min_width(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    field_name = "min_width"
    file_field = :pathways
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.pathways === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.pathways, :min_width)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.pathways.min_width

# Validate float
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            Float64(val)
        catch
            push!(validation_errors, "Row $idx: Invalid float value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_pathways_signposted_as(gtfs::GTFSSchedule)

Validate values of field 'signposted_as' in pathways.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_pathways_signposted_as(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    field_name = "signposted_as"
    file_field = :pathways
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.pathways === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.pathways, :signposted_as)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.pathways.signposted_as

    return validation_errors
end

"""
    validate_value_pathways_reversed_signposted_as(gtfs::GTFSSchedule)

Validate values of field 'reversed_signposted_as' in pathways.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_pathways_reversed_signposted_as(gtfs::GTFSSchedule)
    filename = "pathways.txt"
    field_name = "reversed_signposted_as"
    file_field = :pathways
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.pathways === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.pathways, :reversed_signposted_as)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.pathways.reversed_signposted_as

    return validation_errors
end

"""
    validate_value_levels_level_id(gtfs::GTFSSchedule)

Validate values of field 'level_id' in levels.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_levels_level_id(gtfs::GTFSSchedule)
    filename = "levels.txt"
    field_name = "level_id"
    file_field = :levels
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.levels === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.levels, :level_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.levels.level_id

    return validation_errors
end

"""
    validate_value_levels_level_index(gtfs::GTFSSchedule)

Validate values of field 'level_index' in levels.txt based on GTFS field type 'Float'.
Returns Vector{String} with validation error messages.
"""
function validate_value_levels_level_index(gtfs::GTFSSchedule)
    filename = "levels.txt"
    field_name = "level_index"
    file_field = :levels
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.levels === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.levels, :level_index)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.levels.level_index

# Validate float
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            Float64(val)
        catch
            push!(validation_errors, "Row $idx: Invalid float value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_levels_level_name(gtfs::GTFSSchedule)

Validate values of field 'level_name' in levels.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_levels_level_name(gtfs::GTFSSchedule)
    filename = "levels.txt"
    field_name = "level_name"
    file_field = :levels
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.levels === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.levels, :level_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.levels.level_name

    return validation_errors
end

"""
    validate_value_location_groups_location_group_id(gtfs::GTFSSchedule)

Validate values of field 'location_group_id' in location_groups.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_location_groups_location_group_id(gtfs::GTFSSchedule)
    filename = "location_groups.txt"
    field_name = "location_group_id"
    file_field = :location_groups
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.location_groups === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.location_groups, :location_group_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.location_groups.location_group_id

    return validation_errors
end

"""
    validate_value_location_groups_location_group_name(gtfs::GTFSSchedule)

Validate values of field 'location_group_name' in location_groups.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_location_groups_location_group_name(gtfs::GTFSSchedule)
    filename = "location_groups.txt"
    field_name = "location_group_name"
    file_field = :location_groups
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.location_groups === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.location_groups, :location_group_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.location_groups.location_group_name

    return validation_errors
end

"""
    validate_value_location_group_stops_location_group_id(gtfs::GTFSSchedule)

Validate values of field 'location_group_id' in location_group_stops.txt based on GTFS field type 'Foreign ID referencing `location_groups.location_group_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_location_group_stops_location_group_id(gtfs::GTFSSchedule)
    filename = "location_group_stops.txt"
    field_name = "location_group_id"
    file_field = :location_group_stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.location_group_stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.location_group_stops, :location_group_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.location_group_stops.location_group_id

    return validation_errors
end

"""
    validate_value_location_group_stops_stop_id(gtfs::GTFSSchedule)

Validate values of field 'stop_id' in location_group_stops.txt based on GTFS field type 'Foreign ID referencing `stops.stop_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_location_group_stops_stop_id(gtfs::GTFSSchedule)
    filename = "location_group_stops.txt"
    field_name = "stop_id"
    file_field = :location_group_stops
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.location_group_stops === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.location_group_stops, :stop_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.location_group_stops.stop_id

    return validation_errors
end

"""
    validate_value_locations_geojson_type(gtfs::GTFSSchedule)

Validate values of field '-&nbsp;type' in locations.geojson based on GTFS field type 'String'.
Returns Vector{String} with validation error messages.
"""
function validate_value_locations_geojson_type(gtfs::GTFSSchedule)
    filename = "locations.geojson"
    field_name = "-&nbsp;type"
    file_field = :locations_geojson
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.locations_geojson === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.locations_geojson, :type)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.locations_geojson.type

    return validation_errors
end

"""
    validate_value_locations_geojson_features(gtfs::GTFSSchedule)

Validate values of field '-&nbsp;features' in locations.geojson based on GTFS field type 'Array'.
Returns Vector{String} with validation error messages.
"""
function validate_value_locations_geojson_features(gtfs::GTFSSchedule)
    filename = "locations.geojson"
    field_name = "-&nbsp;features"
    file_field = :locations_geojson
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.locations_geojson === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.locations_geojson, :features)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.locations_geojson.features

    return validation_errors
end

"""
    validate_value_locations_geojson_id(gtfs::GTFSSchedule)

Validate values of field '&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;id' in locations.geojson based on GTFS field type 'String'.
Returns Vector{String} with validation error messages.
"""
function validate_value_locations_geojson_id(gtfs::GTFSSchedule)
    filename = "locations.geojson"
    field_name = "&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;id"
    file_field = :locations_geojson
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.locations_geojson === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.locations_geojson, :id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.locations_geojson.id

    return validation_errors
end

"""
    validate_value_locations_geojson_properties(gtfs::GTFSSchedule)

Validate values of field '&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;properties' in locations.geojson based on GTFS field type 'Object'.
Returns Vector{String} with validation error messages.
"""
function validate_value_locations_geojson_properties(gtfs::GTFSSchedule)
    filename = "locations.geojson"
    field_name = "&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;properties"
    file_field = :locations_geojson
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.locations_geojson === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.locations_geojson, :properties)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.locations_geojson.properties

    return validation_errors
end

"""
    validate_value_locations_geojson_stop_name(gtfs::GTFSSchedule)

Validate values of field '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;stop_name' in locations.geojson based on GTFS field type 'String'.
Returns Vector{String} with validation error messages.
"""
function validate_value_locations_geojson_stop_name(gtfs::GTFSSchedule)
    filename = "locations.geojson"
    field_name = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;stop_name"
    file_field = :locations_geojson
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.locations_geojson === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.locations_geojson, :stop_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.locations_geojson.stop_name

    return validation_errors
end

"""
    validate_value_locations_geojson_stop_desc(gtfs::GTFSSchedule)

Validate values of field '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;stop_desc' in locations.geojson based on GTFS field type 'String'.
Returns Vector{String} with validation error messages.
"""
function validate_value_locations_geojson_stop_desc(gtfs::GTFSSchedule)
    filename = "locations.geojson"
    field_name = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;stop_desc"
    file_field = :locations_geojson
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.locations_geojson === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.locations_geojson, :stop_desc)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.locations_geojson.stop_desc

    return validation_errors
end

"""
    validate_value_locations_geojson_geometry(gtfs::GTFSSchedule)

Validate values of field '&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;geometry' in locations.geojson based on GTFS field type 'Object'.
Returns Vector{String} with validation error messages.
"""
function validate_value_locations_geojson_geometry(gtfs::GTFSSchedule)
    filename = "locations.geojson"
    field_name = "&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;geometry"
    file_field = :locations_geojson
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.locations_geojson === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.locations_geojson, :geometry)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.locations_geojson.geometry

    return validation_errors
end

"""
    validate_value_locations_geojson_coordinates(gtfs::GTFSSchedule)

Validate values of field '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;coordinates' in locations.geojson based on GTFS field type 'Array'.
Returns Vector{String} with validation error messages.
"""
function validate_value_locations_geojson_coordinates(gtfs::GTFSSchedule)
    filename = "locations.geojson"
    field_name = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;coordinates"
    file_field = :locations_geojson
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.locations_geojson === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.locations_geojson, :coordinates)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.locations_geojson.coordinates

    return validation_errors
end

"""
    validate_value_booking_rules_booking_rule_id(gtfs::GTFSSchedule)

Validate values of field 'booking_rule_id' in booking_rules.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_booking_rule_id(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "booking_rule_id"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :booking_rule_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.booking_rule_id

    return validation_errors
end

"""
    validate_value_booking_rules_booking_type(gtfs::GTFSSchedule)

Validate values of field 'booking_type' in booking_rules.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_booking_type(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "booking_type"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :booking_type)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.booking_type

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_booking_rules_prior_notice_duration_min(gtfs::GTFSSchedule)

Validate values of field 'prior_notice_duration_min' in booking_rules.txt based on GTFS field type 'Integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_prior_notice_duration_min(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_duration_min"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_duration_min)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_duration_min

# Validate integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            Int(val)
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_booking_rules_prior_notice_duration_max(gtfs::GTFSSchedule)

Validate values of field 'prior_notice_duration_max' in booking_rules.txt based on GTFS field type 'Integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_prior_notice_duration_max(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_duration_max"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_duration_max)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_duration_max

# Validate integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            Int(val)
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_booking_rules_prior_notice_last_day(gtfs::GTFSSchedule)

Validate values of field 'prior_notice_last_day' in booking_rules.txt based on GTFS field type 'Integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_prior_notice_last_day(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_last_day"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_last_day)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_last_day

# Validate integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            Int(val)
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_booking_rules_prior_notice_last_time(gtfs::GTFSSchedule)

Validate values of field 'prior_notice_last_time' in booking_rules.txt based on GTFS field type 'Time'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_prior_notice_last_time(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_last_time"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_last_time)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_last_time

# Validate time format (HH:MM:SS)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{1,2}:\d{2}:\d{2}$", val_str)
            push!(validation_errors, "Row $idx: Invalid time format '$val_str' (expected HH:MM:SS)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_booking_rules_prior_notice_start_day(gtfs::GTFSSchedule)

Validate values of field 'prior_notice_start_day' in booking_rules.txt based on GTFS field type 'Integer'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_prior_notice_start_day(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_start_day"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_start_day)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_start_day

# Validate integer
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        try
            Int(val)
        catch
            push!(validation_errors, "Row $idx: Invalid integer value '$val'")
        end
    end
end

    return validation_errors
end

"""
    validate_value_booking_rules_prior_notice_start_time(gtfs::GTFSSchedule)

Validate values of field 'prior_notice_start_time' in booking_rules.txt based on GTFS field type 'Time'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_prior_notice_start_time(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_start_time"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_start_time)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_start_time

# Validate time format (HH:MM:SS)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{1,2}:\d{2}:\d{2}$", val_str)
            push!(validation_errors, "Row $idx: Invalid time format '$val_str' (expected HH:MM:SS)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_booking_rules_prior_notice_service_id(gtfs::GTFSSchedule)

Validate values of field 'prior_notice_service_id' in booking_rules.txt based on GTFS field type 'Foreign ID referencing `calendar.service_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_prior_notice_service_id(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "prior_notice_service_id"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :prior_notice_service_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.prior_notice_service_id

    return validation_errors
end

"""
    validate_value_booking_rules_message(gtfs::GTFSSchedule)

Validate values of field 'message' in booking_rules.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_message(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "message"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :message)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.message

    return validation_errors
end

"""
    validate_value_booking_rules_pickup_message(gtfs::GTFSSchedule)

Validate values of field 'pickup_message' in booking_rules.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_pickup_message(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "pickup_message"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :pickup_message)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.pickup_message

    return validation_errors
end

"""
    validate_value_booking_rules_drop_off_message(gtfs::GTFSSchedule)

Validate values of field 'drop_off_message' in booking_rules.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_drop_off_message(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "drop_off_message"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :drop_off_message)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.drop_off_message

    return validation_errors
end

"""
    validate_value_booking_rules_phone_number(gtfs::GTFSSchedule)

Validate values of field 'phone_number' in booking_rules.txt based on GTFS field type 'Phone number'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_phone_number(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "phone_number"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :phone_number)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.phone_number

    return validation_errors
end

"""
    validate_value_booking_rules_info_url(gtfs::GTFSSchedule)

Validate values of field 'info_url' in booking_rules.txt based on GTFS field type 'URL'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_info_url(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "info_url"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :info_url)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.info_url

# Validate URL format
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^https?://", val_str)
            push!(validation_errors, "Row $idx: Invalid URL '$val_str' (must start with http:// or https://)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_booking_rules_booking_url(gtfs::GTFSSchedule)

Validate values of field 'booking_url' in booking_rules.txt based on GTFS field type 'URL'.
Returns Vector{String} with validation error messages.
"""
function validate_value_booking_rules_booking_url(gtfs::GTFSSchedule)
    filename = "booking_rules.txt"
    field_name = "booking_url"
    file_field = :booking_rules
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.booking_rules === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.booking_rules, :booking_url)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.booking_rules.booking_url

# Validate URL format
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^https?://", val_str)
            push!(validation_errors, "Row $idx: Invalid URL '$val_str' (must start with http:// or https://)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_translations_table_name(gtfs::GTFSSchedule)

Validate values of field 'table_name' in translations.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_translations_table_name(gtfs::GTFSSchedule)
    filename = "translations.txt"
    field_name = "table_name"
    file_field = :translations
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.translations === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.translations, :table_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.translations.table_name

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_translations_field_name(gtfs::GTFSSchedule)

Validate values of field 'field_name' in translations.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_translations_field_name(gtfs::GTFSSchedule)
    filename = "translations.txt"
    field_name = "field_name"
    file_field = :translations
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.translations === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.translations, :field_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.translations.field_name

    return validation_errors
end

"""
    validate_value_translations_language(gtfs::GTFSSchedule)

Validate values of field 'language' in translations.txt based on GTFS field type 'Language code'.
Returns Vector{String} with validation error messages.
"""
function validate_value_translations_language(gtfs::GTFSSchedule)
    filename = "translations.txt"
    field_name = "language"
    file_field = :translations
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.translations === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.translations, :language)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.translations.language

    return validation_errors
end

"""
    validate_value_translations_translation(gtfs::GTFSSchedule)

Validate values of field 'translation' in translations.txt based on GTFS field type 'Text or URL or Email or Phone number'.
Returns Vector{String} with validation error messages.
"""
function validate_value_translations_translation(gtfs::GTFSSchedule)
    filename = "translations.txt"
    field_name = "translation"
    file_field = :translations
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.translations === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.translations, :translation)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.translations.translation

# Validate URL format
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^https?://", val_str)
            push!(validation_errors, "Row $idx: Invalid URL '$val_str' (must start with http:// or https://)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_translations_record_id(gtfs::GTFSSchedule)

Validate values of field 'record_id' in translations.txt based on GTFS field type 'Foreign ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_translations_record_id(gtfs::GTFSSchedule)
    filename = "translations.txt"
    field_name = "record_id"
    file_field = :translations
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.translations === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.translations, :record_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.translations.record_id

    return validation_errors
end

"""
    validate_value_translations_record_sub_id(gtfs::GTFSSchedule)

Validate values of field 'record_sub_id' in translations.txt based on GTFS field type 'Foreign ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_translations_record_sub_id(gtfs::GTFSSchedule)
    filename = "translations.txt"
    field_name = "record_sub_id"
    file_field = :translations
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.translations === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.translations, :record_sub_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.translations.record_sub_id

    return validation_errors
end

"""
    validate_value_translations_field_value(gtfs::GTFSSchedule)

Validate values of field 'field_value' in translations.txt based on GTFS field type 'Text or URL or Email or Phone number'.
Returns Vector{String} with validation error messages.
"""
function validate_value_translations_field_value(gtfs::GTFSSchedule)
    filename = "translations.txt"
    field_name = "field_value"
    file_field = :translations
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.translations === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.translations, :field_value)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.translations.field_value

# Validate URL format
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^https?://", val_str)
            push!(validation_errors, "Row $idx: Invalid URL '$val_str' (must start with http:// or https://)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_feed_info_feed_publisher_name(gtfs::GTFSSchedule)

Validate values of field 'feed_publisher_name' in feed_info.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_feed_info_feed_publisher_name(gtfs::GTFSSchedule)
    filename = "feed_info.txt"
    field_name = "feed_publisher_name"
    file_field = :feed_info
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.feed_info === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.feed_info, :feed_publisher_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.feed_info.feed_publisher_name

    return validation_errors
end

"""
    validate_value_feed_info_feed_publisher_url(gtfs::GTFSSchedule)

Validate values of field 'feed_publisher_url' in feed_info.txt based on GTFS field type 'URL'.
Returns Vector{String} with validation error messages.
"""
function validate_value_feed_info_feed_publisher_url(gtfs::GTFSSchedule)
    filename = "feed_info.txt"
    field_name = "feed_publisher_url"
    file_field = :feed_info
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.feed_info === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.feed_info, :feed_publisher_url)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.feed_info.feed_publisher_url

# Validate URL format
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^https?://", val_str)
            push!(validation_errors, "Row $idx: Invalid URL '$val_str' (must start with http:// or https://)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_feed_info_feed_lang(gtfs::GTFSSchedule)

Validate values of field 'feed_lang' in feed_info.txt based on GTFS field type 'Language code'.
Returns Vector{String} with validation error messages.
"""
function validate_value_feed_info_feed_lang(gtfs::GTFSSchedule)
    filename = "feed_info.txt"
    field_name = "feed_lang"
    file_field = :feed_info
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.feed_info === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.feed_info, :feed_lang)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.feed_info.feed_lang

    return validation_errors
end

"""
    validate_value_feed_info_default_lang(gtfs::GTFSSchedule)

Validate values of field 'default_lang' in feed_info.txt based on GTFS field type 'Language code'.
Returns Vector{String} with validation error messages.
"""
function validate_value_feed_info_default_lang(gtfs::GTFSSchedule)
    filename = "feed_info.txt"
    field_name = "default_lang"
    file_field = :feed_info
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.feed_info === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.feed_info, :default_lang)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.feed_info.default_lang

    return validation_errors
end

"""
    validate_value_feed_info_feed_start_date(gtfs::GTFSSchedule)

Validate values of field 'feed_start_date' in feed_info.txt based on GTFS field type 'Date'.
Returns Vector{String} with validation error messages.
"""
function validate_value_feed_info_feed_start_date(gtfs::GTFSSchedule)
    filename = "feed_info.txt"
    field_name = "feed_start_date"
    file_field = :feed_info
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.feed_info === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.feed_info, :feed_start_date)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.feed_info.feed_start_date

# Validate date format (YYYYMMDD)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{8}$", val_str)
            push!(validation_errors, "Row $idx: Invalid date format '$val_str' (expected YYYYMMDD)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_feed_info_feed_end_date(gtfs::GTFSSchedule)

Validate values of field 'feed_end_date' in feed_info.txt based on GTFS field type 'Date'.
Returns Vector{String} with validation error messages.
"""
function validate_value_feed_info_feed_end_date(gtfs::GTFSSchedule)
    filename = "feed_info.txt"
    field_name = "feed_end_date"
    file_field = :feed_info
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.feed_info === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.feed_info, :feed_end_date)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.feed_info.feed_end_date

# Validate date format (YYYYMMDD)
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^\d{8}$", val_str)
            push!(validation_errors, "Row $idx: Invalid date format '$val_str' (expected YYYYMMDD)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_feed_info_feed_version(gtfs::GTFSSchedule)

Validate values of field 'feed_version' in feed_info.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_feed_info_feed_version(gtfs::GTFSSchedule)
    filename = "feed_info.txt"
    field_name = "feed_version"
    file_field = :feed_info
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.feed_info === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.feed_info, :feed_version)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.feed_info.feed_version

    return validation_errors
end

"""
    validate_value_feed_info_feed_contact_email(gtfs::GTFSSchedule)

Validate values of field 'feed_contact_email' in feed_info.txt based on GTFS field type 'Email'.
Returns Vector{String} with validation error messages.
"""
function validate_value_feed_info_feed_contact_email(gtfs::GTFSSchedule)
    filename = "feed_info.txt"
    field_name = "feed_contact_email"
    file_field = :feed_info
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.feed_info === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.feed_info, :feed_contact_email)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.feed_info.feed_contact_email

    return validation_errors
end

"""
    validate_value_feed_info_feed_contact_url(gtfs::GTFSSchedule)

Validate values of field 'feed_contact_url' in feed_info.txt based on GTFS field type 'URL'.
Returns Vector{String} with validation error messages.
"""
function validate_value_feed_info_feed_contact_url(gtfs::GTFSSchedule)
    filename = "feed_info.txt"
    field_name = "feed_contact_url"
    file_field = :feed_info
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.feed_info === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.feed_info, :feed_contact_url)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.feed_info.feed_contact_url

# Validate URL format
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^https?://", val_str)
            push!(validation_errors, "Row $idx: Invalid URL '$val_str' (must start with http:// or https://)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_attributions_attribution_id(gtfs::GTFSSchedule)

Validate values of field 'attribution_id' in attributions.txt based on GTFS field type 'Unique ID'.
Returns Vector{String} with validation error messages.
"""
function validate_value_attributions_attribution_id(gtfs::GTFSSchedule)
    filename = "attributions.txt"
    field_name = "attribution_id"
    file_field = :attributions
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.attributions === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.attributions, :attribution_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.attributions.attribution_id

    return validation_errors
end

"""
    validate_value_attributions_agency_id(gtfs::GTFSSchedule)

Validate values of field 'agency_id' in attributions.txt based on GTFS field type 'Foreign ID referencing `agency.agency_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_attributions_agency_id(gtfs::GTFSSchedule)
    filename = "attributions.txt"
    field_name = "agency_id"
    file_field = :attributions
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.attributions === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.attributions, :agency_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.attributions.agency_id

    return validation_errors
end

"""
    validate_value_attributions_route_id(gtfs::GTFSSchedule)

Validate values of field 'route_id' in attributions.txt based on GTFS field type 'Foreign ID referencing `routes.route_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_attributions_route_id(gtfs::GTFSSchedule)
    filename = "attributions.txt"
    field_name = "route_id"
    file_field = :attributions
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.attributions === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.attributions, :route_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.attributions.route_id

    return validation_errors
end

"""
    validate_value_attributions_trip_id(gtfs::GTFSSchedule)

Validate values of field 'trip_id' in attributions.txt based on GTFS field type 'Foreign ID referencing `trips.trip_id`'.
Returns Vector{String} with validation error messages.
"""
function validate_value_attributions_trip_id(gtfs::GTFSSchedule)
    filename = "attributions.txt"
    field_name = "trip_id"
    file_field = :attributions
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.attributions === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.attributions, :trip_id)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.attributions.trip_id

    return validation_errors
end

"""
    validate_value_attributions_organization_name(gtfs::GTFSSchedule)

Validate values of field 'organization_name' in attributions.txt based on GTFS field type 'Text'.
Returns Vector{String} with validation error messages.
"""
function validate_value_attributions_organization_name(gtfs::GTFSSchedule)
    filename = "attributions.txt"
    field_name = "organization_name"
    file_field = :attributions
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.attributions === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.attributions, :organization_name)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.attributions.organization_name

    return validation_errors
end

"""
    validate_value_attributions_is_producer(gtfs::GTFSSchedule)

Validate values of field 'is_producer' in attributions.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_attributions_is_producer(gtfs::GTFSSchedule)
    filename = "attributions.txt"
    field_name = "is_producer"
    file_field = :attributions
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.attributions === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.attributions, :is_producer)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.attributions.is_producer

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_attributions_is_operator(gtfs::GTFSSchedule)

Validate values of field 'is_operator' in attributions.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_attributions_is_operator(gtfs::GTFSSchedule)
    filename = "attributions.txt"
    field_name = "is_operator"
    file_field = :attributions
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.attributions === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.attributions, :is_operator)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.attributions.is_operator

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_attributions_is_authority(gtfs::GTFSSchedule)

Validate values of field 'is_authority' in attributions.txt based on GTFS field type 'Enum'.
Returns Vector{String} with validation error messages.
"""
function validate_value_attributions_is_authority(gtfs::GTFSSchedule)
    filename = "attributions.txt"
    field_name = "is_authority"
    file_field = :attributions
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.attributions === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.attributions, :is_authority)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.attributions.is_authority

# Validate enum values
for (idx, val) in enumerate(field_data)
    if !ismissing(val) && !validate_enum(filename, field_name, val)
        push!(validation_errors, "Row $idx: Invalid enum value '$val' for field '$field_name'")
    end
end

    return validation_errors
end

"""
    validate_value_attributions_attribution_url(gtfs::GTFSSchedule)

Validate values of field 'attribution_url' in attributions.txt based on GTFS field type 'URL'.
Returns Vector{String} with validation error messages.
"""
function validate_value_attributions_attribution_url(gtfs::GTFSSchedule)
    filename = "attributions.txt"
    field_name = "attribution_url"
    file_field = :attributions
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.attributions === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.attributions, :attribution_url)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.attributions.attribution_url

# Validate URL format
for (idx, val) in enumerate(field_data)
    if !ismissing(val)
        val_str = string(val)
        if !occursin(r"^https?://", val_str)
            push!(validation_errors, "Row $idx: Invalid URL '$val_str' (must start with http:// or https://)")
        end
    end
end

    return validation_errors
end

"""
    validate_value_attributions_attribution_email(gtfs::GTFSSchedule)

Validate values of field 'attribution_email' in attributions.txt based on GTFS field type 'Email'.
Returns Vector{String} with validation error messages.
"""
function validate_value_attributions_attribution_email(gtfs::GTFSSchedule)
    filename = "attributions.txt"
    field_name = "attribution_email"
    file_field = :attributions
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.attributions === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.attributions, :attribution_email)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.attributions.attribution_email

    return validation_errors
end

"""
    validate_value_attributions_attribution_phone(gtfs::GTFSSchedule)

Validate values of field 'attribution_phone' in attributions.txt based on GTFS field type 'Phone number'.
Returns Vector{String} with validation error messages.
"""
function validate_value_attributions_attribution_phone(gtfs::GTFSSchedule)
    filename = "attributions.txt"
    field_name = "attribution_phone"
    file_field = :attributions
    validation_errors = String[]

    # Check if file exists
    if !hasproperty(gtfs, file_field) || gtfs.attributions === nothing
        return validation_errors  # No file, no validation needed
    end

    # Check if field exists in DataFrame
    if !hasproperty(gtfs.attributions, :attribution_phone)
        return validation_errors  # No field, no validation needed
    end

    # Get field data
    field_data = gtfs.attributions.attribution_phone

    return validation_errors
end

# Comprehensive value validator

"""
    validate_field_values(gtfs::GTFSSchedule)

Comprehensive field value validation for GTFS feed.
Validates all field values based on GTFS field types including:
- Date format validation (YYYYMMDD)
- Time format validation (HH:MM:SS)
- URL format validation
- Color format validation (6-digit hex)
- Latitude/longitude range validation
- Integer/float type and constraint validation
- Enum value validation

Returns ValidationResult with all validation messages.
"""
function validate_field_values(gtfs::GTFSSchedule)
    messages = ValidationMessage[]

    # Validate values in agency.txt field agency_id
    value_errors = validate_value_agency_agency_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("agency.txt", "agency_id", error_msg, :error))
    end

    # Validate values in agency.txt field agency_name
    value_errors = validate_value_agency_agency_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("agency.txt", "agency_name", error_msg, :error))
    end

    # Validate values in agency.txt field agency_url
    value_errors = validate_value_agency_agency_url(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("agency.txt", "agency_url", error_msg, :error))
    end

    # Validate values in agency.txt field agency_timezone
    value_errors = validate_value_agency_agency_timezone(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("agency.txt", "agency_timezone", error_msg, :error))
    end

    # Validate values in agency.txt field agency_lang
    value_errors = validate_value_agency_agency_lang(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("agency.txt", "agency_lang", error_msg, :error))
    end

    # Validate values in agency.txt field agency_phone
    value_errors = validate_value_agency_agency_phone(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("agency.txt", "agency_phone", error_msg, :error))
    end

    # Validate values in agency.txt field agency_fare_url
    value_errors = validate_value_agency_agency_fare_url(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("agency.txt", "agency_fare_url", error_msg, :error))
    end

    # Validate values in agency.txt field agency_email
    value_errors = validate_value_agency_agency_email(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("agency.txt", "agency_email", error_msg, :error))
    end

    # Validate values in agency.txt field cemv_support
    value_errors = validate_value_agency_cemv_support(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("agency.txt", "cemv_support", error_msg, :error))
    end

    # Validate values in stops.txt field stop_id
    value_errors = validate_value_stops_stop_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "stop_id", error_msg, :error))
    end

    # Validate values in stops.txt field stop_code
    value_errors = validate_value_stops_stop_code(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "stop_code", error_msg, :error))
    end

    # Validate values in stops.txt field stop_name
    value_errors = validate_value_stops_stop_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "stop_name", error_msg, :error))
    end

    # Validate values in stops.txt field tts_stop_name
    value_errors = validate_value_stops_tts_stop_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "tts_stop_name", error_msg, :error))
    end

    # Validate values in stops.txt field stop_desc
    value_errors = validate_value_stops_stop_desc(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "stop_desc", error_msg, :error))
    end

    # Validate values in stops.txt field stop_lat
    value_errors = validate_value_stops_stop_lat(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "stop_lat", error_msg, :error))
    end

    # Validate values in stops.txt field stop_lon
    value_errors = validate_value_stops_stop_lon(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "stop_lon", error_msg, :error))
    end

    # Validate values in stops.txt field zone_id
    value_errors = validate_value_stops_zone_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "zone_id", error_msg, :error))
    end

    # Validate values in stops.txt field stop_url
    value_errors = validate_value_stops_stop_url(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "stop_url", error_msg, :error))
    end

    # Validate values in stops.txt field location_type
    value_errors = validate_value_stops_location_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "location_type", error_msg, :error))
    end

    # Validate values in stops.txt field parent_station
    value_errors = validate_value_stops_parent_station(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "parent_station", error_msg, :error))
    end

    # Validate values in stops.txt field stop_timezone
    value_errors = validate_value_stops_stop_timezone(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "stop_timezone", error_msg, :error))
    end

    # Validate values in stops.txt field wheelchair_boarding
    value_errors = validate_value_stops_wheelchair_boarding(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "wheelchair_boarding", error_msg, :error))
    end

    # Validate values in stops.txt field level_id
    value_errors = validate_value_stops_level_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "level_id", error_msg, :error))
    end

    # Validate values in stops.txt field platform_code
    value_errors = validate_value_stops_platform_code(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "platform_code", error_msg, :error))
    end

    # Validate values in stops.txt field stop_access
    value_errors = validate_value_stops_stop_access(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stops.txt", "stop_access", error_msg, :error))
    end

    # Validate values in routes.txt field route_id
    value_errors = validate_value_routes_route_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "route_id", error_msg, :error))
    end

    # Validate values in routes.txt field agency_id
    value_errors = validate_value_routes_agency_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "agency_id", error_msg, :error))
    end

    # Validate values in routes.txt field route_short_name
    value_errors = validate_value_routes_route_short_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "route_short_name", error_msg, :error))
    end

    # Validate values in routes.txt field route_long_name
    value_errors = validate_value_routes_route_long_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "route_long_name", error_msg, :error))
    end

    # Validate values in routes.txt field route_desc
    value_errors = validate_value_routes_route_desc(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "route_desc", error_msg, :error))
    end

    # Validate values in routes.txt field route_type
    value_errors = validate_value_routes_route_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "route_type", error_msg, :error))
    end

    # Validate values in routes.txt field route_url
    value_errors = validate_value_routes_route_url(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "route_url", error_msg, :error))
    end

    # Validate values in routes.txt field route_color
    value_errors = validate_value_routes_route_color(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "route_color", error_msg, :error))
    end

    # Validate values in routes.txt field route_text_color
    value_errors = validate_value_routes_route_text_color(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "route_text_color", error_msg, :error))
    end

    # Validate values in routes.txt field route_sort_order
    value_errors = validate_value_routes_route_sort_order(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "route_sort_order", error_msg, :error))
    end

    # Validate values in routes.txt field continuous_pickup
    value_errors = validate_value_routes_continuous_pickup(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "continuous_pickup", error_msg, :error))
    end

    # Validate values in routes.txt field continuous_drop_off
    value_errors = validate_value_routes_continuous_drop_off(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "continuous_drop_off", error_msg, :error))
    end

    # Validate values in routes.txt field network_id
    value_errors = validate_value_routes_network_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "network_id", error_msg, :error))
    end

    # Validate values in routes.txt field cemv_support
    value_errors = validate_value_routes_cemv_support(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("routes.txt", "cemv_support", error_msg, :error))
    end

    # Validate values in trips.txt field route_id
    value_errors = validate_value_trips_route_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("trips.txt", "route_id", error_msg, :error))
    end

    # Validate values in trips.txt field service_id
    value_errors = validate_value_trips_service_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("trips.txt", "service_id", error_msg, :error))
    end

    # Validate values in trips.txt field trip_id
    value_errors = validate_value_trips_trip_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("trips.txt", "trip_id", error_msg, :error))
    end

    # Validate values in trips.txt field trip_headsign
    value_errors = validate_value_trips_trip_headsign(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("trips.txt", "trip_headsign", error_msg, :error))
    end

    # Validate values in trips.txt field trip_short_name
    value_errors = validate_value_trips_trip_short_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("trips.txt", "trip_short_name", error_msg, :error))
    end

    # Validate values in trips.txt field direction_id
    value_errors = validate_value_trips_direction_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("trips.txt", "direction_id", error_msg, :error))
    end

    # Validate values in trips.txt field block_id
    value_errors = validate_value_trips_block_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("trips.txt", "block_id", error_msg, :error))
    end

    # Validate values in trips.txt field shape_id
    value_errors = validate_value_trips_shape_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("trips.txt", "shape_id", error_msg, :error))
    end

    # Validate values in trips.txt field wheelchair_accessible
    value_errors = validate_value_trips_wheelchair_accessible(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("trips.txt", "wheelchair_accessible", error_msg, :error))
    end

    # Validate values in trips.txt field bikes_allowed
    value_errors = validate_value_trips_bikes_allowed(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("trips.txt", "bikes_allowed", error_msg, :error))
    end

    # Validate values in trips.txt field cars_allowed
    value_errors = validate_value_trips_cars_allowed(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("trips.txt", "cars_allowed", error_msg, :error))
    end

    # Validate values in stop_times.txt field trip_id
    value_errors = validate_value_stop_times_trip_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "trip_id", error_msg, :error))
    end

    # Validate values in stop_times.txt field arrival_time
    value_errors = validate_value_stop_times_arrival_time(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "arrival_time", error_msg, :error))
    end

    # Validate values in stop_times.txt field departure_time
    value_errors = validate_value_stop_times_departure_time(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "departure_time", error_msg, :error))
    end

    # Validate values in stop_times.txt field stop_id
    value_errors = validate_value_stop_times_stop_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "stop_id", error_msg, :error))
    end

    # Validate values in stop_times.txt field location_group_id
    value_errors = validate_value_stop_times_location_group_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "location_group_id", error_msg, :error))
    end

    # Validate values in stop_times.txt field location_id
    value_errors = validate_value_stop_times_location_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "location_id", error_msg, :error))
    end

    # Validate values in stop_times.txt field stop_sequence
    value_errors = validate_value_stop_times_stop_sequence(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "stop_sequence", error_msg, :error))
    end

    # Validate values in stop_times.txt field stop_headsign
    value_errors = validate_value_stop_times_stop_headsign(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "stop_headsign", error_msg, :error))
    end

    # Validate values in stop_times.txt field start_pickup_drop_off_window
    value_errors = validate_value_stop_times_start_pickup_drop_off_window(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "start_pickup_drop_off_window", error_msg, :error))
    end

    # Validate values in stop_times.txt field end_pickup_drop_off_window
    value_errors = validate_value_stop_times_end_pickup_drop_off_window(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "end_pickup_drop_off_window", error_msg, :error))
    end

    # Validate values in stop_times.txt field pickup_type
    value_errors = validate_value_stop_times_pickup_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "pickup_type", error_msg, :error))
    end

    # Validate values in stop_times.txt field drop_off_type
    value_errors = validate_value_stop_times_drop_off_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "drop_off_type", error_msg, :error))
    end

    # Validate values in stop_times.txt field continuous_pickup
    value_errors = validate_value_stop_times_continuous_pickup(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "continuous_pickup", error_msg, :error))
    end

    # Validate values in stop_times.txt field continuous_drop_off
    value_errors = validate_value_stop_times_continuous_drop_off(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "continuous_drop_off", error_msg, :error))
    end

    # Validate values in stop_times.txt field shape_dist_traveled
    value_errors = validate_value_stop_times_shape_dist_traveled(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "shape_dist_traveled", error_msg, :error))
    end

    # Validate values in stop_times.txt field timepoint
    value_errors = validate_value_stop_times_timepoint(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "timepoint", error_msg, :error))
    end

    # Validate values in stop_times.txt field pickup_booking_rule_id
    value_errors = validate_value_stop_times_pickup_booking_rule_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "pickup_booking_rule_id", error_msg, :error))
    end

    # Validate values in stop_times.txt field drop_off_booking_rule_id
    value_errors = validate_value_stop_times_drop_off_booking_rule_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_times.txt", "drop_off_booking_rule_id", error_msg, :error))
    end

    # Validate values in calendar.txt field service_id
    value_errors = validate_value_calendar_service_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar.txt", "service_id", error_msg, :error))
    end

    # Validate values in calendar.txt field monday
    value_errors = validate_value_calendar_monday(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar.txt", "monday", error_msg, :error))
    end

    # Validate values in calendar.txt field tuesday
    value_errors = validate_value_calendar_tuesday(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar.txt", "tuesday", error_msg, :error))
    end

    # Validate values in calendar.txt field wednesday
    value_errors = validate_value_calendar_wednesday(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar.txt", "wednesday", error_msg, :error))
    end

    # Validate values in calendar.txt field thursday
    value_errors = validate_value_calendar_thursday(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar.txt", "thursday", error_msg, :error))
    end

    # Validate values in calendar.txt field friday
    value_errors = validate_value_calendar_friday(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar.txt", "friday", error_msg, :error))
    end

    # Validate values in calendar.txt field saturday
    value_errors = validate_value_calendar_saturday(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar.txt", "saturday", error_msg, :error))
    end

    # Validate values in calendar.txt field sunday
    value_errors = validate_value_calendar_sunday(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar.txt", "sunday", error_msg, :error))
    end

    # Validate values in calendar.txt field start_date
    value_errors = validate_value_calendar_start_date(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar.txt", "start_date", error_msg, :error))
    end

    # Validate values in calendar.txt field end_date
    value_errors = validate_value_calendar_end_date(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar.txt", "end_date", error_msg, :error))
    end

    # Validate values in calendar_dates.txt field service_id
    value_errors = validate_value_calendar_dates_service_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar_dates.txt", "service_id", error_msg, :error))
    end

    # Validate values in calendar_dates.txt field date
    value_errors = validate_value_calendar_dates_date(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar_dates.txt", "date", error_msg, :error))
    end

    # Validate values in calendar_dates.txt field exception_type
    value_errors = validate_value_calendar_dates_exception_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("calendar_dates.txt", "exception_type", error_msg, :error))
    end

    # Validate values in fare_attributes.txt field fare_id
    value_errors = validate_value_fare_attributes_fare_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_attributes.txt", "fare_id", error_msg, :error))
    end

    # Validate values in fare_attributes.txt field price
    value_errors = validate_value_fare_attributes_price(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_attributes.txt", "price", error_msg, :error))
    end

    # Validate values in fare_attributes.txt field currency_type
    value_errors = validate_value_fare_attributes_currency_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_attributes.txt", "currency_type", error_msg, :error))
    end

    # Validate values in fare_attributes.txt field payment_method
    value_errors = validate_value_fare_attributes_payment_method(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_attributes.txt", "payment_method", error_msg, :error))
    end

    # Validate values in fare_attributes.txt field transfers
    value_errors = validate_value_fare_attributes_transfers(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_attributes.txt", "transfers", error_msg, :error))
    end

    # Validate values in fare_attributes.txt field agency_id
    value_errors = validate_value_fare_attributes_agency_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_attributes.txt", "agency_id", error_msg, :error))
    end

    # Validate values in fare_attributes.txt field transfer_duration
    value_errors = validate_value_fare_attributes_transfer_duration(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_attributes.txt", "transfer_duration", error_msg, :error))
    end

    # Validate values in fare_rules.txt field fare_id
    value_errors = validate_value_fare_rules_fare_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_rules.txt", "fare_id", error_msg, :error))
    end

    # Validate values in fare_rules.txt field route_id
    value_errors = validate_value_fare_rules_route_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_rules.txt", "route_id", error_msg, :error))
    end

    # Validate values in fare_rules.txt field origin_id
    value_errors = validate_value_fare_rules_origin_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_rules.txt", "origin_id", error_msg, :error))
    end

    # Validate values in fare_rules.txt field destination_id
    value_errors = validate_value_fare_rules_destination_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_rules.txt", "destination_id", error_msg, :error))
    end

    # Validate values in fare_rules.txt field contains_id
    value_errors = validate_value_fare_rules_contains_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_rules.txt", "contains_id", error_msg, :error))
    end

    # Validate values in timeframes.txt field timeframe_group_id
    value_errors = validate_value_timeframes_timeframe_group_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("timeframes.txt", "timeframe_group_id", error_msg, :error))
    end

    # Validate values in timeframes.txt field start_time
    value_errors = validate_value_timeframes_start_time(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("timeframes.txt", "start_time", error_msg, :error))
    end

    # Validate values in timeframes.txt field end_time
    value_errors = validate_value_timeframes_end_time(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("timeframes.txt", "end_time", error_msg, :error))
    end

    # Validate values in timeframes.txt field service_id
    value_errors = validate_value_timeframes_service_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("timeframes.txt", "service_id", error_msg, :error))
    end

    # Validate values in rider_categories.txt field rider_category_id
    value_errors = validate_value_rider_categories_rider_category_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("rider_categories.txt", "rider_category_id", error_msg, :error))
    end

    # Validate values in rider_categories.txt field rider_category_name
    value_errors = validate_value_rider_categories_rider_category_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("rider_categories.txt", "rider_category_name", error_msg, :error))
    end

    # Validate values in rider_categories.txt field is_default_fare_category
    value_errors = validate_value_rider_categories_is_default_fare_category(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("rider_categories.txt", "is_default_fare_category", error_msg, :error))
    end

    # Validate values in rider_categories.txt field eligibility_url
    value_errors = validate_value_rider_categories_eligibility_url(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("rider_categories.txt", "eligibility_url", error_msg, :error))
    end

    # Validate values in fare_media.txt field fare_media_id
    value_errors = validate_value_fare_media_fare_media_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_media.txt", "fare_media_id", error_msg, :error))
    end

    # Validate values in fare_media.txt field fare_media_name
    value_errors = validate_value_fare_media_fare_media_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_media.txt", "fare_media_name", error_msg, :error))
    end

    # Validate values in fare_media.txt field fare_media_type
    value_errors = validate_value_fare_media_fare_media_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_media.txt", "fare_media_type", error_msg, :error))
    end

    # Validate values in fare_products.txt field fare_product_id
    value_errors = validate_value_fare_products_fare_product_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_products.txt", "fare_product_id", error_msg, :error))
    end

    # Validate values in fare_products.txt field fare_product_name
    value_errors = validate_value_fare_products_fare_product_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_products.txt", "fare_product_name", error_msg, :error))
    end

    # Validate values in fare_products.txt field rider_category_id
    value_errors = validate_value_fare_products_rider_category_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_products.txt", "rider_category_id", error_msg, :error))
    end

    # Validate values in fare_products.txt field fare_media_id
    value_errors = validate_value_fare_products_fare_media_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_products.txt", "fare_media_id", error_msg, :error))
    end

    # Validate values in fare_products.txt field amount
    value_errors = validate_value_fare_products_amount(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_products.txt", "amount", error_msg, :error))
    end

    # Validate values in fare_products.txt field currency
    value_errors = validate_value_fare_products_currency(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_products.txt", "currency", error_msg, :error))
    end

    # Validate values in fare_leg_rules.txt field leg_group_id
    value_errors = validate_value_fare_leg_rules_leg_group_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_leg_rules.txt", "leg_group_id", error_msg, :error))
    end

    # Validate values in fare_leg_rules.txt field network_id
    value_errors = validate_value_fare_leg_rules_network_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_leg_rules.txt", "network_id", error_msg, :error))
    end

    # Validate values in fare_leg_rules.txt field from_area_id
    value_errors = validate_value_fare_leg_rules_from_area_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_leg_rules.txt", "from_area_id", error_msg, :error))
    end

    # Validate values in fare_leg_rules.txt field to_area_id
    value_errors = validate_value_fare_leg_rules_to_area_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_leg_rules.txt", "to_area_id", error_msg, :error))
    end

    # Validate values in fare_leg_rules.txt field from_timeframe_group_id
    value_errors = validate_value_fare_leg_rules_from_timeframe_group_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_leg_rules.txt", "from_timeframe_group_id", error_msg, :error))
    end

    # Validate values in fare_leg_rules.txt field to_timeframe_group_id
    value_errors = validate_value_fare_leg_rules_to_timeframe_group_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_leg_rules.txt", "to_timeframe_group_id", error_msg, :error))
    end

    # Validate values in fare_leg_rules.txt field fare_product_id
    value_errors = validate_value_fare_leg_rules_fare_product_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_leg_rules.txt", "fare_product_id", error_msg, :error))
    end

    # Validate values in fare_leg_rules.txt field rule_priority
    value_errors = validate_value_fare_leg_rules_rule_priority(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_leg_rules.txt", "rule_priority", error_msg, :error))
    end

    # Validate values in fare_leg_join_rules.txt field from_network_id
    value_errors = validate_value_fare_leg_join_rules_from_network_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_leg_join_rules.txt", "from_network_id", error_msg, :error))
    end

    # Validate values in fare_leg_join_rules.txt field to_network_id
    value_errors = validate_value_fare_leg_join_rules_to_network_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_leg_join_rules.txt", "to_network_id", error_msg, :error))
    end

    # Validate values in fare_leg_join_rules.txt field from_stop_id
    value_errors = validate_value_fare_leg_join_rules_from_stop_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_leg_join_rules.txt", "from_stop_id", error_msg, :error))
    end

    # Validate values in fare_leg_join_rules.txt field to_stop_id
    value_errors = validate_value_fare_leg_join_rules_to_stop_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_leg_join_rules.txt", "to_stop_id", error_msg, :error))
    end

    # Validate values in fare_transfer_rules.txt field from_leg_group_id
    value_errors = validate_value_fare_transfer_rules_from_leg_group_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_transfer_rules.txt", "from_leg_group_id", error_msg, :error))
    end

    # Validate values in fare_transfer_rules.txt field to_leg_group_id
    value_errors = validate_value_fare_transfer_rules_to_leg_group_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_transfer_rules.txt", "to_leg_group_id", error_msg, :error))
    end

    # Validate values in fare_transfer_rules.txt field transfer_count
    value_errors = validate_value_fare_transfer_rules_transfer_count(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_transfer_rules.txt", "transfer_count", error_msg, :error))
    end

    # Validate values in fare_transfer_rules.txt field duration_limit
    value_errors = validate_value_fare_transfer_rules_duration_limit(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_transfer_rules.txt", "duration_limit", error_msg, :error))
    end

    # Validate values in fare_transfer_rules.txt field duration_limit_type
    value_errors = validate_value_fare_transfer_rules_duration_limit_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_transfer_rules.txt", "duration_limit_type", error_msg, :error))
    end

    # Validate values in fare_transfer_rules.txt field fare_transfer_type
    value_errors = validate_value_fare_transfer_rules_fare_transfer_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_transfer_rules.txt", "fare_transfer_type", error_msg, :error))
    end

    # Validate values in fare_transfer_rules.txt field fare_product_id
    value_errors = validate_value_fare_transfer_rules_fare_product_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("fare_transfer_rules.txt", "fare_product_id", error_msg, :error))
    end

    # Validate values in areas.txt field area_id
    value_errors = validate_value_areas_area_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("areas.txt", "area_id", error_msg, :error))
    end

    # Validate values in areas.txt field area_name
    value_errors = validate_value_areas_area_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("areas.txt", "area_name", error_msg, :error))
    end

    # Validate values in stop_areas.txt field area_id
    value_errors = validate_value_stop_areas_area_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_areas.txt", "area_id", error_msg, :error))
    end

    # Validate values in stop_areas.txt field stop_id
    value_errors = validate_value_stop_areas_stop_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("stop_areas.txt", "stop_id", error_msg, :error))
    end

    # Validate values in networks.txt field network_id
    value_errors = validate_value_networks_network_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("networks.txt", "network_id", error_msg, :error))
    end

    # Validate values in networks.txt field network_name
    value_errors = validate_value_networks_network_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("networks.txt", "network_name", error_msg, :error))
    end

    # Validate values in route_networks.txt field network_id
    value_errors = validate_value_route_networks_network_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("route_networks.txt", "network_id", error_msg, :error))
    end

    # Validate values in route_networks.txt field route_id
    value_errors = validate_value_route_networks_route_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("route_networks.txt", "route_id", error_msg, :error))
    end

    # Validate values in shapes.txt field shape_id
    value_errors = validate_value_shapes_shape_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("shapes.txt", "shape_id", error_msg, :error))
    end

    # Validate values in shapes.txt field shape_pt_lat
    value_errors = validate_value_shapes_shape_pt_lat(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("shapes.txt", "shape_pt_lat", error_msg, :error))
    end

    # Validate values in shapes.txt field shape_pt_lon
    value_errors = validate_value_shapes_shape_pt_lon(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("shapes.txt", "shape_pt_lon", error_msg, :error))
    end

    # Validate values in shapes.txt field shape_pt_sequence
    value_errors = validate_value_shapes_shape_pt_sequence(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("shapes.txt", "shape_pt_sequence", error_msg, :error))
    end

    # Validate values in shapes.txt field shape_dist_traveled
    value_errors = validate_value_shapes_shape_dist_traveled(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("shapes.txt", "shape_dist_traveled", error_msg, :error))
    end

    # Validate values in frequencies.txt field trip_id
    value_errors = validate_value_frequencies_trip_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("frequencies.txt", "trip_id", error_msg, :error))
    end

    # Validate values in frequencies.txt field start_time
    value_errors = validate_value_frequencies_start_time(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("frequencies.txt", "start_time", error_msg, :error))
    end

    # Validate values in frequencies.txt field end_time
    value_errors = validate_value_frequencies_end_time(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("frequencies.txt", "end_time", error_msg, :error))
    end

    # Validate values in frequencies.txt field headway_secs
    value_errors = validate_value_frequencies_headway_secs(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("frequencies.txt", "headway_secs", error_msg, :error))
    end

    # Validate values in frequencies.txt field exact_times
    value_errors = validate_value_frequencies_exact_times(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("frequencies.txt", "exact_times", error_msg, :error))
    end

    # Validate values in transfers.txt field from_stop_id
    value_errors = validate_value_transfers_from_stop_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("transfers.txt", "from_stop_id", error_msg, :error))
    end

    # Validate values in transfers.txt field to_stop_id
    value_errors = validate_value_transfers_to_stop_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("transfers.txt", "to_stop_id", error_msg, :error))
    end

    # Validate values in transfers.txt field from_route_id
    value_errors = validate_value_transfers_from_route_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("transfers.txt", "from_route_id", error_msg, :error))
    end

    # Validate values in transfers.txt field to_route_id
    value_errors = validate_value_transfers_to_route_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("transfers.txt", "to_route_id", error_msg, :error))
    end

    # Validate values in transfers.txt field from_trip_id
    value_errors = validate_value_transfers_from_trip_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("transfers.txt", "from_trip_id", error_msg, :error))
    end

    # Validate values in transfers.txt field to_trip_id
    value_errors = validate_value_transfers_to_trip_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("transfers.txt", "to_trip_id", error_msg, :error))
    end

    # Validate values in transfers.txt field transfer_type
    value_errors = validate_value_transfers_transfer_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("transfers.txt", "transfer_type", error_msg, :error))
    end

    # Validate values in transfers.txt field min_transfer_time
    value_errors = validate_value_transfers_min_transfer_time(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("transfers.txt", "min_transfer_time", error_msg, :error))
    end

    # Validate values in pathways.txt field pathway_id
    value_errors = validate_value_pathways_pathway_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("pathways.txt", "pathway_id", error_msg, :error))
    end

    # Validate values in pathways.txt field from_stop_id
    value_errors = validate_value_pathways_from_stop_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("pathways.txt", "from_stop_id", error_msg, :error))
    end

    # Validate values in pathways.txt field to_stop_id
    value_errors = validate_value_pathways_to_stop_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("pathways.txt", "to_stop_id", error_msg, :error))
    end

    # Validate values in pathways.txt field pathway_mode
    value_errors = validate_value_pathways_pathway_mode(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("pathways.txt", "pathway_mode", error_msg, :error))
    end

    # Validate values in pathways.txt field is_bidirectional
    value_errors = validate_value_pathways_is_bidirectional(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("pathways.txt", "is_bidirectional", error_msg, :error))
    end

    # Validate values in pathways.txt field length
    value_errors = validate_value_pathways_length(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("pathways.txt", "length", error_msg, :error))
    end

    # Validate values in pathways.txt field traversal_time
    value_errors = validate_value_pathways_traversal_time(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("pathways.txt", "traversal_time", error_msg, :error))
    end

    # Validate values in pathways.txt field stair_count
    value_errors = validate_value_pathways_stair_count(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("pathways.txt", "stair_count", error_msg, :error))
    end

    # Validate values in pathways.txt field max_slope
    value_errors = validate_value_pathways_max_slope(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("pathways.txt", "max_slope", error_msg, :error))
    end

    # Validate values in pathways.txt field min_width
    value_errors = validate_value_pathways_min_width(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("pathways.txt", "min_width", error_msg, :error))
    end

    # Validate values in pathways.txt field signposted_as
    value_errors = validate_value_pathways_signposted_as(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("pathways.txt", "signposted_as", error_msg, :error))
    end

    # Validate values in pathways.txt field reversed_signposted_as
    value_errors = validate_value_pathways_reversed_signposted_as(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("pathways.txt", "reversed_signposted_as", error_msg, :error))
    end

    # Validate values in levels.txt field level_id
    value_errors = validate_value_levels_level_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("levels.txt", "level_id", error_msg, :error))
    end

    # Validate values in levels.txt field level_index
    value_errors = validate_value_levels_level_index(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("levels.txt", "level_index", error_msg, :error))
    end

    # Validate values in levels.txt field level_name
    value_errors = validate_value_levels_level_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("levels.txt", "level_name", error_msg, :error))
    end

    # Validate values in location_groups.txt field location_group_id
    value_errors = validate_value_location_groups_location_group_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("location_groups.txt", "location_group_id", error_msg, :error))
    end

    # Validate values in location_groups.txt field location_group_name
    value_errors = validate_value_location_groups_location_group_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("location_groups.txt", "location_group_name", error_msg, :error))
    end

    # Validate values in location_group_stops.txt field location_group_id
    value_errors = validate_value_location_group_stops_location_group_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("location_group_stops.txt", "location_group_id", error_msg, :error))
    end

    # Validate values in location_group_stops.txt field stop_id
    value_errors = validate_value_location_group_stops_stop_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("location_group_stops.txt", "stop_id", error_msg, :error))
    end

    # Validate values in locations.geojson field -&nbsp;type
    value_errors = validate_value_locations_geojson_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("locations.geojson", "-&nbsp;type", error_msg, :error))
    end

    # Validate values in locations.geojson field -&nbsp;features
    value_errors = validate_value_locations_geojson_features(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("locations.geojson", "-&nbsp;features", error_msg, :error))
    end

    # Validate values in locations.geojson field &nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;type
    value_errors = validate_value_locations_geojson_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("locations.geojson", "&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;type", error_msg, :error))
    end

    # Validate values in locations.geojson field &nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;id
    value_errors = validate_value_locations_geojson_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("locations.geojson", "&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;id", error_msg, :error))
    end

    # Validate values in locations.geojson field &nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;properties
    value_errors = validate_value_locations_geojson_properties(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("locations.geojson", "&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;properties", error_msg, :error))
    end

    # Validate values in locations.geojson field &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;stop_name
    value_errors = validate_value_locations_geojson_stop_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("locations.geojson", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;stop_name", error_msg, :error))
    end

    # Validate values in locations.geojson field &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;stop_desc
    value_errors = validate_value_locations_geojson_stop_desc(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("locations.geojson", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;stop_desc", error_msg, :error))
    end

    # Validate values in locations.geojson field &nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;geometry
    value_errors = validate_value_locations_geojson_geometry(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("locations.geojson", "&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;geometry", error_msg, :error))
    end

    # Validate values in locations.geojson field &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;type
    value_errors = validate_value_locations_geojson_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("locations.geojson", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;type", error_msg, :error))
    end

    # Validate values in locations.geojson field &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;coordinates
    value_errors = validate_value_locations_geojson_coordinates(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("locations.geojson", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\-&nbsp;coordinates", error_msg, :error))
    end

    # Validate values in booking_rules.txt field booking_rule_id
    value_errors = validate_value_booking_rules_booking_rule_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "booking_rule_id", error_msg, :error))
    end

    # Validate values in booking_rules.txt field booking_type
    value_errors = validate_value_booking_rules_booking_type(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "booking_type", error_msg, :error))
    end

    # Validate values in booking_rules.txt field prior_notice_duration_min
    value_errors = validate_value_booking_rules_prior_notice_duration_min(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "prior_notice_duration_min", error_msg, :error))
    end

    # Validate values in booking_rules.txt field prior_notice_duration_max
    value_errors = validate_value_booking_rules_prior_notice_duration_max(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "prior_notice_duration_max", error_msg, :error))
    end

    # Validate values in booking_rules.txt field prior_notice_last_day
    value_errors = validate_value_booking_rules_prior_notice_last_day(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "prior_notice_last_day", error_msg, :error))
    end

    # Validate values in booking_rules.txt field prior_notice_last_time
    value_errors = validate_value_booking_rules_prior_notice_last_time(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "prior_notice_last_time", error_msg, :error))
    end

    # Validate values in booking_rules.txt field prior_notice_start_day
    value_errors = validate_value_booking_rules_prior_notice_start_day(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "prior_notice_start_day", error_msg, :error))
    end

    # Validate values in booking_rules.txt field prior_notice_start_time
    value_errors = validate_value_booking_rules_prior_notice_start_time(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "prior_notice_start_time", error_msg, :error))
    end

    # Validate values in booking_rules.txt field prior_notice_service_id
    value_errors = validate_value_booking_rules_prior_notice_service_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "prior_notice_service_id", error_msg, :error))
    end

    # Validate values in booking_rules.txt field message
    value_errors = validate_value_booking_rules_message(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "message", error_msg, :error))
    end

    # Validate values in booking_rules.txt field pickup_message
    value_errors = validate_value_booking_rules_pickup_message(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "pickup_message", error_msg, :error))
    end

    # Validate values in booking_rules.txt field drop_off_message
    value_errors = validate_value_booking_rules_drop_off_message(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "drop_off_message", error_msg, :error))
    end

    # Validate values in booking_rules.txt field phone_number
    value_errors = validate_value_booking_rules_phone_number(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "phone_number", error_msg, :error))
    end

    # Validate values in booking_rules.txt field info_url
    value_errors = validate_value_booking_rules_info_url(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "info_url", error_msg, :error))
    end

    # Validate values in booking_rules.txt field booking_url
    value_errors = validate_value_booking_rules_booking_url(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("booking_rules.txt", "booking_url", error_msg, :error))
    end

    # Validate values in translations.txt field table_name
    value_errors = validate_value_translations_table_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("translations.txt", "table_name", error_msg, :error))
    end

    # Validate values in translations.txt field field_name
    value_errors = validate_value_translations_field_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("translations.txt", "field_name", error_msg, :error))
    end

    # Validate values in translations.txt field language
    value_errors = validate_value_translations_language(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("translations.txt", "language", error_msg, :error))
    end

    # Validate values in translations.txt field translation
    value_errors = validate_value_translations_translation(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("translations.txt", "translation", error_msg, :error))
    end

    # Validate values in translations.txt field record_id
    value_errors = validate_value_translations_record_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("translations.txt", "record_id", error_msg, :error))
    end

    # Validate values in translations.txt field record_sub_id
    value_errors = validate_value_translations_record_sub_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("translations.txt", "record_sub_id", error_msg, :error))
    end

    # Validate values in translations.txt field field_value
    value_errors = validate_value_translations_field_value(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("translations.txt", "field_value", error_msg, :error))
    end

    # Validate values in feed_info.txt field feed_publisher_name
    value_errors = validate_value_feed_info_feed_publisher_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("feed_info.txt", "feed_publisher_name", error_msg, :error))
    end

    # Validate values in feed_info.txt field feed_publisher_url
    value_errors = validate_value_feed_info_feed_publisher_url(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("feed_info.txt", "feed_publisher_url", error_msg, :error))
    end

    # Validate values in feed_info.txt field feed_lang
    value_errors = validate_value_feed_info_feed_lang(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("feed_info.txt", "feed_lang", error_msg, :error))
    end

    # Validate values in feed_info.txt field default_lang
    value_errors = validate_value_feed_info_default_lang(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("feed_info.txt", "default_lang", error_msg, :error))
    end

    # Validate values in feed_info.txt field feed_start_date
    value_errors = validate_value_feed_info_feed_start_date(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("feed_info.txt", "feed_start_date", error_msg, :error))
    end

    # Validate values in feed_info.txt field feed_end_date
    value_errors = validate_value_feed_info_feed_end_date(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("feed_info.txt", "feed_end_date", error_msg, :error))
    end

    # Validate values in feed_info.txt field feed_version
    value_errors = validate_value_feed_info_feed_version(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("feed_info.txt", "feed_version", error_msg, :error))
    end

    # Validate values in feed_info.txt field feed_contact_email
    value_errors = validate_value_feed_info_feed_contact_email(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("feed_info.txt", "feed_contact_email", error_msg, :error))
    end

    # Validate values in feed_info.txt field feed_contact_url
    value_errors = validate_value_feed_info_feed_contact_url(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("feed_info.txt", "feed_contact_url", error_msg, :error))
    end

    # Validate values in attributions.txt field attribution_id
    value_errors = validate_value_attributions_attribution_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("attributions.txt", "attribution_id", error_msg, :error))
    end

    # Validate values in attributions.txt field agency_id
    value_errors = validate_value_attributions_agency_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("attributions.txt", "agency_id", error_msg, :error))
    end

    # Validate values in attributions.txt field route_id
    value_errors = validate_value_attributions_route_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("attributions.txt", "route_id", error_msg, :error))
    end

    # Validate values in attributions.txt field trip_id
    value_errors = validate_value_attributions_trip_id(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("attributions.txt", "trip_id", error_msg, :error))
    end

    # Validate values in attributions.txt field organization_name
    value_errors = validate_value_attributions_organization_name(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("attributions.txt", "organization_name", error_msg, :error))
    end

    # Validate values in attributions.txt field is_producer
    value_errors = validate_value_attributions_is_producer(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("attributions.txt", "is_producer", error_msg, :error))
    end

    # Validate values in attributions.txt field is_operator
    value_errors = validate_value_attributions_is_operator(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("attributions.txt", "is_operator", error_msg, :error))
    end

    # Validate values in attributions.txt field is_authority
    value_errors = validate_value_attributions_is_authority(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("attributions.txt", "is_authority", error_msg, :error))
    end

    # Validate values in attributions.txt field attribution_url
    value_errors = validate_value_attributions_attribution_url(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("attributions.txt", "attribution_url", error_msg, :error))
    end

    # Validate values in attributions.txt field attribution_email
    value_errors = validate_value_attributions_attribution_email(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("attributions.txt", "attribution_email", error_msg, :error))
    end

    # Validate values in attributions.txt field attribution_phone
    value_errors = validate_value_attributions_attribution_phone(gtfs)
    for error_msg in value_errors
        push!(messages, ValidationMessage("attributions.txt", "attribution_phone", error_msg, :error))
    end

    # Determine overall validity
    error_count = count(msg -> msg.severity == :error, messages)
    is_valid = error_count == 0

    # Generate summary
    summary = "Field value validation: $error_count errors"
    if is_valid
        summary *= " - All field values are valid"
    else
        summary *= " - Field value validation failed"
    end

    return ValidationResult(is_valid, messages, summary)
end

