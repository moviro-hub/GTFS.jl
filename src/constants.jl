"""
GTFS.jl - Constants and specifications for GTFS Schedule data

This module defines the constants and validation rules based on the official
GTFS Schedule specification: https://gtfs.org/documentation/schedule/reference/
"""

# Required files that must be present in every GTFS feed
const REQUIRED_FILES = [
    "agency.txt",
    "stops.txt",
    "routes.txt",
    "trips.txt",
    "stop_times.txt"
]

# Conditionally required files - at least one must be present
const CONDITIONALLY_REQUIRED_GROUPS = [
    ["calendar.txt", "calendar_dates.txt"]  # At least one must define service
]

# Optional files that may be present
const OPTIONAL_FILES = [
    # Core optional files
    "fare_attributes.txt",
    "fare_rules.txt",
    "shapes.txt",
    "frequencies.txt",
    "transfers.txt",
    "pathways.txt",
    "levels.txt",
    "feed_info.txt",
    "translations.txt",
    "attributions.txt",

    # Fares v2 (optional)
    "fare_media.txt",
    "fare_products.txt",
    "fare_leg_rules.txt",
    "fare_leg_join_rules.txt",
    "fare_transfer_rules.txt",
    "timeframes.txt",
    "rider_categories.txt",

    # Additional optional files
    "areas.txt",
    "stop_areas.txt",
    "networks.txt",
    "route_networks.txt",
    "location_groups.txt",
    "location_group_stops.txt",
    "locations.geojson",
    "booking_rules.txt"
]

