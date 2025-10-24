# =============================================================================
# ENUM VALUES VALIDATION
# =============================================================================

"""
    validate_enum_values(gtfs::GTFSSchedule) -> ValidationResult

Validate enum fields against their allowed values defined in ENUM_RULES.
Returns ValidationResult with messages and summary.
"""
function validate_enum_values(gtfs::GTFSSchedule)
    messages = ValidationMessage[]
    validate_all_enum_rules!(messages, gtfs)
    return create_validation_result(messages, "Enum values validation")
end

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

"""
    validate_all_enum_rules!(messages, gtfs)

Validate all enum rules across all files.
"""
function validate_all_enum_rules!(messages::Vector{ValidationMessage}, gtfs::GTFSSchedule)
    for (filename, rules) in ENUM_RULES
        validate_file_enum_rules!(messages, gtfs, filename, rules)
    end
end

"""
    validate_file_enum_rules!(messages, gtfs, filename, rules)

Validate all enum rules for a specific file.
"""
function validate_file_enum_rules!(messages::Vector{ValidationMessage}, gtfs::GTFSSchedule, filename::String, rules)
    df = get_dataframe(gtfs, filename)
    df === nothing && return

    for rule in rules
        validate_enum_field!(messages, df, filename, rule)
    end
end

"""
    validate_enum_field!(messages, df, filename, rule)

Validate a single enum field.
"""
function validate_enum_field!(messages::Vector{ValidationMessage}, df, filename::String, rule)
    field_name = rule.field
    !hasproperty(df, Symbol(field_name)) && return

    column = df[!, Symbol(field_name)]
    allowed_values = extract_allowed_values(rule.enum_values)
    allow_empty = get(rule, :allow_empty, false)
    empty_maps_to = get(rule, :empty_maps_to, nothing)

    for (idx, value) in enumerate(column)
        # Check if value is missing or empty
        if ismissing(value) || (isa(value, AbstractString) && isempty(value))
            if !allow_empty
                push!(messages, ValidationMessage(
                    filename,
                    field_name,
                    "Row $idx: Field '$field_name' is empty but allow_empty=false. Allowed values: $(join(allowed_values, ", "))",
                    :error
                ))
            end
            # If allow_empty is true, missing/empty values are valid
            continue
        end

        # Validate non-empty values
        if !is_valid_enum_value(value, allowed_values, rule)
            push!(messages, ValidationMessage(
                filename,
                field_name,
                "Row $idx: Invalid enum value '$value' for field '$field_name'. Allowed values: $(join(allowed_values, ", "))",
                :error
            ))
        end
    end
end

"""
    extract_allowed_values(enum_values)

Extract the list of allowed values from enum_values definition.
"""
function extract_allowed_values(enum_values)
    # Use unique to handle duplicates, then convert to sorted array for display
    return unique([ev.value for ev in enum_values])
end

"""
    is_valid_enum_value(value, allowed_values, rule)

Check if a value is valid according to enum rules.
"""
function is_valid_enum_value(value, allowed_values, rule)
    # Simple check: is the value in the allowed list?
    return value in allowed_values
end
