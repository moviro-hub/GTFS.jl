# Auto-generated file - Field ID reference validation rules
# Generated from GTFS specification parsing

# Compact rule set distilled from parsed field ID reference information
const FIELD_ID_REFERENCES = Dict(
  "stops.txt" => [
    (
      field = Symbol("parent_station"),
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
    ),
    (
      field = Symbol("level_id"),
      references = [
        (
          table = "levels",
          field = "level_id",
        ),
      ],
    ),
  ],
  "routes.txt" => [
    (
      field = Symbol("agency_id"),
      references = [
        (
          table = "agency",
          field = "agency_id",
        ),
      ],
    ),
  ],
  "trips.txt" => [
    (
      field = Symbol("route_id"),
      references = [
        (
          table = "routes",
          field = "route_id",
        ),
      ],
    ),
    (
      field = Symbol("service_id"),
      references = [
        (
          table = "calendar",
          field = "service_id",
        ),
        (
          table = "calendar_dates",
          field = "service_id",
        ),
      ],
    ),
    (
      field = Symbol("shape_id"),
      references = [
        (
          table = "shapes",
          field = "shape_id",
        ),
      ],
    ),
  ],
  "stop_times.txt" => [
    (
      field = Symbol("trip_id"),
      references = [
        (
          table = "trips",
          field = "trip_id",
        ),
      ],
    ),
    (
      field = Symbol("stop_id"),
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
    ),
    (
      field = Symbol("location_group_id"),
      references = [
        (
          table = "location_groups",
          field = "location_group_id",
        ),
      ],
    ),
    (
      field = Symbol("location_id"),
      references = [
        (
          table = "locations",
          field = "geojson",
        ),
      ],
    ),
    (
      field = Symbol("pickup_booking_rule_id"),
      references = [
        (
          table = "booking_rules",
          field = "booking_rule_id",
        ),
      ],
    ),
    (
      field = Symbol("drop_off_booking_rule_id"),
      references = [
        (
          table = "booking_rules",
          field = "booking_rule_id",
        ),
      ],
    ),
  ],
  "calendar_dates.txt" => [
    (
      field = Symbol("service_id"),
      references = [
        (
          table = "calendar",
          field = "service_id",
        ),
      ],
    ),
  ],
  "fare_attributes.txt" => [
    (
      field = Symbol("agency_id"),
      references = [
        (
          table = "agency",
          field = "agency_id",
        ),
      ],
    ),
  ],
  "fare_rules.txt" => [
    (
      field = Symbol("fare_id"),
      references = [
        (
          table = "fare_attributes",
          field = "fare_id",
        ),
      ],
    ),
    (
      field = Symbol("route_id"),
      references = [
        (
          table = "routes",
          field = "route_id",
        ),
      ],
    ),
    (
      field = Symbol("origin_id"),
      references = [
        (
          table = "stops",
          field = "zone_id",
        ),
      ],
    ),
    (
      field = Symbol("destination_id"),
      references = [
        (
          table = "stops",
          field = "zone_id",
        ),
      ],
    ),
    (
      field = Symbol("contains_id"),
      references = [
        (
          table = "stops",
          field = "zone_id",
        ),
      ],
    ),
  ],
  "timeframes.txt" => [
    (
      field = Symbol("service_id"),
      references = [
        (
          table = "calendar",
          field = "service_id",
        ),
        (
          table = "calendar_dates",
          field = "service_id",
        ),
      ],
    ),
  ],
  "fare_products.txt" => [
    (
      field = Symbol("rider_category_id"),
      references = [
        (
          table = "rider_categories",
          field = "rider_category_id",
        ),
      ],
    ),
    (
      field = Symbol("fare_media_id"),
      references = [
        (
          table = "fare_media",
          field = "fare_media_id",
        ),
      ],
    ),
  ],
  "fare_leg_rules.txt" => [
    (
      field = Symbol("network_id"),
      references = [
        (
          table = "routes",
          field = "network_id",
        ),
        (
          table = "networks",
          field = "network_id",
        ),
      ],
    ),
    (
      field = Symbol("from_area_id"),
      references = [
        (
          table = "areas",
          field = "area_id",
        ),
      ],
    ),
    (
      field = Symbol("to_area_id"),
      references = [
        (
          table = "areas",
          field = "area_id",
        ),
      ],
    ),
    (
      field = Symbol("from_timeframe_group_id"),
      references = [
        (
          table = "timeframes",
          field = "timeframe_group_id",
        ),
      ],
    ),
    (
      field = Symbol("to_timeframe_group_id"),
      references = [
        (
          table = "timeframes",
          field = "timeframe_group_id",
        ),
      ],
    ),
    (
      field = Symbol("fare_product_id"),
      references = [
        (
          table = "fare_products",
          field = "fare_product_id",
        ),
      ],
    ),
  ],
  "fare_leg_join_rules.txt" => [
    (
      field = Symbol("from_network_id"),
      references = [
        (
          table = "routes",
          field = "network_id",
        ),
        (
          table = "networks",
          field = "network_id",
        ),
      ],
    ),
    (
      field = Symbol("to_network_id"),
      references = [
        (
          table = "routes",
          field = "network_id",
        ),
        (
          table = "networks",
          field = "network_id",
        ),
      ],
    ),
    (
      field = Symbol("from_stop_id"),
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
    ),
    (
      field = Symbol("to_stop_id"),
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
    ),
  ],
  "fare_transfer_rules.txt" => [
    (
      field = Symbol("from_leg_group_id"),
      references = [
        (
          table = "fare_leg_rules",
          field = "leg_group_id",
        ),
      ],
    ),
    (
      field = Symbol("to_leg_group_id"),
      references = [
        (
          table = "fare_leg_rules",
          field = "leg_group_id",
        ),
      ],
    ),
    (
      field = Symbol("fare_product_id"),
      references = [
        (
          table = "fare_products",
          field = "fare_product_id",
        ),
      ],
    ),
  ],
  "stop_areas.txt" => [
    (
      field = Symbol("area_id"),
      references = [
        (
          table = "areas",
          field = "area_id",
        ),
      ],
    ),
    (
      field = Symbol("stop_id"),
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
    ),
  ],
  "route_networks.txt" => [
    (
      field = Symbol("network_id"),
      references = [
        (
          table = "networks",
          field = "network_id",
        ),
      ],
    ),
    (
      field = Symbol("route_id"),
      references = [
        (
          table = "routes",
          field = "route_id",
        ),
      ],
    ),
  ],
  "frequencies.txt" => [
    (
      field = Symbol("trip_id"),
      references = [
        (
          table = "trips",
          field = "trip_id",
        ),
      ],
    ),
  ],
  "transfers.txt" => [
    (
      field = Symbol("from_stop_id"),
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
    ),
    (
      field = Symbol("to_stop_id"),
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
    ),
    (
      field = Symbol("from_route_id"),
      references = [
        (
          table = "routes",
          field = "route_id",
        ),
      ],
    ),
    (
      field = Symbol("to_route_id"),
      references = [
        (
          table = "routes",
          field = "route_id",
        ),
      ],
    ),
    (
      field = Symbol("from_trip_id"),
      references = [
        (
          table = "trips",
          field = "trip_id",
        ),
      ],
    ),
    (
      field = Symbol("to_trip_id"),
      references = [
        (
          table = "trips",
          field = "trip_id",
        ),
      ],
    ),
  ],
  "pathways.txt" => [
    (
      field = Symbol("from_stop_id"),
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
    ),
    (
      field = Symbol("to_stop_id"),
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
    ),
  ],
  "location_group_stops.txt" => [
    (
      field = Symbol("location_group_id"),
      references = [
        (
          table = "location_groups",
          field = "location_group_id",
        ),
      ],
    ),
    (
      field = Symbol("stop_id"),
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
    ),
  ],
  "booking_rules.txt" => [
    (
      field = Symbol("prior_notice_service_id"),
      references = [
        (
          table = "calendar",
          field = "service_id",
        ),
      ],
    ),
  ],
  "attributions.txt" => [
    (
      field = Symbol("agency_id"),
      references = [
        (
          table = "agency",
          field = "agency_id",
        ),
      ],
    ),
    (
      field = Symbol("route_id"),
      references = [
        (
          table = "routes",
          field = "route_id",
        ),
      ],
    ),
    (
      field = Symbol("trip_id"),
      references = [
        (
          table = "trips",
          field = "trip_id",
        ),
      ],
    ),
  ],
)

