# Examples

**Practical examples for using GTFSSchedule.jl to analyze transit data.**

This page provides practical examples of how to use GTFSSchedule.jl for common transit data analysis tasks.

## Basic Data Exploration

### Loading and Inspecting a GTFS Feed

```julia
using GTFSSchedules
using DataFrames

# Load a GTFS feed
gtfs = read_gtfs("transit_feed.zip")

# Basic information about the feed
println("=== GTFS Feed Overview ===")
println("Agencies: ", nrow(gtfs["agency.txt"]))
println("Stops: ", nrow(gtfs["stops.txt"]))
println("Routes: ", nrow(gtfs["routes.txt"]))
println("Trips: ", nrow(gtfs["trips.txt"]))
println("Stop Times: ", nrow(gtfs["stop_times.txt"]))

# Check for optional files
optional_files = [
    ("Calendar", "calendar.txt"),
    ("Calendar Dates", "calendar_dates.txt"),
    ("Fare Attributes", "fare_attributes.txt"),
    ("Shapes", "shapes.txt"),
    ("Transfers", "transfers.txt"),
    ("Feed Info", "feed_info.txt")
]

println("\n=== Optional Files ===")
for (name, filename) in optional_files
    if haskey(gtfs, filename) && gtfs[filename] !== nothing
        status = "✓ Present ($(nrow(gtfs[filename])) records)"
    else
        status = "✗ Not present"
    end
    println("$name: $status")
end
```

### Agency Information

```julia
# Display all agencies
println("=== Transit Agencies ===")
for row in eachrow(gtfs["agency.txt"])
    println("$(row.agency_name)")
    println("  URL: $(row.agency_url)")
    println("  Timezone: $(row.agency_timezone)")
    if hasproperty(row, :agency_phone)
        println("  Phone: $(row.agency_phone)")
    end
    println()
end
```

## Route Analysis

### Route Types and Statistics

```julia
# Analyze route types
println("=== Route Types ===")
route_type_names = Dict(
    0 => "Light Rail",
    1 => "Subway/Metro",
    2 => "Rail",
    3 => "Bus",
    4 => "Ferry",
    5 => "Cable Tram",
    6 => "Aerial Lift",
    7 => "Funicular",
    11 => "Trolleybus",
    12 => "Monorail"
)

routes_df = gtfs["routes.txt"]
route_counts = Dict{Int, Int}()
for row in eachrow(routes_df)
    route_type = row.route_type
    route_counts[route_type] = get(route_counts, route_type, 0) + 1
end

for (type_id, count) in sort(collect(route_counts))
    type_name = get(route_type_names, type_id, "Unknown ($type_id)")
    println("$type_name: $count routes")
end
```

### Bus Route Analysis

```julia
# Focus on bus routes
routes_df = gtfs["routes.txt"]
bus_routes = filter(row -> row.route_type == 3, routes_df)

println("=== Bus Routes ===")
println("Total bus routes: ", nrow(bus_routes))

# Show first few bus routes
println("\nFirst 10 bus routes:")
for (i, row) in enumerate(eachrow(bus_routes))
    if i > 10
        break
    end
    println("$(row.route_short_name) - $(row.route_long_name)")
end

# Routes with colors
colored_routes = filter(row -> hasproperty(row, :route_color) && !ismissing(row.route_color), bus_routes)
println("\nRoutes with colors: ", nrow(colored_routes))
```

## Stop Analysis

### Stop Types and Locations

```julia
# Analyze stop types
println("=== Stop Types ===")
location_type_names = Dict(
    0 => "Stop/Platform",
    1 => "Station",
    2 => "Entrance/Exit",
    3 => "Generic Node",
    4 => "Boarding Area"
)

stop_counts = Dict{Int, Int}()
for row in eachrow(gtfs.stops)
    location_type = get(row, :location_type, 0)  # Default to 0 if missing
    stop_counts[location_type] = get(stop_counts, location_type, 0) + 1
end

for (type_id, count) in sort(collect(stop_counts))
    type_name = get(location_type_names, type_id, "Unknown ($type_id)")
    println("$type_name: $count")
end
```

### Geographic Analysis

```julia
# Analyze stop coordinates
stops_with_coords = filter(row -> !ismissing(row.stop_lat) && !ismissing(row.stop_lon), gtfs.stops)

if nrow(stops_with_coords) > 0
    println("=== Geographic Coverage ===")
    lats = stops_with_coords.stop_lat
    lons = stops_with_coords.stop_lon

    println("Latitude range: $(minimum(lats)) to $(maximum(lats))")
    println("Longitude range: $(minimum(lons)) to $(maximum(lons))")

    # Find stops in a specific area (example: downtown)
    downtown_stops = filter(row ->
        40.7 <= row.stop_lat <= 40.8 &&
        -74.0 <= row.stop_lon <= -73.9,
        stops_with_coords
    )
    println("Stops in downtown area: ", nrow(downtown_stops))
end
```

