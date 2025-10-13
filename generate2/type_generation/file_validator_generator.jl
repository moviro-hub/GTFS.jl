"""
File Validator Generator

Generates Julia source code for file presence validation functions based on parsed file-level conditions.
"""

include("../conditions/condition_types.jl")

"""
    generate_condition_check(condition::Condition) -> String

Generate Julia code to check a single condition.
"""
function generate_condition_check(condition::Condition)
    if isa(condition, FileCondition)
        file_field = replace(condition.file, ".txt" => "")
        file_field = replace(file_field, ".geojson" => "_geojson")
        file_field = replace(file_field, "." => "_")
        if condition.must_exist
            return "gtfs.$file_field !== nothing"
        else
            return "gtfs.$file_field === nothing"
        end
    elseif isa(condition, FieldCondition)
        file_field = replace(condition.file, ".txt" => "")
        file_field = replace(file_field, ".geojson" => "_geojson")
        file_field = replace(file_field, "." => "_")
        if condition.same_file
            # Field is in the same file being validated
            return "hasproperty(gtfs, :$file_field) && gtfs.$file_field !== nothing && hasproperty(gtfs.$file_field, :$(condition.field)) && any(row -> row.$(condition.field) == \"$(condition.value)\", eachrow(gtfs.$file_field))"
        else
            # Field is in a different file
            return "hasproperty(gtfs, :$file_field) && gtfs.$file_field !== nothing && hasproperty(gtfs.$file_field, :$(condition.field)) && any(row -> row.$(condition.field) == \"$(condition.value)\", eachrow(gtfs.$file_field))"
        end
    else
        return "true"  # Unknown condition type, assume true
    end
end

"""
    generate_file_validation_function(parsed_file::ParsedFileLevelConditions) -> String

Generate validation function for a single file.
"""
function generate_file_validation_function(parsed_file::ParsedFileLevelConditions)
    filename = parsed_file.filename
    presence = parsed_file.presence
    conditions = parsed_file.conditions

    # Create function name
    clean_filename = replace(filename, ".txt" => "")
    clean_filename = replace(clean_filename, ".geojson" => "_geojson")
    clean_filename = replace(clean_filename, "." => "_")  # Replace any remaining dots
    func_name = "validate_file_$clean_filename"

    lines = String[]

    # Function documentation
    push!(lines, "\"\"\"")
    push!(lines, "    $func_name(gtfs::GTFSSchedule)")
    push!(lines, "")
    push!(lines, "Validate presence of $filename based on GTFS specification requirements.")
    push!(lines, "Base requirement: $presence")
    push!(lines, "Returns ValidationMessage with validation result.")
    push!(lines, "\"\"\"")
    push!(lines, "function $func_name(gtfs::GTFSSchedule)")
    push!(lines, "    filename = \"$filename\"")
    push!(lines, "    file_field = :$clean_filename")
    push!(lines, "    file_exists = hasproperty(gtfs, file_field) && getproperty(gtfs, file_field) !== nothing")
    push!(lines, "")

    # Handle different presence types
    if presence == "Required"
        push!(lines, "    # Required file - must always be present")
        push!(lines, "    if !file_exists")
        push!(lines, "        return ValidationMessage(filename, nothing, \"Required file '$filename' is missing\", :error)")
        push!(lines, "    end")
        push!(lines, "    return ValidationMessage(filename, nothing, \"Required file '$filename' is present\", :info)")

    elseif presence == "Optional"
        push!(lines, "    # Optional file - no validation needed")
        push!(lines, "    return ValidationMessage(filename, nothing, \"Optional file '$filename' validation skipped\", :info)")

    elseif presence == "Conditionally Required" || presence == "Conditionally Forbidden"
        push!(lines, "    # Conditionally required/forbidden - check conditions")
        push!(lines, "    conditions_met = false")
        push!(lines, "    condition_descriptions = String[]")
        push!(lines, "")

        for (i, file_relation) in enumerate(conditions)
            # Check all conditions in this file relation
            condition_checks = String[]
            for condition in file_relation.when_all_conditions
                condition_check = generate_condition_check(condition)
                push!(condition_checks, condition_check)
            end

            combined_check = isempty(condition_checks) ? "true" : join(condition_checks, " && ")
            push!(lines, "    # File relation $i: $(file_relation.required ? "required" : "forbidden") when all conditions met")
            push!(lines, "    if $combined_check")
            push!(lines, "        conditions_met = true")
            push!(lines, "        push!(condition_descriptions, \"File relation $i met\")")
            push!(lines, "    end")
            push!(lines, "")
        end

        push!(lines, "    if conditions_met")
        if presence == "Conditionally Required"
            push!(lines, "        # File is conditionally required and conditions are met")
            push!(lines, "        if !file_exists")
            push!(lines, "            return ValidationMessage(filename, nothing, \"Conditionally required file '$filename' is missing (conditions: \$(join(condition_descriptions, \", \")))\", :error)")
            push!(lines, "        else")
            push!(lines, "            return ValidationMessage(filename, nothing, \"Conditionally required file '$filename' is present (conditions: \$(join(condition_descriptions, \", \")))\", :info)")
            push!(lines, "        end")
        else  # Conditionally Forbidden
            push!(lines, "        # File is conditionally forbidden and conditions are met")
            push!(lines, "        if file_exists")
            push!(lines, "            return ValidationMessage(filename, nothing, \"Conditionally forbidden file '$filename' is present (conditions: \$(join(condition_descriptions, \", \")))\", :error)")
            push!(lines, "        else")
            push!(lines, "            return ValidationMessage(filename, nothing, \"Conditionally forbidden file '$filename' is correctly absent (conditions: \$(join(condition_descriptions, \", \")))\", :info)")
            push!(lines, "        end")
        end
        push!(lines, "    else")
        push!(lines, "        # Conditions not met - no validation needed")
        push!(lines, "        return ValidationMessage(filename, nothing, \"File '$filename' conditions not met - no validation required\", :info)")
        push!(lines, "    end")
    else
        push!(lines, "    # Unknown presence type")
        push!(lines, "    return ValidationMessage(filename, nothing, \"Unknown presence type '$presence' for file '$filename'\", :warning)")
    end

    push!(lines, "end")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    generate_comprehensive_validator(parsed_files::Vector{ParsedFileLevelConditions}) -> String

