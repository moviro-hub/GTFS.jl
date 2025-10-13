"""
GTFS Specification Parser Module

Clean, straightforward parsing of the GTFS specification markdown file.
"""

include("types.jl")

"""
    parse_gtfs_specification(markdown_content::String) -> (Vector{DatasetFileDefinition}, Vector{FileDefinition})

Parse the complete GTFS specification markdown content and extract all file definitions.

# Arguments
- `markdown_content::String`: The markdown content of the GTFS specification

# Returns
- `Tuple{Vector{DatasetFileDefinition}, Vector{FileDefinition}}`: Dataset files and field definitions

# Process
1. Parse dataset files from "Dataset Files" section
2. Parse field definitions from "Field Definitions" section
3. Return both structures
"""
function parse_gtfs_specification(markdown_content::String)
    lines = String.(split(markdown_content, '\n'))

    # Step 1: Parse dataset files from Dataset Files section
    dataset_files = parse_dataset_files(lines)

    # Step 2: Create file requirements lookup
    file_requirements = Dict(df.filename => df.presence for df in dataset_files)

    # Step 3: Parse field definitions from Field Definitions section
    file_definitions = parse_field_definitions(lines, file_requirements)

    return (dataset_files, file_definitions)
end

"""
    parse_dataset_files(lines::Vector{String}) -> Vector{DatasetFileDefinition}

Parse dataset files from the "Dataset Files" section.

# Arguments
- `lines::Vector{String}`: Lines of the markdown file

# Returns
- `Vector{DatasetFileDefinition}`: Vector of dataset file definitions
"""
function parse_dataset_files(lines::Vector{String})
    dataset_files = DatasetFileDefinition[]

    in_dataset_files_section = false
    table_started = false

    for (i, line) in enumerate(lines)
        stripped_line = strip(line)

        # Check if we're in the Dataset Files section
        if occursin("## Dataset Files", stripped_line)
            in_dataset_files_section = true
            continue
        end

        # Stop parsing if we've left the Dataset Files section
        if in_dataset_files_section && startswith(stripped_line, "## ") && !occursin("Dataset Files", stripped_line)
            break
        end

        if !in_dataset_files_section
            continue
        end

        # Find and parse the table
        if !table_started
            table_info = find_table_start(lines, i, 10)
            if table_info !== nothing
                table_started = true
                continue
            end
        end

        # Parse table rows
        if table_started && startswith(stripped_line, "|")
            row_data = parse_table_row(line, 3)
            if row_data !== nothing && length(row_data) >= 3
                filename = extract_filename_from_markdown_link(String(row_data[1]))
                presence = clean_presence(String(row_data[2]))
                description = String(row_data[3])

                if !isempty(filename) && !isempty(presence)
                    dataset_file = DatasetFileDefinition(filename, presence, description)
                    push!(dataset_files, dataset_file)
                end
            end
        end
    end

    return dataset_files
end

"""
    parse_file_requirements(lines::Vector{String}) -> Dict{String, String}

Parse file requirements from the "Dataset Files" section.
DEPRECATED: Use parse_dataset_files() instead.

# Arguments
- `lines::Vector{String}`: Lines of the markdown file

# Returns
- `Dict{String, String}`: Mapping from filename to requirement level
"""
function parse_file_requirements(lines::Vector{String})
    file_requirements = Dict{String, String}()

    in_dataset_files_section = false
    in_table = false
    table_header_found = false
    table_separator_found = false

    for (i, line) in enumerate(lines)
        stripped_line = strip(line)

        # Check if we're in the Dataset Files section
        if occursin("## Dataset Files", stripped_line)
            in_dataset_files_section = true
            continue
        end

        # Stop parsing if we've left the Dataset Files section
        if in_dataset_files_section && startswith(stripped_line, "## ") && !occursin("Dataset Files", stripped_line)
            break
        end

        if !in_dataset_files_section
            continue
        end

        # Look for table headers
        if !in_table && occursin("File Name", stripped_line) && occursin("Presence", stripped_line)
            in_table = true
            table_header_found = true
            continue
        end

        # Look for table separator
        if in_table && table_header_found && !table_separator_found &&
           (startswith(stripped_line, "|--") || occursin("---", stripped_line))
            table_separator_found = true
            continue
        end

        # Parse table rows
        if in_table && table_header_found && table_separator_found && startswith(stripped_line, "|")
            parts = split(line, "|")
            if length(parts) >= 4  # The table has 4 columns: empty, File Name, Presence, Description
                filename_part = strip(parts[2])
                presence_part = strip(parts[3])

                # Extract filename from markdown link
                filename = extract_filename_from_markdown_link(String(filename_part))

                # Extract requirement level
                requirement = extract_requirement_level(String(presence_part))

                if !isempty(filename) && !isempty(requirement)
                    file_requirements[filename] = requirement
                end
            end
        end
    end

    return file_requirements
