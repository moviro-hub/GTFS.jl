"""
GTFS.jl - A Julia package for reading and validating GTFS Schedule data

This package provides functionality to read, validate, and work with GTFS (General Transit Feed Specification)
Schedule data in Julia. It supports the official GTFS Schedule specification and includes comprehensive
validation to ensure data compliance.

# Main Features

- Read GTFS feeds from ZIP files
- Comprehensive validation against GTFS specification

# Quick Start

```julia
using GTFS

# Read a GTFS feed
gtfs = read_gtfs("path/to/transit_feed.zip")

# Validate the feed
result = validate(gtfs)
if result.is_valid
    println("GTFS feed is valid!")
else
    println("Validation issues found:")
    println(result)
end

# Access data using DataFrames
println("Number of agencies: ", DataFrames.nrow(gtfs.agency))
println("Number of stops: ", DataFrames.nrow(gtfs.stops))
println("Number of routes: ", DataFrames.nrow(gtfs.routes))
```

# GTFS Specification

This package implements the official GTFS Schedule specification:
https://gtfs.org/documentation/schedule/reference/

# Package Structure

- `read_gtfs()`: Read GTFS feeds from ZIP files
- `validate()`: Validate GTFS feeds against the specification
- `GTFSSchedule`: Main data structure containing all GTFS tables
- `ValidationResult`: Detailed validation results
"""
module GTFS

# Import dependencies
using DataFrames: DataFrames
using CSV: CSV
using JSON3: JSON3

# Export main types and functions
export GTFSSchedule, ValidationResult, ValidationMessage
export read_gtfs, COLUMN_TYPES
export ENUM_VALID_VALUES, validate_enum
export validate_file_presence
export validate_field_presence
export validate_field_values

# Include submodules
include("validation_types.jl")
include("gtfs_types.jl")
include("column_types.jl")
include("file_mapping.jl")
include("enum_validator.jl")
include("file_validator.jl")
include("field_validator.jl")
include("value_validator.jl")
include("reader.jl")

end