# Field definitions for each file
# Structure: filename => Dict(field_name => (type, presence, description))
const FIELD_DEFINITIONS = Dict(
    "agency.txt" => Dict(
        "agency_id" => ("ID", "Optional", "Unique identifier for the transit agency"),
        "agency_name" => ("Text", "Required", "Full name of the transit agency"),
        "agency_url" => ("URL", "Required", "URL of the transit agency"),
        "agency_timezone" => ("Timezone", "Required", "Timezone where the transit agency is located"),
        "agency_lang" => ("Language code", "Optional", "Primary language used by this transit agency"),
        "agency_phone" => ("Phone number", "Optional", "Voice telephone number for the specified agency"),
        "agency_fare_url" => ("URL", "Optional", "URL of a web page that allows a rider to purchase tickets or other fare instruments"),
        "agency_email" => ("Email", "Optional", "Email address actively monitored by the agency's customer service department")
    ),

    "stops.txt" => Dict(
        "stop_id" => ("ID", "Required", "Identifies a stop, station, or station entrance"),
        "stop_code" => ("Text", "Optional", "Short text or a number that identifies the location for riders"),
        "stop_name" => ("Text", "Required", "Name of the location"),
        "tts_stop_name" => ("Text", "Optional", "Readable version of the stop_name"),
        "stop_desc" => ("Text", "Optional", "Description of the location"),
        "stop_lat" => ("Latitude", "Conditionally Required", "Latitude of the stop or station"),
        "stop_lon" => ("Longitude", "Conditionally Required", "Longitude of the stop or station"),
        "zone_id" => ("ID", "Optional", "Identifies the fare zone for a stop"),
        "stop_url" => ("URL", "Optional", "URL of a web page about the location"),
        "location_type" => ("Enum", "Optional", "Type of location"),
        "parent_station" => ("ID referencing stops.stop_id", "Conditionally Required", "Defines hierarchy between the different location types"),
        "stop_timezone" => ("Timezone", "Optional", "Timezone of the location"),
        "wheelchair_boarding" => ("Enum", "Optional", "Indicates whether wheelchair boardings are possible from the location"),
        "level_id" => ("ID referencing levels.level_id", "Optional", "Level of the location"),
        "platform_code" => ("Text", "Optional", "Platform identifier for a platform stop")
    ),

    "routes.txt" => Dict(
        "route_id" => ("ID", "Required", "Identifies a route"),
        "agency_id" => ("ID referencing agency.agency_id", "Optional", "Agency for the specified route"),
        "route_short_name" => ("Text", "Conditionally Required", "Short name of a route"),
        "route_long_name" => ("Text", "Conditionally Required", "Full name of a route"),
        "route_desc" => ("Text", "Optional", "Description of a route that provides useful, quality information"),
        "route_type" => ("Enum", "Required", "Indicates the type of transportation used on a route"),
        "route_url" => ("URL", "Optional", "URL of a web page about the particular route"),
        "route_color" => ("Color", "Optional", "Route color designation that matches public facing material"),
        "route_text_color" => ("Color", "Optional", "Legible color to use for text drawn against a background of route_color"),
        "route_sort_order" => ("Non-negative integer", "Optional", "Orders the routes in a way which is ideal for presentation to customers"),
        "continuous_pickup" => ("Enum", "Optional", "Indicates that the rider can board the transit vehicle at any point along the vehicle's travel path"),
        "continuous_drop_off" => ("Enum", "Optional", "Indicates that the rider can alight from the transit vehicle at any point along the vehicle's travel path"),
        "network_id" => ("ID referencing networks.network_id", "Optional", "Identifies a group of routes")
    ),

    "trips.txt" => Dict(
        "route_id" => ("ID referencing routes.route_id", "Required", "Identifies a route"),
        "service_id" => ("ID", "Required", "Identifies a set of dates when service is available for one or more routes"),
        "trip_id" => ("ID", "Required", "Identifies a trip"),
        "trip_headsign" => ("Text", "Optional", "Text that appears on signage identifying the trip's destination to riders"),
        "trip_short_name" => ("Text", "Optional", "Public facing text used to identify the trip to riders"),
        "direction_id" => ("Enum", "Optional", "Indicates the direction of travel for a trip"),
        "block_id" => ("ID", "Optional", "Identifies the block to which the trip belongs"),
        "shape_id" => ("ID referencing shapes.shape_id", "Optional", "Identifies a geospatial shape describing the vehicle travel path for a trip"),
        "wheelchair_accessible" => ("Enum", "Optional", "Indicates wheelchair accessibility"),
        "bikes_allowed" => ("Enum", "Optional", "Indicates whether bikes are allowed"),
        "trip_route_type" => ("Enum", "Optional", "Indicates the type of transportation used on a trip")
    ),

    "stop_times.txt" => Dict(
        "trip_id" => ("ID referencing trips.trip_id", "Required", "Identifies a trip"),
        "arrival_time" => ("Time", "Conditionally Required", "Arrival time at a specific stop for a specific trip on a route"),
        "departure_time" => ("Time", "Conditionally Required", "Departure time from a specific stop for a specific trip on a route"),
        "stop_id" => ("ID referencing stops.stop_id", "Required", "Identifies the serviced stop"),
        "stop_sequence" => ("Non-negative integer", "Required", "Order of stops for a particular trip"),
        "stop_headsign" => ("Text", "Optional", "Text that appears on signage identifying the trip's destination to riders"),
        "pickup_type" => ("Enum", "Optional", "Indicates whether passengers are picked up at the stop as part of the normal schedule"),
        "drop_off_type" => ("Enum", "Optional", "Indicates whether passengers are dropped off at the stop as part of the normal schedule"),
        "continuous_pickup" => ("Enum", "Optional", "Indicates that the rider can board the transit vehicle at any point along the vehicle's travel path"),
        "continuous_drop_off" => ("Enum", "Optional", "Indicates that the rider can alight from the transit vehicle at any point along the vehicle's travel path"),
        "shape_dist_traveled" => ("Non-negative float", "Optional", "Actual distance traveled along the shape from the first shape point to the point specified in this record"),
        "timepoint" => ("Enum", "Optional", "Indicates if arrival and departure times for a stop are strictly adhered to by the transit vehicle")
    ),

    "calendar.txt" => Dict(
        "service_id" => ("ID", "Required", "Uniquely identifies a set of dates when service is available for one or more routes"),
        "monday" => ("Enum", "Required", "Indicates whether the service operates on all Mondays in the date range specified"),
        "tuesday" => ("Enum", "Required", "Indicates whether the service operates on all Tuesdays in the date range specified"),
        "wednesday" => ("Enum", "Required", "Indicates whether the service operates on all Wednesdays in the date range specified"),
        "thursday" => ("Enum", "Required", "Indicates whether the service operates on all Thursdays in the date range specified"),
        "friday" => ("Enum", "Required", "Indicates whether the service operates on all Fridays in the date range specified"),
        "saturday" => ("Enum", "Required", "Indicates whether the service operates on all Saturdays in the date range specified"),
        "sunday" => ("Enum", "Required", "Indicates whether the service operates on all Sundays in the date range specified"),
        "start_date" => ("Date", "Required", "Start service date for the service interval"),
        "end_date" => ("Date", "Required", "End service date for the service interval")
    ),

    "calendar_dates.txt" => Dict(
        "service_id" => ("ID referencing calendar.service_id", "Required", "Identifies a set of dates when a service exception occurs for one or more routes"),
        "date" => ("Date", "Required", "Particular date when service availability is different than the norm"),
        "exception_type" => ("Enum", "Required", "Indicates whether service is available on the date specified in the date field")
    ),

    # Optional core files
    "fare_attributes.txt" => Dict(
        "fare_id" => ("ID", "Required", "Identifies a fare class"),
        "price" => ("Currency amount", "Required", "Fare price, in the unit specified by currency_type"),
        "currency_type" => ("Currency code", "Required", "ISO 4217 alphabetical currency code"),
        "payment_method" => ("Enum", "Required", "Indicates when the fare must be paid"),
        "transfers" => ("Enum", "Optional", "Specifies the number of transfers permitted on this fare"),
        "agency_id" => ("ID referencing agency.agency_id", "Optional", "Identifies the relevant agency for a fare"),
        "transfer_duration" => ("Non-negative integer", "Optional", "Length of time in seconds before a transfer expires")
    ),

    "fare_rules.txt" => Dict(
        "fare_id" => ("ID referencing fare_attributes.fare_id", "Required", "Identifies a fare class"),
        "route_id" => ("ID referencing routes.route_id", "Optional", "Identifies a route associated with the fare class"),
        "origin_id" => ("ID referencing stops.zone_id", "Optional", "Identifies an origin zone"),
        "destination_id" => ("ID referencing stops.zone_id", "Optional", "Identifies a destination zone"),
        "contains_id" => ("ID referencing stops.zone_id", "Optional", "Identifies the zones that a rider will enter while using a given fare class")
    ),

    "shapes.txt" => Dict(
        "shape_id" => ("ID", "Required", "Identifies a geospatial shape describing the vehicle travel path for a trip"),
        "shape_pt_lat" => ("Latitude", "Required", "Latitude of a shape point"),
        "shape_pt_lon" => ("Longitude", "Required", "Longitude of a shape point"),
        "shape_pt_sequence" => ("Non-negative integer", "Required", "Sequence in which the shape points connect to form the shape"),
        "shape_dist_traveled" => ("Non-negative float", "Optional", "Actual distance traveled along the shape from the first shape point to the point specified in this record")
    ),

    "frequencies.txt" => Dict(
        "trip_id" => ("ID referencing trips.trip_id", "Required", "Identifies a trip to which the specified headway of service applies"),
        "start_time" => ("Time", "Required", "Time at which service begins with the specified frequency"),
        "end_time" => ("Time", "Required", "Time at which service changes from a fixed-frequency schedule to a fixed-schedule using the exact times specified in stop_times.txt"),
        "headway_secs" => ("Non-negative integer", "Required", "Time between departures from the same stop (headway) for this trip type, during the time interval specified by start_time and end_time"),
        "exact_times" => ("Enum", "Optional", "Indicates the type of service for a trip")
    ),

    "transfers.txt" => Dict(
        "from_stop_id" => ("ID referencing stops.stop_id", "Required", "Identifies a stop or station where a connection between routes begins"),
        "to_stop_id" => ("ID referencing stops.stop_id", "Required", "Identifies a stop or station where a connection between routes ends"),
        "from_route_id" => ("ID referencing routes.route_id", "Optional", "Identifies a route where a connection begins"),
        "to_route_id" => ("ID referencing routes.route_id", "Optional", "Identifies a route where a connection ends"),
        "from_trip_id" => ("ID referencing trips.trip_id", "Optional", "Identifies a trip where a connection begins"),
        "to_trip_id" => ("ID referencing trips.trip_id", "Optional", "Identifies a trip where a connection ends"),
        "transfer_type" => ("Enum", "Required", "Indicates the type of connection for the specified (from_stop_id, to_stop_id) pair"),
        "min_transfer_time" => ("Non-negative integer", "Optional", "Amount of time, in seconds, that must be available to permit a transfer between routes at the specified stops")
    ),

    "pathways.txt" => Dict(
        "pathway_id" => ("ID", "Required", "Identifies a pathway"),
        "from_stop_id" => ("ID referencing stops.stop_id", "Required", "Location at which the pathway begins"),
        "to_stop_id" => ("ID referencing stops.stop_id", "Required", "Location at which the pathway ends"),
        "pathway_mode" => ("Enum", "Required", "Type of pathway between the specified (from_stop_id, to_stop_id) pair"),
        "is_bidirectional" => ("Enum", "Required", "Describes the direction that a pathway can be taken"),
        "length" => ("Non-negative float", "Optional", "Horizontal length in meters of the pathway from the origin location to the destination location"),
        "traversal_time" => ("Non-negative integer", "Optional", "Average time in seconds needed to walk through the pathway from the origin location to the destination location"),
        "stair_count" => ("Integer", "Optional", "Number of stairs of the pathway"),
        "max_slope" => ("Float", "Optional", "Maximum slope ratio of the pathway"),
        "min_width" => ("Non-negative float", "Optional", "Minimum width of the pathway in meters"),
        "signposted_as" => ("Text", "Optional", "String of text from physical signage visible to transit riders"),
        "reversed_signposted_as" => ("Text", "Optional", "String of text from physical signage visible to transit riders describing the pathway in the opposite direction")
    ),

    "levels.txt" => Dict(
        "level_id" => ("ID", "Required", "Identifies a level in a station"),
        "level_index" => ("Float", "Required", "Numeric index of the level that indicates relative position of this level in relation to other levels"),
        "level_name" => ("Text", "Optional", "Optional name of the level")
    ),

    "feed_info.txt" => Dict(
        "feed_publisher_name" => ("Text", "Required", "Full name of the organization that publishes the dataset"),
        "feed_publisher_url" => ("URL", "Required", "URL of the dataset publishing organization's website"),
        "feed_lang" => ("Language code", "Required", "Default language for the text in this dataset"),
        "default_lang" => ("Language code", "Optional", "Defines the language used when the data consumer doesn't know the language of the rider"),
        "feed_start_date" => ("Date", "Optional", "The dataset provides complete and reliable schedule information for service beginning on this date"),
        "feed_end_date" => ("Date", "Optional", "The dataset provides complete and reliable schedule information for service ending on this date"),
        "feed_version" => ("Text", "Optional", "String that indicates the current version of their GTFS dataset"),
        "feed_contact_email" => ("Email", "Optional", "Email address for communication regarding the GTFS dataset and data publishing practices"),
        "feed_contact_url" => ("URL", "Optional", "URL for contact information, a web-form, support desk, or other tools for communication regarding the GTFS dataset and data publishing practices")
    ),

    "translations.txt" => Dict(
        "table_name" => ("Text", "Required", "Defines the table that contains the field to be translated"),
        "field_name" => ("Text", "Required", "Defines the field to be translated"),
        "language" => ("Language code", "Required", "Defines the language of translation"),
        "translation" => ("Text", "Required", "Defines the translated value"),
        "record_id" => ("ID", "Conditionally Required", "Defines the record that corresponds to the field to be translated"),
        "record_sub_id" => ("ID", "Conditionally Required", "Defines the record sub-type that corresponds to the field to be translated"),
        "field_value" => ("Text", "Conditionally Required", "Defines the field value to be translated")
    ),

    "attributions.txt" => Dict(
        "attribution_id" => ("ID", "Optional", "Identifies an attribution for the dataset or the subset of the dataset"),
        "agency_id" => ("ID referencing agency.agency_id", "Optional", "Agency to which the attribution applies"),
        "route_id" => ("ID referencing routes.route_id", "Optional", "Route to which the attribution applies"),
        "trip_id" => ("ID referencing trips.trip_id", "Optional", "Trip to which the attribution applies"),
        "organization_name" => ("Text", "Required", "Name of the organization that the dataset is attributed to"),
        "is_producer" => ("Enum", "Optional", "Indicates whether the organization produces the dataset"),
        "is_operator" => ("Enum", "Optional", "Indicates whether the organization operates the service"),
        "is_authority" => ("Enum", "Optional", "Indicates whether the organization has the authority over the service"),
        "attribution_url" => ("URL", "Optional", "URL of the organization"),
        "attribution_email" => ("Email", "Optional", "Email of the organization"),
        "attribution_phone" => ("Phone number", "Optional", "Phone number of the organization")
    )
)

