"""
Column Types Generator

Generates Julia source code for column type mappings from GTFS field type mappings.
"""

include("../type_conversion/type_mappings.jl")

"""
    generate_column_types_dict(type_mappings::Vector{FieldTypeMapping}) -> Dict{String, Dict{String, Type}}

Convert field type mappings to a nested dictionary structure for column types.
Groups mappings by file name and creates field name to Julia type mappings.
"""
function generate_column_types_dict(type_mappings::Vector{FieldTypeMapping})
    column_types = Dict{String, Dict{String, Type}}()

    for mapping in type_mappings
        file_name = mapping.file
        field_name = mapping.field
        julia_type_info = mapping.julia_type

        # Create the Julia type based on nullability
        if julia_type_info.is_nullable
            julia_type = Union{Missing, julia_type_info.base_type}
        else
            julia_type = julia_type_info.base_type
        end

        # Initialize file dictionary if it doesn't exist
        if !haskey(column_types, file_name)
            column_types[file_name] = Dict{String, Type}()
        end

        # Add field mapping
        column_types[file_name][field_name] = julia_type
    end

    return column_types
end

"""
    escape_julia_string(str::String) -> String

Escape a string for use in Julia string literals.
"""
function escape_julia_string(str::String)
    # Replace HTML entities and special characters
    str = replace(str, "&nbsp;" => " ")
    str = replace(str, "&amp;" => "&")
    str = replace(str, "&lt;" => "<")
    str = replace(str, "&gt;" => ">")
    str = replace(str, "&quot;" => "\"")
    str = replace(str, "&apos;" => "'")

    # Escape backslashes and quotes
    str = replace(str, "\\" => "\\\\")
    str = replace(str, "\"" => "\\\"")

    return str
end

"""
    format_type_as_string(julia_type::Type) -> String

Format a Julia type as a string for code generation.
"""
function format_type_as_string(julia_type::Type)
    if julia_type <: Union
        # Handle Union types like Union{Missing, String}
        args = julia_type.parameters
        if length(args) == 2 && args[1] == Missing
            base_type = args[2]
            # Use String for Date types to avoid dependency issues
            if base_type == Date
                return "Union{Missing, String}"
            else
                return "Union{Missing, $base_type}"
            end
        else
            return string(julia_type)
        end
    else
        # Use String for Date types to avoid dependency issues
        if julia_type == Date
            return "String"
        else
            return string(julia_type)
        end
    end
end

"""
    write_column_types_file(output_path::String, column_types::Dict{String, Dict{String, Type}})

Write the column types dictionary to a Julia source file.
"""
function write_column_types_file(output_path::String, column_types::Dict{String, Dict{String, Type}})
    # Create output directory if it doesn't exist
    output_dir = dirname(output_path)
    if !isdir(output_dir)
        mkpath(output_dir)
    end

    # Generate the Julia source code
    lines = String[]

    # Header comment
    push!(lines, "# Auto-generated file - Column type mappings for GTFS files")
    push!(lines, "# Generated from GTFS specification parsing")
    push!(lines, "")

    # Start the constant definition
    push!(lines, "const COLUMN_TYPES = Dict{String, Dict{String, Type}}(")

    # Sort files for consistent output
    sorted_files = sort(collect(keys(column_types)))

    for (i, file_name) in enumerate(sorted_files)
        file_dict = column_types[file_name]

        # Start file entry
        push!(lines, "    \"$file_name\" => Dict{String, Type}(")

        # Sort fields for consistent output
        sorted_fields = sort(collect(keys(file_dict)))

        for (j, field_name) in enumerate(sorted_fields)
            julia_type = file_dict[field_name]
            type_str = format_type_as_string(julia_type)
            escaped_field_name = escape_julia_string(field_name)

            # Add comma except for last field
            comma = j < length(sorted_fields) ? "," : ""
            push!(lines, "        \"$escaped_field_name\" => $type_str$comma")
        end

        # Close file entry
        file_comma = i < length(sorted_files) ? "," : ""
        push!(lines, "    )$file_comma")
    end

    # Close the main dictionary
    push!(lines, ")")

    # Write to file
    open(output_path, "w") do io
        for line in lines
            println(io, line)
        end
    end

    println("✓ Generated column types file: $output_path")
end

# Exports
export generate_column_types_dict
export write_column_types_file