end

"""
    parse_field_definitions(lines::Vector{String}, file_requirements::Dict{String, String}) -> Vector{FileDefinition}

Parse field definitions from the "Field Definitions" section.

# Arguments
- `lines::Vector{String}`: Lines of the markdown file
- `file_requirements::Dict{String, String}`: File requirements from Dataset Files section

# Returns
- `Vector{FileDefinition}`: Vector of parsed file definitions
"""
function parse_field_definitions(lines::Vector{String}, file_requirements::Dict{String, String})
    file_definitions = FileDefinition[]

    in_field_definitions_section = false
    current_file = nothing
    current_file_fields = FieldDefinition[]
    current_primary_key = ""

    for (i, line) in enumerate(lines)
        stripped_line = strip(line)

        # Check if we're in the Field Definitions section
        if occursin("## Field Definitions", stripped_line)
            in_field_definitions_section = true
            continue
        end

        # Stop parsing if we've left the Field Definitions section
        if in_field_definitions_section && startswith(stripped_line, "## ") && !occursin("Field Definitions", stripped_line)
            break
        end

        if !in_field_definitions_section
            continue
        end

        # Look for file headers (e.g., "### agency.txt" or "### locations.geojson")
        if startswith(stripped_line, "### ") && (endswith(stripped_line, ".txt") || endswith(stripped_line, ".geojson"))
            # Save previous file if it exists
            if current_file !== nothing && !isempty(current_file_fields)
                file_def = create_file_definition(current_file, current_file_fields, file_requirements, current_primary_key)
                push!(file_definitions, file_def)
            end

            # Start new file
            current_file = replace(stripped_line, "### " => "")
            current_file_fields = FieldDefinition[]
            current_primary_key = ""
            continue
        end

        # Look for primary key line
        if current_file !== nothing && occursin("Primary key", stripped_line)
            # Extract primary key from the line
            # Format: "Primary key (`agency_id`)" or "Primary key (`trip_id`, `stop_sequence`)"
            primary_key_match = match(r"Primary key \(`([^`]+(?:`, `[^`]+)*)`\)", stripped_line)
            if primary_key_match !== nothing
                current_primary_key = String(primary_key_match[1])
            end
            continue
        end

        # Look for field table and parse it
        if current_file !== nothing && isempty(current_file_fields)
            fields = parse_field_table(lines, i)
            if !isempty(fields)
                current_file_fields = fields
            end
        end
    end

    # Save the last file if it exists
    if current_file !== nothing && !isempty(current_file_fields)
        file_def = create_file_definition(current_file, current_file_fields, file_requirements, current_primary_key)
        push!(file_definitions, file_def)
    end

    return file_definitions
end

