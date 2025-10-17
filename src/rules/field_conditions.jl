# Auto-generated file - Generic field presence validator
# Generated from GTFS specification parsing

# Compact rule set distilled from parsed field-level conditions
const FIELD_RULES = Dict(
  "stops.txt" => [
    (
      field = Symbol("stop_name"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "0"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "1"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "2"),
      ]
    ),
    (
      field = Symbol("stop_name"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "3"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "4"),
      ]
    ),
    (
      field = Symbol("stop_lat"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "0"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "1"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "2"),
      ]
    ),
    (
      field = Symbol("stop_lat"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "3"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "4"),
      ]
    ),
    (
      field = Symbol("stop_lon"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "0"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "1"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "2"),
      ]
    ),
    (
      field = Symbol("stop_lon"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "3"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "4"),
      ]
    ),
    (
      field = Symbol("parent_station"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "2"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "3"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "4"),
      ]
    ),
    (
      field = Symbol("parent_station"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "0"),
      ]
    ),
    (
      field = Symbol("parent_station"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "1"),
      ]
    ),
    (
      field = Symbol("stop_access"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "1"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "2"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "3"),
        (type = :field, file = "stops.txt", field = Symbol("location_type"), value = "4"),
      ]
    ),
    (
      field = Symbol("stop_access"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stops.txt", field = Symbol("parent_station"), value = ""),
      ]
    ),
  ],
  "routes.txt" => [
    (
      field = Symbol("route_short_name"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "routes.txt", field = Symbol("routes.route_long_name"), value = ""),
      ]
    ),
    (
      field = Symbol("route_long_name"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "routes.txt", field = Symbol("routes.route_short_name"), value = ""),
      ]
    ),
    (
      field = Symbol("continuous_pickup"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "routes.txt", field = Symbol("1"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.start_pickup_drop_off_window"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.end_pickup_drop_off_window"), value = ""),
      ]
    ),
    (
      field = Symbol("continuous_drop_off"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "routes.txt", field = Symbol("1"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.start_pickup_drop_off_window"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.end_pickup_drop_off_window"), value = ""),
      ]
    ),
  ],
  "stop_times.txt" => [
    (
      field = Symbol("arrival_time"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.stop_sequence"), value = ""),
      ]
    ),
    (
      field = Symbol("arrival_time"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("timepoint"), value = "1"),
      ]
    ),
    (
      field = Symbol("arrival_time"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("start_pickup_drop_off_window"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("end_pickup_drop_off_window"), value = ""),
      ]
    ),
    (
      field = Symbol("departure_time"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("timepoint"), value = "1"),
      ]
    ),
    (
      field = Symbol("departure_time"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("start_pickup_drop_off_window"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("end_pickup_drop_off_window"), value = ""),
      ]
    ),
    (
      field = Symbol("stop_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.location_group_id"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.location_id"), value = ""),
      ]
    ),
    (
      field = Symbol("stop_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.location_group_id"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.location_id"), value = ""),
      ]
    ),
    (
      field = Symbol("location_group_id"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.stop_id"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.location_id"), value = ""),
      ]
    ),
    (
      field = Symbol("location_id"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.stop_id"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.location_group_id"), value = ""),
      ]
    ),
    (
      field = Symbol("start_pickup_drop_off_window"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.location_group_id"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.location_id"), value = ""),
      ]
    ),
    (
      field = Symbol("start_pickup_drop_off_window"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("end_pickup_drop_off_window"), value = ""),
      ]
    ),
    (
      field = Symbol("start_pickup_drop_off_window"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("arrival_time"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("departure_time"), value = ""),
      ]
    ),
    (
      field = Symbol("end_pickup_drop_off_window"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.location_group_id"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("stop_times.location_id"), value = ""),
      ]
    ),
    (
      field = Symbol("end_pickup_drop_off_window"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("start_pickup_drop_off_window"), value = ""),
      ]
    ),
    (
      field = Symbol("end_pickup_drop_off_window"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("arrival_time"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("departure_time"), value = ""),
      ]
    ),
    (
      field = Symbol("pickup_type"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("pickup_type"), value = "0"),
        (type = :field, file = "stop_times.txt", field = Symbol("start_pickup_drop_off_window"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("end_pickup_drop_off_window"), value = ""),
      ]
    ),
    (
      field = Symbol("pickup_type"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("pickup_type"), value = "3"),
        (type = :field, file = "stop_times.txt", field = Symbol("start_pickup_drop_off_window"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("end_pickup_drop_off_window"), value = ""),
      ]
    ),
    (
      field = Symbol("drop_off_type"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("drop_off_type"), value = "0"),
        (type = :field, file = "stop_times.txt", field = Symbol("start_pickup_drop_off_window"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("end_pickup_drop_off_window"), value = ""),
      ]
    ),
    (
      field = Symbol("continuous_pickup"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("1"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("start_pickup_drop_off_window"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("end_pickup_drop_off_window"), value = ""),
      ]
    ),
    (
      field = Symbol("continuous_drop_off"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "stop_times.txt", field = Symbol("1"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("start_pickup_drop_off_window"), value = ""),
        (type = :field, file = "stop_times.txt", field = Symbol("end_pickup_drop_off_window"), value = ""),
      ]
    ),
  ],
  "timeframes.txt" => [
    (
      field = Symbol("start_time"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "timeframes.txt", field = Symbol("timeframes.end_time"), value = ""),
      ]
    ),
    (
      field = Symbol("end_time"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "timeframes.txt", field = Symbol("timeframes.start_time"), value = ""),
      ]
    ),
  ],
  "fare_leg_join_rules.txt" => [
    (
      field = Symbol("from_stop_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "fare_leg_join_rules.txt", field = Symbol("to_stop_id"), value = ""),
      ]
    ),
    (
      field = Symbol("to_stop_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "fare_leg_join_rules.txt", field = Symbol("from_stop_id"), value = ""),
      ]
    ),
  ],
  "fare_transfer_rules.txt" => [
    (
      field = Symbol("transfer_count"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "fare_transfer_rules.txt", field = Symbol("fare_transfer_rules.from_leg_group_id"), value = ""),
        (type = :field, file = "fare_transfer_rules.txt", field = Symbol("fare_transfer_rules.to_leg_group_id"), value = ""),
      ]
    ),
    (
      field = Symbol("transfer_count"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "fare_transfer_rules.txt", field = Symbol("fare_transfer_rules.from_leg_group_id"), value = ""),
        (type = :field, file = "fare_transfer_rules.txt", field = Symbol("fare_transfer_rules.to_leg_group_id"), value = ""),
      ]
    ),
    (
      field = Symbol("duration_limit_type"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "fare_transfer_rules.txt", field = Symbol("fare_transfer_rules.duration_limit"), value = ""),
      ]
    ),
    (
      field = Symbol("duration_limit_type"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "fare_transfer_rules.txt", field = Symbol("fare_transfer_rules.duration_limit"), value = ""),
      ]
    ),
  ],
  "transfers.txt" => [
    (
      field = Symbol("from_stop_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "transfers.txt", field = Symbol("transfer_type"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("1"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("2"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("3"), value = ""),
      ]
    ),
    (
      field = Symbol("from_stop_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "transfers.txt", field = Symbol("transfer_type"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("4"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("5"), value = ""),
      ]
    ),
    (
      field = Symbol("to_stop_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "transfers.txt", field = Symbol("transfer_type"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("1"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("2"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("3"), value = ""),
      ]
    ),
    (
      field = Symbol("to_stop_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "transfers.txt", field = Symbol("transfer_type"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("4"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("5"), value = ""),
      ]
    ),
    (
      field = Symbol("from_trip_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "transfers.txt", field = Symbol("transfer_type"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("4"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("5"), value = ""),
      ]
    ),
    (
      field = Symbol("to_trip_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "transfers.txt", field = Symbol("transfer_type"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("4"), value = ""),
        (type = :field, file = "transfers.txt", field = Symbol("5"), value = ""),
      ]
    ),
  ],
  "booking_rules.txt" => [
    (
      field = Symbol("prior_notice_duration_min"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = Symbol("booking_type"), value = "1"),
      ]
    ),
    (
      field = Symbol("prior_notice_duration_max"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = Symbol("booking_type"), value = "0"),
        (type = :field, file = "booking_rules.txt", field = Symbol("booking_type"), value = "2"),
      ]
    ),
    (
      field = Symbol("prior_notice_duration_max"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = Symbol("booking_type"), value = "1"),
      ]
    ),
    (
      field = Symbol("prior_notice_last_day"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = Symbol("booking_type"), value = "2"),
      ]
    ),
    (
      field = Symbol("prior_notice_last_time"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = Symbol("prior_notice_last_day"), value = ""),
      ]
    ),
    (
      field = Symbol("prior_notice_start_day"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = Symbol("booking_type"), value = "0"),
      ]
    ),
    (
      field = Symbol("prior_notice_start_day"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = Symbol("booking_type"), value = "1"),
        (type = :field, file = "booking_rules.txt", field = Symbol("prior_notice_duration_max"), value = ""),
      ]
    ),
    (
      field = Symbol("prior_notice_start_time"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = Symbol("prior_notice_start_day"), value = ""),
      ]
    ),
    (
      field = Symbol("prior_notice_service_id"),
      presence = "Conditionally Forbidden",
      required = false,
      forbidden = true,
      conditions = [
        (type = :field, file = "booking_rules.txt", field = Symbol("booking_type"), value = "2"),
      ]
    ),
  ],
  "translations.txt" => [
    (
      field = Symbol("record_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "translations.txt", field = Symbol("table_name"), value = ""),
        (type = :field, file = "translations.txt", field = Symbol("feed_info"), value = ""),
      ]
    ),
    (
      field = Symbol("record_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "translations.txt", field = Symbol("field_value"), value = ""),
      ]
    ),
    (
      field = Symbol("record_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "translations.txt", field = Symbol("field_value"), value = ""),
      ]
    ),
    (
      field = Symbol("record_sub_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "translations.txt", field = Symbol("table_name"), value = ""),
        (type = :field, file = "translations.txt", field = Symbol("feed_info"), value = ""),
      ]
    ),
    (
      field = Symbol("record_sub_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "translations.txt", field = Symbol("field_value"), value = ""),
      ]
    ),
    (
      field = Symbol("record_sub_id"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "translations.txt", field = Symbol("table_name"), value = "stop_times"),
        (type = :field, file = "translations.txt", field = Symbol("record_id"), value = ""),
      ]
    ),
    (
      field = Symbol("field_value"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "translations.txt", field = Symbol("table_name"), value = ""),
        (type = :field, file = "translations.txt", field = Symbol("feed_info"), value = ""),
      ]
    ),
    (
      field = Symbol("field_value"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "translations.txt", field = Symbol("record_id"), value = ""),
      ]
    ),
    (
      field = Symbol("field_value"),
      presence = "Conditionally Required",
      required = true,
      forbidden = false,
      conditions = [
        (type = :field, file = "translations.txt", field = Symbol("record_id"), value = ""),
      ]
    ),
  ],
)

