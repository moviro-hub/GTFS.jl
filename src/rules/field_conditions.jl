# Auto-generated file - Generic field presence validator
# Generated from GTFS specification parsing

# Compact rule set distilled from parsed field-level conditions
const FIELD_RULES = Dict(
  "stops.txt" => [
    (
      field = "stop_name",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "0"),
      ]
    ),
    (
      field = "stop_name",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "1"),
      ]
    ),
    (
      field = "stop_name",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "2"),
      ]
    ),
    (
      field = "stop_lat",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "0"),
      ]
    ),
    (
      field = "stop_lat",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "1"),
      ]
    ),
    (
      field = "stop_lat",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "2"),
      ]
    ),
    (
      field = "stop_lon",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "0"),
      ]
    ),
    (
      field = "stop_lon",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "1"),
      ]
    ),
    (
      field = "stop_lon",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "2"),
      ]
    ),
    (
      field = "parent_station",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "2"),
      ]
    ),
    (
      field = "parent_station",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "3"),
      ]
    ),
    (
      field = "parent_station",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "4"),
      ]
    ),
    (
      field = "parent_station",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "1"),
      ]
    ),
    (
      field = "stop_access",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "1"),
      ]
    ),
    (
      field = "stop_access",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "2"),
      ]
    ),
    (
      field = "stop_access",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "3"),
      ]
    ),
    (
      field = "stop_access",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stops.txt", field = "location_type", value = "4"),
      ]
    ),
    (
      field = "stop_access",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stops.txt", field = "parent_station", value = ""),
      ]
    ),
  ],
  "routes.txt" => [
    (
      field = "route_short_name",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "routes.txt", field = "route_long_name", value = ""),
      ]
    ),
    (
      field = "route_long_name",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "routes.txt", field = "route_short_name", value = ""),
      ]
    ),
    (
      field = "continuous_pickup",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "stop_times.start_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "continuous_pickup",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "stop_times.end_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "continuous_drop_off",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "stop_times.start_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "continuous_drop_off",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "stop_times.end_pickup_drop_off_window", value = "defined"),
      ]
    ),
  ],
  "stop_times.txt" => [
    (
      field = "arrival_time",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "stop_sequence", value = ""),
      ]
    ),
    (
      field = "arrival_time",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "timepoint", value = "1"),
      ]
    ),
    (
      field = "arrival_time",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "start_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "arrival_time",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "end_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "departure_time",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "timepoint", value = "1"),
      ]
    ),
    (
      field = "departure_time",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "start_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "departure_time",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "end_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "stop_id",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "location_group_id", value = ""),
        (type = :field, file = "stop_times.txt", field = "location_id", value = ""),
      ]
    ),
    (
      field = "stop_id",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "location_group_id", value = "defined"),
      ]
    ),
    (
      field = "stop_id",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "location_id", value = "defined"),
      ]
    ),
    (
      field = "location_group_id",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "stop_id", value = "defined"),
      ]
    ),
    (
      field = "location_group_id",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "location_id", value = "defined"),
      ]
    ),
    (
      field = "location_id",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "stop_id", value = "defined"),
      ]
    ),
    (
      field = "location_id",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "location_group_id", value = "defined"),
      ]
    ),
    (
      field = "start_pickup_drop_off_window",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "location_group_id", value = "defined"),
      ]
    ),
    (
      field = "start_pickup_drop_off_window",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "location_id", value = "defined"),
      ]
    ),
    (
      field = "start_pickup_drop_off_window",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "end_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "start_pickup_drop_off_window",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "arrival_time", value = "defined"),
      ]
    ),
    (
      field = "start_pickup_drop_off_window",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "departure_time", value = "defined"),
      ]
    ),
    (
      field = "end_pickup_drop_off_window",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "location_group_id", value = "defined"),
      ]
    ),
    (
      field = "end_pickup_drop_off_window",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "location_id", value = "defined"),
      ]
    ),
    (
      field = "end_pickup_drop_off_window",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "start_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "end_pickup_drop_off_window",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "arrival_time", value = "defined"),
      ]
    ),
    (
      field = "end_pickup_drop_off_window",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "departure_time", value = "defined"),
      ]
    ),
    (
      field = "pickup_type",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "pickup_type", value = "0"),
      ]
    ),
    (
      field = "pickup_type",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "start_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "pickup_type",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "end_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "pickup_type",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "pickup_type", value = "3"),
      ]
    ),
    (
      field = "pickup_type",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "start_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "pickup_type",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "end_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "drop_off_type",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "drop_off_type", value = "0"),
      ]
    ),
    (
      field = "drop_off_type",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "start_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "drop_off_type",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "end_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "continuous_pickup",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "start_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "continuous_pickup",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "end_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "continuous_drop_off",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "start_pickup_drop_off_window", value = "defined"),
      ]
    ),
    (
      field = "continuous_drop_off",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = "end_pickup_drop_off_window", value = "defined"),
      ]
    ),
  ],
  "timeframes.txt" => [
    (
      field = "start_time",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "timeframes.txt", field = "end_time", value = "defined"),
      ]
    ),
    (
      field = "end_time",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "timeframes.txt", field = "start_time", value = "defined"),
      ]
    ),
  ],
  "fare_leg_join_rules.txt" => [
    (
      field = "from_stop_id",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "fare_leg_join_rules.txt", field = "to_stop_id", value = "defined"),
      ]
    ),
    (
      field = "to_stop_id",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "fare_leg_join_rules.txt", field = "from_stop_id", value = "defined"),
      ]
    ),
  ],
  "fare_transfer_rules.txt" => [
    (
      field = "transfer_count",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "fare_transfer_rules.txt", field = "from_leg_group_id", value = ""),
        (type = :field, file = "fare_transfer_rules.txt", field = "to_leg_group_id", value = ""),
      ]
    ),
    (
      field = "transfer_count",
      presence = "Conditionally Forbidden",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "fare_transfer_rules.txt", field = "from_leg_group_id", value = ""),
        (type = :field, file = "fare_transfer_rules.txt", field = "to_leg_group_id", value = ""),
      ]
    ),
    (
      field = "duration_limit_type",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "fare_transfer_rules.txt", field = "duration_limit", value = "defined"),
      ]
    ),
    (
      field = "duration_limit_type",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "fare_transfer_rules.txt", field = "duration_limit", value = ""),
      ]
    ),
  ],
  "transfers.txt" => [
    (
      field = "from_stop_id",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "transfers.txt", field = "transfer_type", value = ""),
      ]
    ),
    (
      field = "from_stop_id",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "transfers.txt", field = "transfer_type", value = ""),
      ]
    ),
    (
      field = "to_stop_id",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "transfers.txt", field = "transfer_type", value = ""),
      ]
    ),
    (
      field = "to_stop_id",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "transfers.txt", field = "transfer_type", value = ""),
      ]
    ),
    (
      field = "from_trip_id",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "transfers.txt", field = "transfer_type", value = ""),
      ]
    ),
    (
      field = "to_trip_id",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "transfers.txt", field = "transfer_type", value = ""),
      ]
    ),
  ],
  "booking_rules.txt" => [
    (
      field = "prior_notice_duration_min",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = "booking_type", value = "1"),
      ]
    ),
    (
      field = "prior_notice_duration_max",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = "booking_type", value = "0"),
        (type = :field, file = "booking_rules.txt", field = "booking_type", value = "2"),
      ]
    ),
    (
      field = "prior_notice_last_day",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = "booking_type", value = "2"),
      ]
    ),
    (
      field = "prior_notice_last_time",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = "prior_notice_last_day", value = "defined"),
      ]
    ),
    (
      field = "prior_notice_start_day",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = "booking_type", value = "0"),
      ]
    ),
    (
      field = "prior_notice_start_day",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = "booking_type", value = "1"),
        (type = :field, file = "booking_rules.txt", field = "prior_notice_duration_max", value = "defined"),
      ]
    ),
    (
      field = "prior_notice_start_time",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = "prior_notice_start_day", value = "defined"),
      ]
    ),
    (
      field = "prior_notice_service_id",
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = "booking_type", value = "2"),
      ]
    ),
  ],
  "translations.txt" => [
    (
      field = "record_id",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "translations.txt", field = "table_name", value = ""),
        (type = :field, file = "translations.txt", field = "feed_info", value = ""),
      ]
    ),
    (
      field = "record_id",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "translations.txt", field = "field_value", value = "defined"),
      ]
    ),
    (
      field = "record_id",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "translations.txt", field = "field_value", value = ""),
      ]
    ),
    (
      field = "record_sub_id",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "translations.txt", field = "table_name", value = ""),
        (type = :field, file = "translations.txt", field = "feed_info", value = ""),
      ]
    ),
    (
      field = "record_sub_id",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "translations.txt", field = "field_value", value = "defined"),
      ]
    ),
    (
      field = "record_sub_id",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "translations.txt", field = "table_name", value = "stop_times"),
        (type = :field, file = "translations.txt", field = "record_id", value = "defined"),
      ]
    ),
    (
      field = "field_value",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "translations.txt", field = "table_name", value = ""),
        (type = :field, file = "translations.txt", field = "feed_info", value = ""),
      ]
    ),
    (
      field = "field_value",
      presence = "Conditionally Required",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "translations.txt", field = "record_id", value = "defined"),
      ]
    ),
    (
      field = "field_value",
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "translations.txt", field = "record_id", value = ""),
      ]
    ),
  ],
)