"""
    parse_field_table(lines::Vector{String}, start_line::Int) -> Vector{FieldDefinition}

Parse a field table starting from the given line.

# Arguments
- `lines::Vector{String}`: All lines of the markdown file
- `start_line::Int`: Line number to start parsing from

# Returns
- `Vector{FieldDefinition}`: Parsed field definitions
"""
function parse_field_table(lines::Vector{String}, start_line::Int)
    fields = FieldDefinition[]

    # Look for table header
    table_header_found = false
    table_separator_found = false

    for i in start_line:min(start_line + 50, length(lines))  # Look ahead up to 50 lines
        line = lines[i]
        stripped_line = strip(line)

        # Stop if we hit another file section
        if startswith(stripped_line, "### ") && (endswith(stripped_line, ".txt") || endswith(stripped_line, ".geojson"))
            break
        end

        # Look for table headers
        if !table_header_found && occursin("Field Name", stripped_line) &&
           (occursin("Type", stripped_line) || occursin("Presence", stripped_line))
            table_header_found = true
            continue
        end

        # Look for table separator
        if table_header_found && !table_separator_found &&
           (startswith(stripped_line, "|--") || occursin("---", stripped_line))
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

        # Stop if we hit another section after finding and parsing the table
        if table_header_found && table_separator_found && !isempty(fields) &&
           (isempty(stripped_line) || startswith(stripped_line, "###"))
            break
        end
    end

    return fields
end

"""
    parse_field_row(line::String) -> Union{FieldDefinition, Nothing}

Parse a single field row from the table.

# Arguments
- `line::String`: The table row line

# Returns
- `Union{FieldDefinition, Nothing}`: Parsed field definition or nothing if invalid
"""
function parse_field_row(line::String)
    parts = split(line, "|")

    # Clean up parts and ensure we have enough columns
    cleaned_parts = [strip(part) for part in parts if !isempty(strip(part))]

    if length(cleaned_parts) >= 3  # At least Field Name, Type, Presence
        field_name = replace(cleaned_parts[1], "`" => "")  # Remove backticks from field names
        field_type = cleaned_parts[2]
        presence = length(cleaned_parts) >= 3 ? cleaned_parts[3] : ""
        description = length(cleaned_parts) >= 4 ? cleaned_parts[4] : ""

        # Skip header rows
        if occursin("Field Name", field_name) || occursin("---", field_name) ||
           occursin("Type", field_name) || occursin("Presence", field_name) ||
           occursin("Description", field_name)
            return nothing
        end

        # Validate required fields
        if isempty(field_name) || isempty(field_type)
            return nothing
        end

        # Handle missing presence
        if isempty(presence)
            presence = "Unknown"
            println("Warning: Missing presence for field '$field_name'")
        end

        # Remove markdown formatting from presence
        presence = replace(presence, "**" => "")

        # Handle missing description
        if isempty(description)
            description = "No description available"
        end

        return FieldDefinition(field_name, field_type, presence, description)
    end

    return nothing
end

"""
    create_file_definition(filename::String, fields::Vector{FieldDefinition},
                          file_requirements::Dict{String, String}, primary_key::String) -> FileDefinition

Create a FileDefinition from parsed data.

# Arguments
- `filename::String`: The filename
- `fields::Vector{FieldDefinition}`: The parsed fields
- `file_requirements::Dict{String, String}`: File requirements lookup
- `primary_key::String`: The primary key specification

# Returns
- `FileDefinition`: The created file definition
"""
function create_file_definition(filename::String, fields::Vector{FieldDefinition},
                               file_requirements::Dict{String, String}, primary_key::String)
    # Get file requirement
    file_requirement = get(file_requirements, filename, "Unknown")

    # Use the provided primary key, or fallback to first field if empty
    final_primary_key = if !isempty(primary_key)
        primary_key
    elseif !isempty(fields)
        fields[1].field_name
    else
        "unknown"
    end

    return FileDefinition(filename, file_requirement, final_primary_key, fields)
end

