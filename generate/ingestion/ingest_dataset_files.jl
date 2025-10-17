"""
    DatasetFileDefinition

Represents a GTFS file from the Dataset Files section.

# Fields
- `filename::String`: The GTFS file name (e.g., "agency.txt")
- `presence::String`: The presence requirement (e.g., "Required", "Optional")
- `description::String`: The file description
"""
struct DatasetFileDefinition
    filename::String
    presence::String
    description::String
end

"""
    parse_dataset_files(lines::Vector{String}, presence_types::Vector{PresenceInfo}) -> Vector{DatasetFileDefinition}

Parse dataset files from the "Dataset Files" section.

# Arguments
- `lines::Vector{String}`: Lines of the markdown file
- `presence_types::Vector{PresenceInfo}`: Available presence types for normalization

# Returns
- `Vector{DatasetFileDefinition}`: Vector of dataset file definitions
"""
function parse_dataset_files(lines::Vector{String}, presence_types::Vector{PresenceInfo})
    dataset_files = DatasetFileDefinition[]
    in_section = false
    table_started = false

    for (i, line) in enumerate(lines)
        stripped_line = strip(line)

        # Check for section start
        if is_section_header(line, "Dataset Files", 2)
            in_section = true
            continue
        end

        # Check for section end
        if in_section && is_section_boundary(line, 2) && !occursin("Dataset Files", stripped_line)
            break
        end

        if !in_section
            continue
        end

        # Find table start
        if !table_started
            table_info = find_markdown_table(lines, i, 10)
            if table_info !== nothing
                table_started = true
                continue
            end
        end

        # Parse table rows
        if table_started && startswith(stripped_line, "|")
            row_data = parse_markdown_row(line, true)
            if row_data !== nothing && length(row_data) >= 3
                filename = strip_markdown_link(String(row_data[1]))
                presence = normalize_presence(String(row_data[2]), presence_types)
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
