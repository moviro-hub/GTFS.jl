# Auto-generated file - Field constraint validation rules
# Generated from GTFS specification parsing

# Compact rule set distilled from parsed field constraint information
const FIELD_CONSTRAINTS = Dict(
  "agency.txt" => [
    (
      field = "agency_id",
      constraint = "Unique",
    ),
  ],
  "stops.txt" => [
    (
      field = "stop_id",
      constraint = "Unique",
    ),
  ],
  "routes.txt" => [
    (
      field = "route_id",
      constraint = "Unique",
    ),
    (
      field = "route_sort_order",
      constraint = "Non-negative",
    ),
  ],
  "trips.txt" => [
    (
      field = "trip_id",
      constraint = "Unique",
    ),
  ],
  "stop_times.txt" => [
    (
      field = "stop_sequence",
      constraint = "Non-negative",
    ),
    (
      field = "shape_dist_traveled",
      constraint = "Non-negative",
    ),
  ],
  "calendar.txt" => [
    (
      field = "service_id",
      constraint = "Unique",
    ),
  ],
  "fare_attributes.txt" => [
    (
      field = "fare_id",
      constraint = "Unique",
    ),
    (
      field = "price",
      constraint = "Non-negative",
    ),
    (
      field = "transfer_duration",
      constraint = "Non-negative",
    ),
  ],
  "rider_categories.txt" => [
    (
      field = "rider_category_id",
      constraint = "Unique",
    ),
  ],
  "fare_media.txt" => [
    (
      field = "fare_media_id",
      constraint = "Unique",
    ),
  ],
  "fare_leg_rules.txt" => [
    (
      field = "rule_priority",
      constraint = "Non-negative",
    ),
  ],
  "fare_transfer_rules.txt" => [
    (
      field = "transfer_count",
      constraint = "Non-zero",
    ),
    (
      field = "duration_limit",
      constraint = "Positive",
    ),
  ],
  "areas.txt" => [
    (
      field = "area_id",
      constraint = "Unique",
    ),
  ],
  "networks.txt" => [
    (
      field = "network_id",
      constraint = "Unique",
    ),
  ],
  "shapes.txt" => [
    (
      field = "shape_pt_sequence",
      constraint = "Non-negative",
    ),
    (
      field = "shape_dist_traveled",
      constraint = "Non-negative",
    ),
  ],
  "frequencies.txt" => [
    (
      field = "headway_secs",
      constraint = "Positive",
    ),
  ],
  "transfers.txt" => [
    (
      field = "min_transfer_time",
      constraint = "Non-negative",
    ),
  ],
  "pathways.txt" => [
    (
      field = "pathway_id",
      constraint = "Unique",
    ),
    (
      field = "length",
      constraint = "Non-negative",
    ),
    (
      field = "traversal_time",
      constraint = "Positive",
    ),
    (
      field = "min_width",
      constraint = "Positive",
    ),
  ],
  "levels.txt" => [
    (
      field = "level_id",
      constraint = "Unique",
    ),
  ],
  "location_groups.txt" => [
    (
      field = "location_group_id",
      constraint = "Unique",
    ),
  ],
  "booking_rules.txt" => [
    (
      field = "booking_rule_id",
      constraint = "Unique",
    ),
  ],
  "attributions.txt" => [
    (
      field = "attribution_id",
      constraint = "Unique",
    ),
  ],
)

