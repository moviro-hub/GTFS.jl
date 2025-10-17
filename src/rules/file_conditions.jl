# Auto-generated file - Generic file presence validator
# Generated from GTFS specification parsing

# Compact rule set distilled from parsed file-level conditions
const FILE_RULES = Dict(
  "agency.txt" => (
    presence = "Required",
    relations = [
    ]
  ),
  "stops.txt" => (
    presence = "Required",
    relations = [
    ]
  ),
  "routes.txt" => (
    presence = "Required",
    relations = [
    ]
  ),
  "trips.txt" => (
    presence = "Required",
    relations = [
    ]
  ),
  "stop_times.txt" => (
    presence = "Required",
    relations = [
    ]
  ),
  "calendar.txt" => (
    presence = "Required",
    relations = [
    ]
  ),
  "calendar_dates.txt" => (
    presence = "Required",
    relations = [
    ]
  ),
  "fare_attributes.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "fare_rules.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "timeframes.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "rider_categories.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "fare_media.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "fare_products.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "fare_leg_rules.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "fare_leg_join_rules.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "fare_transfer_rules.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "areas.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "stop_areas.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "networks.txt" => (
    presence = "Conditionally Forbidden",
    relations = [
      (required = false, forbidden = true, when_all = [
        (type = :file, file = "routes.txt", must_exist = true),
        (type = :field, file = "route_networks.txt", field = Symbol("network_id"), value = ""),
      ]),
    ]
  ),
  "route_networks.txt" => (
    presence = "Conditionally Forbidden",
    relations = [
      (required = false, forbidden = true, when_all = [
        (type = :file, file = "routes.txt", must_exist = true),
        (type = :field, file = "route_networks.txt", field = Symbol("network_id"), value = ""),
      ]),
    ]
  ),
  "shapes.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "frequencies.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "transfers.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "pathways.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "levels.txt" => (
    presence = "Required",
    relations = [
    ]
  ),
  "location_groups.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "location_group_stops.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "locations.geojson" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "booking_rules.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "translations.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
  "feed_info.txt" => (
    presence = "Required",
    relations = [
    ]
  ),
  "attributions.txt" => (
    presence = "Optional",
    relations = [
    ]
  ),
)

