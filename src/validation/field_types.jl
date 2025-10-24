# =============================================================================
# FIELD TYPE VALIDATION
# =============================================================================

"""
    validate_field_types(gtfs_feed::GTFSSchedule) -> ValidationResult

Validate all fields in a GTFS feed against their expected types.

# Arguments
- `gtfs_feed::GTFSSchedule`: The GTFS feed to validate (Dict of DataFrames)

# Returns
- `ValidationResult`: Validation results with errors and statistics
"""
function validate_field_types(gtfs_feed::GTFSSchedule)
    messages = ValidationMessage[]
    stats = validate_all_fields!(messages, gtfs_feed)
    return create_validation_result(messages, "Field type validation")
end

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

"""
    validate_all_fields!(messages, gtfs_feed)

Validate all fields in all files of the GTFS feed.
"""
function validate_all_fields!(messages::Vector{ValidationMessage}, gtfs_feed::GTFSSchedule)
    files_validated = 0
    fields_validated = 0

    for (filename, df) in gtfs_feed
        df === nothing && continue
        file_types = get(FIELD_TYPES, filename, nothing)
        file_types === nothing && continue

        files_validated += 1

        for field_info in file_types
            !hasproperty(df, Symbol(field_info.field)) && continue

            validator = get_validator_for_field(field_info)
            validator === nothing && continue

            fields_validated += 1
            validate_field!(messages, df, field_info, filename, validator)
        end
    end

    return (files=files_validated, fields=fields_validated)
end

"""
    validate_field!(messages, df, field_info, filename, validator)

Validate a single field against its expected type.
"""
function validate_field!(messages::Vector{ValidationMessage}, df, field_info, filename::String, validator)
    column = df[!, Symbol(field_info.field)]
    type_name = string(field_info.type_symbol)

    for (idx, value) in enumerate(column)
        ismissing(value) && continue
        validator(value) || push!(messages, ValidationMessage(
            filename,
            field_info.field,
            "Row $idx: Value '$value' does not match expected type $type_name",
            :error
        ))
    end
end

"""
    get_validator_for_field(field_info)

Get the appropriate validation function for a field based on its type.
"""
function get_validator_for_field(field_info)
    # Use the type_symbol directly for validator lookup
    type_symbol = field_info.type_symbol

    # Look up the validator in GTFS_TYPE_VALIDATORS
    validator = get(GTFS_TYPE_VALIDATORS, type_symbol, nothing)

    return validator
end
