#!/usr/bin/env julia

"""
GTFS Specification Parser - Main Script

Orchestrates the download and parsing of the GTFS specification.
"""

include("download/download.jl")
include("ingestion/parser.jl")
include("ingestion/writer.jl")
include("conditions/condition_types.jl")
include("conditions/condition_utils.jl")
include("conditions/file_level_parser.jl")
include("conditions/field_level_parser.jl")
include("conditions/enum_parser.jl")
include("type_conversion/type_mappings.jl")
include("type_conversion/gtfs_to_julia.jl")

function main()
    println("=== GTFS Specification Parser ===")
    println("Downloading and parsing the official Google Transit GTFS specification...")
    println()

    try
        # Step 1: Download the specification
        println("Step 1: Downloading GTFS specification...")
        spec_file = download_gtfs_spec_to_dir(".")
        println("✓ Downloaded to: $spec_file")
        println()

        # Step 2: Read the content
        println("Step 2: Reading specification content...")
        markdown_content = read(spec_file, String)
        println("✓ Read $(length(markdown_content)) characters")
        println()

        # Step 3: Parse the specification
        println("Step 3: Parsing specification...")
        dataset_files, file_definitions = parse_gtfs_specification(markdown_content)
        println("✓ Parsed $(length(dataset_files)) dataset files and $(length(file_definitions)) detailed file definitions")
        println()

        # Step 4: Save results as JSON
        save_results_as_json(dataset_files, file_definitions)

        # Step 5: Parse file-level conditional requirements
        parsed_files = parse_all_file_level_conditions(dataset_files)

        # Step 6: Parse field-level conditional requirements
        parsed_fields = parse_all_field_level_conditions(file_definitions)

        # Step 7: Parse enum values
        parsed_enums = parse_all_enum_fields(file_definitions)

        # Step 8: Convert types
        type_mappings = convert_all_field_types(file_definitions)

        println("\n=== Parsing Complete ===")
        return (dataset_files, file_definitions, parsed_files, parsed_fields, parsed_enums, type_mappings)

    catch e
        println("Error: $e")
        rethrow(e)
    end
end

# Run the main function if this script is executed directly
if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
