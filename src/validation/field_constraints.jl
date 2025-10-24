# =============================================================================
# FIELD CONSTRAINTS VALIDATION
# =============================================================================

"""
    validate_field_constraints(gtfs_feed::GTFSSchedule) -> ValidationResult

Validate all fields in a GTFS feed against their constraints.
Returns ValidationResult with messages and summary.
"""
function validate_field_constraints(gtfs_feed::GTFSSchedule)
    messages = ValidationMessage[]
    validate_all_constraints!(messages, gtfs_feed)
    return create_validation_result(messages, "Field constraints validation")
end

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

"""
    validate_all_constraints!(messages, gtfs_feed)

Validate all field constraints across all files.
"""
function validate_all_constraints!(messages::Vector{ValidationMessage}, gtfs_feed::GTFSSchedule)
    for (filename, constraints) in FIELD_CONSTRAINTS
        validate_file_constraints!(messages, gtfs_feed, filename, constraints)
    end
end

"""
    validate_file_constraints!(messages, gtfs_feed, filename, constraints)

Validate all constraints for a specific file.
"""
function validate_file_constraints!(messages::Vector{ValidationMessage}, gtfs_feed::GTFSSchedule, filename::String, constraints)
    df = get_dataframe(gtfs_feed, filename)
    df === nothing && return

    for constraint_rule in constraints
        validate_constraint!(messages, df, filename, constraint_rule)
    end
end

"""
    validate_constraint!(messages, df, filename, constraint_rule)

Validate a single field constraint.
"""
function validate_constraint!(messages::Vector{ValidationMessage}, df, filename::String, constraint_rule)
    field_name = constraint_rule.field
    !hasproperty(df, Symbol(field_name)) && return

    validator = get(GTFS_CONSTRAINTS_VALIDATORS, constraint_rule.constraint, nothing)
    validator === nothing && return

    column = df[!, Symbol(field_name)]
    constraint_name = constraint_rule.constraint

    # Use unified constraint checking
    _validate_field_constraint!(messages, column, validator, filename, field_name, constraint_name)
end

"""
    _validate_field_constraint!(messages, column, validator, filename, field_name, constraint_name)

Unified constraint validation that handles both column-level and element-level constraints.
"""
function _validate_field_constraint!(messages::Vector{ValidationMessage}, column, validator,
                                   filename::String, field_name::String, constraint_name::String)
    if constraint_name == "Unique"
        _validate_column_constraint!(messages, column, validator, filename, field_name, constraint_name)
    else
        _validate_element_constraint!(messages, column, validator, filename, field_name, constraint_name)
    end
end

"""
    _validate_column_constraint!(messages, column, validator, filename, field_name, constraint_name)

Validate a constraint that applies to the entire column (e.g., Unique).
"""
function _validate_column_constraint!(messages::Vector{ValidationMessage}, column, validator,
                                   filename::String, field_name::String, constraint_name::String)
    if !validator(column)
        push!(messages, ValidationMessage(
            filename,
            field_name,
            "Field '$field_name' violates constraint: $constraint_name",
            :error
        ))
    end
end

"""
    _validate_element_constraint!(messages, column, validator, filename, field_name, constraint_name)

Validate a constraint that applies to individual elements (e.g., Non-negative, Positive).
"""
function _validate_element_constraint!(messages::Vector{ValidationMessage}, column, validator,
                                     filename::String, field_name::String, constraint_name::String)
    for (idx, value) in enumerate(column)
        ismissing(value) && continue

        if !validator(value)
            push!(messages, ValidationMessage(
                filename,
                field_name,
                "Row $idx: Value '$value' violates constraint: $constraint_name",
                :error
            ))
        end
    end
end
