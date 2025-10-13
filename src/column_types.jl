# Auto-generated file - Column type mappings for GTFS files
# Generated from GTFS specification parsing

const COLUMN_TYPES = Dict{String, Dict{String, Type}}(
    "agency.txt" => Dict{String, Type}(
        "agency_email" => Union{Missing, String},
        "agency_fare_url" => Union{Missing, String},
        "agency_id" => Union{Missing, String},
        "agency_lang" => Union{Missing, String},
        "agency_name" => String,
        "agency_phone" => Union{Missing, String},
        "agency_timezone" => String,
        "agency_url" => String,
        "cemv_support" => Union{Missing, Int64}
    ),
    "areas.txt" => Dict{String, Type}(
        "area_id" => String,
        "area_name" => Union{Missing, String}
    ),
    "attributions.txt" => Dict{String, Type}(
        "agency_id" => Union{Missing, String},
        "attribution_email" => Union{Missing, String},
        "attribution_id" => Union{Missing, String},
        "attribution_phone" => Union{Missing, String},
        "attribution_url" => Union{Missing, String},
        "is_authority" => Union{Missing, Int64},
        "is_operator" => Union{Missing, Int64},
        "is_producer" => Union{Missing, Int64},
        "organization_name" => String,
        "route_id" => Union{Missing, String},
        "trip_id" => Union{Missing, String}
    ),
    "booking_rules.txt" => Dict{String, Type}(
        "booking_rule_id" => String,
        "booking_type" => Int64,
        "booking_url" => Union{Missing, String},
        "drop_off_message" => Union{Missing, String},
        "info_url" => Union{Missing, String},
        "message" => Union{Missing, String},
        "phone_number" => Union{Missing, String},
        "pickup_message" => Union{Missing, String},
        "prior_notice_duration_max" => Union{Missing, Int64},
        "prior_notice_duration_min" => Union{Missing, Int64},
        "prior_notice_last_day" => Union{Missing, Int64},
        "prior_notice_last_time" => Union{Missing, String},
        "prior_notice_service_id" => Union{Missing, String},
        "prior_notice_start_day" => Union{Missing, Int64},
        "prior_notice_start_time" => Union{Missing, String}
    ),
    "calendar.txt" => Dict{String, Type}(
        "end_date" => String,
        "friday" => Int64,
        "monday" => Int64,
        "saturday" => Int64,
        "service_id" => String,
        "start_date" => String,
        "sunday" => Int64,
        "thursday" => Int64,
        "tuesday" => Int64,
        "wednesday" => Int64
    ),
    "calendar_dates.txt" => Dict{String, Type}(
        "date" => String,
        "exception_type" => Int64,
        "service_id" => String
    ),
    "fare_attributes.txt" => Dict{String, Type}(
        "agency_id" => Union{Missing, String},
        "currency_type" => String,
        "fare_id" => String,
        "payment_method" => Int64,
        "price" => Float64,
        "transfer_duration" => Union{Missing, Int64},
        "transfers" => Int64
    ),
    "fare_leg_join_rules.txt" => Dict{String, Type}(
        "from_network_id" => String,
        "from_stop_id" => Union{Missing, String},
        "to_network_id" => String,
        "to_stop_id" => Union{Missing, String}
    ),
    "fare_leg_rules.txt" => Dict{String, Type}(
        "fare_product_id" => String,
        "from_area_id" => Union{Missing, String},
        "from_timeframe_group_id" => Union{Missing, String},
        "leg_group_id" => Union{Missing, String},
        "network_id" => Union{Missing, String},
        "rule_priority" => Union{Missing, Int64},
        "to_area_id" => Union{Missing, String},
        "to_timeframe_group_id" => Union{Missing, String}
    ),
    "fare_media.txt" => Dict{String, Type}(
        "fare_media_id" => String,
        "fare_media_name" => Union{Missing, String},
        "fare_media_type" => Int64
    ),
    "fare_products.txt" => Dict{String, Type}(
        "amount" => String,
        "currency" => String,
        "fare_media_id" => Union{Missing, String},
        "fare_product_id" => String,
        "fare_product_name" => Union{Missing, String},
        "rider_category_id" => Union{Missing, String}
    ),
    "fare_rules.txt" => Dict{String, Type}(
        "contains_id" => Union{Missing, String},
        "destination_id" => Union{Missing, String},
        "fare_id" => String,
        "origin_id" => Union{Missing, String},
        "route_id" => Union{Missing, String}
    ),
    "fare_transfer_rules.txt" => Dict{String, Type}(
        "duration_limit" => Union{Missing, Int64},
        "duration_limit_type" => Union{Missing, Int64},
        "fare_product_id" => Union{Missing, String},
        "fare_transfer_type" => Int64,
        "from_leg_group_id" => Union{Missing, String},
        "to_leg_group_id" => Union{Missing, String},
        "transfer_count" => Union{Missing, Int64}
    ),
    "feed_info.txt" => Dict{String, Type}(
        "default_lang" => Union{Missing, String},
        "feed_contact_email" => Union{Missing, String},
        "feed_contact_url" => Union{Missing, String},
        "feed_end_date" => Union{Missing, String},
        "feed_lang" => String,
        "feed_publisher_name" => String,
        "feed_publisher_url" => String,
        "feed_start_date" => Union{Missing, String},
        "feed_version" => Union{Missing, String}
    ),
    "frequencies.txt" => Dict{String, Type}(
        "end_time" => String,
        "exact_times" => Union{Missing, Int64},
        "headway_secs" => Int64,
        "start_time" => String,
        "trip_id" => String
    ),
    "levels.txt" => Dict{String, Type}(
        "level_id" => String,
        "level_index" => Float64,
        "level_name" => Union{Missing, String}
    ),
    "location_group_stops.txt" => Dict{String, Type}(
        "location_group_id" => String,
        "stop_id" => String
    ),
    "location_groups.txt" => Dict{String, Type}(
        "location_group_id" => String,
        "location_group_name" => Union{Missing, String}
    ),
    "locations.geojson" => Dict{String, Type}(
        "        \\- coordinates" => String,
        "        \\- stop_desc" => Union{Missing, String},
        "        \\- stop_name" => Union{Missing, String},
        "        \\- type" => String,
        "    \\- geometry" => String,
        "    \\- id" => String,
        "    \\- properties" => String,
        "    \\- type" => String,
        "- features" => String,
        "- type" => String
    ),
    "networks.txt" => Dict{String, Type}(
        "network_id" => String,
        "network_name" => Union{Missing, String}
    ),
    "pathways.txt" => Dict{String, Type}(
        "from_stop_id" => String,
        "is_bidirectional" => Int64,
        "length" => Union{Missing, Float64},
        "max_slope" => Union{Missing, Float64},
        "min_width" => Union{Missing, Float64},
        "pathway_id" => String,
        "pathway_mode" => Int64,
        "reversed_signposted_as" => Union{Missing, String},
        "signposted_as" => Union{Missing, String},
        "stair_count" => Union{Missing, Int64},
        "to_stop_id" => String,
        "traversal_time" => Union{Missing, Int64}
    ),
    "rider_categories.txt" => Dict{String, Type}(
        "eligibility_url" => Union{Missing, String},
        "is_default_fare_category" => Int64,
        "rider_category_id" => String,
        "rider_category_name" => String
    ),
    "route_networks.txt" => Dict{String, Type}(
        "network_id" => String,
        "route_id" => String
    ),
    "routes.txt" => Dict{String, Type}(
        "agency_id" => Union{Missing, String},
        "cemv_support" => Union{Missing, Int64},
        "continuous_drop_off" => Union{Missing, Int64},
        "continuous_pickup" => Union{Missing, Int64},
        "network_id" => Union{Missing, String},
        "route_color" => Union{Missing, String},
        "route_desc" => Union{Missing, String},
        "route_id" => String,
        "route_long_name" => Union{Missing, String},
        "route_short_name" => Union{Missing, String},
        "route_sort_order" => Union{Missing, Int64},
        "route_text_color" => Union{Missing, String},
        "route_type" => Int64,
        "route_url" => Union{Missing, String}
    ),
    "shapes.txt" => Dict{String, Type}(
        "shape_dist_traveled" => Union{Missing, Float64},
        "shape_id" => String,
        "shape_pt_lat" => Float64,
        "shape_pt_lon" => Float64,
        "shape_pt_sequence" => Int64
    ),
    "stop_areas.txt" => Dict{String, Type}(
        "area_id" => String,
        "stop_id" => String
    ),
    "stop_times.txt" => Dict{String, Type}(
        "arrival_time" => Union{Missing, String},
        "continuous_drop_off" => Union{Missing, Int64},
        "continuous_pickup" => Union{Missing, Int64},
        "departure_time" => Union{Missing, String},
        "drop_off_booking_rule_id" => Union{Missing, String},
        "drop_off_type" => Union{Missing, Int64},
        "end_pickup_drop_off_window" => Union{Missing, String},
        "location_group_id" => Union{Missing, String},
        "location_id" => Union{Missing, String},
        "pickup_booking_rule_id" => Union{Missing, String},
        "pickup_type" => Union{Missing, Int64},
        "shape_dist_traveled" => Union{Missing, Float64},
        "start_pickup_drop_off_window" => Union{Missing, String},
        "stop_headsign" => Union{Missing, String},
        "stop_id" => Union{Missing, String},
        "stop_sequence" => Int64,
        "timepoint" => Union{Missing, Int64},
        "trip_id" => String
    ),
    "stops.txt" => Dict{String, Type}(
        "level_id" => Union{Missing, String},
        "location_type" => Union{Missing, Int64},
        "parent_station" => Union{Missing, String},
        "platform_code" => Union{Missing, String},
        "stop_access" => Union{Missing, Int64},
        "stop_code" => Union{Missing, String},
        "stop_desc" => Union{Missing, String},
        "stop_id" => String,
        "stop_lat" => Union{Missing, Float64},
        "stop_lon" => Union{Missing, Float64},
        "stop_name" => Union{Missing, String},
        "stop_timezone" => Union{Missing, String},
        "stop_url" => Union{Missing, String},
        "tts_stop_name" => Union{Missing, String},
        "wheelchair_boarding" => Union{Missing, Int64},
        "zone_id" => Union{Missing, String}
    ),
    "timeframes.txt" => Dict{String, Type}(
        "end_time" => Union{Missing, String},
        "service_id" => String,
        "start_time" => Union{Missing, String},
        "timeframe_group_id" => String
    ),
    "transfers.txt" => Dict{String, Type}(
        "from_route_id" => Union{Missing, String},
        "from_stop_id" => Union{Missing, String},
        "from_trip_id" => Union{Missing, String},
        "min_transfer_time" => Union{Missing, Int64},
        "to_route_id" => Union{Missing, String},
        "to_stop_id" => Union{Missing, String},
        "to_trip_id" => Union{Missing, String},
        "transfer_type" => Int64
    ),
    "translations.txt" => Dict{String, Type}(
        "field_name" => String,
        "field_value" => Union{Missing, String},
        "language" => String,
        "record_id" => Union{Missing, String},
        "record_sub_id" => Union{Missing, String},
        "table_name" => Int64,
        "translation" => String
    ),
    "trips.txt" => Dict{String, Type}(
        "bikes_allowed" => Union{Missing, Int64},
        "block_id" => Union{Missing, String},
        "cars_allowed" => Union{Missing, Int64},
        "direction_id" => Union{Missing, Int64},
        "route_id" => String,
        "service_id" => String,
        "shape_id" => Union{Missing, String},
        "trip_headsign" => Union{Missing, String},
        "trip_id" => String,
        "trip_short_name" => Union{Missing, String},
        "wheelchair_accessible" => Union{Missing, Int64}
    )
)