## Trip and Schedule Analysis

### Service Patterns

```julia
# Analyze service patterns
println("=== Service Analysis ===")

# Count trips per route
trip_counts = Dict{String, Int}()
for row in eachrow(gtfs.trips)
    route_id = row.route_id
    trip_counts[route_id] = get(trip_counts, route_id, 0) + 1
end

# Find routes with most trips
top_routes = sort(collect(trip_counts), by=x->x[2], rev=true)[1:min(10, length(trip_counts))]

println("Routes with most trips:")
for (route_id, count) in top_routes
    # Find route name
    route_info = filter(row -> row.route_id == route_id, gtfs.routes)
    if nrow(route_info) > 0
        route_name = route_info.route_short_name[1]
        println("  $route_name ($route_id): $count trips")
    end
end
```

### Stop Time Analysis

```julia
# Analyze stop times
println("\n=== Stop Time Analysis ===")

# Count stops per trip
stop_counts_per_trip = Dict{String, Int}()
for row in eachrow(gtfs.stop_times)
    trip_id = row.trip_id
    stop_counts_per_trip[trip_id] = get(stop_counts_per_trip, trip_id, 0) + 1
end

if !isempty(stop_counts_per_trip)
    stop_counts = collect(values(stop_counts_per_trip))
    println("Average stops per trip: ", round(mean(stop_counts), digits=1))
    println("Min stops per trip: ", minimum(stop_counts))
    println("Max stops per trip: ", maximum(stop_counts))
end

# Find trips with most stops
longest_trips = sort(collect(stop_counts_per_trip), by=x->x[2], rev=true)[1:min(5, length(stop_counts_per_trip))]
println("\nLongest trips (by number of stops):")
for (trip_id, count) in longest_trips
    println("  $trip_id: $count stops")
end
```

## Validation Examples

### Basic Validation

```julia
# Validate the feed
println("=== Validation ===")
result = GTFSSchedules.Validations.validate_gtfs(gtfs)

println("Validation result: ", result.summary)

if !result.is_valid
    println("\nIssues found:")

    # Separate errors and warnings
    errors = filter(e -> e.severity == :error, result.messages)
    warnings = filter(e -> e.severity == :warning, result.messages)

    if !isempty(errors)
        println("\nErrors:")
        for (i, error) in enumerate(errors[1:min(10, length(errors))])
            println("  $i. $(error.file): $(error.message)")
        end
        if length(errors) > 10
            println("  ... and $(length(errors) - 10) more errors")
        end
    end

    if !isempty(warnings)
        println("\nWarnings:")
        for (i, warning) in enumerate(warnings[1:min(10, length(warnings))])
            println("  $i. $(warning.file): $(warning.message)")
        end
        if length(warnings) > 10
            println("  ... and $(length(warnings) - 10) more warnings")
        end
    end
end
```

### Validation with Custom Limits

```julia
# Validate with limited warnings
result = GTFSSchedules.Validations.validate_gtfs(gtfs)
println("Validation with limited warnings: ", result.summary)
```

## Advanced Examples

### Finding Transfer Opportunities

```julia
# Analyze transfers if available
if gtfs.transfers !== nothing
    println("=== Transfer Analysis ===")
    println("Total transfers: ", nrow(gtfs.transfers))

    # Transfer types
    transfer_types = Dict(
        0 => "Recommended",
        1 => "Timed",
        2 => "Minimum time",
        3 => "Not possible"
    )

    transfer_counts = Dict{Int, Int}()
    for row in eachrow(gtfs.transfers)
        transfer_type = get(row, :transfer_type, 0)
        transfer_counts[transfer_type] = get(transfer_counts, transfer_type, 0) + 1
    end

    for (type_id, count) in sort(collect(transfer_counts))
        type_name = get(transfer_types, type_id, "Unknown ($type_id)")
        println("$type_name: $count")
    end
end
```

### Fare Analysis

```julia
# Analyze fares if available
if gtfs.fare_attributes !== nothing
    println("=== Fare Analysis ===")
    println("Fare types: ", nrow(gtfs.fare_attributes))

    for row in eachrow(gtfs.fare_attributes)
        println("Fare: $(row.fare_id)")
        println("  Price: $(row.price)")
        println("  Currency: $(row.currency_type)")
        println("  Payment method: $(row.payment_method)")
        println("  Transfers: $(row.transfers)")
        println()
    end
end
```

