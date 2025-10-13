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
export read_gtfs, COLUMN_TYPES, FILE_TO_FIELD
export ENUM_VALID_VALUES, validate_enum
export validate_file_presence
export validate_field_presence
export validate_field_values
export validate

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

"""
    validate(gtfs::GTFSSchedule) -> ValidationResult

Comprehensive validation function that runs all validation checks on a GTFS feed.

This function combines:
- File presence validation
- Field presence validation
- Field value validation

# Arguments
- `gtfs::GTFSSchedule`: The GTFS feed to validate

# Returns
- `ValidationResult`: Combined validation results from all validation types
"""
function validate(gtfs::GTFSSchedule)
    all_messages = ValidationMessage[]

    # Run file presence validation
    file_result = validate_file_presence(gtfs)
    append!(all_messages, file_result.messages)

    # Run field presence validation
    field_result = validate_field_presence(gtfs)
    append!(all_messages, field_result.messages)

    # Run field value validation
    value_result = validate_field_values(gtfs)
    append!(all_messages, value_result.messages)

    # Determine overall validity
    error_count = count(msg -> msg.severity == :error, all_messages)
    warning_count = count(msg -> msg.severity == :warning, all_messages)
    is_valid = error_count == 0

    # Generate comprehensive summary
    summary = "GTFS validation: $error_count errors, $warning_count warnings"
    if is_valid
        summary *= " - Feed is valid"
    else
        summary *= " - Feed validation failed"
    end

    return ValidationResult(is_valid, all_messages, summary)
end

end
