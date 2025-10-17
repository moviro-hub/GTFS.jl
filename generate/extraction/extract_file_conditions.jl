"""
    File Conditions Extraction

Extracts file-level conditional requirements from GTFS specification.
Handles "Conditionally Required" and "Conditionally Forbidden" file conditions.
"""

# =============================================================================
# DATA STRUCTURES
# =============================================================================

"""
    Condition

Abstract base type for all condition types.
"""
abstract type Condition end

"""
    FileCondition <: Condition

Represents a condition based on file existence.

# Fields
- `file::String`: The file name
- `must_exist::Bool`: Whether the file must exist (true) or must not exist (false)
"""
struct FileCondition <: Condition
    file::String
    must_exist::Bool
end

"""
    FileFieldCondition <: Condition

Represents a condition based on a field value in a file.

# Fields
- `file::String`: The file containing the field
- `field::String`: The field name
- `value::String`: The expected value
- `same_file::Bool`: Whether the referenced field is in the same file
"""
struct FileFieldCondition <: Condition
    file::String
    field::String
    value::String
    same_file::Bool
end

"""
    FileRelation

Represents a file's conditional requirement.

# Fields
- `required::Bool`: Whether the file is required when conditions are met
- `forbidden::Bool`: Whether the file is forbidden when conditions are met
- `when_all_conditions::Vector{Condition}`: Conditions that must all be true

# Logic
- `required=true, forbidden=false` → file is required when conditions are met
- `required=false, forbidden=true` → file is forbidden when conditions are met
- `required=false, forbidden=false` → file is optional
- Both `required` and `forbidden` true is invalid
"""
struct FileRelation
    required::Bool
    forbidden::Bool
    when_all_conditions::Vector{Condition}
end

"""
    FileRelations

Groups file relations by filename and presence type.

# Fields
- `filename::String`: The GTFS file name
- `presence::String`: The presence type
- `conditions::Vector{FileRelation}`: List of file relations
"""
struct FileRelations
    filename::String
    presence::String
    conditions::Vector{FileRelation}
end



# =============================================================================
# CONDITION PARSING
# =============================================================================

"""
    parse_file_level_condition_line(line::String, presence::String, field_to_file::Dict{String, String}) -> Union{FileRelation, Nothing}

Parse a single condition line into a FileRelation.

# Arguments
- `line::String`: The condition line text
- `presence::String`: The presence type (e.g., "Conditionally Required")
- `field_to_file::Dict{String, String}`: Mapping of field names to file names

# Returns
- `Union{FileRelation, Nothing}`: Parsed file relation or nothing if parsing fails
"""
function parse_file_level_condition_line(line::String, presence::String, field_to_file::Dict{String, String})
    if isempty(line)
        return nothing
    end

    # Determine requirement flags based on presence type
    required, forbidden = parse_presence_flags(presence)

    # Extract file and field references
    file_references = extract_file_references(line)
    field_references = extract_field_references(line)

    # Parse conditions
    conditions = parse_conditions_from_references(line, file_references, field_references, field_to_file)

    if isempty(conditions)
        return nothing
    end

    return FileRelation(required, forbidden, conditions)
end


"""
    parse_conditions_from_references(line::String, file_references::Vector{String}, field_references::Vector{String}, field_to_file::Dict{String, String}) -> Vector{Condition}

Parse file and field references into condition objects.

# Arguments
- `line::String`: The original condition line for context
- `file_references::Vector{String}`: List of file references found
- `field_references::Vector{String}`: List of field references found
- `field_to_file::Dict{String, String}`: Mapping of field names to file names

# Returns
- `Vector{Condition}`: List of parsed conditions
"""
function parse_conditions_from_references(line::String, file_references::Vector{String}, field_references::Vector{String}, field_to_file::Dict{String, String})
    conditions = Condition[]

    # Parse file conditions
    for file_ref in file_references
        file_condition = parse_file_condition(line, file_ref)
        if file_condition !== nothing
            push!(conditions, file_condition)
        end
    end

    # Parse field conditions
    for field_ref in field_references
        field_condition = parse_field_condition(field_ref, field_to_file)
        if field_condition !== nothing
            push!(conditions, field_condition)
        end
    end

    return conditions
end

"""
    parse_file_condition(line::String, file_ref::String) -> Union{FileCondition, Nothing}

Parse a file reference into a FileCondition.

# Arguments
- `line::String`: The condition line for context
- `file_ref::String`: The file reference

# Returns
- `Union{FileCondition, Nothing}`: Parsed file condition or nothing if invalid
"""
function parse_file_condition(line::String, file_ref::String)
    if isempty(file_ref)
        return nothing
    end

    # Determine if file must exist or not based on context
    must_exist = determine_file_existence_requirement(line)

    return FileCondition(file_ref, must_exist)
end

