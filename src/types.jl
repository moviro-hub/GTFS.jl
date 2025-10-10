"""
GTFS.jl - Type definitions for GTFS Schedule data

This module defines the main GTFSSchedule struct and related types for
representing GTFS Schedule data in Julia.
"""

# DataFrames.DataFrames imported in main module

"""
    GTFSSchedule

Main struct representing a complete GTFS Schedule dataset.

This struct uses a hybrid approach, wrapping DataFrames.DataFrames in a typed struct
to provide both type safety and powerful data manipulation capabilities.

# Fields

## Required Files
- `agency::DataFrames.DataFrame`: Transit agency information
- `stops::DataFrames.DataFrame`: Stop and station information
- `routes::DataFrames.DataFrame`: Route information
- `trips::DataFrames.DataFrame`: Trip information
- `stop_times::DataFrames.DataFrame`: Stop time information

## Conditionally Required Files
- `calendar::Union{DataFrames.DataFrame, Nothing}`: Service calendar (required if calendar_dates is not present)
- `calendar_dates::Union{DataFrames.DataFrame, Nothing}`: Service calendar exceptions (required if calendar is not present)

## Optional Core Files
- `fare_attributes::Union{DataFrames.DataFrame, Nothing}`: Fare information
- `fare_rules::Union{DataFrames.DataFrame, Nothing}`: Fare rules
- `shapes::DataFrames.DataFrame`: Shape information for route geometry
- `frequencies::Union{DataFrames.DataFrame, Nothing}`: Frequency-based service information
- `transfers::Union{DataFrames.DataFrame, Nothing}`: Transfer information between stops
- `pathways::Union{DataFrames.DataFrame, Nothing}`: Pathway information for stations
- `levels::Union{DataFrames.DataFrame, Nothing}`: Level information for stations
- `feed_info::Union{DataFrames.DataFrame, Nothing}`: Feed metadata
- `translations::Union{DataFrames.DataFrame, Nothing}`: Translation information
- `attributions::Union{DataFrames.DataFrame, Nothing}`: Attribution information

## Fares v2 Files (Optional)
- `fare_media::Union{DataFrames.DataFrame, Nothing}`: Fare media information
- `fare_products::Union{DataFrames.DataFrame, Nothing}`: Fare product information
- `fare_leg_rules::Union{DataFrames.DataFrame, Nothing}`: Fare leg rules
- `fare_transfer_rules::Union{DataFrames.DataFrame, Nothing}`: Fare transfer rules
- `timeframes::Union{DataFrames.DataFrame, Nothing}`: Timeframe information
- `rider_categories::Union{DataFrames.DataFrame, Nothing}`: Rider category information

## Additional Optional Files
- `areas::Union{DataFrames.DataFrame, Nothing}`: Area information
- `stop_areas::Union{DataFrames.DataFrame, Nothing}`: Stop area information
- `networks::Union{DataFrames.DataFrame, Nothing}`: Network information
- `route_networks::Union{DataFrames.DataFrame, Nothing}`: Route network information
- `location_groups::Union{DataFrames.DataFrame, Nothing}`: Location group information
- `location_group_stops::Union{DataFrames.DataFrame, Nothing}`: Location group stop information
- `locations_geojson::Union{DataFrames.DataFrame, Nothing}`: GeoJSON location information (GTFS-Flex extension)
- `booking_rules::Union{DataFrames.DataFrame, Nothing}`: Booking rule information

# Example

```julia
# Read a GTFS feed
gtfs = read_gtfs("path/to/feed.zip")

# Access required tables
println("Number of agencies: ", DataFrames.nrow(gtfs.agency))
println("Number of stops: ", DataFrames.nrow(gtfs.stops))
println("Number of routes: ", DataFrames.nrow(gtfs.routes))

# Access optional tables (check for nothing first)
if gtfs.feed_info !== nothing
    println("Feed version: ", gtfs.feed_info.feed_version[1])
end

# Use DataFrames.DataFrames operations
bus_routes = filter(row -> row.route_type == 3, gtfs.routes)
```
"""
struct GTFSSchedule
    # Required files
    agency::DataFrames.DataFrame
    stops::DataFrames.DataFrame
    routes::DataFrames.DataFrame
    trips::DataFrames.DataFrame
    stop_times::DataFrames.DataFrame

    # Conditionally required (calendar OR calendar_dates)
    calendar::Union{DataFrames.DataFrame, Nothing}
    calendar_dates::Union{DataFrames.DataFrame, Nothing}

    # Optional core files
    fare_attributes::Union{DataFrames.DataFrame, Nothing}
    fare_rules::Union{DataFrames.DataFrame, Nothing}
    shapes::Union{DataFrames.DataFrame, Nothing}
    frequencies::Union{DataFrames.DataFrame, Nothing}
    transfers::Union{DataFrames.DataFrame, Nothing}
    pathways::Union{DataFrames.DataFrame, Nothing}
    levels::Union{DataFrames.DataFrame, Nothing}
    feed_info::Union{DataFrames.DataFrame, Nothing}
    translations::Union{DataFrames.DataFrame, Nothing}
    attributions::Union{DataFrames.DataFrame, Nothing}

    # Fares v2 (optional)
    fare_media::Union{DataFrames.DataFrame, Nothing}
    fare_products::Union{DataFrames.DataFrame, Nothing}
    fare_leg_rules::Union{DataFrames.DataFrame, Nothing}
    fare_leg_join_rules::Union{DataFrames.DataFrame, Nothing}
    fare_transfer_rules::Union{DataFrames.DataFrame, Nothing}
    timeframes::Union{DataFrames.DataFrame, Nothing}
    rider_categories::Union{DataFrames.DataFrame, Nothing}

    # Additional optional files
    areas::Union{DataFrames.DataFrame, Nothing}
    stop_areas::Union{DataFrames.DataFrame, Nothing}
    networks::Union{DataFrames.DataFrame, Nothing}
    route_networks::Union{DataFrames.DataFrame, Nothing}
    location_groups::Union{DataFrames.DataFrame, Nothing}
    location_group_stops::Union{DataFrames.DataFrame, Nothing}
    locations_geojson::Union{DataFrames.DataFrame, Nothing}
    booking_rules::Union{DataFrames.DataFrame, Nothing}
