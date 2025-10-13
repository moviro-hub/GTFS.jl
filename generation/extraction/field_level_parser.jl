"""
Field-Level Condition Parser

Parses conditional requirements for GTFS fields within files
(determines when specific fields are required, optional, or forbidden).
"""

include("condition_types.jl")
include("condition_utils.jl")

"""
    extract_field_condition_section(description::String) -> String

Extract the "Conditionally Required:" or "Conditionally Forbidden:" section from a field description.
"""
function extract_field_condition_section(description::String)
    # Try various patterns for conditionally required/forbidden sections
    patterns = [
        r"Conditionally Required:",
        r"Conditionally Forbidden:",
        r"\*\*Conditionally Required\*\*:",
        r"\*\*Conditionally Forbidden\*\*:"
    ]

    for pattern in patterns
        match_result = findfirst(pattern, description)
        if match_result !== nothing
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
    parse_field_level_condition_line(field_name::String, line::String, current_file::String, presence::String) -> Union{FieldRelation, Nothing}

Parse a single condition line for a field into a FieldRelation.
"""
function parse_field_level_condition_line(field_name::String, line::String, current_file::String, presence::String)
    # Determine required and forbidden flags based on presence type
    if presence == "Conditionally Required"
        required = true
        forbidden = false
    elseif presence == "Conditionally Forbidden"
        required = false
        forbidden = true
    else
        required = false
        forbidden = false
    end

    # Extract field references from backticks
    fields = extract_field_references(line)

    # Build condition vector
    conditions = Condition[]

    # Parse field conditions (same-file references)
    for field_str in fields
        # Handle field references that include file prefix (e.g., "stop_times.stop_id")
        if occursin(".", field_str)
            parts = split(field_str, ".")
            if length(parts) >= 2
                ref_file = parts[1] * ".txt"
                ref_field_name = parts[2]
            else
                ref_file = current_file
                ref_field_name = field_str
            end
        else
            ref_file = current_file
            ref_field_name = field_str
        end

        if occursin("=", field_str)
            parts = split(field_str, "=")
            if length(parts) >= 2
                ref_field_name = String(strip(parts[1]))
                ref_field_value = String(strip(parts[2]))
                push!(conditions, FieldCondition(ref_file, ref_field_name, ref_field_value, true))
            end
        elseif !isempty(field_str)
            # Field mentioned without value - check for "is X or Y" pattern
            # Look for patterns like "location_type` is `3` or `4`"
            value_pattern = r"`(\d+)`"
            values = [String(m.captures[1]) for m in eachmatch(value_pattern, line)]

            if !isempty(values)
                # Create condition for each value (OR logic represented as separate conditions)
                for value in values
                    push!(conditions, FieldCondition(ref_file, ref_field_name, value, true))
                end
            else
                # For forbidden conditions, we need to check if the field is defined
                # This is a special case for "Forbidden if X is defined" conditions
                push!(conditions, FieldCondition(ref_file, ref_field_name, "defined", true))
            end
        end
    end

    if isempty(conditions)
        return nothing
    end

    return FieldRelation(current_file, field_name, presence, required, forbidden, conditions)
end

"""
    parse_field_level_conditional_requirements(file_def::FileDefinition) -> Vector{FieldRelation}

Parse field-level conditional requirements for all fields in a file definition.
"""
function parse_field_level_conditional_requirements(file_def::FileDefinition)
    field_requirements = FieldRelation[]

    for field in file_def.fields
        # Only process fields with conditional presence
        if !(field.presence in ["Conditionally Required", "Conditionally Forbidden"])
            continue
        end

        section = extract_field_condition_section(field.description)
        if isempty(section)
            continue
        end

        lines = filter(!isempty, strip.(split(section, r"<br>|\n")))

        for line in lines
            line_str = String(line)
            if !startswith(line_str, "-")
                continue
            end

            # Parse the line
            req = parse_field_level_condition_line(field.field_name, line_str, file_def.filename, field.presence)
            if req !== nothing
                push!(field_requirements, req)
            end
        end
    end

    return field_requirements
end

"""
    parse_all_field_level_conditions(file_definitions::Vector{FileDefinition}) -> Vector{ParsedFieldLevelConditions}

Parse field-level conditional requirements for all files.
"""
function parse_all_field_level_conditions(file_definitions::Vector{FileDefinition})
    result = ParsedFieldLevelConditions[]

    for file_def in file_definitions
        field_reqs = parse_field_level_conditional_requirements(file_def)
        if !isempty(field_reqs)
            push!(result, ParsedFieldLevelConditions(file_def.filename, field_reqs))
        end
    end

    return result
end


# Exports
export extract_field_condition_section
export parse_field_level_condition_line
export parse_field_level_conditional_requirements
export parse_all_field_level_conditions
