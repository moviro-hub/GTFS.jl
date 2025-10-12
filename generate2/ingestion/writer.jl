"""
GTFS Specification Writer Module

Handles saving parsed GTFS specification data to JSON files.
"""

include("types.jl")
using Dates
using JSON

# Struct to hold the complete GTFS data for JSON serialization
struct GTFSData
    metadata::Dict{String, Any}
    dataset_files::Vector{DatasetFileDefinition}
    files::Vector{FileDefinition}
end

"""
    save_results_as_json(dataset_files::Vector{DatasetFileDefinition}, file_definitions::Vector{FileDefinition})

Save the parsed results as JSON for programmatic use using JSON.jl's built-in struct conversion.
"""
function save_results_as_json(dataset_files::Vector{DatasetFileDefinition}, file_definitions::Vector{FileDefinition})
    output_file = "parsed_gtfs_spec.json"

    println("Saving results to: $output_file")

    # Create the data structure - JSON.jl will automatically convert structs to JSON
    data = GTFSData(
        Dict(
            "generated_on" => string(Dates.now()),
            "source" => "https://github.com/google/transit/blob/master/gtfs/spec/en/reference.md",
            "total_dataset_files" => length(dataset_files),
            "total_files" => length(file_definitions),
            "total_fields" => sum(length(fd.fields) for fd in file_definitions)
        ),
        dataset_files,
        file_definitions
    )

    # Write JSON to file - JSON.jl handles struct conversion automatically
    open(output_file, "w") do io
        JSON.print(io, data, 2)  # Pretty print with 2-space indentation
    end

    println("✓ Results saved to: $output_file")
end

# Exports
export save_results_as_json
export GTFSData
