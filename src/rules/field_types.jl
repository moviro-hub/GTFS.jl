# Auto-generated file - Field type validation rules
# Generated from GTFS specification parsing

# Compact rule set distilled from parsed field type information
const FIELD_TYPES = Dict(
    "agency.txt" => [
        (
            field = "agency_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "agency_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "agency_url",
            type_symbol = :GTFSURL,
            alternative_types = [],
        ),
        (
            field = "agency_timezone",
            type_symbol = :GTFSTimezone,
            alternative_types = [],
        ),
        (
            field = "agency_lang",
            type_symbol = :GTFSLanguageCode,
            alternative_types = [],
        ),
        (
            field = "agency_phone",
            type_symbol = :GTFSPhoneNumber,
            alternative_types = [],
        ),
        (
            field = "agency_fare_url",
            type_symbol = :GTFSURL,
            alternative_types = [],
        ),
        (
            field = "agency_email",
            type_symbol = :GTFSEmail,
            alternative_types = [],
        ),
        (
            field = "cemv_support",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
    ],
    "stops.txt" => [
        (
            field = "stop_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "stop_code",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "stop_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "tts_stop_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "stop_desc",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "stop_lat",
            type_symbol = :GTFSLatitude,
            alternative_types = [],
        ),
        (
            field = "stop_lon",
            type_symbol = :GTFSLongitude,
            alternative_types = [],
        ),
        (
            field = "zone_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "stop_url",
            type_symbol = :GTFSURL,
            alternative_types = [],
        ),
        (
            field = "location_type",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "parent_station",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "stop_timezone",
            type_symbol = :GTFSTimezone,
            alternative_types = [],
        ),
        (
            field = "wheelchair_boarding",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "level_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "platform_code",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "stop_access",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
    ],
    "routes.txt" => [
        (
            field = "route_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "agency_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "route_short_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "route_long_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "route_desc",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "route_type",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "route_url",
            type_symbol = :GTFSURL,
            alternative_types = [],
        ),
        (
            field = "route_color",
            type_symbol = :GTFSColor,
            alternative_types = [],
        ),
        (
            field = "route_text_color",
            type_symbol = :GTFSColor,
            alternative_types = [],
        ),
        (
            field = "route_sort_order",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
        (
            field = "continuous_pickup",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "continuous_drop_off",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "network_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "cemv_support",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
    ],
    "trips.txt" => [
        (
            field = "route_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "service_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "trip_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "trip_headsign",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "trip_short_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "direction_id",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "block_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "shape_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "wheelchair_accessible",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "bikes_allowed",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "cars_allowed",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
    ],
    "stop_times.txt" => [
        (
            field = "trip_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "arrival_time",
            type_symbol = :GTFSTime,
            alternative_types = [],
        ),
        (
            field = "departure_time",
            type_symbol = :GTFSTime,
            alternative_types = [],
        ),
        (
            field = "stop_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "location_group_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "location_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "stop_sequence",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
        (
            field = "stop_headsign",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "start_pickup_drop_off_window",
            type_symbol = :GTFSTime,
            alternative_types = [],
        ),
        (
            field = "end_pickup_drop_off_window",
            type_symbol = :GTFSTime,
            alternative_types = [],
        ),
        (
            field = "pickup_type",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "drop_off_type",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "continuous_pickup",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "continuous_drop_off",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "shape_dist_traveled",
            type_symbol = :GTFSFloat,
            alternative_types = [],
        ),
        (
            field = "timepoint",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "pickup_booking_rule_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "drop_off_booking_rule_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
    ],
    "calendar.txt" => [
        (
            field = "service_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "monday",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "tuesday",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "wednesday",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "thursday",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "friday",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "saturday",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "sunday",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "start_date",
            type_symbol = :GTFSDate,
            alternative_types = [],
        ),
        (
            field = "end_date",
            type_symbol = :GTFSDate,
            alternative_types = [],
        ),
    ],
    "calendar_dates.txt" => [
        (
            field = "service_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "date",
            type_symbol = :GTFSDate,
            alternative_types = [],
        ),
        (
            field = "exception_type",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
    ],
    "fare_attributes.txt" => [
        (
            field = "fare_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "price",
            type_symbol = :GTFSFloat,
            alternative_types = [],
        ),
        (
            field = "currency_type",
            type_symbol = :GTFSCurrencyCode,
            alternative_types = [],
        ),
        (
            field = "payment_method",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "transfers",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "agency_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "transfer_duration",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
    ],
    "fare_rules.txt" => [
        (
            field = "fare_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "route_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "origin_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "destination_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "contains_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
    ],
    "timeframes.txt" => [
        (
            field = "timeframe_group_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "start_time",
            type_symbol = :GTFSLocalTime,
            alternative_types = [],
        ),
        (
            field = "end_time",
            type_symbol = :GTFSLocalTime,
            alternative_types = [],
        ),
        (
            field = "service_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
    ],
    "rider_categories.txt" => [
        (
            field = "rider_category_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "rider_category_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "is_default_fare_category",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "eligibility_url",
            type_symbol = :GTFSURL,
            alternative_types = [],
        ),
    ],
    "fare_media.txt" => [
        (
            field = "fare_media_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "fare_media_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "fare_media_type",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
    ],
    "fare_products.txt" => [
        (
            field = "fare_product_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "fare_product_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "rider_category_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "fare_media_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "amount",
            type_symbol = :GTFSCurrencyAmount,
            alternative_types = [],
        ),
        (
            field = "currency",
            type_symbol = :GTFSCurrencyCode,
            alternative_types = [],
        ),
    ],
    "fare_leg_rules.txt" => [
        (
            field = "leg_group_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "network_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "from_area_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "to_area_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "from_timeframe_group_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "to_timeframe_group_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "fare_product_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "rule_priority",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
    ],
    "fare_leg_join_rules.txt" => [
        (
            field = "from_network_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "to_network_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "from_stop_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "to_stop_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
    ],
    "fare_transfer_rules.txt" => [
        (
            field = "from_leg_group_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "to_leg_group_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "transfer_count",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
        (
            field = "duration_limit",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
        (
            field = "duration_limit_type",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "fare_transfer_type",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "fare_product_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
    ],
    "areas.txt" => [
        (
            field = "area_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "area_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
    ],
    "stop_areas.txt" => [
        (
            field = "area_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "stop_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
    ],
    "networks.txt" => [
        (
            field = "network_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "network_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
    ],
    "route_networks.txt" => [
        (
            field = "network_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "route_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
    ],
    "shapes.txt" => [
        (
            field = "shape_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "shape_pt_lat",
            type_symbol = :GTFSLatitude,
            alternative_types = [],
        ),
        (
            field = "shape_pt_lon",
            type_symbol = :GTFSLongitude,
            alternative_types = [],
        ),
        (
            field = "shape_pt_sequence",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
        (
            field = "shape_dist_traveled",
            type_symbol = :GTFSFloat,
            alternative_types = [],
        ),
    ],
    "frequencies.txt" => [
        (
            field = "trip_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "start_time",
            type_symbol = :GTFSTime,
            alternative_types = [],
        ),
        (
            field = "end_time",
            type_symbol = :GTFSTime,
            alternative_types = [],
        ),
        (
            field = "headway_secs",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
        (
            field = "exact_times",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
    ],
    "transfers.txt" => [
        (
            field = "from_stop_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "to_stop_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "from_route_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "to_route_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "from_trip_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "to_trip_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "transfer_type",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "min_transfer_time",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
    ],
    "pathways.txt" => [
        (
            field = "pathway_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "from_stop_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "to_stop_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "pathway_mode",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "is_bidirectional",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "length",
            type_symbol = :GTFSFloat,
            alternative_types = [],
        ),
        (
            field = "traversal_time",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
        (
            field = "stair_count",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
        (
            field = "max_slope",
            type_symbol = :GTFSFloat,
            alternative_types = [],
        ),
        (
            field = "min_width",
            type_symbol = :GTFSFloat,
            alternative_types = [],
        ),
        (
            field = "signposted_as",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "reversed_signposted_as",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
    ],
    "levels.txt" => [
        (
            field = "level_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "level_index",
            type_symbol = :GTFSFloat,
            alternative_types = [],
        ),
        (
            field = "level_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
    ],
    "location_groups.txt" => [
        (
            field = "location_group_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "location_group_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
    ],
    "location_group_stops.txt" => [
        (
            field = "location_group_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "stop_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
    ],
    "booking_rules.txt" => [
        (
            field = "booking_rule_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "booking_type",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "prior_notice_duration_min",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
        (
            field = "prior_notice_duration_max",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
        (
            field = "prior_notice_last_day",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
        (
            field = "prior_notice_last_time",
            type_symbol = :GTFSTime,
            alternative_types = [],
        ),
        (
            field = "prior_notice_start_day",
            type_symbol = :GTFSInteger,
            alternative_types = [],
        ),
        (
            field = "prior_notice_start_time",
            type_symbol = :GTFSTime,
            alternative_types = [],
        ),
        (
            field = "prior_notice_service_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "message",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "pickup_message",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "drop_off_message",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "phone_number",
            type_symbol = :GTFSPhoneNumber,
            alternative_types = [],
        ),
        (
            field = "info_url",
            type_symbol = :GTFSURL,
            alternative_types = [],
        ),
        (
            field = "booking_url",
            type_symbol = :GTFSURL,
            alternative_types = [],
        ),
    ],
    "translations.txt" => [
        (
            field = "table_name",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "field_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "language",
            type_symbol = :GTFSLanguageCode,
            alternative_types = [],
        ),
        (
            field = "translation",
            type_symbol = :GTFSText,
            alternative_types = [
                :GTFSURL,
                :GTFSEmail,
                :GTFSPhoneNumber,
            ],
        ),
        (
            field = "record_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "record_sub_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "field_value",
            type_symbol = :GTFSText,
            alternative_types = [
                :GTFSURL,
                :GTFSEmail,
                :GTFSPhoneNumber,
            ],
        ),
    ],
    "feed_info.txt" => [
        (
            field = "feed_publisher_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "feed_publisher_url",
            type_symbol = :GTFSURL,
            alternative_types = [],
        ),
        (
            field = "feed_lang",
            type_symbol = :GTFSLanguageCode,
            alternative_types = [],
        ),
        (
            field = "default_lang",
            type_symbol = :GTFSLanguageCode,
            alternative_types = [],
        ),
        (
            field = "feed_start_date",
            type_symbol = :GTFSDate,
            alternative_types = [],
        ),
        (
            field = "feed_end_date",
            type_symbol = :GTFSDate,
            alternative_types = [],
        ),
        (
            field = "feed_version",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "feed_contact_email",
            type_symbol = :GTFSEmail,
            alternative_types = [],
        ),
        (
            field = "feed_contact_url",
            type_symbol = :GTFSURL,
            alternative_types = [],
        ),
    ],
    "attributions.txt" => [
        (
            field = "attribution_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "agency_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "route_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "trip_id",
            type_symbol = :GTFSID,
            alternative_types = [],
        ),
        (
            field = "organization_name",
            type_symbol = :GTFSText,
            alternative_types = [],
        ),
        (
            field = "is_producer",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "is_operator",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "is_authority",
            type_symbol = :GTFSEnum,
            alternative_types = [],
        ),
        (
            field = "attribution_url",
            type_symbol = :GTFSURL,
            alternative_types = [],
        ),
        (
            field = "attribution_email",
            type_symbol = :GTFSEmail,
            alternative_types = [],
        ),
        (
            field = "attribution_phone",
            type_symbol = :GTFSPhoneNumber,
            alternative_types = [],
        ),
    ],
)
