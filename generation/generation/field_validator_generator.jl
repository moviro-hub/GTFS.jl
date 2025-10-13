"""
Field Validator Generator

Generates Julia source code for field-level validation functions based on parsed field-level conditions.
"""

include("../extraction/condition_types.jl")

"""
    generate_field_condition_check(condition::Condition) -> String

Generate Julia code to check a single field condition.
"""
function generate_field_condition_check(condition::Condition)
    if isa(condition, FileCondition)
        file_field = replace(condition.file, ".txt" => "")
        file_field = replace(file_field, ".geojson" => "")
        file_field = replace(file_field, "." => "_")
        if condition.must_exist
            return "hasproperty(gtfs, :$file_field) && gtfs.$file_field !== nothing"
        else
            return "!hasproperty(gtfs, :$file_field) || gtfs.$file_field === nothing"
        end
    elseif isa(condition, FieldCondition)
        file_field = replace(condition.file, ".txt" => "")
        file_field = replace(file_field, ".geojson" => "")
        file_field = replace(file_field, "." => "_")
        clean_condition_field = condition.field  # Backticks already removed in parser
        # Handle numeric field names by prefixing with underscore
        if tryparse(Int, clean_condition_field) !== nothing
            clean_condition_field = "_$clean_condition_field"
        end
        if condition.same_file
            # Field is in the same file being validated
            return "hasproperty(gtfs, :$file_field) && gtfs.$file_field !== nothing && hasproperty(gtfs.$file_field, :$clean_condition_field) && any(row -> !ismissing(row.$clean_condition_field) && row.$clean_condition_field == \"$(condition.value)\", eachrow(gtfs.$file_field))"
        else
            # Field is in a different file
            return "hasproperty(gtfs, :$file_field) && gtfs.$file_field !== nothing && hasproperty(gtfs.$file_field, :$clean_condition_field) && any(row -> !ismissing(row.$clean_condition_field) && row.$clean_condition_field == \"$(condition.value)\", eachrow(gtfs.$file_field))"
        end
    else
        return "true"  # Unknown condition type, assume true
    end
end

