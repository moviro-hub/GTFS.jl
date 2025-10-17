# Auto-generated file - Field constraint validation rules
# Generated from GTFS specification parsing

# Compact rule set distilled from parsed field constraint information
const FIELD_CONSTRAINTS = Dict(
  "agency.txt" => [
    (
      field = Symbol("agency_id"),
      constraint = "Unique",
    ),
  ],
  "stops.txt" => [
    (
      field = Symbol("stop_id"),
      constraint = "Unique",
    ),
  ],
  "routes.txt" => [
    (
      field = Symbol("route_id"),
      constraint = "Unique",
    ),
    (
      field = Symbol("route_sort_order"),
      constraint = "Non-negative",
    ),
  ],
  "trips.txt" => [
    (
      field = Symbol("trip_id"),
      constraint = "Unique",
    ),
  ],
  "stop_times.txt" => [
    (
      field = Symbol("stop_sequence"),
      constraint = "Non-negative",
    ),
    (
      field = Symbol("shape_dist_traveled"),
      constraint = "Non-negative",
    ),
  ],
  "calendar.txt" => [
    (
      field = Symbol("service_id"),
      constraint = "Unique",
    ),
  ],
  "fare_attributes.txt" => [
    (
      field = Symbol("fare_id"),
      constraint = "Unique",
    ),
    (
      field = Symbol("price"),
      constraint = "Non-negative",
    ),
    (
      field = Symbol("transfer_duration"),
      constraint = "Non-negative",
    ),
  ],
  "rider_categories.txt" => [
    (
      field = Symbol("rider_category_id"),
      constraint = "Unique",
    ),
  ],
  "fare_media.txt" => [
    (
      field = Symbol("fare_media_id"),
      constraint = "Unique",
    ),
  ],
  "fare_leg_rules.txt" => [
    (
      field = Symbol("rule_priority"),
      constraint = "Non-negative",
    ),
  ],
  "fare_transfer_rules.txt" => [
    (
      field = Symbol("transfer_count"),
      constraint = "Non-zero",
    ),
    (
      field = Symbol("duration_limit"),
      constraint = "Positive",
    ),
  ],
  "areas.txt" => [
    (
      field = Symbol("area_id"),
      constraint = "Unique",
    ),
  ],
  "networks.txt" => [
    (
      field = Symbol("network_id"),
      constraint = "Unique",
    ),
  ],
  "shapes.txt" => [
    (
      field = Symbol("shape_pt_sequence"),
      constraint = "Non-negative",
    ),
    (
      field = Symbol("shape_dist_traveled"),
      constraint = "Non-negative",
    ),
  ],
  "frequencies.txt" => [
    (
      field = Symbol("headway_secs"),
      constraint = "Positive",
    ),
  ],
  "transfers.txt" => [
    (
      field = Symbol("min_transfer_time"),
      constraint = "Non-negative",
    ),
  ],
  "pathways.txt" => [
    (
      field = Symbol("pathway_id"),
      constraint = "Unique",
    ),
    (
      field = Symbol("length"),
      constraint = "Non-negative",
    ),
    (
      field = Symbol("traversal_time"),
      constraint = "Positive",
    ),
    (
      field = Symbol("min_width"),
      constraint = "Positive",
    ),
  ],
  "levels.txt" => [
    (
      field = Symbol("level_id"),
      constraint = "Unique",
    ),
  ],
  "location_groups.txt" => [
    (
      field = Symbol("location_group_id"),
      constraint = "Unique",
    ),
  ],
  "booking_rules.txt" => [
    (
      field = Symbol("booking_rule_id"),
      constraint = "Unique",
    ),
  ],
  "attributions.txt" => [
    (
      field = Symbol("attribution_id"),
      constraint = "Unique",
    ),
  ],
)