"""
    extract_filename_from_markdown_link(markdown_link::String) -> String

Extract filename from markdown link format.

# Arguments
- `markdown_link::String`: Markdown link like "[agency.txt](#agencytxt)"

# Returns
- `String`: Extracted filename
"""
function extract_filename_from_markdown_link(markdown_link::String)
    if occursin("[", markdown_link) && occursin("]", markdown_link)
        # Extract from [filename.txt](#filename)
        start_idx = findfirst("[", markdown_link)
        end_idx = findfirst("]", markdown_link)
        if start_idx !== nothing && end_idx !== nothing
            return markdown_link[start_idx[1]+1:end_idx[1]-1]
        end
    end
    return markdown_link
end

"""
    extract_requirement_level(presence_text::String) -> String

Extract requirement level from presence text.

# Arguments
- `presence_text::String`: Presence text like "**Required**"

# Returns
- `String`: Extracted requirement level
"""
function extract_requirement_level(presence_text::String)
    return clean_presence(presence_text)
end

"""
    clean_presence(presence_text::String) -> String

Clean and normalize presence/requirement text.

# Arguments
- `presence_text::String`: Raw presence text like "**Required**"

# Returns
- `String`: Cleaned presence level
"""
function clean_presence(presence_text::String)
    # Remove markdown formatting
    clean_text = replace(presence_text, "**" => "")
    clean_text = strip(clean_text)

    # Map to standard requirement levels
    if occursin("Required", clean_text) && !occursin("Conditionally", clean_text)
        return "Required"
    elseif occursin("Conditionally Required", clean_text)
        return "Conditionally Required"
    elseif occursin("Conditionally Forbidden", clean_text)
        return "Conditionally Forbidden"
    elseif occursin("Optional", clean_text)
        return "Optional"
    else
        return "Unknown"
    end
end

"""
    find_table_start(lines::Vector{String}, start_line::Int, max_lookahead::Int) -> Union{Nothing, Tuple{Int, Int}}

Find the start of a markdown table (header and separator).

# Arguments
- `lines::Vector{String}`: All lines of the markdown file
- `start_line::Int`: Line to start searching from
- `max_lookahead::Int`: Maximum number of lines to look ahead

# Returns
- `Union{Nothing, Tuple{Int, Int}}`: Nothing if not found, or (header_line, separator_line) if found
"""
function find_table_start(lines::Vector{String}, start_line::Int, max_lookahead::Int)
    header_line = nothing
    separator_line = nothing

    for i in start_line:min(start_line + max_lookahead, length(lines))
        stripped = strip(lines[i])

        # Look for table header
        if header_line === nothing && startswith(stripped, "|") && occursin("|", stripped[2:end])
            header_line = i
            continue
        end

        # Look for separator after header
        if header_line !== nothing && separator_line === nothing &&
           (startswith(stripped, "|--") || (startswith(stripped, "|") && occursin("---", stripped)))
            separator_line = i
            return (header_line, separator_line)
        end
    end

    return nothing
end

"""
    parse_table_row(line::String, expected_columns::Int) -> Union{Vector{String}, Nothing}

Parse a markdown table row into its column values.

# Arguments
- `line::String`: The table row line
- `expected_columns::Int`: Expected number of columns

# Returns
- `Union{Vector{String}, Nothing}`: Vector of column values, or nothing if invalid
"""
function parse_table_row(line::String, expected_columns::Int)
    parts = split(line, "|")

    # Clean up parts
    cleaned_parts = [strip(part) for part in parts if !isempty(strip(part))]

    # Check if this is a header or separator row
    if length(cleaned_parts) > 0
        first_part = cleaned_parts[1]
        if occursin("---", first_part) ||
           occursin("Field Name", first_part) ||
           occursin("File Name", first_part) ||
           occursin("Type", first_part) ||
           occursin("Presence", first_part) ||
           occursin("Description", first_part)
            return nothing
        end
    end

    # Must have at least expected_columns
    if length(cleaned_parts) < expected_columns
        return nothing
    end

    return cleaned_parts[1:expected_columns]
end
