"""
Value Validation Generator

Generates Julia source code for field value validation functions based on GTFS field types.
"""

include("../extraction/julia_type.jl")

"""
    generate_value_validation_code(gtfs_type::String, field_name::String) -> String

Generate value validation code based on GTFS field type.
"""
function generate_value_validation_code(gtfs_type::String, field_name::String)
    type_lower = lowercase(gtfs_type)

    # Date validation (YYYYMMDD format)
    if occursin("date", type_lower) && !occursin("foreign id", type_lower)
        return """
    # Validate date format (YYYYMMDD)
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            val_str = string(val)
            if !occursin(r"^\\d{8}\$", val_str)
                push!(validation_errors, "Row \$idx: Invalid date format '\$val_str' (expected YYYYMMDD)")
            end
        end
    end"""
    end

    # Time validation (HH:MM:SS format, supports >24 hours)
    if occursin("time", type_lower) && !occursin("timeframe", type_lower) && !occursin("timezone", type_lower)
        return """
    # Validate time format (HH:MM:SS)
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            val_str = string(val)
            if !occursin(r"^\\d{1,2}:\\d{2}:\\d{2}\$", val_str)
                push!(validation_errors, "Row \$idx: Invalid time format '\$val_str' (expected HH:MM:SS)")
            end
        end
    end"""
    end

    # Timezone validation (IANA timezone format)
    if occursin("timezone", type_lower)
        return """
    # Validate timezone format (IANA timezone)
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            val_str = string(val)
            # Basic timezone format validation (should be like America/New_York, Europe/London, etc.)
            if !occursin(r"^[A-Za-z_]+/[A-Za-z_]+\$", val_str)
                push!(validation_errors, "Row \$idx: Invalid timezone format '\$val_str' (expected IANA timezone like America/New_York)")
            end
        end
    end"""
    end

    # Foreign ID validation (string references to other tables)
    if occursin("foreign id", type_lower)
        return """
    # Validate foreign ID format (non-empty string)
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            val_str = string(val)
            if isempty(val_str)
                push!(validation_errors, "Row \$idx: Foreign ID cannot be empty")
            end
        end
    end"""
    end

    # URL validation
    if occursin("url", type_lower)
        return """
    # Validate URL format
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            val_str = string(val)
            if !occursin(r"^https?://", val_str)
                push!(validation_errors, "Row \$idx: Invalid URL '\$val_str' (must start with http:// or https://)")
            end
        end
    end"""
    end

    # Color validation (#RRGGBB format)
    if occursin("color", type_lower)
        return """
    # Validate color format (#RRGGBB)
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            val_str = string(val)
            if !occursin(r"^[0-9A-Fa-f]{6}\$", val_str)
                push!(validation_errors, "Row \$idx: Invalid color '\$val_str' (expected 6-digit hex without #)")
            end
        end
    end"""
    end

    # Latitude validation (-90 to 90)
    if occursin("latitude", type_lower)
        return """
    # Validate latitude range (-90 to 90)
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            try
                lat = Float64(val)
                if lat < -90.0 || lat > 90.0
                    push!(validation_errors, "Row \$idx: Latitude \$lat out of range (must be between -90 and 90)")
                end
            catch
                push!(validation_errors, "Row \$idx: Invalid latitude value '\$val'")
            end
        end
    end"""
    end

    # Longitude validation (-180 to 180)
    if occursin("longitude", type_lower)
        return """
    # Validate longitude range (-180 to 180)
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            try
                lon = Float64(val)
                if lon < -180.0 || lon > 180.0
                    push!(validation_errors, "Row \$idx: Longitude \$lon out of range (must be between -180 and 180)")
                end
            catch
                push!(validation_errors, "Row \$idx: Invalid longitude value '\$val'")
            end
        end
    end"""
    end

    # Integer validation
    if occursin("integer", type_lower) && !occursin("enum", type_lower)
        # Check for constraints
        if occursin("non-negative", type_lower)
            return """
    # Validate non-negative integer
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            try
                int_val = Int(val)
                if int_val < 0
                    push!(validation_errors, "Row \$idx: Value \$int_val must be non-negative")
                end
            catch
                push!(validation_errors, "Row \$idx: Invalid integer value '\$val'")
            end
        end
    end"""
        elseif occursin("positive", type_lower)
            return """
    # Validate positive integer
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            try
                int_val = Int(val)
                if int_val <= 0
                    push!(validation_errors, "Row \$idx: Value \$int_val must be positive")
                end
            catch
                push!(validation_errors, "Row \$idx: Invalid integer value '\$val'")
            end
        end
    end"""
        else
            return """
    # Validate integer
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            try
                Int(val)
            catch
                push!(validation_errors, "Row \$idx: Invalid integer value '\$val'")
            end
        end
    end"""
        end
    end

    # Float validation
    if occursin("float", type_lower)
        if occursin("non-negative", type_lower)
            return """
    # Validate non-negative float
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            try
                float_val = Float64(val)
                if float_val < 0.0
                    push!(validation_errors, "Row \$idx: Value \$float_val must be non-negative")
                end
            catch
                push!(validation_errors, "Row \$idx: Invalid float value '\$val'")
            end
        end
    end"""
        else
            return """
    # Validate float
    for (idx, val) in enumerate(field_data)
        if !ismissing(val)
            try
                Float64(val)
            catch
                push!(validation_errors, "Row \$idx: Invalid float value '\$val'")
            end
        end
    end"""
        end
    end

    # Enum validation - use existing enum_validator
    if occursin("enum", type_lower)
        return """
    # Validate enum values
    for (idx, val) in enumerate(field_data)
        if !ismissing(val) && !validate_enum(filename, field_name, val)
            push!(validation_errors, "Row \$idx: Invalid enum value '\$val' for field '\$field_name'")
        end
    end"""
    end

    # No specific validation for this type
    return ""