"""
    determine_file_existence_requirement(line::String) -> Bool

Determine if a file must exist based on the condition line context.

# Arguments
- `line::String`: The condition line

# Returns
- `Bool`: true if file must exist, false if file must not exist
"""
function determine_file_existence_requirement(line::String)
    line_lower = lowercase(line)

    # Check for negative indicators
    negative_indicators = ["omitted", "is not", "not defined", "not provided"]
    if any(occursin(indicator, line_lower) for indicator in negative_indicators)
        return false
    end

    # Default to file must exist
    return true
end

"""
    parse_field_condition(field_ref::String, field_to_file::Dict{String, String}) -> Union{FileFieldCondition, Nothing}

Parse a field reference into a FileFieldCondition.

# Arguments
- `field_ref::String`: The field reference
- `field_to_file::Dict{String, String}`: Mapping of field names to file names

# Returns
- `Union{FileFieldCondition, Nothing}`: Parsed field condition or nothing if invalid
"""
function parse_field_condition(field_ref::String, field_to_file::Dict{String, String})
    if isempty(field_ref)
        return nothing
    end

    # Parse field name and value
    field_name, field_value = parse_field_name_and_value(field_ref)
    if isempty(field_name)
        return nothing
    end

    # Determine file context
    file_name = get(field_to_file, field_name, "")
    same_file = !isempty(file_name)

    return FileFieldCondition(file_name, field_name, field_value, same_file)
end

# =============================================================================
# MAIN EXTRACTION FUNCTIONS
# =============================================================================

"""
    parse_file_level_conditional_requirements(dataset_file, field_to_file::Dict{String, String}, conditionally_required::String, conditionally_forbidden::String) -> Vector{FileRelation}

Parse file-level conditional requirements from a dataset file definition.

# Arguments
- `dataset_file`: Dataset file definition to process
- `field_to_file::Dict{String, String}`: Mapping of field names to file names
- `conditionally_required::String`: Presence type for conditionally required files
- `conditionally_forbidden::String`: Presence type for conditionally forbidden files

# Returns
- `Vector{FileRelation}`: List of file relations with conditional requirements
"""
function parse_file_level_conditional_requirements(dataset_file, field_to_file::Dict{String, String}, conditionally_required::String, conditionally_forbidden::String)
    if !(dataset_file.presence in [conditionally_required, conditionally_forbidden])
        return FileRelation[]
    end

    section = extract_condition_section(dataset_file.description, ["Conditionally Required:", "Conditionally Forbidden:"])
    if isempty(section)
        return FileRelation[]
    end

    # Parse condition lines
    condition_lines = parse_condition_lines(section)
    conditions = FileRelation[]

    for line in condition_lines
        file_relation = parse_file_level_condition_line(line, dataset_file.presence, field_to_file)
        if file_relation !== nothing
            push!(conditions, file_relation)
        end
    end

    return conditions
end


"""
    to_parsed_file_level_conditions(dataset_file, field_to_file::Dict{String, String}, conditionally_required::String, conditionally_forbidden::String) -> FileRelations

Convert a DatasetFileDefinition to a FileRelations with parsed conditions.

# Arguments
- `dataset_file`: Dataset file definition to convert
- `field_to_file::Dict{String, String}`: Mapping of field names to file names
- `conditionally_required::String`: Presence type for conditionally required files
- `conditionally_forbidden::String`: Presence type for conditionally forbidden files

# Returns
- `FileRelations`: File relations with parsed conditions
"""
function to_parsed_file_level_conditions(dataset_file, field_to_file::Dict{String, String}, conditionally_required::String, conditionally_forbidden::String)
    conditions = parse_file_level_conditional_requirements(dataset_file, field_to_file, conditionally_required, conditionally_forbidden)
    return FileRelations(
        dataset_file.filename,
        dataset_file.presence,
        conditions
    )
end

"""
    extract_all_file_conditions(dataset_files::Vector, file_definitions::Vector, presence_types::Vector=PresenceInfo[]) -> Vector{FileRelations}

Extract file-level conditional requirements for all dataset files.

# Arguments
- `dataset_files::Vector`: List of dataset file definitions to process
- `file_definitions::Vector`: List of file definitions for field mapping
- `presence_types::Vector=PresenceInfo[]`: List of presence types for validation

# Returns
- `Vector{FileRelations}`: List of file relations grouped by file
"""
function extract_all_file_conditions(dataset_files::Vector, file_definitions::Vector, presence_types::Vector=PresenceInfo[])
    if isempty(dataset_files)
        return FileRelations[]
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

    # Build field to file lookup dictionary
    field_to_file = build_field_to_file_mapping(file_definitions)

    # Process each dataset file
    result = FileRelations[]
    for dataset_file in dataset_files
        file_relations = to_parsed_file_level_conditions(dataset_file, field_to_file, conditionally_required, conditionally_forbidden)
        push!(result, file_relations)
    end

    return result
end
