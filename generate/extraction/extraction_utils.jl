"""
    Extraction Utilities

Common utilities for extracting references and conditions from GTFS specification text.
Provides consistent patterns for file references, field references, and condition parsing.
"""

# =============================================================================
# REGEX PATTERNS
# =============================================================================

# Pattern for markdown file links: [filename.txt](#filename)
const MARKDOWN_FILE_PATTERN = r"\[([^\]]+\.(?:txt|geojson))\]\([^)]+\)"

# Pattern for plain text file references: locations.geojson
const PLAIN_FILE_PATTERN = r"\b([a-zA-Z_][a-zA-Z0-9_]*\.(?:txt|geojson))\b"

# Pattern for field references in backticks: `fieldname=value`
const BACKTICK_FIELD_PATTERN = r"`([^`]+)`"

# HTML break tags that need to be normalized
const HTML_BREAK_PATTERNS = ("<br><br>" => "\n", "<br>" => "\n")

# =============================================================================
# FILE REFERENCE EXTRACTION
# =============================================================================

"""
    extract_file_references(text::String) -> Vector{String}

Extract file references from GTFS specification text.

# Arguments
- `text::String`: Text to search for file references

# Returns
- `Vector{String}`: Unique list of file references found

# Examples
```julia
julia> extract_file_references("See [stops.txt](#stops) and locations.geojson")
["stops.txt", "locations.geojson"]
```
"""
function extract_file_references(text::String)
    if isempty(text)
        return String[]
    end

    files = String[]

    # Extract markdown file links: [filename.txt](#filename)
    for match in eachmatch(MARKDOWN_FILE_PATTERN, text)
        push!(files, match.captures[1])
    end

    # Extract plain text file references: locations.geojson
    for match in eachmatch(PLAIN_FILE_PATTERN, text)
        push!(files, match.captures[1])
    end

    return unique(files)
end

"""
    extract_field_references(text::String) -> Vector{String}

Extract field references from backtick-wrapped text in GTFS specification.

# Arguments
- `text::String`: Text to search for field references

# Returns
- `Vector{String}`: List of field references found

# Examples
```julia
julia> extract_field_references("When `location_type=0` or `location_type=1`")
["location_type=0", "location_type=1"]
```
"""
function extract_field_references(text::String)
    if isempty(text)
        return String[]
    end

    fields = String[]

    for match in eachmatch(BACKTICK_FIELD_PATTERN, text)
        push!(fields, match.captures[1])
    end

    return fields
end

# =============================================================================
# CONDITION EXTRACTION
# =============================================================================

"""
    extract_condition_section(text::String, markers::Vector{String}) -> String

Extract a condition section from text using the provided markers.

# Arguments
- `text::String`: Text to search for condition sections
- `markers::Vector{String}`: List of markers to search for (e.g., ["Conditionally Required:", "Conditionally Forbidden:"])

# Returns
- `String`: The condition section text with HTML breaks normalized to newlines, or empty string if no marker found

# Examples
```julia
julia> extract_condition_section("Conditionally Required:<br>- Required when...", ["Conditionally Required:"])
"Conditionally Required:\n- Required when..."
```
"""
function extract_condition_section(text::String, markers::Vector{String})
    if isempty(text) || isempty(markers)
        return ""
    end

    for marker in markers
        marker_position = findfirst(marker, text)
        if marker_position !== nothing
            section_start = last(marker_position)
            section_text = text[section_start:end]

            # Normalize HTML breaks to newlines
            for (html_break, newline) in HTML_BREAK_PATTERNS
                section_text = replace(section_text, html_break => newline)
            end

            return section_text
        end
    end

    return ""
end

# =============================================================================
# COMMON UTILITY FUNCTIONS
# =============================================================================

"""
    parse_presence_flags(presence::String) -> Tuple{Bool, Bool}

Parse presence type into required/forbidden flags.

# Arguments
- `presence::String`: The presence type

# Returns
- `Tuple{Bool, Bool}`: (required, forbidden) flags
"""
function parse_presence_flags(presence::String)
    if presence == "Conditionally Required"
        return true, false
    elseif presence == "Conditionally Forbidden"
        return false, true
    else
        return false, false
    end