### Shape Analysis

```julia
# Analyze route shapes if available
if gtfs.shapes !== nothing
    println("=== Shape Analysis ===")
    println("Total shape points: ", nrow(gtfs.shapes))

    # Count shapes
    shape_ids = unique(gtfs.shapes.shape_id)
    println("Unique shapes: ", length(shape_ids))

    # Find longest shapes
    shape_lengths = Dict{String, Int}()
    for row in eachrow(gtfs.shapes)
        shape_id = row.shape_id
        shape_lengths[shape_id] = get(shape_lengths, shape_id, 0) + 1
    end

    longest_shapes = sort(collect(shape_lengths), by=x->x[2], rev=true)[1:min(5, length(shape_lengths))]
    println("\nLongest shapes (by number of points):")
    for (shape_id, count) in longest_shapes
        println("  $shape_id: $count points")
    end
end
```

## Data Export Examples

### Export to CSV

```julia
# Export specific data to CSV files
using CSV

# Export bus routes
bus_routes = filter(row -> row.route_type == 3, gtfs.routes)
CSV.write("bus_routes.csv", bus_routes)

# Export stops with coordinates
stops_with_coords = filter(row -> !ismissing(row.stop_lat) && !ismissing(row.stop_lon), gtfs.stops)
CSV.write("stops_with_coords.csv", stops_with_coords)

println("Exported data to CSV files")
```

### Create Summary Statistics

```julia
# Create a summary report
function create_summary_report(gtfs)
    report = """
    GTFS Feed Summary Report
    ========================

    Basic Statistics:
    - Agencies: $(nrow(gtfs.agency))
    - Stops: $(nrow(gtfs.stops))
    - Routes: $(nrow(gtfs.routes))
    - Trips: $(nrow(gtfs.trips))
    - Stop Times: $(nrow(gtfs.stop_times))

    Route Types:
    """

    # Add route type breakdown
    route_counts = Dict{Int, Int}()
    for row in eachrow(gtfs.routes)
        route_type = row.route_type
        route_counts[route_type] = get(route_counts, route_type, 0) + 1
    end

    for (type_id, count) in sort(collect(route_counts))
        report *= "  - Type $type_id: $count routes\n"
    end

    # Add optional files status
    report *= "\nOptional Files:\n"
    optional_files = [
        ("Calendar", gtfs.calendar),
        ("Fare Attributes", gtfs.fare_attributes),
        ("Shapes", gtfs.shapes),
        ("Transfers", gtfs.transfers)
    ]

    for (name, df) in optional_files
        status = df !== nothing ? "Present" : "Not present"
        report *= "  - $name: $status\n"
    end

    return report
end

# Generate and save report
report = create_summary_report(gtfs)
open("gtfs_summary.txt", "w") do io
    write(io, report)
end

println("Summary report saved to gtfs_summary.txt")
```

## Error Handling Examples

### Safe Data Access

```julia
# Safe way to access optional data
function safe_get_feed_info(gtfs)
    if gtfs.feed_info !== nothing && nrow(gtfs.feed_info) > 0
        info = gtfs.feed_info[1, :]
        return Dict(
            "feed_publisher_name" => get(info, :feed_publisher_name, "Unknown"),
            "feed_publisher_url" => get(info, :feed_publisher_url, "Unknown"),
            "feed_lang" => get(info, :feed_lang, "Unknown"),
            "feed_version" => get(info, :feed_version, "Unknown")
        )
    else
        return Dict("error" => "Feed info not available")
    end
end

feed_info = safe_get_feed_info(gtfs)
println("Feed Info: ", feed_info)
```

### Handling Missing Data

```julia
# Handle missing or invalid data gracefully
function analyze_stop_coordinates(gtfs)
    valid_stops = 0
    invalid_stops = 0

    for row in eachrow(gtfs.stops)
        lat = get(row, :stop_lat, missing)
        lon = get(row, :stop_lon, missing)

        if ismissing(lat) || ismissing(lon)
            invalid_stops += 1
        elseif -90 <= lat <= 90 && -180 <= lon <= 180
            valid_stops += 1
        else
            invalid_stops += 1
        end
    end

    return (valid=valid_stops, invalid=invalid_stops)
end

coord_stats = analyze_stop_coordinates(gtfs)
println("Stop coordinates: $(coord_stats.valid) valid, $(coord_stats.invalid) invalid")
```

These examples demonstrate the flexibility and power of GTFSSchedule.jl for transit data analysis. The package's integration with DataFrames makes it easy to perform complex queries and transformations on GTFS data.