end

"""
    generate_value_validation_function(file::String, field::String, gtfs_type::String) -> String

Generate validation function for a single field's values.
"""
function generate_value_validation_function(file::String, field::String, gtfs_type::String)
    # Create function name
    clean_file = replace(file, ".txt" => "")
    clean_file = replace(clean_file, ".geojson" => "")
    clean_file = replace(clean_file, "." => "_")

    # Clean field name - remove HTML entities and special characters
    clean_field = replace(field, "&nbsp;" => "_")
    clean_field = replace(clean_field, "&amp;" => "_")
    clean_field = replace(clean_field, "&lt;" => "_")
    clean_field = replace(clean_field, "&gt;" => "_")
    clean_field = replace(clean_field, "&quot;" => "_")
    clean_field = replace(clean_field, "&apos;" => "_")
    clean_field = replace(clean_field, "-" => "_")
    clean_field = replace(clean_field, "." => "_")
    clean_field = replace(clean_field, " " => "_")
    clean_field = replace(clean_field, "\\" => "_")
    clean_field = replace(clean_field, "/" => "_")
    clean_field = replace(clean_field, "(" => "_")
    clean_field = replace(clean_field, ")" => "_")
    clean_field = replace(clean_field, "[" => "_")
    clean_field = replace(clean_field, "]" => "_")
    clean_field = replace(clean_field, "{" => "_")
    clean_field = replace(clean_field, "}" => "_")
    clean_field = replace(clean_field, ":" => "_")
    clean_field = replace(clean_field, ";" => "_")
    clean_field = replace(clean_field, "," => "_")
    clean_field = replace(clean_field, "!" => "_")
    clean_field = replace(clean_field, "?" => "_")
    clean_field = replace(clean_field, "@" => "_")
    clean_field = replace(clean_field, "#" => "_")
    clean_field = replace(clean_field, "\$" => "_")
    clean_field = replace(clean_field, "%" => "_")
    clean_field = replace(clean_field, "^" => "_")
    clean_field = replace(clean_field, "&" => "_")
    clean_field = replace(clean_field, "*" => "_")
    clean_field = replace(clean_field, "+" => "_")
    clean_field = replace(clean_field, "=" => "_")
    clean_field = replace(clean_field, "|" => "_")
    clean_field = replace(clean_field, "~" => "_")
    clean_field = replace(clean_field, "`" => "_")
    clean_field = replace(clean_field, "'" => "_")
    clean_field = replace(clean_field, "\"" => "_")

    # Remove multiple consecutive underscores
    clean_field = replace(clean_field, r"_+" => "_")
    # Remove leading/trailing underscores
    clean_field = strip(clean_field, '_')

    if tryparse(Int, clean_field) !== nothing
        clean_field = "_$clean_field"
    end

    # Ensure field name is not empty
    if isempty(clean_field)
        clean_field = "unknown_field"
    end

    func_name = "validate_value_$(clean_file)_$(clean_field)"

    lines = String[]

    # Function documentation
    push!(lines, "\"\"\"")
    push!(lines, "    $func_name(gtfs::GTFSSchedule)")
    push!(lines, "")
    # Escape field name for documentation
    escaped_field = replace(field, "\\" => "\\\\")
    escaped_field = replace(escaped_field, "\"" => "\\\"")
    push!(lines, "Validate values of field '$escaped_field' in $file based on GTFS field type '$gtfs_type'.")
    push!(lines, "Returns Vector{String} with validation error messages.")
    push!(lines, "\"\"\"")
    push!(lines, "function $func_name(gtfs::GTFSSchedule)")
    push!(lines, "    filename = \"$file\"")
    # Escape field name for string literal
    escaped_field_literal = replace(field, "\\" => "\\\\")
    escaped_field_literal = replace(escaped_field_literal, "\"" => "\\\"")
    push!(lines, "    field_name = \"$escaped_field_literal\"")
    push!(lines, "    file_field = :$clean_file")
    push!(lines, "    validation_errors = String[]")
    push!(lines, "")

    # Check if file exists
    push!(lines, "    # Check if file exists")
    push!(lines, "    if !hasproperty(gtfs, file_field) || gtfs.$clean_file === nothing")
    push!(lines, "        return validation_errors  # No file, no validation needed")
    push!(lines, "    end")
    push!(lines, "")

    # Check if field exists in DataFrame
    push!(lines, "    # Check if field exists in DataFrame")
    push!(lines, "    if !hasproperty(gtfs.$clean_file, :$clean_field)")
    push!(lines, "        return validation_errors  # No field, no validation needed")
    push!(lines, "    end")
    push!(lines, "")

    # Get field data
    push!(lines, "    # Get field data")
    push!(lines, "    field_data = gtfs.$clean_file.$clean_field")
    push!(lines, "")

    # Add value validation code
    value_validation_code = generate_value_validation_code(gtfs_type, field)
    if !isempty(value_validation_code)
        push!(lines, value_validation_code)
        push!(lines, "")
    end

    # Return validation errors
    push!(lines, "    return validation_errors")
    push!(lines, "end")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    generate_comprehensive_value_validator(type_mappings::Vector{FieldTypeMapping}) -> String

