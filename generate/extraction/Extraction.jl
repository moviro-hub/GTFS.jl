"""
    Extraction

Module for extracting validation rules and type information from parsed GTFS data.

This module processes the structured data from the Ingestion module and extracts
specific validation rules and type information including:

- File-level and field-level conditions and requirements
- Enum values and validation rules
- Field type mappings and constraints
- Foreign key relationships and references
- Field constraints (Unique, Non-negative, etc.)

The module provides a comprehensive set of extractors that transform the parsed
specification into validation rules suitable for code generation.
"""
module Extraction

using ..Ingestion: DatasetFileDefinition
using ..Ingestion: FieldDefinition, FileDefinition
using ..Ingestion: PresenceInfo

# Main extraction functions
export extract_all_file_conditions
export extract_all_field_conditions
export extract_all_field_enum_values
export extract_all_field_types
export extract_all_field_id_references
export extract_all_field_constraints

# Data structures - File/Field conditions
export FileRelations, FileRelation, FileCondition, FileFieldCondition
export FieldRelations, FieldRelation, FieldCondition

# Data structures - Enums
export EnumField, EnumValue

# Data structures - Types
export FieldTypeInfo, FileTypeInfo

# Data structures - Foreign references
export ForeignReference, FieldForeignInfo, FileForeignInfo

# Data structures - Field constraints
export FieldConstraintInfo, FileFieldConstraintInfo

include("extraction_utils.jl")
include("extract_file_conditions.jl")
include("extract_field_conditions.jl")
include("extract_field_enum_values.jl")
include("extract_field_types.jl")
include("extract_field_id_references.jl")
include("extract_field_constraints.jl")

end
