"""
    Field Conditions Extraction

Extracts field-level conditional requirements from GTFS specification.
Handles "Conditionally Required" and "Conditionally Forbidden" field conditions.
"""

# =============================================================================
# DATA STRUCTURES
# =============================================================================

"""
    FieldCondition

Represents a condition that must be met for a field requirement.

# Fields
- `file::String`: The file containing the referenced field
- `field::String`: The field name being referenced
- `value::String`: The expected value or condition
- `same_file::Bool`: Whether the referenced field is in the same file
"""
struct FieldCondition
    file::String
    field::String
    value::String
    same_file::Bool
end

"""
    FieldRelation

Represents a field's conditional requirement within a specific file.

# Fields
- `file::String`: The file containing this field
- `field::String`: The field name
- `presence::String`: The presence type (e.g., "Conditionally Required")
- `required::Bool`: Whether the field is required when conditions are met
- `forbidden::Bool`: Whether the field is forbidden when conditions are met
- `when_all_conditions::Vector{FieldCondition}`: Conditions that must all be true

# Logic
- `required=true, forbidden=false` → field is required when conditions are met
- `required=false, forbidden=true` → field is forbidden when conditions are met
- `required=false, forbidden=false` → field is optional
- Both `required` and `forbidden` true is invalid
"""
struct FieldRelation
    file::String
    field::String
    presence::String
    required::Bool
    forbidden::Bool
    when_all_conditions::Vector{FieldCondition}
end

"""
    FieldRelations

Groups field relations by filename.

# Fields
- `filename::String`: The GTFS file name
- `fields::Vector{FieldRelation}`: List of field relations for this file
"""
struct FieldRelations
    filename::String
    fields::Vector{FieldRelation}
end

# =============================================================================
# CONDITION SECTION EXTRACTION
# =============================================================================

"""
    extract_field_condition_section(description::String) -> String

Extract condition sections from field descriptions.

# Arguments
- `description::String`: Field description text

# Returns
- `String`: The condition section with HTML breaks normalized, or empty string if not found

# Examples
```julia
julia> extract_field_condition_section("Conditionally Required:<br>- When...")
"Conditionally Required:\n- When..."
```
"""
function extract_field_condition_section(description::String)
    if isempty(description)
        return ""
    end

    # Common condition section markers
    condition_markers = [
        "Conditionally Required:",
        "Conditionally Forbidden:",
        "**Conditionally Required**:",
        "**Conditionally Forbidden**:"
    ]

    return extract_condition_section(description, condition_markers)
end

# =============================================================================
# CONDITION PARSING
# =============================================================================

"""
    parse_field_level_condition_line(fieldname::String, line::String, current_file::String, presence::String) -> Union{FieldRelation, Nothing}

Parse a single condition line for a field into a FieldRelation.

# Arguments
- `fieldname::String`: The field name being processed
- `line::String`: The condition line text
- `current_file::String`: The current file being processed
- `presence::String`: The presence type (e.g., "Conditionally Required")

# Returns
- `Union{FieldRelation, Nothing}`: Parsed field relation or nothing if parsing fails
"""
function parse_field_level_condition_line(fieldname::String, line::String, current_file::String, presence::String)
    if isempty(line) || isempty(fieldname)
        return nothing
    end

    # Determine requirement flags based on presence type
    required, forbidden = parse_presence_flags(presence)

    # Extract field references from backticks
    field_references = extract_field_references(line)
    if isempty(field_references)
        return nothing
    end

    # Parse each field reference into conditions
    conditions = FieldCondition[]
    for field_reference in field_references
        condition = parse_field_reference(field_reference, current_file)
        if condition !== nothing
            push!(conditions, condition)
        end
    end

    if isempty(conditions)
        return nothing
    end

    return FieldRelation(current_file, fieldname, presence, required, forbidden, conditions)
end


"""
    parse_field_reference(field_reference::String, current_file::String) -> Union{FieldCondition, Nothing}

Parse a field reference string into a FieldCondition.

# Arguments
- `field_reference::String`: Field reference (e.g., "stop_id=1" or "routes.route_id")
- `current_file::String`: Current file context

# Returns
- `Union{FieldCondition, Nothing}`: Parsed condition or nothing if invalid
"""
function parse_field_reference(field_reference::String, current_file::String)
    if isempty(field_reference)
        return nothing
    end

    # Parse field name and value
    ref_field, ref_value = parse_field_name_and_value(field_reference)
    if isempty(ref_field)
        return nothing
    end

    # Parse file and field names
    ref_file, _ = parse_file_field_reference(field_reference, current_file)

    same_file = (ref_file == current_file)
    return FieldCondition(ref_file, ref_field, ref_value, same_file)
end


# =============================================================================
# MAIN EXTRACTION FUNCTIONS
# =============================================================================

"""
    parse_field_level_conditional_requirements(file_def::FileDefinition, conditionally_required::String, conditionally_forbidden::String) -> Vector{FieldRelation}

Parse field-level conditional requirements for all fields in a file definition.

# Arguments
- `file_def::FileDefinition`: File definition containing fields to process
- `conditionally_required::String`: Presence type for conditionally required fields
- `conditionally_forbidden::String`: Presence type for conditionally forbidden fields

# Returns
- `Vector{FieldRelation}`: List of field relations with conditional requirements
"""
function parse_field_level_conditional_requirements(file_def::FileDefinition, conditionally_required::String, conditionally_forbidden::String)
    field_requirements = FieldRelation[]

    for field in file_def.fields
        # Only process fields with conditional presence
        if !(field.presence in [conditionally_required, conditionally_forbidden])
            continue
        end

        section = extract_field_condition_section(field.description)
        if isempty(section)
            continue
        end

        # Parse condition lines
        condition_lines = parse_condition_lines(section)
        for line in condition_lines
            field_relation = parse_field_level_condition_line(field.fieldname, line, file_def.filename, field.presence)
            if field_relation !== nothing
                push!(field_requirements, field_relation)
            end
        end
    end

    return field_requirements
end


"""
    extract_all_field_conditions(file_definitions::Vector{FileDefinition}, presence_types::Vector=PresenceInfo[]) -> Vector{FieldRelations}

Extract field-level conditional requirements for all files.

# Arguments
- `file_definitions::Vector{FileDefinition}`: List of file definitions to process
- `presence_types::Vector=PresenceInfo[]`: List of presence types for validation

# Returns
- `Vector{FieldRelations}`: List of field relations grouped by file
"""
function extract_all_field_conditions(file_definitions::Vector{FileDefinition}, presence_types::Vector=PresenceInfo[])
    if isempty(file_definitions)
        return FieldRelations[]
    end

    # Get presence keywords for validation
    conditionally_required = "Conditionally Required"
    conditionally_forbidden = "Conditionally Forbidden"

    if !isempty(presence_types)
        for presence_info in presence_types
            if presence_info.presence == "Conditionally Required"
                conditionally_required = presence_info.presence
            elseif presence_info.presence == "Conditionally Forbidden"
                conditionally_forbidden = presence_info.presence
            end
        end
    end

    result = FieldRelations[]

    for file_def in file_definitions
        field_requirements = parse_field_level_conditional_requirements(file_def, conditionally_required, conditionally_forbidden)
        if !isempty(field_requirements)
            push!(result, FieldRelations(file_def.filename, field_requirements))
        end
    end

    return result
end
