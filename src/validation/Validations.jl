module Validations

using DataFrames
using Dates

# Import FIELD_RULES, FILE_RULES, ENUM_RULES, FIELD_CONSTRAINTS, and FIELD_ID_REFERENCES from the parent module
using ..GTFS: GTFSSchedule, FIELD_TYPES, FIELD_RULES, FILE_RULES, ENUM_RULES, FIELD_CONSTRAINTS, FIELD_ID_REFERENCES

include("types.jl")
include("utils.jl")
include("field_types.jl")
include("field_conditions.jl")
include("file_conditions.jl")
include("field_enum_values.jl")
include("field_constraints.jl")
include("field_id_references.jl")
include("gtfs.jl")

# Export only essential validation functions
export validate_gtfs, print_validation_results, has_validation_errors

end
