# GTFSSchedules.jl

[Documentation](https://moviro-hub.github.io/GTFSSchedules.jl)

**A Julia package for reading, validating, and working with GTFS (General Transit Feed Specification) transit data.**

GTFS is the standard format for public transportation data used by Google Maps, transit apps, and planning tools. This package provides a complete Julia implementation for reading GTFS feeds, validating them against the official specification, and accessing the data through familiar DataFrames.

## Key Features

- **Complete GTFS Support**: Full implementation of the [GTFS Schedule specification](https://gtfs.org/documentation/schedule/reference/)
- **Comprehensive Validation**: Built-in validation against official GTFS rules with detailed error reporting (rules auto-generated from the specification)

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/moviro-hub/GTFSSchedules.jl.git")
```

## Quick Start

```julia
using GTFSSchedules
using DataFrames

# Read a GTFS feed from ZIP file
gtfs = read_gtfs("path/to/transit_feed.zip")

# Or read from unzipped directory
gtfs = read_gtfs("path/to/transit_feed/")

# Validate the feed
result = GTFSSchedules.Validations.validate_gtfs(gtfs)
if result.is_valid
    println("GTFS feed is valid!")
else
    println("Validation issues found:")
    println(result)
end

# Access data using DataFrames
println("Number of agencies: ", nrow(gtfs["agency.txt"]))
println("Number of stops: ", nrow(gtfs["stops.txt"]))
println("Number of routes: ", nrow(gtfs["routes.txt"]))

# Filter data
routes_df = gtfs["routes.txt"]
bus_routes = filter(row -> row.route_type == 3, routes_df)
println("Number of bus routes: ", nrow(bus_routes))
```

## License

This package is licensed under the MIT License. See LICENSE file for details.

## References

- [GTFS Schedule Specification](https://gtfs.org/documentation/schedule/reference/)
