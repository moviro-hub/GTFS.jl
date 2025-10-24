# GTFSSchedule.jl

[Documentation](https://moviro-hub.github.io/GTFSSchedule.jl)

A Julia package for reading and validating GTFS (General Transit Feed Specification) Schedule data.


## Features

- **Complete GTFS Support**: Implements the full [GTFS Schedule specification](https://gtfs.org/documentation/schedule/reference/)
- **Comprehensive Validation**: Validate feeds against the official GTFS specification


## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/moviro-hub/GTFSSchedule.jl.git")
```

## Quick Start

```julia
using GTFSSchedule

# Read a GTFS feed from ZIP file
gtfs = read_gtfs("path/to/transit_feed.zip")

# Or read from unzipped directory
gtfs = read_gtfs("path/to/transit_feed/")

# Validate the feed
result = validate(gtfs)
if result.is_valid
    println("GTFS feed is valid!")
else
    println("Validation issues found:")
    println(result)
end

# Access data using DataFrames
println("Number of agencies: ", nrow(gtfs.agency))
println("Number of stops: ", nrow(gtfs.stops))
println("Number of routes: ", nrow(gtfs.routes))

# Filter data
bus_routes = filter(row -> row.route_type == 3, gtfs.routes)
println("Number of bus routes: ", nrow(bus_routes))
```

## License

This package is licensed under the MIT License. See LICENSE file for details.

## References

- [GTFS Schedule Specification](https://gtfs.org/documentation/schedule/reference/)
- [GTFS Best Practices](https://gtfs.org/documentation/schedule/best-practices/)
- [GTFS Examples](https://gtfs.org/documentation/schedule/data-examples/)
