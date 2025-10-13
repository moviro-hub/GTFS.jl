"""
GTFS Struct Generator

Generates Julia source code for the GTFSSchedule struct based on parsed file-level conditions.
"""

include("../ingestion/types.jl")

"""
    categorize_files(dataset_files::Vector{DatasetFileDefinition}) -> Dict{String, Vector{DatasetFileDefinition}}

Categorize GTFS files by their requirement level.
Uses a predefined list of core required files to ensure proper categorization.
"""
function categorize_files(dataset_files::Vector{DatasetFileDefinition})
    # Core required files that should always be non-nullable DataFrames
    core_required_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt"]

    categories = Dict{String, Vector{DatasetFileDefinition}}()
    categories["Required"] = DatasetFileDefinition[]
    categories["Conditionally Required"] = DatasetFileDefinition[]
    categories["Optional"] = DatasetFileDefinition[]

    for file in dataset_files
        if file.filename in core_required_files
            # Force core files to be required regardless of spec parsing
            # Create a new file definition with "Required" presence
            required_file = DatasetFileDefinition(file.filename, "Required", file.description)
            push!(categories["Required"], required_file)
        elseif file.presence == "Required"
            push!(categories["Required"], file)
        elseif file.presence == "Conditionally Required"
            push!(categories["Conditionally Required"], file)
        else
            push!(categories["Optional"], file)
        end
    end

    return categories
end

"""
    filename_to_field_name(filename::String) -> String

Convert a GTFS filename to a Julia field name.
"""
function filename_to_field_name(filename::String)
    # Remove .txt extension
    base_name = replace(filename, ".txt" => "")
    base_name = replace(base_name, ".geojson" => "_geojson")

    # Convert to snake_case if needed
    # Most GTFS files are already in snake_case
    return base_name
end

"""
    get_field_type(filename::String, presence::String) -> String

Get the Julia type for a GTFS file field based on its presence requirement.
"""
function get_field_type(filename::String, presence::String)
    if presence == "Required"
        return "DataFrames.DataFrame"
    else
        return "Union{DataFrames.DataFrame, Nothing}"
    end
end

"""
    generate_gtfs_struct(dataset_files::Vector{DatasetFileDefinition}) -> String

Generate the GTFSSchedule struct definition as a string.
"""
function generate_gtfs_struct(dataset_files::Vector{DatasetFileDefinition})
    categories = categorize_files(dataset_files)

    lines = String[]

    # Struct header
    push!(lines, "struct GTFSSchedule")

    # Required files
    if !isempty(categories["Required"])
        push!(lines, "    # Required files")
        for file in sort(categories["Required"], by=x->x.filename)
            field_name = filename_to_field_name(file.filename)
            field_type = get_field_type(file.filename, file.presence)
            push!(lines, "    $field_name::$field_type")
        end
        push!(lines, "")
    end

    # Conditionally required files
    if !isempty(categories["Conditionally Required"])
        push!(lines, "    # Conditionally required files")
        for file in sort(categories["Conditionally Required"], by=x->x.filename)
            field_name = filename_to_field_name(file.filename)
            field_type = get_field_type(file.filename, file.presence)
            push!(lines, "    $field_name::$field_type")
        end
        push!(lines, "")
    end

    # Optional files
    if !isempty(categories["Optional"])
        push!(lines, "    # Optional files")
        for file in sort(categories["Optional"], by=x->x.filename)
            field_name = filename_to_field_name(file.filename)
            field_type = get_field_type(file.filename, file.presence)
            push!(lines, "    $field_name::$field_type")
        end
    end

    # Struct end
    push!(lines, "end")

    return join(lines, "\n")
end

"""
    write_gtfs_types_file(output_path::String, dataset_files::Vector{DatasetFileDefinition})

Write the GTFSSchedule struct definition to a Julia source file.
"""
function write_gtfs_types_file(output_path::String, dataset_files::Vector{DatasetFileDefinition})
    # Create output directory if it doesn't exist
    output_dir = dirname(output_path)
    if !isdir(output_dir)
        mkpath(output_dir)
    end

    # Generate the Julia source code
    lines = String[]

    # Header comment
    push!(lines, "# Auto-generated file - GTFSSchedule struct definition")
    push!(lines, "# Generated from GTFS specification parsing")
    push!(lines, "")
    push!(lines, "# DataFrames imported in main module")
    push!(lines, "")

    # Add documentation
    push!(lines, "\"\"\"")
    push!(lines, "    GTFSSchedule")
    push!(lines, "")
    push!(lines, "Main struct representing a complete GTFS Schedule dataset.")
    push!(lines, "")
    push!(lines, "This struct uses a hybrid approach, wrapping DataFrames in a typed struct")
    push!(lines, "to provide both type safety and powerful data manipulation capabilities.")
    push!(lines, "")
    push!(lines, "Fields are automatically generated from the GTFS specification and")
    push!(lines, "categorized by requirement level:")
    push!(lines, "- Required files: Always present, non-nullable DataFrames")
    push!(lines, "- Conditionally required files: Union{DataFrame, Nothing}")
    push!(lines, "- Optional files: Union{DataFrame, Nothing}")
    push!(lines, "\"\"\"")
    push!(lines, "")

    # Generate the struct
    struct_code = generate_gtfs_struct(dataset_files)
    push!(lines, struct_code)

    # Write to file
    open(output_path, "w") do io
        for line in lines
            println(io, line)
        end
    end

    println("✓ Generated GTFSSchedule struct file: $output_path")
end

# Exports
export categorize_files
export generate_gtfs_struct
export write_gtfs_types_file