# Enum values for various fields
const ENUM_VALUES = Dict(
    "location_type" => [0, 1, 2, 3, 4],
    "route_type" => [0, 1, 2, 3, 4, 5, 6, 7, 11, 12],
    "direction_id" => [0, 1],
    "wheelchair_accessible" => [0, 1, 2],
    "bikes_allowed" => [0, 1, 2],
    "pickup_type" => [0, 1, 2, 3],
    "drop_off_type" => [0, 1, 2, 3],
    "continuous_pickup" => [0, 1, 2, 3],
    "continuous_drop_off" => [0, 1, 2, 3],
    "timepoint" => [0, 1],
    "exception_type" => [1, 2],

    # Additional enum values for optional files
    "payment_method" => [0, 1],
    "transfers" => [0, 1, 2, nothing],
    "transfer_type" => [0, 1, 2, 3, 4, 5],
    "pathway_mode" => [1, 2, 3, 4, 5, 6, 7],
    "is_bidirectional" => [0, 1],
    "exact_times" => [0, 1],
    "is_producer" => [0, 1],
    "is_operator" => [0, 1],
    "is_authority" => [0, 1]
)

# Field-level conditional rules (within single file)
# Structure: (file, field, condition_type, condition_field, condition_values, message)
const CONDITIONAL_FIELD_RULES = [
    # stops.txt conditional requirements
    ("stops.txt", "stop_lat", :required_when, "location_type", [0, 1, 2, nothing, missing], "Required when location_type is 0, 1, 2, or empty"),
    ("stops.txt", "stop_lon", :required_when, "location_type", [0, 1, 2, nothing, missing], "Required when location_type is 0, 1, 2, or empty"),
    ("stops.txt", "parent_station", :required_when, "location_type", [2, 3, 4], "Required when location_type is 2, 3, or 4"),
    ("stops.txt", "parent_station", :forbidden_when, "location_type", [1], "Forbidden when location_type is 1 (station)"),

    # routes.txt conditional requirements
    ("routes.txt", ["route_short_name", "route_long_name"], :at_least_one, nothing, nothing, "At least one of route_short_name or route_long_name must be present"),

    # stop_times.txt conditional requirements
    ("stop_times.txt", "arrival_time", :required_when, "stop_sequence", [1], "Required for first stop in trip"),
    ("stop_times.txt", "departure_time", :required_when, "stop_sequence", [1], "Required for first stop in trip"),

    # agency.txt conditional requirements
    ("agency.txt", "agency_id", :required_when_multiple_records, nothing, nothing, "Required when multiple agencies exist"),

    # fare_attributes.txt conditional requirements
    ("fare_attributes.txt", "transfer_duration", :required_when, "transfers", [1, 2], "Required when transfers is 1 or 2"),
    ("fare_attributes.txt", "agency_id", :required_when_multiple_agencies, nothing, nothing, "Required when multiple agencies exist"),

    # translations.txt conditional requirements
    ("translations.txt", "record_id", :required_when, "table_name", ["agency", "stops", "routes", "trips", "stop_times", "pathways", "levels", "feed_info", "fare_attributes", "fare_rules", "fare_products", "fare_leg_rules", "fare_transfer_rules", "areas", "stop_areas", "networks", "route_networks", "attributions"], "Required for most table types"),
    ("translations.txt", "record_sub_id", :required_when, "table_name", ["stop_times"], "Required when table_name is stop_times"),
    ("translations.txt", "field_value", :required_when, "translation_type", ["field_value"], "Required when translation_type is field_value"),

    # Fares v2 conditional requirements
    ("fare_leg_rules.txt", "fare_product_id", :required_when, "leg_group_id", [nothing, missing], "Required when leg_group_id is not specified"),
    ("fare_leg_rules.txt", "leg_group_id", :required_when, "fare_product_id", [nothing, missing], "Required when fare_product_id is not specified"),
    ("fare_transfer_rules.txt", "from_leg_group_id", :required_when, "to_leg_group_id", [nothing, missing], "Required when to_leg_group_id is not specified"),
    ("fare_transfer_rules.txt", "to_leg_group_id", :required_when, "from_leg_group_id", [nothing, missing], "Required when from_leg_group_id is not specified")
]