Generate main validation function that validates all files.
"""
function generate_comprehensive_validator(parsed_files::Vector{ParsedFileLevelConditions})
    lines = String[]

    push!(lines, "\"\"\"")
    push!(lines, "    validate_file_presence(gtfs::GTFSSchedule)")
    push!(lines, "")
    push!(lines, "Comprehensive file presence validation for GTFS feed.")
    push!(lines, "Validates all files based on GTFS specification requirements including:")
    push!(lines, "- Required files (must be present)")
    push!(lines, "- Conditionally required files (must be present when conditions are met)")
    push!(lines, "- Conditionally forbidden files (must not be present when conditions are met)")
    push!(lines, "- Optional files (no validation)")
    push!(lines, "")
    push!(lines, "Returns ValidationResult with all validation messages.")
    push!(lines, "\"\"\"")
    push!(lines, "function validate_file_presence(gtfs::GTFSSchedule)")
    push!(lines, "    messages = ValidationMessage[]")
    push!(lines, "")

    # Group files by presence type for better organization
    required_files = filter(pf -> pf.presence == "Required", parsed_files)
    conditionally_required = filter(pf -> pf.presence == "Conditionally Required", parsed_files)
    conditionally_forbidden = filter(pf -> pf.presence == "Conditionally Forbidden", parsed_files)
    optional_files = filter(pf -> pf.presence == "Optional", parsed_files)

    if !isempty(required_files)
        push!(lines, "    # Validate required files")
        for parsed_file in required_files
            clean_filename = replace(parsed_file.filename, ".txt" => "")
            clean_filename = replace(clean_filename, ".geojson" => "_geojson")
            clean_filename = replace(clean_filename, "." => "_")
            push!(lines, "    push!(messages, validate_file_$clean_filename(gtfs))")
        end
        push!(lines, "")
    end

    if !isempty(conditionally_required)
        push!(lines, "    # Validate conditionally required files")
        for parsed_file in conditionally_required
            clean_filename = replace(parsed_file.filename, ".txt" => "")
            clean_filename = replace(clean_filename, ".geojson" => "_geojson")
            clean_filename = replace(clean_filename, "." => "_")
            push!(lines, "    push!(messages, validate_file_$clean_filename(gtfs))")
        end
        push!(lines, "")
    end

    if !isempty(conditionally_forbidden)
        push!(lines, "    # Validate conditionally forbidden files")
        for parsed_file in conditionally_forbidden
            clean_filename = replace(parsed_file.filename, ".txt" => "")
            clean_filename = replace(clean_filename, ".geojson" => "_geojson")
            clean_filename = replace(clean_filename, "." => "_")
            push!(lines, "    push!(messages, validate_file_$clean_filename(gtfs))")
        end
        push!(lines, "")
    end

    if !isempty(optional_files)
        push!(lines, "    # Optional files (no validation needed)")
        push!(lines, "    # Files: $(join([pf.filename for pf in optional_files], ", "))")
        push!(lines, "")
    end

    push!(lines, "    # Determine overall validity")
    push!(lines, "    error_count = count(msg -> msg.severity == :error, messages)")
    push!(lines, "    warning_count = count(msg -> msg.severity == :warning, messages)")
    push!(lines, "    is_valid = error_count == 0")
    push!(lines, "")
    push!(lines, "    # Generate summary")
    push!(lines, "    summary = \"File presence validation: \$(error_count) errors, \$(warning_count) warnings\"")
    push!(lines, "    if is_valid")
    push!(lines, "        summary *= \" - All file presence requirements satisfied\"")
    push!(lines, "    else")
    push!(lines, "        summary *= \" - File presence validation failed\"")
    push!(lines, "    end")
    push!(lines, "")
    push!(lines, "    return ValidationResult(is_valid, messages, summary)")
    push!(lines, "end")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    write_file_validator_file(output_path::String, parsed_files::Vector{ParsedFileLevelConditions})

Write the file validator file with all validation functions.
"""
function write_file_validator_file(output_path::String, parsed_files::Vector{ParsedFileLevelConditions})
    # Create output directory if it doesn't exist
    output_dir = dirname(output_path)
    if !isdir(output_dir)
        mkpath(output_dir)
    end

    # Generate the Julia source code
    lines = String[]

    # Header comment
    push!(lines, "# Auto-generated file - File presence validation functions")
    push!(lines, "# Generated from GTFS specification parsing")
    push!(lines, "")

    # Add documentation
    push!(lines, "\"\"\"")
    push!(lines, "File Presence Validation Functions")
    push!(lines, "")
    push!(lines, "This module provides validation functions for GTFS file presence requirements.")
    push!(lines, "Validates files based on GTFS specification requirements:")
    push!(lines, "- Required files: Must always be present")
    push!(lines, "- Conditionally required files: Must be present when conditions are met")
    push!(lines, "- Conditionally forbidden files: Must not be present when conditions are met")
    push!(lines, "- Optional files: No validation required")
    push!(lines, "")
    push!(lines, "Usage:")
    push!(lines, "    result = validate_file_presence(gtfs)")
    push!(lines, "    if result.is_valid")
    push!(lines, "        println(\"All file requirements satisfied\")")
    push!(lines, "    else")
    push!(lines, "        for msg in result.messages")
    push!(lines, "            if msg.severity == :error")
    push!(lines, "                println(\"ERROR: \", msg.message)")
    push!(lines, "            end")
    push!(lines, "        end")
    push!(lines, "    end")
    push!(lines, "\"\"\"")
    push!(lines, "")

    # Generate comprehensive validator
    comprehensive_code = generate_comprehensive_validator(parsed_files)
    push!(lines, comprehensive_code)

    # Generate specific validators for each file
    push!(lines, "# Individual file validation functions")
    push!(lines, "")

    for parsed_file in parsed_files
        func_code = generate_file_validation_function(parsed_file)
        push!(lines, func_code)
    end

    # Write to file
    open(output_path, "w") do io
        for line in lines
            println(io, line)
        end
    end

    println("✓ Generated file validator: $output_path")
end

# Exports
export generate_condition_check
export generate_file_validation_function
export generate_comprehensive_validator
export write_file_validator_file
