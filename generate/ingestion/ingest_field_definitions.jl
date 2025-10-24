"""
    Field Definitions Ingestion

Parses field definitions from the GTFS specification markdown.
Extracts field information including names, types, presence requirements, and descriptions.
"""

# =============================================================================
# DATA STRUCTURES
# =============================================================================

"""
    FieldDefinition

Represents a single field definition from the GTFS specification.

# Fields
- `fieldname::String`: The field name
- `field_type::String`: The field type (e.g., "Text", "Enum", "ID")
- `presence::String`: The presence requirement (e.g., "Required", "Optional")
- `description::String`: The field description
"""
struct FieldDefinition
    fieldname::String
    field_type::String
    presence::String
    description::String
end

"""
    FileDefinition

Represents a GTFS file definition with its fields and metadata.

# Fields
- `filename::String`: The GTFS file name (e.g., "stops.txt")
- `primary_key::String`: The primary key field name
- `fields::Vector{FieldDefinition}`: List of field definitions for this file
"""
struct FileDefinition
    filename::String
    primary_key::String
    fields::Vector{FieldDefinition}
end

# =============================================================================
# MAIN PARSING FUNCTIONS
# =============================================================================

"""
    parse_field_definitions(lines::Vector{String}) -> Vector{FileDefinition}

Parse field definitions from the "Field Definitions" section.

# Arguments
- `lines::Vector{String}`: Lines from the GTFS specification markdown

# Returns
- `Vector{FileDefinition}`: List of file definitions with their fields

# Examples
```julia
julia> parse_field_definitions(lines)
[FileDefinition("stops.txt", "stop_id", [...]), ...]
```
"""
function parse_field_definitions(lines::Vector{String})
    if isempty(lines)
        return FileDefinition[]
    end

    file_definitions = FileDefinition[]
    in_section = false
    current_file = nothing
    current_file_fields = FieldDefinition[]
    current_primary_key = ""

    for (i, line) in enumerate(lines)
        stripped_line = strip(line)

        # Check for section start
        if is_section_header(line, "Field Definitions", 2)
            in_section = true
            continue
        end

        # Check for section end - only break on level 2 headers that are not Field Definitions
        if in_section && startswith(stripped_line, "## ") && !occursin("Field Definitions", stripped_line)
            break
        end

        if !in_section
            continue
        end

        # Check for new file definition
        if is_file_header_line(String(stripped_line))
            # Save previous file if it exists
            if current_file !== nothing && !isempty(current_file_fields)
                file_def = create_file_definition(current_file, current_file_fields, current_primary_key)
                push!(file_definitions, file_def)
            end

            # Start new file
            current_file = extract_filename_from_header(String(stripped_line))
            current_file_fields = FieldDefinition[]
            current_primary_key = ""
            continue
        end

        # Extract primary key
        if current_file !== nothing && occursin("Primary key", stripped_line)
            primary_key_match = match(PRIMARY_KEY_PATTERN, stripped_line)
            if primary_key_match !== nothing
                current_primary_key = String(primary_key_match[1])
            end
            continue
        end

        # Parse field table for current file
        if current_file !== nothing && isempty(current_file_fields)
            fields = parse_field_table(lines, i + 1)
            if !isempty(fields)
                current_file_fields = fields
            end
        end
    end

    # Add final file definition
    if current_file !== nothing && !isempty(current_file_fields)
        file_def = create_file_definition(current_file, current_file_fields, current_primary_key)
        push!(file_definitions, file_def)
    end

    return file_definitions
end

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

"""
    is_file_header_line(line::String) -> Bool

Check if a line is a file header (starts with ### and ends with .txt or .geojson).

# Arguments
- `line::String`: The line to check

# Returns
- `Bool`: Whether the line is a file header
"""
function is_file_header_line(line::String)
    if isempty(line)
        return false
    end

    return startswith(line, "### ") && (endswith(line, ".txt") || endswith(line, ".geojson"))
end

"""
    extract_filename_from_header(header_line::String) -> String

Extract filename from a file header line.

# Arguments
- `header_line::String`: The header line (e.g., "### stops.txt")

# Returns
- `String`: The extracted filename
"""
function extract_filename_from_header(header_line::String)
    return replace(header_line, "### " => "")