Generate main validation function that validates all field values.
"""
function generate_comprehensive_value_validator(type_mappings::Vector{FieldTypeMapping})
    lines = String[]

    push!(lines, "\"\"\"")
    push!(lines, "    validate_field_values(gtfs::GTFSSchedule)")
    push!(lines, "")
    push!(lines, "Comprehensive field value validation for GTFS feed.")
    push!(lines, "Validates all field values based on GTFS field types including:")
    push!(lines, "- Date format validation (YYYYMMDD)")
    push!(lines, "- Time format validation (HH:MM:SS)")
    push!(lines, "- URL format validation")
    push!(lines, "- Color format validation (6-digit hex)")
    push!(lines, "- Latitude/longitude range validation")
    push!(lines, "- Integer/float type and constraint validation")
    push!(lines, "- Enum value validation")
    push!(lines, "")
    push!(lines, "Returns ValidationResult with all validation messages.")
    push!(lines, "\"\"\"")
    push!(lines, "function validate_field_values(gtfs::GTFSSchedule)")
    push!(lines, "    messages = ValidationMessage[]")
    push!(lines, "")

    # Generate calls to individual value validators
    for mapping in type_mappings
        clean_file = replace(mapping.file, ".txt" => "")
        clean_file = replace(clean_file, ".geojson" => "")
        clean_file = replace(clean_file, "." => "_")

        # Clean field name - remove HTML entities and special characters
        clean_field = replace(mapping.field, "&nbsp;" => "_")
        clean_field = replace(clean_field, "&amp;" => "_")
        clean_field = replace(clean_field, "&lt;" => "_")
        clean_field = replace(clean_field, "&gt;" => "_")
        clean_field = replace(clean_field, "&quot;" => "_")
        clean_field = replace(clean_field, "&apos;" => "_")
        clean_field = replace(clean_field, "-" => "_")
        clean_field = replace(clean_field, "." => "_")
        clean_field = replace(clean_field, " " => "_")
        clean_field = replace(clean_field, "\\" => "_")
        clean_field = replace(clean_field, "/" => "_")
        clean_field = replace(clean_field, "(" => "_")
        clean_field = replace(clean_field, ")" => "_")
        clean_field = replace(clean_field, "[" => "_")
        clean_field = replace(clean_field, "]" => "_")
        clean_field = replace(clean_field, "{" => "_")
        clean_field = replace(clean_field, "}" => "_")
        clean_field = replace(clean_field, ":" => "_")
        clean_field = replace(clean_field, ";" => "_")
        clean_field = replace(clean_field, "," => "_")
        clean_field = replace(clean_field, "!" => "_")
        clean_field = replace(clean_field, "?" => "_")
        clean_field = replace(clean_field, "@" => "_")
        clean_field = replace(clean_field, "#" => "_")
        clean_field = replace(clean_field, "\$" => "_")
        clean_field = replace(clean_field, "%" => "_")
        clean_field = replace(clean_field, "^" => "_")
        clean_field = replace(clean_field, "&" => "_")
        clean_field = replace(clean_field, "*" => "_")
        clean_field = replace(clean_field, "+" => "_")
        clean_field = replace(clean_field, "=" => "_")
        clean_field = replace(clean_field, "|" => "_")
        clean_field = replace(clean_field, "~" => "_")
        clean_field = replace(clean_field, "`" => "_")
        clean_field = replace(clean_field, "'" => "_")
        clean_field = replace(clean_field, "\"" => "_")

        # Remove multiple consecutive underscores
        clean_field = replace(clean_field, r"_+" => "_")
        # Remove leading/trailing underscores
        clean_field = strip(clean_field, '_')

        if tryparse(Int, clean_field) !== nothing
            clean_field = "_$clean_field"
        end

        # Ensure field name is not empty
        if isempty(clean_field)
            clean_field = "unknown_field"
        end

        func_name = "validate_value_$(clean_file)_$(clean_field)"

        # Escape field name for string literal
        escaped_field_literal = replace(mapping.field, "\\" => "\\\\")
        escaped_field_literal = replace(escaped_field_literal, "\"" => "\\\"")
        push!(lines, "    # Validate values in $(mapping.file) field $(escaped_field_literal)")
        push!(lines, "    value_errors = $func_name(gtfs)")
        push!(lines, "    for error_msg in value_errors")
        push!(lines, "        push!(messages, ValidationMessage(\"$(mapping.file)\", \"$escaped_field_literal\", error_msg, :error))")
        push!(lines, "    end")
        push!(lines, "")
    end

    push!(lines, "    # Determine overall validity")
    push!(lines, "    error_count = count(msg -> msg.severity == :error, messages)")
    push!(lines, "    is_valid = error_count == 0")
    push!(lines, "")
    push!(lines, "    # Generate summary")
    push!(lines, "    summary = \"Field value validation: \$error_count errors\"")
    push!(lines, "    if is_valid")
    push!(lines, "        summary *= \" - All field values are valid\"")
    push!(lines, "    else")
    push!(lines, "        summary *= \" - Field value validation failed\"")
    push!(lines, "    end")
    push!(lines, "")
    push!(lines, "    return ValidationResult(is_valid, messages, summary)")
    push!(lines, "end")
    push!(lines, "")

    return join(lines, "\n")
end

"""
    write_value_validator_file(output_path::String, type_mappings::Vector{FieldTypeMapping})

