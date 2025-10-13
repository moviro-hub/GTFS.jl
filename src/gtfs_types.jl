# Auto-generated file - GTFSSchedule struct definition
# Generated from GTFS specification parsing

# DataFrames imported in main module

"""
    GTFSSchedule

Main struct representing a complete GTFS Schedule dataset.

This struct uses a hybrid approach, wrapping DataFrames in a typed struct
to provide both type safety and powerful data manipulation capabilities.

Fields are automatically generated from the GTFS specification and
categorized by requirement level:
- Required files: Always present, non-nullable DataFrames
- Conditionally required files: Union{DataFrame, Nothing}
- Optional files: Union{DataFrame, Nothing}
"""

struct GTFSSchedule
    # Required files
    agency::DataFrames.DataFrame
    routes::DataFrames.DataFrame
    stop_times::DataFrames.DataFrame
    stops::DataFrames.DataFrame
    trips::DataFrames.DataFrame

    # Conditionally required files
    calendar::Union{DataFrames.DataFrame, Nothing}
    calendar_dates::Union{DataFrames.DataFrame, Nothing}
    feed_info::Union{DataFrames.DataFrame, Nothing}
    levels::Union{DataFrames.DataFrame, Nothing}

    # Optional files
    areas::Union{DataFrames.DataFrame, Nothing}
    attributions::Union{DataFrames.DataFrame, Nothing}
    booking_rules::Union{DataFrames.DataFrame, Nothing}
    fare_attributes::Union{DataFrames.DataFrame, Nothing}
    fare_leg_join_rules::Union{DataFrames.DataFrame, Nothing}
    fare_leg_rules::Union{DataFrames.DataFrame, Nothing}
    fare_media::Union{DataFrames.DataFrame, Nothing}
    fare_products::Union{DataFrames.DataFrame, Nothing}
    fare_rules::Union{DataFrames.DataFrame, Nothing}
    fare_transfer_rules::Union{DataFrames.DataFrame, Nothing}
    frequencies::Union{DataFrames.DataFrame, Nothing}
    location_group_stops::Union{DataFrames.DataFrame, Nothing}
    location_groups::Union{DataFrames.DataFrame, Nothing}
    locations_geojson::Union{DataFrames.DataFrame, Nothing}
    networks::Union{DataFrames.DataFrame, Nothing}
    pathways::Union{DataFrames.DataFrame, Nothing}
    rider_categories::Union{DataFrames.DataFrame, Nothing}
    route_networks::Union{DataFrames.DataFrame, Nothing}
    shapes::Union{DataFrames.DataFrame, Nothing}
    stop_areas::Union{DataFrames.DataFrame, Nothing}
    timeframes::Union{DataFrames.DataFrame, Nothing}
    transfers::Union{DataFrames.DataFrame, Nothing}
    translations::Union{DataFrames.DataFrame, Nothing}
end
