"""
Condition Types Module

Defines all data structures for representing conditional requirements
in GTFS specifications (both file-level and field-level).
"""

include("../ingestion/types.jl")

# Base condition type
abstract type Condition end

# Condition types
struct FileCondition <: Condition
    file::String
    must_exist::Bool  # true = file must exist, false = file must not exist
end

struct FieldCondition <: Condition
    file::String
    field::String
    value::String
    same_file::Bool  # true if referencing field in same file
end

# File-level conditional requirements
struct FileRelation
    required::Bool                       # true = file is required
    forbidden::Bool                      # true = file is forbidden
    when_all_conditions::Vector{Condition}  # ALL conditions must be true
    # Logic: required=true,forbidden=false → required
    #        required=false,forbidden=true → forbidden
    #        required=false,forbidden=false → optional
    #        Both true is invalid (document only, no validation)
end

struct ParsedFileLevelConditions
    filename::String
    presence::String
    conditions::Vector{FileRelation}
end

# Field-level conditional requirements
struct FieldRelation
    file::String                        # Which file this field belongs to
    field::String                       # Field name
    presence::String                    # "Required", "Optional", "Conditionally Required", etc.
    required::Bool                      # true = field is required
    forbidden::Bool                     # true = field is forbidden
    when_all_conditions::Vector{Condition}  # Conditions that must be true
    # Logic: required=true,forbidden=false → required
    #        required=false,forbidden=true → forbidden
    #        required=false,forbidden=false → optional
    #        Both true is invalid (document only, no validation)
end

struct ParsedFieldLevelConditions
    filename::String
    fields::Vector{FieldRelation}
end

# Exports
export Condition
export FileCondition
export FieldCondition
export FileRelation
export ParsedFileLevelConditions
export FieldRelation
export ParsedFieldLevelConditions
