"""
GTFS Specification Data Types

Simple data structures to hold parsed GTFS specification information.
All fields are strings for simplicity and future extensibility.
"""

"""
    FieldDefinition

Represents a single field definition from the GTFS specification.

# Fields
- `field_name::String`: The field name (e.g., "agency_id")
- `field_type::String`: The field type (e.g., "Unique ID", "Text", "Enum")
- `presence::String`: The presence requirement (e.g., "Required", "Optional")
- `description::String`: The field description
"""
struct FieldDefinition
    field_name::String
    field_type::String
    presence::String
    description::String
end

"""
    FileDefinition

Represents a GTFS file definition with its fields and metadata.

# Fields
- `filename::String`: The GTFS file name (e.g., "agency.txt")
- `file_requirement::String`: File requirement (e.g., "Required", "Optional")
- `primary_key::String`: Primary key specification (e.g., "agency_id" or "trip_id, stop_sequence")
- `fields::Vector{FieldDefinition}`: Vector of field definitions for this file
"""
struct FileDefinition
    filename::String
    file_requirement::String
    primary_key::String
    fields::Vector{FieldDefinition}
end

"""
    DatasetFileDefinition

Represents a GTFS file from the Dataset Files section.

# Fields
- `filename::String`: The GTFS file name (e.g., "agency.txt")
- `presence::String`: The presence requirement (e.g., "Required", "Optional")
- `description::String`: The file description
"""
struct DatasetFileDefinition
    filename::String
    presence::String
    description::String
end
