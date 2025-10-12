"""
GTFS to Julia Type Conversion

Main conversion logic for mapping GTFS field types to Julia types.
"""

include("type_mappings.jl")

"""
    convert_field_type(field::FieldDefinition, file::String) -> FieldTypeMapping

Convert a single field definition to a type mapping.
"""
function convert_field_type(field::FieldDefinition, file::String)
    # Clean field name (remove backticks)
    clean_field_name = replace(field.field_name, "`" => "")

    # Convert GTFS type to Julia type
    julia_type = gtfs_type_to_julia(field.field_type, field.presence)

    return FieldTypeMapping(
        file,
        clean_field_name,
        field.field_type,
        julia_type
    )
end

"""
    convert_all_field_types(file_definitions::Vector{FileDefinition}) -> Vector{FieldTypeMapping}

Convert all field types in all files to Julia type mappings.
"""
function convert_all_field_types(file_definitions::Vector{FileDefinition})
    type_mappings = FieldTypeMapping[]

    for file_def in file_definitions
        for field in file_def.fields
            mapping = convert_field_type(field, file_def.filename)
            push!(type_mappings, mapping)
        end
    end

    return type_mappings
end


# Exports
export convert_field_type
export convert_all_field_types
