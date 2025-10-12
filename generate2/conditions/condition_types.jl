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
struct FileLevelConditionalRequirement
    file_is_required::Bool              # true = file is required, false = file is optional
    when_all_conditions::Vector{Condition}  # ALL conditions must be true
end

struct ParsedFileLevelConditions
    filename::String
    presence::String
    conditions::Vector{FileLevelConditionalRequirement}
end

# Field-level conditional requirements
struct FieldLevelConditionalRequirement
    file::String                        # Which file this field belongs to
    field::String                       # Field name
    presence::String                    # "Required", "Optional", "Conditionally Required", etc.
    field_is_required::Bool             # true = required, false = optional/forbidden
    when_all_conditions::Vector{Condition}  # Conditions that must be true
end

struct ParsedFieldLevelConditions
    filename::String
    fields::Vector{FieldLevelConditionalRequirement}
end

# Exports
export Condition
export FileCondition
export FieldCondition
export FileLevelConditionalRequirement
export ParsedFileLevelConditions
export FieldLevelConditionalRequirement
export ParsedFieldLevelConditions