Write the value validator file with all validation functions.
"""
function write_value_validator_file(output_path::String, type_mappings::Vector{FieldTypeMapping})
    # Create output directory if it doesn't exist
    output_dir = dirname(output_path)
    if !isdir(output_dir)
        mkpath(output_dir)
    end

    lines = String[]

    # File header
    push!(lines, "# Auto-generated file - Field value validation functions")
    push!(lines, "# Generated from GTFS specification parsing")
    push!(lines, "")
    push!(lines, "\"\"\"")
    push!(lines, "Field Value Validation Functions")
    push!(lines, "")
    push!(lines, "This module provides validation functions for GTFS field values.")
    push!(lines, "All functions validate the format and type of field values based on GTFS specifications.")
    push!(lines, "")
    push!(lines, "Usage:")
    push!(lines, "    validate_field_values(gtfs)  # Validate all field values")
    push!(lines, "    validate_value_stops_stop_lat(gtfs)  # Validate specific field")
    push!(lines, "\"\"\"")
    push!(lines, "")

    # Generate individual value validators
    push!(lines, "# Individual field value validation functions")
    push!(lines, "")

    # Keep track of generated functions to avoid duplicates
    generated_functions = Set{String}()

    for mapping in type_mappings
        # Create function name
        clean_file = replace(mapping.file, ".txt" => "")
        clean_file = replace(clean_file, ".geojson" => "")
        clean_file = replace(clean_file, "." => "_")

        # Clean field name - remove HTML entities and special characters
        clean_field = replace(mapping.field, "&nbsp;" => "_")
        clean_field = replace(clean_field, "&amp;" => "_")
        clean_field = replace(clean_field, "&lt;" => "_")
        clean_field = replace(clean_field, "&gt;" => "_")
        clean_field = replace(clean_field, "&quot;" => "_")
        clean_field = replace(clean_field, "&apos;" => "_")
        clean_field = replace(clean_field, "-" => "_")
        clean_field = replace(clean_field, "." => "_")
        clean_field = replace(clean_field, " " => "_")
        clean_field = replace(clean_field, "\\" => "_")
        clean_field = replace(clean_field, "/" => "_")
        clean_field = replace(clean_field, "(" => "_")
        clean_field = replace(clean_field, ")" => "_")
        clean_field = replace(clean_field, "[" => "_")
        clean_field = replace(clean_field, "]" => "_")
        clean_field = replace(clean_field, "{" => "_")
        clean_field = replace(clean_field, "}" => "_")
        clean_field = replace(clean_field, ":" => "_")
        clean_field = replace(clean_field, ";" => "_")
        clean_field = replace(clean_field, "," => "_")
        clean_field = replace(clean_field, "!" => "_")
        clean_field = replace(clean_field, "?" => "_")
        clean_field = replace(clean_field, "@" => "_")
        clean_field = replace(clean_field, "#" => "_")
        clean_field = replace(clean_field, "\$" => "_")
        clean_field = replace(clean_field, "%" => "_")
        clean_field = replace(clean_field, "^" => "_")
        clean_field = replace(clean_field, "&" => "_")
        clean_field = replace(clean_field, "*" => "_")
        clean_field = replace(clean_field, "+" => "_")
        clean_field = replace(clean_field, "=" => "_")
        clean_field = replace(clean_field, "|" => "_")
        clean_field = replace(clean_field, "~" => "_")
        clean_field = replace(clean_field, "`" => "_")
        clean_field = replace(clean_field, "'" => "_")
        clean_field = replace(clean_field, "\"" => "_")

        # Remove multiple consecutive underscores
        clean_field = replace(clean_field, r"_+" => "_")
        # Remove leading/trailing underscores
        clean_field = strip(clean_field, '_')

        if tryparse(Int, clean_field) !== nothing
            clean_field = "_$clean_field"
        end

        # Ensure field name is not empty
        if isempty(clean_field)
            clean_field = "unknown_field"
        end

        func_name = "validate_value_$(clean_file)_$(clean_field)"

        # Only generate if not already generated
        if !(func_name in generated_functions)
            push!(generated_functions, func_name)
            field_code = generate_value_validation_function(mapping.file, mapping.field, mapping.gtfs_type)
            push!(lines, field_code)
        end
    end

    # Generate comprehensive validator
    push!(lines, "# Comprehensive value validator")
    push!(lines, "")
    comprehensive_code = generate_comprehensive_value_validator(type_mappings)
    push!(lines, comprehensive_code)

    # Write to file
    open(output_path, "w") do io
        for line in lines
            println(io, line)
        end
    end

    println("✓ Generated value validator: $output_path")
end

# Exports
export generate_value_validation_code
export generate_value_validation_function
export generate_comprehensive_value_validator
export write_value_validator_file
