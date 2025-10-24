# Auto-generated file - Field ID reference validation rules
# Generated from GTFS specification parsing

# Compact rule set distilled from parsed field ID reference information
const FIELD_ID_REFERENCES = Dict(
  "stops.txt" => [
    (
      field = "parent_station",
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "level_id",
      references = [
        (
          table = "levels",
          field = "level_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "routes.txt" => [
    (
      field = "agency_id",
      references = [
        (
          table = "agency",
          field = "agency_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "trips.txt" => [
    (
      field = "route_id",
      references = [
        (
          table = "routes",
          field = "route_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "service_id",
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
      is_conditional = false,
    ),
    (
      field = "shape_id",
      references = [
        (
          table = "shapes",
          field = "shape_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "stop_times.txt" => [
    (
      field = "trip_id",
      references = [
        (
          table = "trips",
          field = "trip_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "stop_id",
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "location_group_id",
      references = [
        (
          table = "location_groups",
          field = "location_group_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "location_id",
      references = [
        (
          table = "locations",
          field = "geojson",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "pickup_booking_rule_id",
      references = [
        (
          table = "booking_rules",
          field = "booking_rule_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "drop_off_booking_rule_id",
      references = [
        (
          table = "booking_rules",
          field = "booking_rule_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "calendar_dates.txt" => [
    (
      field = "service_id",
      references = [
        (
          table = "calendar",
          field = "service_id",
        ),
      ],
      is_conditional = true,
    ),
  ],
  "fare_attributes.txt" => [
    (
      field = "agency_id",
      references = [
        (
          table = "agency",
          field = "agency_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "fare_rules.txt" => [
    (
      field = "fare_id",
      references = [
        (
          table = "fare_attributes",
          field = "fare_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "route_id",
      references = [
        (
          table = "routes",
          field = "route_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "origin_id",
      references = [
        (
          table = "stops",
          field = "zone_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "destination_id",
      references = [
        (
          table = "stops",
          field = "zone_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "contains_id",
      references = [
        (
          table = "stops",
          field = "zone_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "timeframes.txt" => [
    (
      field = "service_id",
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
      is_conditional = false,
    ),
  ],
  "fare_products.txt" => [
    (
      field = "rider_category_id",
      references = [
        (
          table = "rider_categories",
          field = "rider_category_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "fare_media_id",
      references = [
        (
          table = "fare_media",
          field = "fare_media_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "fare_leg_rules.txt" => [
    (
      field = "network_id",
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
      is_conditional = false,
    ),
    (
      field = "from_area_id",
      references = [
        (
          table = "areas",
          field = "area_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "to_area_id",
      references = [
        (
          table = "areas",
          field = "area_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "from_timeframe_group_id",
      references = [
        (
          table = "timeframes",
          field = "timeframe_group_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "to_timeframe_group_id",
      references = [
        (
          table = "timeframes",
          field = "timeframe_group_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "fare_product_id",
      references = [
        (
          table = "fare_products",
          field = "fare_product_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "fare_leg_join_rules.txt" => [
    (
      field = "from_network_id",
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
      is_conditional = false,
    ),
    (
      field = "to_network_id",
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
      is_conditional = false,
    ),
    (
      field = "from_stop_id",
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "to_stop_id",
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "fare_transfer_rules.txt" => [
    (
      field = "from_leg_group_id",
      references = [
        (
          table = "fare_leg_rules",
          field = "leg_group_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "to_leg_group_id",
      references = [
        (
          table = "fare_leg_rules",
          field = "leg_group_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "fare_product_id",
      references = [
        (
          table = "fare_products",
          field = "fare_product_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "stop_areas.txt" => [
    (
      field = "area_id",
      references = [
        (
          table = "areas",
          field = "area_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "stop_id",
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "route_networks.txt" => [
    (
      field = "network_id",
      references = [
        (
          table = "networks",
          field = "network_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "route_id",
      references = [
        (
          table = "routes",
          field = "route_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "frequencies.txt" => [
    (
      field = "trip_id",
      references = [
        (
          table = "trips",
          field = "trip_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "transfers.txt" => [
    (
      field = "from_stop_id",
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "to_stop_id",
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "from_route_id",
      references = [
        (
          table = "routes",
          field = "route_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "to_route_id",
      references = [
        (
          table = "routes",
          field = "route_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "from_trip_id",
      references = [
        (
          table = "trips",
          field = "trip_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "to_trip_id",
      references = [
        (
          table = "trips",
          field = "trip_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "pathways.txt" => [
    (
      field = "from_stop_id",
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "to_stop_id",
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "location_group_stops.txt" => [
    (
      field = "location_group_id",
      references = [
        (
          table = "location_groups",
          field = "location_group_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "stop_id",
      references = [
        (
          table = "stops",
          field = "stop_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "booking_rules.txt" => [
    (
      field = "prior_notice_service_id",
      references = [
        (
          table = "calendar",
          field = "service_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
  "attributions.txt" => [
    (
      field = "agency_id",
      references = [
        (
          table = "agency",
          field = "agency_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "route_id",
      references = [
        (
          table = "routes",
          field = "route_id",
        ),
      ],
      is_conditional = false,
    ),
    (
      field = "trip_id",
      references = [
        (
          table = "trips",
          field = "trip_id",
        ),
      ],
      is_conditional = false,
    ),
  ],
)