end

"""
    parse_line_requirement_level(line::String, field_presence::String) -> Tuple{Bool, Bool}

Parse the requirement level (Required/Optional/Forbidden) from a condition line.

# Arguments
- `line::String`: The condition line text
- `field_presence::String`: The field's overall presence attribute

# Returns
- `Tuple{Bool, Bool}`: (required, forbidden) flags

# Logic
- If line contains "**Required**" or "Required" → (true, false)
- If line contains "**Forbidden**" or "Forbidden" → (false, true)
- If line contains "Optional" → (false, false) - will be skipped
- Otherwise, use field_presence as fallback
"""
function parse_line_requirement_level(line::String, field_presence::String)
    line_lower = lowercase(line)

    # Check for explicit requirement markers in the line
    if occursin(r"\*\*required\*\*|^-\s*required\s+for", line_lower)
        return true, false
    elseif occursin(r"\*\*forbidden\*\*|^-\s*forbidden\s+for", line_lower)
        return false, true
    elseif occursin(r"optional\s+for", line_lower)
        return false, false  # Will be skipped
    end

    # Fallback to field presence if no explicit marker
    return parse_presence_flags(field_presence)
end

"""
    parse_condition_lines(section::String) -> Vector{String}

Parse condition section into individual condition lines.

# Arguments
- `section::String`: Condition section text

# Returns
- `Vector{String}`: List of condition lines starting with "-"
"""
function parse_condition_lines(section::String)
    if isempty(section)
        return String[]
    end

    lines = filter(!isempty, strip.(split(section, r"<br>|\n")))
    condition_lines = String[]

    for line in lines
        line_str = String(line)
        if startswith(line_str, "-")
            push!(condition_lines, line_str)
        end
    end

    return condition_lines
end

"""
    clean_field_name(field_name::String) -> String

Clean up field names by removing HTML entities, whitespace, and formatting characters.

# Arguments
- `field_name::String`: The raw field name

# Returns
- `String`: Cleaned field name

# Examples
```julia
julia> clean_field_name("-&nbsp;stop_name")
"stop_name"

julia> clean_field_name("\\-&nbsp;&nbsp;&nbsp;&nbsp;type")
"type"
```
"""
function clean_field_name(field_name::String)
    if isempty(field_name)
        return ""
    end

    # Remove backticks (common in field names)
    cleaned = replace(field_name, "`" => "")

    # Remove HTML entities
    cleaned = replace(cleaned, "&nbsp;" => "")

    # Remove backslashes and dashes used for formatting
    cleaned = replace(cleaned, "\\-" => "")
    cleaned = replace(cleaned, "-" => "")

    # Remove leading/trailing whitespace and normalize internal whitespace
    cleaned = strip(cleaned)
    cleaned = replace(cleaned, r"\s+" => "_")  # Replace multiple spaces with underscore

    # Remove leading underscores that might result from cleaning
    cleaned = lstrip(cleaned, '_')

    return cleaned
end

# =============================================================================
# FIELD REFERENCE PARSING UTILITIES
# =============================================================================

"""
    is_valid_field_name(name::String) -> Bool

Validate that a field name is not just a number and contains at least one letter.

# Arguments
- `name::String`: Field name to validate

# Returns
- `Bool`: True if the field name is valid

# Examples
```julia
julia> is_valid_field_name("stop_id")
true

julia> is_valid_field_name("1")
false

julia> is_valid_field_name("route_type")
true
```
"""
function is_valid_field_name(name::String)
    # Must contain at least one letter and not be empty
    return !isempty(strip(name)) && occursin(r"[a-zA-Z]", name)
end

"""
    clean_field_name(field_name::String, condition_file::String, target_file::String) -> String

Clean field name by removing table prefixes for same-file conditions.

# Arguments
- `field_name::String`: Original field name
- `condition_file::String`: File containing the condition
- `target_file::String`: File being validated

# Returns
- `String`: Cleaned field name

# Examples
```julia
julia> clean_field_name("routes.route_long_name", "routes.txt", "routes.txt")
"route_long_name"

julia> clean_field_name("stop_times.stop_id", "routes.txt", "routes.txt")
"stop_times.stop_id"  # Cross-file reference, keep prefix
```
"""
function clean_field_name(field_name::String, condition_file::String, target_file::String)
    # If condition references the same file, remove table prefix
    if condition_file == target_file && occursin(".", field_name)
        parts = split(field_name, ".")
        # Return last part if it matches the table name prefix
        if length(parts) >= 2
            return parts[end]
        end
    end
    return field_name