# Cross-file conditional rules (field presence depends on data in other files)
# Structure: (target_file, target_field, condition_file, condition_type, condition_field, message)
const CROSS_FILE_CONDITIONAL_RULES = [
    # routes.txt cross-file requirements
    ("routes.txt", "agency_id", "agency.txt", :required_when_multiple_records, nothing, "Required when multiple agencies exist"),

    # stop_times.txt cross-file requirements

    # stops.txt cross-file requirements
    ("stops.txt", "level_id", "pathways.txt", :required_when_file_exists, nothing, "Required when pathways.txt exists and stop is referenced"),

    # fare_rules.txt cross-file requirements
    ("fare_rules.txt", "route_id", "fare_attributes.txt", :required_when_field_present, "route_id", "Required when fare_attributes has route_id"),

    # attributions.txt cross-file requirements
    ("attributions.txt", "agency_id", "agency.txt", :required_when_multiple_records, nothing, "Required when multiple agencies exist")
]

# File-level conditional rules (entire files are conditionally required)
# Structure: (file, condition_type, related_files, message)
const FILE_LEVEL_CONDITIONAL_RULES = [
    # Service definition files
    (["calendar.txt", "calendar_dates.txt"], :at_least_one, nothing, "At least one must be present to define service"),

    # Fares v2 files
    ("fare_leg_rules.txt", :required_if_exists, ["fare_products.txt"], "Required when fare_products.txt exists"),
    ("fare_leg_join_rules.txt", :required_if_exists, ["fare_leg_rules.txt"], "Required when fare_leg_rules.txt exists"),
    ("fare_transfer_rules.txt", :required_if_exists, ["fare_leg_rules.txt"], "Required when fare_leg_rules.txt exists"),

    # Pathway-related files
    ("levels.txt", :required_if_pathways_exist, ["pathways.txt"], "Required when pathways.txt exists and references level_id"),

    # Location group files
    ("location_groups.txt", :required_if_referenced, ["stop_times.txt"], "Required when stop_times.txt references location groups"),
    ("location_group_stops.txt", :required_if_exists, ["location_groups.txt"], "Required when location_groups.txt exists"),

    # Network files
    ("route_networks.txt", :required_if_exists, ["networks.txt"], "Required when networks.txt exists"),

    # Area files
    ("stop_areas.txt", :required_if_exists, ["areas.txt"], "Required when areas.txt exists")
]

