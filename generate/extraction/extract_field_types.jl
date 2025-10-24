"""
    Field Types Extraction

Extracts type information from GTFS specification field definitions.
Handles multiple types per field and maps them to primary and alternative types.
"""

# =============================================================================
# DATA STRUCTURES
# =============================================================================

"""
    FieldTypeInfo

Represents type information for a single field.

# Fields
- `fieldname::String`: The field name
- `primary_type::String`: The first matching type (primary type)
- `alternative_types::Vector{String}`: Remaining types from "or" patterns
"""
struct FieldTypeInfo
    fieldname::String
    primary_type::String
    alternative_types::Vector{String}
end

"""
    FileTypeInfo

Groups field type information by filename.

# Fields
- `filename::String`: The GTFS file name
- `fields::Vector{FieldTypeInfo}`: List of field type information for this file
"""
struct FileTypeInfo
    filename::String
    fields::Vector{FieldTypeInfo}
end

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================


"""
    extract_available_types(field_types::Dict{String,String}) -> Vector{String}

Extract type names from ingested field types.

# Arguments
- `field_types::Dict{String,String}`: Dictionary of type names to descriptions

# Returns
- `Vector{String}`: List of available type names
"""
function extract_available_types(field_types::Dict{String,String})
    return collect(keys(field_types))
end

"""
    find_exact_type_match(type_str::String, available_types::Vector{String}) -> Union{String, Nothing}

Find exact match for type string in available types (case-insensitive).

# Arguments
- `type_str::String`: The type string to match
- `available_types::Vector{String}`: List of available type names

# Returns
- `Union{String, Nothing}`: Matching type name or nothing if no exact match
"""
function find_exact_type_match(type_str::String, available_types::Vector{String})
    if isempty(type_str) || isempty(available_types)
        return nothing
    end

    type_lower = lowercase(type_str)
    for available_type in available_types
        if lowercase(available_type) == type_lower
            return available_type
        end
    end
    return nothing
end

"""
    find_partial_type_match(type_str::String, available_types::Vector{String}) -> Union{String, Nothing}

Find partial match for type string in available types (case-insensitive).
Prioritizes longer, more specific matches.

# Arguments
- `type_str::String`: The type string to match
- `available_types::Vector{String}`: List of available type names

# Returns
- `Union{String, Nothing}`: Matching type name or nothing if no partial match
"""
function find_partial_type_match(type_str::String, available_types::Vector{String})
    if isempty(type_str) || isempty(available_types)
        return nothing
    end

    type_lower = lowercase(type_str)
    # Sort by length (longest first) to prioritize more specific matches
    sorted_types = sort(available_types, by=length, rev=true)

    for available_type in sorted_types
        if occursin(lowercase(available_type), type_lower)
            return available_type
        end
    end
    return nothing
end

# =============================================================================
# TYPE PARSING
# =============================================================================

"""
    parse_type_string(field_type_str::String, available_types::Vector{String}) -> Tuple{Union{String,Nothing}, Vector{String}}

Parse field type string and return primary and alternative types.
Handles "or" patterns like "Text or URL or Email or Phone number".

# Arguments
- `field_type_str::String`: The field type string to parse
- `available_types::Vector{String}`: List of available type names

# Returns
- `Tuple{Union{String,Nothing}, Vector{String}}`: (primary_type, alternative_types)

# Examples
```julia
julia> parse_type_string("Text or URL", ["Text", "URL", "Email"])
("Text", ["URL"])

julia> parse_type_string("Text", ["Text", "URL"])
("Text", String[])
```
"""
function parse_type_string(field_type_str::String, available_types::Vector{String})
    if isempty(field_type_str) || isempty(available_types)
        return (nothing, String[])
    end

    field_lower = lowercase(field_type_str)

    # Handle Foreign ID referencing pattern
    if occursin("foreign id referencing", field_lower)
        return ("ID", String[])
    end

    # Handle "or" pattern
    if occursin(" or ", field_lower)
        return parse_or_pattern(field_type_str, available_types)
    end

    # Try exact match for single type
    exact_match = find_exact_type_match(field_type_str, available_types)
    if exact_match !== nothing
        return (exact_match, String[])
    end

    # Try partial match
    partial_match = find_partial_type_match(field_type_str, available_types)
    if partial_match !== nothing
        return (partial_match, String[])
    end

    return (nothing, String[])
end

"""
    parse_or_pattern(field_type_str::String, available_types::Vector{String}) -> Tuple{Union{String,Nothing}, Vector{String}}

Parse "or" pattern in field type string.

# Arguments
- `field_type_str::String`: The field type string with "or" pattern
- `available_types::Vector{String}`: List of available type names

# Returns
- `Tuple{Union{String,Nothing}, Vector{String}}`: (primary_type, alternative_types)
"""
function parse_or_pattern(field_type_str::String, available_types::Vector{String})
    field_lower = lowercase(field_type_str)
    parts = split(field_lower, " or ")
    matched_types = String[]

    for part in parts
        part_cleaned = String(strip(part))
        if isempty(part_cleaned)
            continue
        end

        matched = find_exact_type_match(part_cleaned, available_types)
        if matched !== nothing
            push!(matched_types, matched)
        end
    end

    if isempty(matched_types)
        return (nothing, String[])
    end

    # First match is primary, rest are alternatives
    return (matched_types[1], matched_types[2:end])
end

# =============================================================================
# MAIN EXTRACTION FUNCTIONS
# =============================================================================

"""
    extract_all_field_types(file_defs::Vector{FileDefinition}, field_types::Dict{String,String}, field_signs::Dict{String,String}) -> Vector{FileTypeInfo}

Extract type information for all fields in all files.

# Arguments
- `file_defs::Vector{FileDefinition}`: List of file definitions to process
- `field_types::Dict{String,String}`: Dictionary of type names to descriptions
- `field_signs::Dict{String,String}`: Dictionary of field signs (unused in current implementation)

# Returns
- `Vector{FileTypeInfo}`: List of file type information grouped by file
"""
function extract_all_field_types(file_defs::Vector{FileDefinition}, field_types::Dict{String,String}, field_signs::Dict{String,String})
    if isempty(file_defs)
        return FileTypeInfo[]
    end

    # Get all available types from ingested data
    available_types = extract_available_types(field_types)

    result = FileTypeInfo[]
    for file_def in file_defs
        # Skip non-txt files (e.g., .geojson)
        if !endswith(lowercase(file_def.filename), ".txt")
            continue
        end

        field_infos = extract_field_types_for_file(file_def, available_types)
        file_info = FileTypeInfo(file_def.filename, field_infos)
        push!(result, file_info)
    end

    return result
end

"""
    extract_field_types_for_file(file_def::FileDefinition, available_types::Vector{String}) -> Vector{FieldTypeInfo}

Extract type information for all fields in a single file.

# Arguments
- `file_def::FileDefinition`: The file definition to process
- `available_types::Vector{String}`: List of available type names

# Returns
- `Vector{FieldTypeInfo}`: List of field type information for this file
"""
function extract_field_types_for_file(file_def::FileDefinition, available_types::Vector{String})
    field_infos = FieldTypeInfo[]

    for field_def in file_def.fields
        # Parse the field type string
        primary_type, alternative_types = parse_type_string(field_def.field_type, available_types)

        # If no type found, use the original field type as fallback
        if primary_type === nothing
            primary_type = field_def.field_type
        end

        # Create field type info with cleaned field name
        field_info = FieldTypeInfo(
            clean_field_name(field_def.fieldname),
            primary_type,
            alternative_types
        )

        push!(field_infos, field_info)
    end

    return field_infos
end
