# Auto-generated file - GTFS file to struct field mapping
# Generated from GTFS specification parsing

"""
File Mapping Module

Provides mappings between GTFS file names and GTFSSchedule struct field names.
This file is auto-generated from the GTFS specification.
"""

# File name to struct field name mapping
const FILE_TO_FIELD = Dict{String, Symbol}(
    "agency.txt" => :agency,
    "areas.txt" => :areas,
    "attributions.txt" => :attributions,
    "booking_rules.txt" => :booking_rules,
    "calendar.txt" => :calendar,
    "calendar_dates.txt" => :calendar_dates,
    "fare_attributes.txt" => :fare_attributes,
    "fare_leg_join_rules.txt" => :fare_leg_join_rules,
    "fare_leg_rules.txt" => :fare_leg_rules,
    "fare_media.txt" => :fare_media,
    "fare_products.txt" => :fare_products,
    "fare_rules.txt" => :fare_rules,
    "fare_transfer_rules.txt" => :fare_transfer_rules,
    "feed_info.txt" => :feed_info,
    "frequencies.txt" => :frequencies,
    "levels.txt" => :levels,
    "location_group_stops.txt" => :location_group_stops,
    "location_groups.txt" => :location_groups,
    "locations.geojson" => :locations_geojson,
    "networks.txt" => :networks,
    "pathways.txt" => :pathways,
    "rider_categories.txt" => :rider_categories,
    "route_networks.txt" => :route_networks,
    "routes.txt" => :routes,
    "shapes.txt" => :shapes,
    "stop_areas.txt" => :stop_areas,
    "stop_times.txt" => :stop_times,
    "stops.txt" => :stops,
    "timeframes.txt" => :timeframes,
    "transfers.txt" => :transfers,
    "translations.txt" => :translations,
    "trips.txt" => :trips
)

# Required GTFS files (must be present)
const REQUIRED_FILES = [
    "agency.txt",
    "stops.txt",
    "routes.txt",
    "trips.txt",
    "stop_times.txt"
]

# Conditionally required files
const CONDITIONALLY_REQUIRED_FILES = [
    "calendar.txt",
    "calendar_dates.txt",
    "feed_info.txt",
    "levels.txt",
    "stops.txt"
]