end

"""
    create_file_definition(filename::String, fields::Vector{FieldDefinition}, primary_key::String) -> FileDefinition

Create a FileDefinition from parsed data.

# Arguments
- `filename::String`: The file name
- `fields::Vector{FieldDefinition}`: List of field definitions
- `primary_key::String`: The primary key field name

# Returns
- `FileDefinition`: The created file definition
"""
function create_file_definition(filename::String, fields::Vector{FieldDefinition}, primary_key::String)
    return FileDefinition(filename, primary_key, fields)
end

"""
    parse_field_table(lines::Vector{String}, start_line::Int) -> Vector{FieldDefinition}

Parse a field table starting from the given line.

# Arguments
- `lines::Vector{String}`: Lines to search through
- `start_line::Int`: Starting line index

# Returns
- `Vector{FieldDefinition}`: List of parsed field definitions
"""
function parse_field_table(lines::Vector{String}, start_line::Int)
    if isempty(lines) || start_line < 1 || start_line > length(lines)
        return FieldDefinition[]
    end

    fields = FieldDefinition[]
    table_header_found = false
    table_separator_found = false
    end_line = min(start_line + 50, length(lines))

    for i in start_line:end_line
        line = lines[i]
        stripped_line = strip(line)

        # Stop at next file definition
        if is_file_header_line(String(stripped_line))
            break
        end

        # Find table header
        if !table_header_found && is_field_table_header(String(stripped_line))
            table_header_found = true
            continue
        end

        # Find table separator
        if table_header_found && !table_separator_found && is_table_separator_line(String(stripped_line))
            table_separator_found = true
            continue
        end

        # Parse table rows
        if table_header_found && table_separator_found && startswith(stripped_line, "|")
            field = parse_field_row(line)
            if field !== nothing
                push!(fields, field)
            end
        end

        # Stop at end of table
        if table_header_found && table_separator_found && !isempty(fields) &&
                (isempty(stripped_line) || startswith(stripped_line, "###"))
            break
        end
    end

    return fields
end

"""
    is_field_table_header(line::String) -> Bool

Check if a line is a field table header.

# Arguments
- `line::String`: The line to check

# Returns
- `Bool`: Whether the line is a field table header
"""
function is_field_table_header(line::String)
    if isempty(line)
        return false
    end

    return occursin("Field Name", line) && (occursin("Type", line) || occursin("Presence", line))
end

"""
    parse_field_row(line::String) -> Union{FieldDefinition, Nothing}

Parse a single field row from the table.

# Arguments
- `line::String`: The table row line to parse

# Returns
- `Union{FieldDefinition, Nothing}`: Parsed field definition or nothing if invalid

# Examples
```julia
julia> parse_field_row("| stop_id | ID | Required | Unique identifier |")
FieldDefinition("stop_id", "ID", "Required", "Unique identifier")
```
"""
function parse_field_row(line::String)
    if isempty(line)
        return nothing
    end

    parts = split(line, "|")
    cleaned_parts = [strip(part) for part in parts if !isempty(strip(part))]

    if length(cleaned_parts) < 3
        return nothing
    end

    fieldname = clean_field_name(String(cleaned_parts[1]))
    field_type = String(cleaned_parts[2])
    presence = length(cleaned_parts) >= 3 ? String(cleaned_parts[3]) : ""
    description = length(cleaned_parts) >= 4 ? String(cleaned_parts[4]) : ""

    # Skip header and separator rows
    if is_header_or_separator_row(String(cleaned_parts[1]))
        return nothing
    end

    # Validate required fields
    if isempty(fieldname) || isempty(field_type)
        return nothing
    end

    # Set defaults for optional fields
    if isempty(presence)
        presence = "Unknown"
    else
        presence = strip_markdown_bold(presence)
    end

    if isempty(description)
        description = "No description available"
    end

    return FieldDefinition(fieldname, field_type, presence, description)
end

"""
    clean_field_name(field_name::String) -> String

Clean up field name by removing backticks and other formatting.

# Arguments
- `field_name::String`: The raw field name

# Returns
- `String`: Cleaned field name
"""
function clean_field_name(field_name::String)
    return replace(field_name, "`" => "")
end