end

"""
    ValidationMessage

Represents a specific validation message with context.

# Fields
- `file::String`: Name of the GTFS file where the message occurred
- `field::Union{String, Nothing}`: Name of the field (if applicable)
- `message::String`: Message text
- `severity::Symbol`: Message severity (:error, :warning, or :info)
"""
struct ValidationMessage
    file::String
    field::Union{String, Nothing}
    message::String
    severity::Symbol  # :error, :warning, or :info
end

"""
    ValidationResult

Result of GTFS validation containing errors and warnings.

# Fields
- `is_valid::Bool`: Whether the GTFS feed is valid
- `messages::Vector{ValidationMessage}`: List of validation messages
- `summary::String`: Summary of validation results
"""
struct ValidationResult
    is_valid::Bool
    messages::Vector{ValidationMessage}
    summary::String
end

# Constructor for ValidationResult
    function ValidationResult(messages::Vector{ValidationMessage})
        error_count = count(e -> e.severity == :error, messages)
        warning_count = count(e -> e.severity == :warning, messages)
        info_count = count(e -> e.severity == :info, messages)

        is_valid = error_count == 0

        summary = if is_valid
            if warning_count == 0 && info_count == 0
                "GTFS feed is valid with no issues."
            elseif warning_count == 0
                "GTFS feed is valid with $info_count info message(s)."
            elseif info_count == 0
                "GTFS feed is valid with $warning_count warning(s)."
            else
                "GTFS feed is valid with $warning_count warning(s) and $info_count info message(s)."
            end
        else
            if warning_count == 0 && info_count == 0
                "GTFS feed has $error_count error(s)."
            elseif warning_count == 0
                "GTFS feed has $error_count error(s) and $info_count info message(s)."
            elseif info_count == 0
                "GTFS feed has $error_count error(s) and $warning_count warning(s)."
            else
                "GTFS feed has $error_count error(s), $warning_count warning(s), and $info_count info message(s)."
            end
        end

        return ValidationResult(is_valid, messages, summary)
    end

# Pretty printing for ValidationResult
    function Base.show(io::IO, result::ValidationResult)
        println(io, result.summary)

        errors = filter(e -> e.severity == :error, result.messages)
        warnings = filter(e -> e.severity == :warning, result.messages)
        infos = filter(e -> e.severity == :info, result.messages)

        if !isempty(errors)
            println(io, "\nErrors:")
            for (i, error) in enumerate(errors)
                location = error.field !== nothing ? "$(error.file):$(error.field)" : error.file
                println(io, "  $i. [$location] $(error.message)")
            end
        end

        if !isempty(warnings)
            println(io, "\nWarnings:")
            for (i, warning) in enumerate(warnings)
                location = warning.field !== nothing ? "$(warning.file):$(warning.field)" : warning.file
                println(io, "  $i. [$location] $(warning.message)")
            end
        end

        if !isempty(infos)
            println(io, "\nInfo:")
            for (i, info) in enumerate(infos)
                location = info.field !== nothing ? "$(info.file):$(info.field)" : info.file
                println(io, "  $i. [$location] $(info.message)")
            end
        end
    end

# Pretty printing for ValidationMessage
function Base.show(io::IO, message::ValidationMessage)
    location = if message.field !== nothing
        "$(message.file):$(message.field)"
    else
        message.file
    end
    println(io, "[$(message.severity)] $location: $(message.message)")
end
