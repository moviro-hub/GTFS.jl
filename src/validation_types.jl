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
# GTFSSchedule struct is now auto-generated in gtfs_types.jl

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
