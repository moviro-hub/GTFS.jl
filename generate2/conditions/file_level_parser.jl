"""
File-Level Condition Parser

Parses conditional requirements for GTFS dataset files
(determines when entire files are required or optional).
"""

include("condition_types.jl")
include("condition_utils.jl")

"""
    extract_condition_section(description::String) -> String

Extract the "Conditionally Required:" section from a file description.
"""
function extract_condition_section(description::String)
    # Find the start of the conditionally required section
    # Handle both "Conditionally Required:" and "Conditionally Forbidden:"
    patterns = [r"Conditionally Required:", r"Conditionally Forbidden:"]

    for pattern in patterns
        match_result = findfirst(pattern, description)
        if match_result !== nothing
            # Extract everything after the pattern
            start_pos = last(match_result)
            section = description[start_pos:end]

            # Clean up HTML tags and normalize
            section = replace(section, "<br>" => "\n")
            section = replace(section, "<br><br>" => "\n")

            return section
        end
    end

    return ""
end

"""
    parse_file_level_condition_line(line::String, presence::String) -> Union{FileRelation, Nothing}

Parse a single condition line into a FileRelation.
"""
function parse_file_level_condition_line(line::String, presence::String)
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

    # Extract references
    files = extract_file_references(line)
    fields = extract_field_references(line)

    # Build condition vector
    conditions = Condition[]

    # Parse file conditions
    for file in files
        if occursin("omitted", lowercase(line)) || occursin("is not", lowercase(line))
            push!(conditions, FileCondition(file, false))  # file must not exist
        else
            push!(conditions, FileCondition(file, true))   # file must exist
        end
    end

    # Special handling for GeoJSON files
    # Check if this condition mentions locations.geojson specifically
    if occursin(r"locations\.geojson", line)
        # For GeoJSON files, we need to check if they have content/features
        if occursin("defined", lowercase(line)) || occursin("provided", lowercase(line))
            push!(conditions, FileCondition("locations.geojson", true))
        elseif occursin("not defined", lowercase(line)) || occursin("not provided", lowercase(line))
            push!(conditions, FileCondition("locations.geojson", false))
        end
    end

    # Parse field conditions
    for field_str in fields
        if occursin("=", field_str)
            parts = split(field_str, "=")
            if length(parts) >= 2
                field_name = String(strip(parts[1]))
                field_value = String(strip(parts[2]))
                inferred_file = infer_file_from_field(field_name, files)
                push!(conditions, FieldCondition(inferred_file, field_name, field_value, false))
            end
        end
    end

    if isempty(conditions)
        return nothing
    end

    return FileRelation(required, forbidden, conditions)
end

"""
    parse_file_level_conditional_requirements(dataset_file::DatasetFileDefinition) -> Vector{FileRelation}

Parse file-level conditional requirements from a dataset file definition.
"""
function parse_file_level_conditional_requirements(dataset_file::DatasetFileDefinition)
    if !(dataset_file.presence in ["Conditionally Required", "Conditionally Forbidden"])
        return FileRelation[]
    end

    section = extract_condition_section(dataset_file.description)
    if isempty(section)
        return FileRelation[]
    end

    lines = filter(!isempty, strip.(split(section, r"<br>|\n")))

    conditions = FileRelation[]

    for line in lines
        line_str = String(line)  # Convert SubString to String
        if !startswith(line_str, "-")
            continue
        end

        # Parse the line
        cond = parse_file_level_condition_line(line_str, dataset_file.presence)
        if cond !== nothing
            push!(conditions, cond)
        end
    end

    return conditions
end

"""
    to_parsed_file_level_conditions(dataset_file::DatasetFileDefinition) -> ParsedFileLevelConditions

Convert a DatasetFileDefinition to a ParsedFileLevelConditions with parsed conditions.
"""
function to_parsed_file_level_conditions(dataset_file::DatasetFileDefinition)
    conditions = parse_file_level_conditional_requirements(dataset_file)
    return ParsedFileLevelConditions(
        dataset_file.filename,
        dataset_file.presence,
        conditions
    )
end

"""
    parse_all_file_level_conditions(dataset_files::Vector{DatasetFileDefinition}) -> Vector{ParsedFileLevelConditions}

Parse file-level conditional requirements for all dataset files.
"""
function parse_all_file_level_conditions(dataset_files::Vector{DatasetFileDefinition})
    return [to_parsed_file_level_conditions(df) for df in dataset_files]
end


# Exports
export extract_condition_section
export parse_file_level_condition_line
export parse_file_level_conditional_requirements
export to_parsed_file_level_conditions
export parse_all_file_level_conditions
