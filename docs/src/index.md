# GTFS.jl

A Julia package for reading and validating GTFS (General Transit Feed Specification) Schedule data.

## Features

- **Complete GTFS Support**: Implements the full [GTFS Schedule specification](https://gtfs.org/documentation/schedule/reference/)
- **Comprehensive Validation**: Validate feeds against the official GTFS specification

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/moviro-hub/GTFS.jl.git")
```

## Quick Start

```julia
using GTFS

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

## Basic Usage

### Reading GTFS Data

The main function for reading GTFS data is `read_gtfs()`. It can handle both ZIP files and unzipped directories:

```julia
# From ZIP file
gtfs = read_gtfs("transit_feed.zip")

# From directory
gtfs = read_gtfs("transit_feed/")
```
