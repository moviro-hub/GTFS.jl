"""
File Mapping Generator

Generates a mapping from GTFS file names to struct field names.
"""

include("../ingestion/types.jl")

"""
    filename_to_field_name(filename::String) -> Symbol

Convert a GTFS filename to a Julia struct field name.
"""
function filename_to_field_name(filename::String)
    # Remove .txt extension
    base_name = replace(filename, ".txt" => "")
    base_name = replace(base_name, ".geojson" => "_geojson")

    # Convert to snake_case if needed
    return Symbol(base_name)
end

"""
    generate_file_mapping(dataset_files::Vector{DatasetFileDefinition}) -> String

Generate the file mapping dictionary code.
"""
function generate_file_mapping(dataset_files::Vector{DatasetFileDefinition})
    lines = String[]

    push!(lines, "# File name to struct field name mapping")
    push!(lines, "const FILE_TO_FIELD = Dict{String, Symbol}(")

    sorted_files = sort(dataset_files, by=x->x.filename)
    for (i, file) in enumerate(sorted_files)
        field_name = filename_to_field_name(file.filename)
        comma = i < length(sorted_files) ? "," : ""
        push!(lines, "    \"$(file.filename)\" => :$field_name$comma")
    end

    push!(lines, ")")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    generate_required_files_list(dataset_files::Vector{DatasetFileDefinition}) -> String

Generate the list of required files.
"""
function generate_required_files_list(dataset_files::Vector{DatasetFileDefinition})
    # Core required files that should always be non-nullable DataFrames
    core_required = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt"]

    lines = String[]

    push!(lines, "# Required GTFS files (must be present)")
    push!(lines, "const REQUIRED_FILES = [")

    for (i, filename) in enumerate(core_required)
        comma = i < length(core_required) ? "," : ""
        push!(lines, "    \"$filename\"$comma")
    end

    push!(lines, "]")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    generate_conditionally_required_files(dataset_files::Vector{DatasetFileDefinition}) -> String

Generate information about conditionally required files.
"""
function generate_conditionally_required_files(dataset_files::Vector{DatasetFileDefinition})
    cond_required = filter(df -> df.presence == "Conditionally Required", dataset_files)

    lines = String[]

    push!(lines, "# Conditionally required files")
    push!(lines, "const CONDITIONALLY_REQUIRED_FILES = [")

    for (i, file) in enumerate(sort(cond_required, by=x->x.filename))
        comma = i < length(cond_required) ? "," : ""
        push!(lines, "    \"$(file.filename)\"$comma")
    end

    push!(lines, "]")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    write_file_mapping_file(output_path::String, dataset_files::Vector{DatasetFileDefinition})

Write the file mapping source file.
"""
function write_file_mapping_file(output_path::String, dataset_files::Vector{DatasetFileDefinition})
    # Create output directory if it doesn't exist
    output_dir = dirname(output_path)
    if !isdir(output_dir)
        mkpath(output_dir)
    end

    lines = String[]

    # Header
    push!(lines, "# Auto-generated file - GTFS file to struct field mapping")
    push!(lines, "# Generated from GTFS specification parsing")
    push!(lines, "")
    push!(lines, "\"\"\"")
    push!(lines, "File Mapping Module")
    push!(lines, "")
    push!(lines, "Provides mappings between GTFS file names and GTFSSchedule struct field names.")
    push!(lines, "This file is auto-generated from the GTFS specification.")
    push!(lines, "\"\"\"")
    push!(lines, "")

    # Generate mappings
    push!(lines, generate_file_mapping(dataset_files))
    push!(lines, generate_required_files_list(dataset_files))
    push!(lines, generate_conditionally_required_files(dataset_files))

    # Write to file
    open(output_path, "w") do io
        for line in lines
            println(io, line)
        end
    end

    println("✓ Generated file mapping: $output_path")
end

# Exports
export filename_to_field_name
export generate_file_mapping
export generate_required_files_list
export generate_conditionally_required_files
export write_file_mapping_file
