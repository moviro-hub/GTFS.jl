"""
    Generation

Module for generating Julia source files from extracted GTFS validation rules.

This module takes the extracted validation rules and type information from the
Extraction module and generates clean, type-safe Julia source files including:

- File-level and field-level condition validation rules
- Enum value validation with proper type mappings
- Field type definitions with GTFS type constants
- Foreign key relationship validation
- Field constraint validation (Unique, Non-negative, etc.)

The module provides a complete code generation pipeline that creates maintainable
Julia validation code from the GTFS specification.
"""
module Generation

# =============================================================================
# IMPORTS
# =============================================================================

using ..Extraction: FileRelations, FileRelation, FileCondition, FileFieldCondition
using ..Extraction: FieldRelations, FieldRelation, FieldCondition
using ..Extraction: FileEnumInfo, FieldEnumInfo, FileTypeInfo, FieldTypeInfo, FileForeignInfo, FieldForeignInfo, ForeignReference
using ..Extraction: FileFieldConstraintInfo, FieldConstraintInfo
using ..Ingestion: FileDefinition, FieldDefinition

# =============================================================================
# EXPORTS
# =============================================================================

# Main generation functions
export write_source_file
export generate_file_conditions, generate_field_conditions, generate_field_enum_values
export generate_field_types, generate_field_id_references, generate_field_constraints

# Common utilities
export indent_line, indent_lines, format_julia_struct, format_julia_array

# =============================================================================
# INCLUDES
# =============================================================================

include("generate_file_conditions.jl")
include("generate_field_conditions.jl")
include("generate_field_enum_values.jl")
include("generate_field_types.jl")
include("generate_field_id_references.jl")
include("generate_field_constraints.jl")

# =============================================================================
# COMMON GENERATION UTILITIES
# =============================================================================

"""
    indent_line(line::String, level::Int=1) -> String

Indent a line by the specified number of levels (4 spaces per level).

# Arguments
- `line::String`: The line to indent
- `level::Int=1`: Number of indentation levels

# Returns
- `String`: The indented line

# Examples
```julia
julia> indent_line("field = value", 2)
"        field = value"
```
"""
function indent_line(line::String, level::Int = 1)
    if isempty(line)
        return line
    end

    indent = "    "^level
    return indent * line
end

"""
    indent_lines(lines::Vector{String}, level::Int=1) -> Vector{String}

Indent multiple lines by the specified number of levels.

# Arguments
- `lines::Vector{String}`: The lines to indent
- `level::Int=1`: Number of indentation levels

# Returns
- `Vector{String}`: The indented lines
"""
function indent_lines(lines::Vector{String}, level::Int = 1)
    return [indent_line(line, level) for line in lines]
end

"""
    format_julia_struct(struct_name::String, fields::Vector{String}) -> Vector{String}

Format a Julia struct definition.

# Arguments
- `struct_name::String`: The struct name
- `fields::Vector{String}`: The field definitions

# Returns
- `Vector{String}`: The formatted struct lines

# Examples
```julia
julia> format_julia_struct("MyStruct", ["field1::String", "field2::Int"])
["struct MyStruct", "    field1::String", "    field2::Int", "end"]
```
"""
function format_julia_struct(struct_name::String, fields::Vector{String})
    lines = String[]
    push!(lines, "struct $struct_name")

    for field in fields
        push!(lines, indent_line(field))
    end

    push!(lines, "end")
    return lines
end

"""
    format_julia_array(array_name::String, elements::Vector{String}, element_type::String="") -> Vector{String}

Format a Julia array definition.

# Arguments
- `array_name::String`: The array variable name
- `elements::Vector{String}`: The array elements
- `element_type::String="": Optional element type specification

# Returns
- `Vector{String}`: The formatted array lines

# Examples
```julia
julia> format_julia_array("my_array", ["1", "2", "3"], "Int")
["const my_array::Vector{Int} = [", "    1,", "    2,", "    3", "]"]
```
"""
function format_julia_array(array_name::String, elements::Vector{String}, element_type::String = "")
    lines = String[]

    if isempty(element_type)
        array_def = "const $array_name = ["
    else
        array_def = "const $array_name::Vector{$element_type} = ["
    end

    push!(lines, array_def)

    for (i, element) in enumerate(elements)
        if i == length(elements)
            push!(lines, indent_line(element))
        else
            push!(lines, indent_line(element * ","))
        end
    end

    push!(lines, "]")
    return lines
end

# =============================================================================
# FILE OPERATIONS
# =============================================================================

"""
    write_source_file(file::String, lines::Vector{String})

Write the generated source file to the specified path.

# Arguments
- `file::String`: Path where to write the generated source file
- `lines::Vector{String}`: Lines of Julia source code to write

# Side Effects
- Creates the output directory if it doesn't exist
- Overwrites the target file if it exists

# Examples
```julia
julia> write_source_file("output.jl", ["struct MyStruct", "    field::String", "end"])
# Creates output.jl with the specified content
```
"""
function write_source_file(file::String, lines::Vector{String})
    if isempty(file)
        error("File path cannot be empty")
    end

    if isempty(lines)
        error("Cannot write empty source file")
    end

    # Create output directory if it doesn't exist
    output_dir = dirname(file)
    if !isdir(output_dir)
        mkpath(output_dir)
    end

    # Write file
    return open(file, "w") do io
        for line in lines
            println(io, line)
        end
    end
end

end