"""
    generate_field_validation_function(field_relation::FieldRelation) -> String

Generate validation function for a single field's presence requirements.
"""
function generate_field_validation_function(field_relation::FieldRelation)
    file_name = field_relation.file
    field_name = field_relation.field
    presence = field_relation.presence
    conditions = field_relation.when_all_conditions

    # Create function name
    clean_file = replace(file_name, ".txt" => "")
    clean_file = replace(clean_file, ".geojson" => "")
    clean_file = replace(clean_file, "." => "_")
    clean_field = replace(field_name, "." => "_")
    clean_field = replace(clean_field, " " => "_")
    func_name = "validate_field_$(clean_file)_$(clean_field)"

    lines = String[]

    # Function documentation
    push!(lines, "\"\"\"")
    push!(lines, "    $func_name(gtfs::GTFSSchedule)")
    push!(lines, "")
    push!(lines, "Validate presence of field '$field_name' in $file_name based on GTFS specification requirements.")
    push!(lines, "Base requirement: $presence")
    push!(lines, "Returns ValidationMessage with validation result.")
    push!(lines, "\"\"\"")
    push!(lines, "function $func_name(gtfs::GTFSSchedule)")
    push!(lines, "    filename = \"$file_name\"")
    push!(lines, "    field_name = \"$field_name\"")
    push!(lines, "    file_field = :$clean_file")
    push!(lines, "")
    push!(lines, "    # Check if file exists")
    push!(lines, "    if !hasproperty(gtfs, file_field) || gtfs.$clean_file === nothing")
    push!(lines, "        return ValidationMessage(filename, field_name, \"File '$file_name' does not exist, cannot validate field '$field_name'\", :warning)")
    push!(lines, "    end")
    push!(lines, "")
    # Clean field name for use in code (backticks already removed in parser)
    clean_field_name = field_name
    # Handle numeric field names by prefixing with underscore
    if tryparse(Int, clean_field_name) !== nothing
        clean_field_name = "_$clean_field_name"
    end

    push!(lines, "    # Check if field exists in DataFrame")
    push!(lines, "    if !hasproperty(gtfs.$clean_file, :$clean_field_name)")
    push!(lines, "        return ValidationMessage(filename, field_name, \"Field '$field_name' does not exist in file '$file_name'\", :warning)")
    push!(lines, "    end")
    push!(lines, "")
    push!(lines, "    # Get field data")
    push!(lines, "    field_data = gtfs.$clean_file.$clean_field_name")
    push!(lines, "")

    # Handle different presence types
    if presence == "Required"
        push!(lines, "    # Required field - check for missing values")
        push!(lines, "    missing_count = count(ismissing, field_data)")
        push!(lines, "    if missing_count > 0")
            push!(lines, "        return ValidationMessage(filename, field_name, \"Required field '$field_name' has \$missing_count missing values\", :error)")
            push!(lines, "    end")
        push!(lines, "    return ValidationMessage(filename, field_name, \"Required field '$field_name' has no missing values\", :info)")

    elseif presence == "Optional"
        push!(lines, "    # Optional field - no validation needed")
        push!(lines, "    return ValidationMessage(filename, field_name, \"Optional field '$field_name' validation skipped\", :info)")

    elseif presence == "Conditionally Required" || presence == "Conditionally Forbidden"
        push!(lines, "    # Conditionally required/forbidden - check conditions")
        push!(lines, "    conditions_met = false")
        push!(lines, "    condition_descriptions = String[]")
        push!(lines, "")

        for (i, condition) in enumerate(conditions)
            condition_check = generate_field_condition_check(condition)
            push!(lines, "    # Condition $i: $(field_relation.required ? "required" : "forbidden") when conditions met")
            push!(lines, "    if $condition_check")
            push!(lines, "        conditions_met = true")
            push!(lines, "        push!(condition_descriptions, \"Condition $i met\")")
            push!(lines, "    end")
            push!(lines, "")
        end

        push!(lines, "    if conditions_met")
        if presence == "Conditionally Required"
            push!(lines, "        # Field is conditionally required and conditions are met")
            push!(lines, "        missing_count = count(ismissing, field_data)")
            push!(lines, "        if missing_count > 0")
                push!(lines, "            return ValidationMessage(filename, field_name, \"Conditionally required field '$field_name' has \$missing_count missing values (conditions: \$(join(condition_descriptions, \", \")))\", :error)")
                push!(lines, "        else")
                push!(lines, "            return ValidationMessage(filename, field_name, \"Conditionally required field '$field_name' has no missing values (conditions: \$(join(condition_descriptions, \", \")))\", :info)")
                push!(lines, "        end")
        else  # Conditionally Forbidden
            push!(lines, "        # Field is conditionally forbidden and conditions are met")
            push!(lines, "        non_missing_count = count(!ismissing, field_data)")
            push!(lines, "        if non_missing_count > 0")
                push!(lines, "            return ValidationMessage(filename, field_name, \"Conditionally forbidden field '$field_name' has \$non_missing_count non-missing values (conditions: \$(join(condition_descriptions, \", \")))\", :error)")
                push!(lines, "        else")
                push!(lines, "            return ValidationMessage(filename, field_name, \"Conditionally forbidden field '$field_name' is correctly empty (conditions: \$(join(condition_descriptions, \", \")))\", :info)")
                push!(lines, "        end")
        end
        push!(lines, "    else")
        push!(lines, "        # Conditions not met - no validation needed")
        push!(lines, "        return ValidationMessage(filename, field_name, \"Field '$field_name' conditions not met - no validation required\", :info)")
        push!(lines, "    end")
    else
        push!(lines, "    # Unknown presence type")
        push!(lines, "    return ValidationMessage(filename, field_name, \"Unknown presence type '$presence' for field '$field_name'\", :warning)")
    end

    push!(lines, "end")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    generate_file_field_validator(parsed_file::ParsedFieldLevelConditions) -> String

