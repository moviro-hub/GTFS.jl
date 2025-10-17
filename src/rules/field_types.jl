# Auto-generated file - Field type validation rules
# Generated from GTFS specification parsing

# Compact rule set distilled from parsed field type information
const FIELD_TYPES = Dict(
  "agency.txt" => [
    (
      field = Symbol("agency_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("agency_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("agency_url"),
      primary_type = GTFSUrl,
      alternative_types = [],
    ),
    (
      field = Symbol("agency_timezone"),
      primary_type = GTFSTimezone,
      alternative_types = [],
    ),
    (
      field = Symbol("agency_lang"),
      primary_type = GTFSLanguagecode,
      alternative_types = [],
    ),
    (
      field = Symbol("agency_phone"),
      primary_type = GTFSPhonenumber,
      alternative_types = [],
    ),
    (
      field = Symbol("agency_fare_url"),
      primary_type = GTFSUrl,
      alternative_types = [],
    ),
    (
      field = Symbol("agency_email"),
      primary_type = GTFSEmail,
      alternative_types = [],
    ),
    (
      field = Symbol("cemv_support"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
  ],
  "stops.txt" => [
    (
      field = Symbol("stop_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_code"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("tts_stop_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_desc"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_lat"),
      primary_type = GTFSLatitude,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_lon"),
      primary_type = GTFSLongitude,
      alternative_types = [],
    ),
    (
      field = Symbol("zone_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_url"),
      primary_type = GTFSUrl,
      alternative_types = [],
    ),
    (
      field = Symbol("location_type"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("parent_station"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_timezone"),
      primary_type = GTFSTimezone,
      alternative_types = [],
    ),
    (
      field = Symbol("wheelchair_boarding"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("level_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("platform_code"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_access"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
  ],
  "routes.txt" => [
    (
      field = Symbol("route_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("agency_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("route_short_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("route_long_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("route_desc"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("route_type"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("route_url"),
      primary_type = GTFSUrl,
      alternative_types = [],
    ),
    (
      field = Symbol("route_color"),
      primary_type = GTFSColor,
      alternative_types = [],
    ),
    (
      field = Symbol("route_text_color"),
      primary_type = GTFSColor,
      alternative_types = [],
    ),
    (
      field = Symbol("route_sort_order"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
    (
      field = Symbol("continuous_pickup"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("continuous_drop_off"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("network_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("cemv_support"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
  ],
  "trips.txt" => [
    (
      field = Symbol("route_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("service_id"),
      primary_type = GTFSForeignidreferencing`Calendar.Service_Id`Or`Calendar_Dates.Service_Id`,
      alternative_types = [],
    ),
    (
      field = Symbol("trip_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("trip_headsign"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("trip_short_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("direction_id"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("block_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("shape_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("wheelchair_accessible"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("bikes_allowed"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("cars_allowed"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
  ],
  "stop_times.txt" => [
    (
      field = Symbol("trip_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("arrival_time"),
      primary_type = GTFSTime,
      alternative_types = [],
    ),
    (
      field = Symbol("departure_time"),
      primary_type = GTFSTime,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("location_group_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("location_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_sequence"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_headsign"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("start_pickup_drop_off_window"),
      primary_type = GTFSTime,
      alternative_types = [],
    ),
    (
      field = Symbol("end_pickup_drop_off_window"),
      primary_type = GTFSTime,
      alternative_types = [],
    ),
    (
      field = Symbol("pickup_type"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("drop_off_type"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("continuous_pickup"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("continuous_drop_off"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("shape_dist_traveled"),
      primary_type = GTFSFloat,
      alternative_types = [],
    ),
    (
      field = Symbol("timepoint"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("pickup_booking_rule_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("drop_off_booking_rule_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
  ],
  "calendar.txt" => [
    (
      field = Symbol("service_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("monday"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("tuesday"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("wednesday"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("thursday"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("friday"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("saturday"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("sunday"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("start_date"),
      primary_type = GTFSDate,
      alternative_types = [],
    ),
    (
      field = Symbol("end_date"),
      primary_type = GTFSDate,
      alternative_types = [],
    ),
  ],
  "calendar_dates.txt" => [
    (
      field = Symbol("service_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("date"),
      primary_type = GTFSDate,
      alternative_types = [],
    ),
    (
      field = Symbol("exception_type"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
  ],
  "fare_attributes.txt" => [
    (
      field = Symbol("fare_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("price"),
      primary_type = GTFSFloat,
      alternative_types = [],
    ),
    (
      field = Symbol("currency_type"),
      primary_type = GTFSCurrencycode,
      alternative_types = [],
    ),
    (
      field = Symbol("payment_method"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("transfers"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("agency_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("transfer_duration"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
  ],
  "fare_rules.txt" => [
    (
      field = Symbol("fare_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("route_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("origin_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("destination_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("contains_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
  ],
  "timeframes.txt" => [
    (
      field = Symbol("timeframe_group_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("start_time"),
      primary_type = GTFSLocaltime,
      alternative_types = [],
    ),
    (
      field = Symbol("end_time"),
      primary_type = GTFSLocaltime,
      alternative_types = [],
    ),
    (
      field = Symbol("service_id"),
      primary_type = GTFSForeignidreferencing`Calendar.Service_Id`Or`Calendar_Dates.Service_Id`,
      alternative_types = [],
    ),
  ],
  "rider_categories.txt" => [
    (
      field = Symbol("rider_category_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("rider_category_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("is_default_fare_category"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("eligibility_url"),
      primary_type = GTFSUrl,
      alternative_types = [],
    ),
  ],
  "fare_media.txt" => [
    (
      field = Symbol("fare_media_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("fare_media_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("fare_media_type"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
  ],
  "fare_products.txt" => [
    (
      field = Symbol("fare_product_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("fare_product_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("rider_category_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("fare_media_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("amount"),
      primary_type = GTFSCurrencyamount,
      alternative_types = [],
    ),
    (
      field = Symbol("currency"),
      primary_type = GTFSCurrencycode,
      alternative_types = [],
    ),
  ],
  "fare_leg_rules.txt" => [
    (
      field = Symbol("leg_group_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("network_id"),
      primary_type = GTFSForeignidreferencing`Routes.Network_Id`Or`Networks.Network_Id`,
      alternative_types = [],
    ),
    (
      field = Symbol("from_area_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("to_area_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("from_timeframe_group_id"),
      primary_type = GTFSTime,
      alternative_types = [],
    ),
    (
      field = Symbol("to_timeframe_group_id"),
      primary_type = GTFSTime,
      alternative_types = [],
    ),
    (
      field = Symbol("fare_product_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("rule_priority"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
  ],
  "fare_leg_join_rules.txt" => [
    (
      field = Symbol("from_network_id"),
      primary_type = GTFSForeignidreferencing`Routes.Network_Id`Or`Networks.Network_Id`,
      alternative_types = [],
    ),
    (
      field = Symbol("to_network_id"),
      primary_type = GTFSForeignidreferencing`Routes.Network_Id`Or`Networks.Network_Id`,
      alternative_types = [],
    ),
    (
      field = Symbol("from_stop_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("to_stop_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
  ],
  "fare_transfer_rules.txt" => [
    (
      field = Symbol("from_leg_group_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("to_leg_group_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("transfer_count"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
    (
      field = Symbol("duration_limit"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
    (
      field = Symbol("duration_limit_type"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("fare_transfer_type"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("fare_product_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
  ],
  "areas.txt" => [
    (
      field = Symbol("area_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("area_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
  ],
  "stop_areas.txt" => [
    (
      field = Symbol("area_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
  ],
  "networks.txt" => [
    (
      field = Symbol("network_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("network_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
  ],
  "route_networks.txt" => [
    (
      field = Symbol("network_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("route_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
  ],
  "shapes.txt" => [
    (
      field = Symbol("shape_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("shape_pt_lat"),
      primary_type = GTFSLatitude,
      alternative_types = [],
    ),
    (
      field = Symbol("shape_pt_lon"),
      primary_type = GTFSLongitude,
      alternative_types = [],
    ),
    (
      field = Symbol("shape_pt_sequence"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
    (
      field = Symbol("shape_dist_traveled"),
      primary_type = GTFSFloat,
      alternative_types = [],
    ),
  ],
  "frequencies.txt" => [
    (
      field = Symbol("trip_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("start_time"),
      primary_type = GTFSTime,
      alternative_types = [],
    ),
    (
      field = Symbol("end_time"),
      primary_type = GTFSTime,
      alternative_types = [],
    ),
    (
      field = Symbol("headway_secs"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
    (
      field = Symbol("exact_times"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
  ],
  "transfers.txt" => [
    (
      field = Symbol("from_stop_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("to_stop_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("from_route_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("to_route_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("from_trip_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("to_trip_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("transfer_type"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("min_transfer_time"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
  ],
  "pathways.txt" => [
    (
      field = Symbol("pathway_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("from_stop_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("to_stop_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("pathway_mode"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("is_bidirectional"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("length"),
      primary_type = GTFSFloat,
      alternative_types = [],
    ),
    (
      field = Symbol("traversal_time"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
    (
      field = Symbol("stair_count"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
    (
      field = Symbol("max_slope"),
      primary_type = GTFSFloat,
      alternative_types = [],
    ),
    (
      field = Symbol("min_width"),
      primary_type = GTFSFloat,
      alternative_types = [],
    ),
    (
      field = Symbol("signposted_as"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("reversed_signposted_as"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
  ],
  "levels.txt" => [
    (
      field = Symbol("level_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("level_index"),
      primary_type = GTFSFloat,
      alternative_types = [],
    ),
    (
      field = Symbol("level_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
  ],
  "location_groups.txt" => [
    (
      field = Symbol("location_group_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("location_group_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
  ],
  "location_group_stops.txt" => [
    (
      field = Symbol("location_group_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
  ],
  "locations.geojson" => [
    (
      field = Symbol("type"),
      primary_type = GTFSString,
      alternative_types = [],
    ),
    (
      field = Symbol("features"),
      primary_type = GTFSArray,
      alternative_types = [],
    ),
    (
      field = Symbol("type"),
      primary_type = GTFSString,
      alternative_types = [],
    ),
    (
      field = Symbol("id"),
      primary_type = GTFSString,
      alternative_types = [],
    ),
    (
      field = Symbol("properties"),
      primary_type = GTFSObject,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_name"),
      primary_type = GTFSString,
      alternative_types = [],
    ),
    (
      field = Symbol("stop_desc"),
      primary_type = GTFSString,
      alternative_types = [],
    ),
    (
      field = Symbol("geometry"),
      primary_type = GTFSObject,
      alternative_types = [],
    ),
    (
      field = Symbol("type"),
      primary_type = GTFSString,
      alternative_types = [],
    ),
    (
      field = Symbol("coordinates"),
      primary_type = GTFSArray,
      alternative_types = [],
    ),
  ],
  "booking_rules.txt" => [
    (
      field = Symbol("booking_rule_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("booking_type"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("prior_notice_duration_min"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
    (
      field = Symbol("prior_notice_duration_max"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
    (
      field = Symbol("prior_notice_last_day"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
    (
      field = Symbol("prior_notice_last_time"),
      primary_type = GTFSTime,
      alternative_types = [],
    ),
    (
      field = Symbol("prior_notice_start_day"),
      primary_type = GTFSInteger,
      alternative_types = [],
    ),
    (
      field = Symbol("prior_notice_start_time"),
      primary_type = GTFSTime,
      alternative_types = [],
    ),
    (
      field = Symbol("prior_notice_service_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("message"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("pickup_message"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("drop_off_message"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("phone_number"),
      primary_type = GTFSPhonenumber,
      alternative_types = [],
    ),
    (
      field = Symbol("info_url"),
      primary_type = GTFSUrl,
      alternative_types = [],
    ),
    (
      field = Symbol("booking_url"),
      primary_type = GTFSUrl,
      alternative_types = [],
    ),
  ],
  "translations.txt" => [
    (
      field = Symbol("table_name"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("field_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("language"),
      primary_type = GTFSLanguagecode,
      alternative_types = [],
    ),
    (
      field = Symbol("translation"),
      primary_type = GTFSText,
      alternative_types = [
        GTFSUrl,
        GTFSEmail,
        GTFSPhonenumber,
      ],
    ),
    (
      field = Symbol("record_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("record_sub_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("field_value"),
      primary_type = GTFSText,
      alternative_types = [
        GTFSUrl,
        GTFSEmail,
        GTFSPhonenumber,
      ],
    ),
  ],
  "feed_info.txt" => [
    (
      field = Symbol("feed_publisher_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("feed_publisher_url"),
      primary_type = GTFSUrl,
      alternative_types = [],
    ),
    (
      field = Symbol("feed_lang"),
      primary_type = GTFSLanguagecode,
      alternative_types = [],
    ),
    (
      field = Symbol("default_lang"),
      primary_type = GTFSLanguagecode,
      alternative_types = [],
    ),
    (
      field = Symbol("feed_start_date"),
      primary_type = GTFSDate,
      alternative_types = [],
    ),
    (
      field = Symbol("feed_end_date"),
      primary_type = GTFSDate,
      alternative_types = [],
    ),
    (
      field = Symbol("feed_version"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("feed_contact_email"),
      primary_type = GTFSEmail,
      alternative_types = [],
    ),
    (
      field = Symbol("feed_contact_url"),
      primary_type = GTFSUrl,
      alternative_types = [],
    ),
  ],
  "attributions.txt" => [
    (
      field = Symbol("attribution_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("agency_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("route_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("trip_id"),
      primary_type = GTFSId,
      alternative_types = [],
    ),
    (
      field = Symbol("organization_name"),
      primary_type = GTFSText,
      alternative_types = [],
    ),
    (
      field = Symbol("is_producer"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("is_operator"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("is_authority"),
      primary_type = GTFSEnum,
      alternative_types = [],
    ),
    (
      field = Symbol("attribution_url"),
      primary_type = GTFSUrl,
      alternative_types = [],
    ),
    (
      field = Symbol("attribution_email"),
      primary_type = GTFSEmail,
      alternative_types = [],
    ),
    (
      field = Symbol("attribution_phone"),
      primary_type = GTFSPhonenumber,
      alternative_types = [],
    ),
  ],
)

