"""
Enum Validator Generator

Generates Julia source code for enum validation functions based on parsed enum fields.
"""

include("../extraction/types.jl")

"""
    generate_enum_validator_function(parsed_enum::ParsedEnumField) -> String

Generate a validation function for a single enum field.
"""
function generate_enum_validator_function(parsed_enum::ParsedEnumField)
    file_name = parsed_enum.file
    field_name = parsed_enum.field
    enum_values = parsed_enum.enum_values

    # Create function name
    clean_file = replace(file_name, ".txt" => "")
    clean_field = field_name
    func_name = "validate_$(clean_file)_$(clean_field)"

    # Extract valid values
    valid_values = String[]
    for enum_val in enum_values
        if enum_val.value == "empty"
            push!(valid_values, "\"\"")
        else
            push!(valid_values, "\"$(enum_val.value)\"")
        end
    end

    # Generate function code
    lines = String[]
    push!(lines, "\"\"\"")
    push!(lines, "    $func_name(value)")
    push!(lines, "")
    push!(lines, "Validate enum value for $field_name in $file_name.")
    push!(lines, "Returns true if value is valid, false otherwise.")
    push!(lines, "Handles missing values by returning true.")
    push!(lines, "\"\"\"")
    push!(lines, "function $func_name(value)")
    push!(lines, "    # Handle missing values")
    push!(lines, "    if ismissing(value)")
    push!(lines, "        return true")
    push!(lines, "    end")
    push!(lines, "")
    push!(lines, "    # Convert to string for comparison")
    push!(lines, "    str_value = string(value)")
    push!(lines, "")
    push!(lines, "    # Check against valid values")
    push!(lines, "    valid_values = [$(join(valid_values, ", "))]")
    push!(lines, "    return str_value in valid_values")
    push!(lines, "end")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    generate_enum_validator_dict(parsed_enums::Vector{ParsedEnumField}) -> String

Generate a dictionary mapping (file, field) to valid values.
"""
function generate_enum_validator_dict(parsed_enums::Vector{ParsedEnumField})
    lines = String[]

    push!(lines, "# Dictionary of valid enum values")
    push!(lines, "const ENUM_VALID_VALUES = Dict{Tuple{String, String}, Vector{String}}(")

    for (i, parsed_enum) in enumerate(parsed_enums)
        file_name = parsed_enum.file
        field_name = parsed_enum.field
        enum_values = parsed_enum.enum_values

        # Extract valid values
        valid_values = String[]
        for enum_val in enum_values
            if enum_val.value == "empty"
                push!(valid_values, "\"\"")
            else
                push!(valid_values, "\"$(enum_val.value)\"")
            end
        end

        # Add dictionary entry
        comma = i < length(parsed_enums) ? "," : ""
        push!(lines, "    (\"$file_name\", \"$field_name\") => [$(join(valid_values, ", "))]$comma")
    end

    push!(lines, ")")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    generate_generic_validator() -> String

Generate a generic enum validation function.
"""
function generate_generic_validator()
    lines = String[]

    push!(lines, "\"\"\"")
    push!(lines, "    validate_enum(file::String, field::String, value)")
    push!(lines, "")
    push!(lines, "Generic enum validator that looks up valid values in ENUM_VALID_VALUES dictionary.")
    push!(lines, "Returns true if value is valid for the given file and field, false otherwise.")
    push!(lines, "Handles missing values by returning true.")
    push!(lines, "\"\"\"")
    push!(lines, "function validate_enum(file::String, field::String, value)")
    push!(lines, "    # Handle missing values")
    push!(lines, "    if ismissing(value)")
    push!(lines, "        return true")
    push!(lines, "    end")
    push!(lines, "")
    push!(lines, "    # Look up valid values")
    push!(lines, "    key = (file, field)")
    push!(lines, "    if !haskey(ENUM_VALID_VALUES, key)")
    push!(lines, "        return true  # No validation defined, assume valid")
    push!(lines, "    end")
    push!(lines, "")
    push!(lines, "    # Convert to string for comparison")
    push!(lines, "    str_value = string(value)")
    push!(lines, "")
    push!(lines, "    # Check against valid values")
    push!(lines, "    valid_values = ENUM_VALID_VALUES[key]")
    push!(lines, "    return str_value in valid_values")
    push!(lines, "end")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    write_enum_validator_file(output_path::String, parsed_enums::Vector{ParsedEnumField})

Write the enum validator file with all validation functions.
"""
function write_enum_validator_file(output_path::String, parsed_enums::Vector{ParsedEnumField})
    # Create output directory if it doesn't exist
    output_dir = dirname(output_path)
    if !isdir(output_dir)
        mkpath(output_dir)
    end

    # Generate the Julia source code
    lines = String[]

    # Header comment
    push!(lines, "# Auto-generated file - Enum validation functions")
    push!(lines, "# Generated from GTFS specification parsing")
    push!(lines, "")

    # Add documentation
    push!(lines, "\"\"\"")
    push!(lines, "Enum Validation Functions")
    push!(lines, "")
    push!(lines, "This module provides validation functions for GTFS enum fields.")
    push!(lines, "All functions return true if the value is valid, false otherwise.")
    push!(lines, "Missing values are always considered valid (presence validation is handled separately).")
    push!(lines, "")
    push!(lines, "Usage:")
    push!(lines, "    validate_routes_route_type(\"0\")  # true")
    push!(lines, "    validate_routes_route_type(\"99\") # false")
    push!(lines, "    validate_enum(\"routes.txt\", \"route_type\", \"0\")  # generic validator")
    push!(lines, "\"\"\"")
    push!(lines, "")

    # Generate dictionary of valid values
    dict_code = generate_enum_validator_dict(parsed_enums)
    push!(lines, dict_code)

    # Generate generic validator
    generic_code = generate_generic_validator()
    push!(lines, generic_code)

    # Generate specific validators for each enum field
    push!(lines, "# Specific validation functions for each enum field")
    push!(lines, "")

    for parsed_enum in parsed_enums
        func_code = generate_enum_validator_function(parsed_enum)
        push!(lines, func_code)
    end

    # Write to file
    open(output_path, "w") do io
        for line in lines
            println(io, line)
        end
    end

    println("✓ Generated enum validator file: $output_path")
end

# Exports
export generate_enum_validator_function
export generate_enum_validator_dict
export generate_generic_validator
export write_enum_validator_file