Generate validation function for all fields in a file.
"""
function generate_file_field_validator(parsed_file::ParsedFieldLevelConditions)
    filename = parsed_file.filename
    fields = parsed_file.fields

    # Create function name
    clean_filename = replace(filename, ".txt" => "")
    clean_filename = replace(clean_filename, ".geojson" => "")
    clean_filename = replace(clean_filename, "." => "_")
    func_name = "validate_fields_$clean_filename"

    lines = String[]

    # Function documentation
    push!(lines, "\"\"\"")
    push!(lines, "    $func_name(gtfs::GTFSSchedule)")
    push!(lines, "")
    push!(lines, "Validate all fields in $filename based on GTFS specification requirements.")
    push!(lines, "Returns Vector{ValidationMessage} with validation results for all fields.")
    push!(lines, "\"\"\"")
    push!(lines, "function $func_name(gtfs::GTFSSchedule)")
    push!(lines, "    messages = ValidationMessage[]")
    push!(lines, "")

    # Generate calls to individual field validators
    for field_relation in fields
        clean_field = replace(field_relation.field, "." => "_")
        clean_field = replace(clean_field, " " => "_")
        field_func_name = "validate_field_$(clean_filename)_$(clean_field)"
        push!(lines, "    push!(messages, $field_func_name(gtfs))")
    end

    push!(lines, "")
    push!(lines, "    return messages")
    push!(lines, "end")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    generate_comprehensive_field_validator(parsed_fields::Vector{ParsedFieldLevelConditions}) -> String

Generate main validation function that validates all fields in all files.
"""
function generate_comprehensive_field_validator(parsed_fields::Vector{ParsedFieldLevelConditions})
    lines = String[]

    push!(lines, "\"\"\"")
    push!(lines, "    validate_field_presence(gtfs::GTFSSchedule)")
    push!(lines, "")
    push!(lines, "Comprehensive field presence validation for GTFS feed.")
    push!(lines, "Validates all fields based on GTFS specification requirements including:")
    push!(lines, "- Required fields (must have no missing values)")
    push!(lines, "- Conditionally required fields (must have no missing values when conditions are met)")
    push!(lines, "- Conditionally forbidden fields (must be empty when conditions are met)")
    push!(lines, "- Optional fields (no validation)")
    push!(lines, "")
    push!(lines, "Returns ValidationResult with all validation messages.")
    push!(lines, "\"\"\"")
    push!(lines, "function validate_field_presence(gtfs::GTFSSchedule)")
    push!(lines, "    messages = ValidationMessage[]")
    push!(lines, "")

    # Generate calls to file field validators
    for parsed_file in parsed_fields
        clean_filename = replace(parsed_file.filename, ".txt" => "")
        clean_filename = replace(clean_filename, ".geojson" => "")
        clean_filename = replace(clean_filename, "." => "_")
        file_func_name = "validate_fields_$clean_filename"
        push!(lines, "    # Validate fields in $(parsed_file.filename)")
        push!(lines, "    append!(messages, $file_func_name(gtfs))")
        push!(lines, "")
    end

    push!(lines, "    # Determine overall validity")
    push!(lines, "    error_count = count(msg -> msg.severity == :error, messages)")
    push!(lines, "    warning_count = count(msg -> msg.severity == :warning, messages)")
    push!(lines, "    is_valid = error_count == 0")
    push!(lines, "")
    push!(lines, "    # Generate summary")
    push!(lines, "    summary = \"Field presence validation: \$(error_count) errors, \$(warning_count) warnings\"")
    push!(lines, "    if is_valid")
    push!(lines, "        summary *= \" - All field presence requirements satisfied\"")
    push!(lines, "    else")
    push!(lines, "        summary *= \" - Field presence validation failed\"")
    push!(lines, "    end")
    push!(lines, "")
    push!(lines, "    return ValidationResult(is_valid, messages, summary)")
    push!(lines, "end")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    write_field_validator_file(output_path::String, parsed_fields::Vector{ParsedFieldLevelConditions})

Write the field validator file with all presence validation functions.
"""
function write_field_validator_file(output_path::String, parsed_fields::Vector{ParsedFieldLevelConditions})
    # Create output directory if it doesn't exist
    output_dir = dirname(output_path)
    if !isdir(output_dir)
        mkpath(output_dir)
    end

    # Generate the Julia source code
    lines = String[]

    # Header comment
    push!(lines, "# Auto-generated file - Field presence validation functions")
    push!(lines, "# Generated from GTFS specification parsing")
    push!(lines, "")

    # Add documentation
    push!(lines, "\"\"\"")
    push!(lines, "Field Presence Validation Functions")
    push!(lines, "")
    push!(lines, "This module provides validation functions for GTFS field presence requirements.")
    push!(lines, "Validates fields based on GTFS specification requirements:")
    push!(lines, "- Required fields: Must have no missing values")
    push!(lines, "- Conditionally required fields: Must have no missing values when conditions are met")
    push!(lines, "- Conditionally forbidden fields: Must be empty when conditions are met")
    push!(lines, "- Optional fields: No validation required")
    push!(lines, "")
    push!(lines, "Usage:")
    push!(lines, "    result = validate_field_presence(gtfs)")
    push!(lines, "    if result.is_valid")
    push!(lines, "        println(\"All field requirements satisfied\")")
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
    comprehensive_code = generate_comprehensive_field_validator(parsed_fields)
    push!(lines, comprehensive_code)

    # Generate file-level field validators
    push!(lines, "# File-level field validation functions")
    push!(lines, "")

    for parsed_file in parsed_fields
        file_code = generate_file_field_validator(parsed_file)
        push!(lines, file_code)
    end

    # Generate individual field validators
    push!(lines, "# Individual field validation functions")
    push!(lines, "")

    # Keep track of generated functions to avoid duplicates
    generated_functions = Set{String}()

    for parsed_file in parsed_fields
        for field_relation in parsed_file.fields
            # Create function name
            clean_file = replace(field_relation.file, ".txt" => "")
            clean_file = replace(clean_file, ".geojson" => "")
            clean_file = replace(clean_file, "." => "_")
            clean_field = replace(field_relation.field, "." => "_")
            clean_field = replace(clean_field, " " => "_")
            if tryparse(Int, clean_field) !== nothing
                clean_field = "_$clean_field"
            end
            func_name = "validate_field_$(clean_file)_$(clean_field)"

            # Only generate if not already generated
            if !(func_name in generated_functions)
                push!(generated_functions, func_name)
                field_code = generate_field_validation_function(field_relation)
                push!(lines, field_code)
            end
        end
    end

    # Write to file
    open(output_path, "w") do io
        for line in lines
            println(io, line)
        end
    end

    println("✓ Generated field validator: $output_path")
end

# Exports
export generate_field_condition_check
export generate_field_validation_function
export generate_file_field_validator
export generate_comprehensive_field_validator
export write_field_validator_file
