#!/usr/bin/env julia

"""
GTFS Specification Parser - Main Script

Orchestrates the download and parsing of the GTFS specification.
"""

include("download/download.jl")
include("ingestion/parser.jl")
include("extraction/condition_types.jl")
include("extraction/condition_utils.jl")
include("extraction/file_level_parser.jl")
include("extraction/field_level_parser.jl")
include("extraction/types.jl")
include("extraction/enum_parser.jl")
include("extraction/julia_type.jl")
include("extraction/type_mapping.jl")
include("generation/validation_types_generator.jl")
include("generation/column_types_generator.jl")
include("generation/gtfs_struct_generator.jl")
include("generation/enum_validator_generator.jl")
include("generation/file_validator_generator.jl")
include("generation/field_validator_generator.jl")
include("generation/value_validation_generator.jl")
include("generation/file_mapping_generator.jl")

function main()
    println("=== GTFS Specification Parser ===")
    println("Downloading and parsing the official Google Transit GTFS specification...")
    println()

    try
        # Step 1: Download the specification
        println("Step 1: Downloading GTFS reference...")
        spec_file = download_gtfs_spec_to_dir(".")
        println("✓ Downloaded")
        println()

        # Step 2: ingestion
        println("Step 2: Ingestion GTFS reference...")
        markdown_content = read(spec_file, String)
        dataset_files, file_definitions = parse_gtfs_specification(markdown_content)
        println("✓ Ingested")
        println()

        # Step 3: Extraction
        println("Step 5: Extraction rules and conditions...")
        parsed_files = parse_all_file_level_conditions(dataset_files)
        parsed_fields = parse_all_field_level_conditions(file_definitions)
        parsed_enums = parse_all_enum_fields(file_definitions)
        type_mappings = convert_all_field_types(file_definitions)
        println("✓ Extracted")
        println()

        # Step 4: Generation
        write_file_validator_file("../src/file_validator.jl", parsed_files)
        println("✓ Generated file validator")
        println()

        # Step 5: Generate validation types
        println("Step 5: Generating validation types...")
        write_validation_types_file("../src/validation_types.jl", dataset_files)
        println("✓ Generated validation types")
        println()

        # Step 6: Generation
        println("Step 6: Generating GTFSSchedule struct...")
        write_gtfs_types_file("../src/gtfs_types.jl", dataset_files)
        write_file_mapping_file("../src/file_mapping.jl", dataset_files)
        write_field_validator_file("../src/field_validator.jl", parsed_fields)
        write_value_validator_file("../src/value_validator.jl", type_mappings)
        write_enum_validator_file("../src/enum_validator.jl", parsed_enums)
        column_types = generate_column_types_dict(type_mappings)
        write_column_types_file("../src/column_types.jl", column_types)
        println("✓ Generated")
        println()
        println("✓ All steps completed")
        return nothing

    catch e
        println("Error: $e")
        rethrow(e)
    end
end

# Run the main function if this script is executed directly
if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