end

"""
    parse_field_name_and_value(field_reference::String) -> Tuple{String, String}

Parse a field reference string to extract field name and value.

# Arguments
- `field_reference::String`: Field reference (e.g., "stop_id=1" or "route_type")

# Returns
- `Tuple{String, String}`: (field_name, field_value)

# Examples
```julia
julia> parse_field_name_and_value("stop_id=1")
("stop_id", "1")

julia> parse_field_name_and_value("route_type")
("route_type", "")
```
"""
function parse_field_name_and_value(field_reference::String)
    if isempty(field_reference)
        return "", ""
    end

    # Handle "field=value" pattern
    if occursin("=", field_reference)
        field_parts = split(field_reference, "=")
        if length(field_parts) >= 2
            field_name = strip(field_parts[1])
            field_value = strip(field_parts[2])
            return field_name, field_value
        else
            return "", ""
        end
    end

    # Handle "field is defined" or "field is empty" patterns
    # Check if the reference contains "is defined" or "is empty"
    field_lower = lowercase(field_reference)
    if occursin(r"is\s+defined", field_lower)
        # Extract field name before "is defined"
        field_name = strip(replace(field_reference, r"(?i)\s+is\s+defined.*" => ""))
        return field_name, "defined"
    elseif occursin(r"is\s+empty", field_lower)
        # Extract field name before "is empty"
        field_name = strip(replace(field_reference, r"(?i)\s+is\s+empty.*" => ""))
        return field_name, ""
    end

    # Validate field name - must contain at least one letter
    if !is_valid_field_name(field_reference)
        return "", ""
    end

    # Default: just field name, no value
    return field_reference, ""
end

"""
    parse_file_field_reference(field_reference::String, current_file::String) -> Tuple{String, String}

Parse file and field names from a field reference.

# Arguments
- `field_reference::String`: Field reference string
- `current_file::String`: Current file context

# Returns
- `Tuple{String, String}`: (file_name, field_name)

# Examples
```julia
julia> parse_file_field_reference("stop_times.stop_id", "routes.txt")
("stop_times.txt", "stop_id")

julia> parse_file_field_reference("route_type", "routes.txt")
("routes.txt", "route_type")
```
"""
function parse_file_field_reference(field_reference::String, current_file::String)
    # Handle cross-file references (e.g., "stop_times.stop_id")
    if occursin(".", field_reference)
        parts = split(field_reference, ".")
        if length(parts) >= 2
            ref_file = parts[1] * ".txt"
            ref_field = parts[2]
            return ref_file, ref_field
        end
    end

    # Same-file reference
    return current_file, field_reference
end

# =============================================================================
# FIELD-TO-FILE MAPPING UTILITIES
# =============================================================================

"""
    build_field_to_file_mapping(file_definitions::Vector) -> Dict{String, String}

Build a mapping from field names to file names.

# Arguments
- `file_definitions::Vector`: List of file definitions

# Returns
- `Dict{String, String}`: Mapping of field names to file names
"""
function build_field_to_file_mapping(file_definitions::Vector)
    field_to_file = Dict{String, String}()

    for file_def in file_definitions
        for field in file_def.fields
            field_to_file[field.fieldname] = file_def.filename
        end
    end

    return field_to_file
end

# =============================================================================
# COMMON ITERATION PATTERNS
# =============================================================================

"""
    iterate_all_fields(file_definitions::Vector{FileDefinition})

Iterator that yields (file_def, field) pairs for all fields in all file definitions.

# Arguments
- `file_definitions::Vector{FileDefinition}`: List of file definitions

# Returns
- Iterator yielding `(file_def::FileDefinition, field::FieldDefinition)` pairs
"""
function iterate_all_fields(file_definitions::Vector{FileDefinition})
    return ((file_def, field) for file_def in file_definitions for field in file_def.fields)
end
