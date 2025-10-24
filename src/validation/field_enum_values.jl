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
    allowed_values = _extract_allowed_values(rule.enum_values)
    allow_empty = get(rule, :allow_empty, false)

    for (idx, value) in enumerate(column)
        _validate_enum_value!(messages, filename, field_name, idx, value, allowed_values, allow_empty)
    end
end

"""
    _validate_enum_value!(messages, filename, field_name, idx, value, allowed_values, allow_empty)

Validate a single enum value.
"""
function _validate_enum_value!(messages::Vector{ValidationMessage}, filename::String,
                              field_name::String, idx::Int, value, allowed_values, allow_empty::Bool)
        # Check if value is missing or empty
        if ismissing(value) || (isa(value, AbstractString) && isempty(value))
            if !allow_empty
            _add_enum_empty_error!(messages, filename, field_name, idx, allowed_values)
        end
        return
    end

    # Validate non-empty values
    if !(value in allowed_values)
        _add_enum_invalid_value_error!(messages, filename, field_name, idx, value, allowed_values)
    end
end

"""
    _add_enum_empty_error!(messages, filename, field_name, idx, allowed_values)

Add error message for empty enum value when not allowed.
"""
function _add_enum_empty_error!(messages::Vector{ValidationMessage}, filename::String,
                               field_name::String, idx::Int, allowed_values)
                push!(messages, ValidationMessage(
                    filename,
                    field_name,
                    "Row $idx: Field '$field_name' is empty but allow_empty=false. Allowed values: $(join(allowed_values, ", "))",
                    :error
                ))
            end

"""
    _add_enum_invalid_value_error!(messages, filename, field_name, idx, value, allowed_values)

Add error message for invalid enum value.
"""
function _add_enum_invalid_value_error!(messages::Vector{ValidationMessage}, filename::String,
                                       field_name::String, idx::Int, value, allowed_values)
            push!(messages, ValidationMessage(
                filename,
                field_name,
                "Row $idx: Invalid enum value '$value' for field '$field_name'. Allowed values: $(join(allowed_values, ", "))",
                :error
            ))
end

"""
    _extract_allowed_values(enum_values)

Extract the list of allowed values from enum_values definition.
"""
function _extract_allowed_values(enum_values)
    return unique([ev.value for ev in enum_values])
end