# Conditionally forbidden rules (fields/values should not be present under certain conditions)
# Structure: (file, field, condition_type, condition_field, condition_values, message)
const CONDITIONALLY_FORBIDDEN_RULES = [
    # stops.txt forbidden rules
    ("stops.txt", "parent_station", :forbidden_when, "location_type", [1], "Forbidden when location_type is 1 (station)"),

    # trips.txt forbidden rules (conflicts with routes.txt)
    ("trips.txt", "bikes_allowed", :forbidden_when_conflicts, "routes.txt", "bikes_allowed", "Should not override route-level bikes_allowed without justification")
]

# Foreign key relationships
const FOREIGN_KEYS = [
    # Core relationships
    ("routes.txt", "agency_id", "agency.txt", "agency_id"),
    ("trips.txt", "route_id", "routes.txt", "route_id"),
    ("trips.txt", "service_id", "calendar.txt", "service_id"),
    ("trips.txt", "service_id", "calendar_dates.txt", "service_id"),
    ("trips.txt", "shape_id", "shapes.txt", "shape_id"),
    ("stop_times.txt", "trip_id", "trips.txt", "trip_id"),
    ("stop_times.txt", "stop_id", "stops.txt", "stop_id"),
    ("stops.txt", "parent_station", "stops.txt", "stop_id"),
    ("stops.txt", "level_id", "levels.txt", "level_id"),
    ("calendar_dates.txt", "service_id", "calendar.txt", "service_id"),

    # Optional file relationships
    ("fare_attributes.txt", "agency_id", "agency.txt", "agency_id"),
    ("fare_rules.txt", "fare_id", "fare_attributes.txt", "fare_id"),
    ("fare_rules.txt", "route_id", "routes.txt", "route_id"),
    ("fare_rules.txt", "origin_id", "stops.txt", "zone_id"),
    ("fare_rules.txt", "destination_id", "stops.txt", "zone_id"),
    ("fare_rules.txt", "contains_id", "stops.txt", "zone_id"),
    ("frequencies.txt", "trip_id", "trips.txt", "trip_id"),
    ("transfers.txt", "from_stop_id", "stops.txt", "stop_id"),
    ("transfers.txt", "to_stop_id", "stops.txt", "stop_id"),
    ("transfers.txt", "from_route_id", "routes.txt", "route_id"),
    ("transfers.txt", "to_route_id", "routes.txt", "route_id"),
    ("transfers.txt", "from_trip_id", "trips.txt", "trip_id"),
    ("transfers.txt", "to_trip_id", "trips.txt", "trip_id"),
    ("pathways.txt", "from_stop_id", "stops.txt", "stop_id"),
    ("pathways.txt", "to_stop_id", "stops.txt", "stop_id"),
    ("attributions.txt", "agency_id", "agency.txt", "agency_id"),
    ("attributions.txt", "route_id", "routes.txt", "route_id"),
    ("attributions.txt", "trip_id", "trips.txt", "trip_id")
]

# Field type validation patterns
const TYPE_PATTERNS = Dict(
    "Color" => r"^[0-9A-Fa-f]{6}$",
    "Date" => r"^\d{8}$",
    "Time" => r"^([0-9]|[0-1][0-9]|2[0-9]|3[0-9]|4[0-9]|5[0-9]):[0-5][0-9]:[0-5][0-9]$",
    "Email" => r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    "URL" => r"^https?://.+",
    "Latitude" => r"^-?([1-8]?[0-9](\.[0-9]+)?|90(\.0+)?)$",
    "Longitude" => r"^-?((1[0-7][0-9])|([1-9]?[0-9]))(\.[0-9]+)?$",
    "Currency code" => r"^[A-Z]{3}$",
    "Language code" => r"^[a-z]{2}(-[A-Z]{2})?$",
    "Phone number" => r"^[\+]?[1-9][\d]{0,15}$",
    "Currency amount" => r"^\d+(\.\d{1,2})?$",
    "Non-negative integer" => r"^\d+$",
    "Non-negative float" => r"^\d+(\.\d+)?$",
    "Integer" => r"^-?\d+$",
    "Float" => r"^-?\d+(\.\d+)?$"
)
