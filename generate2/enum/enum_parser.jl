"""
Enum Value Parser

Parses enum values and their descriptions from GTFS field descriptions
where field_type is "Enum".
"""

include("types.jl")
include("../ingestion/types.jl")

"""
    extract_enum_section(description::String) -> String

Extract the "Valid options are:" section from a field description.
"""
function extract_enum_section(description::String)
    # Look for "Valid options are:" pattern
    patterns = [
        r"Valid options are:",
        r"Valid values are:",
        r"The following values are supported:"
    ]

    for pattern in patterns
        match_result = findfirst(pattern, description)
        if match_result !== nothing
            # Extract everything after the pattern
            start_pos = last(match_result)
            section = description[start_pos:end]

            # Clean up HTML tags
            section = replace(section, "<br>" => "\n")
            section = replace(section, "<br><br>" => "\n")

            return section
        end
    end

    return ""
end

"""
    parse_enum_line(line::String) -> Union{EnumValue, Nothing}

Parse a single enum line like "`0` - Description text".
"""
function parse_enum_line(line::String)
    # Pattern to match: `value` - description
    # Handles both regular values and "empty" as a special case
    pattern = r"`([^`]+)`\s*-\s*(.+)"

    m = match(pattern, line)
    if m !== nothing
        value = String(strip(m.captures[1]))
        description = String(strip(m.captures[2]))

        # Clean up description - remove trailing periods and extra whitespace
        description = strip(description, ['.', ' ', '\n', '\r'])

        return EnumValue(value, description)
    end

    return nothing
end

"""
    parse_enum_field(file_def::FileDefinition, field::FieldDefinition) -> Union{ParsedEnumField, Nothing}

Parse enum values for a single field.
"""
function parse_enum_field(file_def::FileDefinition, field::FieldDefinition)
    # Only process Enum fields
    if field.field_type != "Enum"
        return nothing
    end

    # Extract the enum section from description
    section = extract_enum_section(field.description)
    if isempty(section)
        return nothing
    end

    # Split into lines and parse each one
    lines = split(section, '\n')
    enum_values = EnumValue[]

    for line in lines
        line_str = String(strip(line))
        if isempty(line_str)
            continue
        end

        # Try to parse as enum line
        enum_val = parse_enum_line(line_str)
        if enum_val !== nothing
            push!(enum_values, enum_val)
        end
    end

    # Only return if we found enum values
    if isempty(enum_values)
        return nothing
    end

    # Clean field name (remove backticks)
    clean_field_name = replace(field.field_name, "`" => "")

    return ParsedEnumField(file_def.filename, clean_field_name, enum_values)
end

"""
    parse_all_enum_fields(file_definitions::Vector{FileDefinition}) -> Vector{ParsedEnumField}

Parse enum values for all enum fields in all files.
"""
function parse_all_enum_fields(file_definitions::Vector{FileDefinition})
    result = ParsedEnumField[]

    for file_def in file_definitions
        for field in file_def.fields
            parsed_enum = parse_enum_field(file_def, field)
            if parsed_enum !== nothing
                push!(result, parsed_enum)
            end
        end
    end

    return result
end


# Exports
export extract_enum_section
export parse_enum_line
export parse_enum_field
export parse_all_enum_fields
