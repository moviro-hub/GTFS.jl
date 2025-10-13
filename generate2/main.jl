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
include("enum/types.jl")
include("enum/enum_parser.jl")
include("type_conversion/type_mappings.jl")
include("type_conversion/gtfs_to_julia.jl")
include("type_generation/column_types_generator.jl")
include("type_generation/gtfs_struct_generator.jl")
include("type_generation/enum_validator_generator.jl")
include("type_generation/file_validator_generator.jl")
include("type_generation/field_validator_generator.jl")
include("type_generation/value_validation_generator.jl")
include("type_generation/file_mapping_generator.jl")

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

        # Step 5.5: Generate file validator
        println("Step 5.5: Generating file validator...")
        write_file_validator_file("../src/file_validator.jl", parsed_files)
        println()

        # Step 6: Generate GTFSSchedule struct
        println("Step 6: Generating GTFSSchedule struct...")
        write_gtfs_types_file("../src/gtfs_types.jl", dataset_files)
        println()

        # Step 6.5: Generate file mapping
        println("Step 6.5: Generating file mapping...")
        write_file_mapping_file("../src/file_mapping.jl", dataset_files)
        println()

        # Step 7: Parse field-level conditional requirements
        parsed_fields = parse_all_field_level_conditions(file_definitions)

        # Step 7.5: Parse enum values (needed for field validator)
        parsed_enums = parse_all_enum_fields(file_definitions)

        # Step 8: Convert types (needed for field validator)
        type_mappings = convert_all_field_types(file_definitions)

        # Step 8.5: Generate field validator (presence validation only)
        println("Step 8.5: Generating field validator...")
        write_field_validator_file("../src/field_validator.jl", parsed_fields)
        println()

        # Step 8.7: Generate value validator
        println("Step 8.7: Generating value validator...")
        write_value_validator_file("../src/value_validator.jl", type_mappings)
        println()

        # Step 9: Generate enum validator
        println("Step 9: Generating enum validator...")
        write_enum_validator_file("../src/enum_validator.jl", parsed_enums)
        println()

        # Step 11: Generate column_types.jl
        println("Step 11: Generating column types file...")
        column_types = generate_column_types_dict(type_mappings)
        write_column_types_file("../src/column_types.jl", column_types)
        println()

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
