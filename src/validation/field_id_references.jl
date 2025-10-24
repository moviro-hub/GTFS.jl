# =============================================================================
# ID REFERENCE (FOREIGN KEY) VALIDATION
# =============================================================================

"""
    validate_id_references(gtfs_feed::GTFSSchedule) -> ValidationResult

Validate foreign key relationships in a GTFS feed.

Checks that ID values in fields reference existing values in referenced tables.

# Arguments
- `gtfs_feed::GTFSSchedule`: The GTFS feed to validate

# Returns
- `ValidationResult`: Validation results with referential integrity errors
"""
function validate_id_references(gtfs_feed::GTFSSchedule)
    messages = ValidationMessage[]
    validate_all_id_references!(messages, gtfs_feed)
    return create_validation_result(messages, "ID reference validation")
end

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

"""
    validate_all_id_references!(messages, gtfs_feed)

Validate all ID references across all files.
"""
function validate_all_id_references!(messages::Vector{ValidationMessage}, gtfs_feed::GTFSSchedule)
    for (filename, ref_rules) in FIELD_ID_REFERENCES
        validate_file_id_references!(messages, gtfs_feed, filename, ref_rules)
    end
end

"""
    validate_file_id_references!(messages, gtfs_feed, filename, ref_rules)

Validate all ID reference rules for a specific file.
"""
function validate_file_id_references!(messages::Vector{ValidationMessage}, gtfs_feed::GTFSSchedule, filename::String, ref_rules)
    df = get_dataframe(gtfs_feed, filename)
    df === nothing && return

    for ref_rule in ref_rules
        validate_reference!(messages, gtfs_feed, df, filename, ref_rule)
    end
end

"""
    validate_reference!(messages, gtfs_feed, df, filename, ref_rule)

Validate a single ID reference rule.
"""
function validate_reference!(messages::Vector{ValidationMessage}, gtfs_feed::GTFSSchedule, df, filename::String, ref_rule)
    field_name = ref_rule.field
    !hasproperty(df, Symbol(field_name)) && return

    column = df[!, Symbol(field_name)]

    # For conditional references (e.g., "Foreign ID referencing X or ID"),
    # allow any value - it can be either a foreign ID or an independent ID
    if ref_rule.is_conditional
        return
    end

    # Build set of valid values from all referenced tables
    valid_values = collect_valid_reference_values(gtfs_feed, ref_rule.references, ref_rule.is_conditional)

    # Skip validation if no valid reference values (e.g., when calendar.txt is missing)
    isempty(valid_values) && return

    # Check each value in the column
    for (idx, value) in enumerate(column)
        ismissing(value) && continue

        # Allow empty values for optional foreign ID references
        if string(value) == "" || string(value) == "0"
            continue
        end

        if !is_valid_reference(value, valid_values)
            ref_desc = format_reference_description(ref_rule.references)
            push!(messages, ValidationMessage(
                filename,
                field_name,
                "Row $idx: Value '$value' does not reference any valid ID in $ref_desc",
                :error
            ))
        end
    end
end

"""
    collect_valid_reference_values(gtfs_feed, references, is_conditional)

Collect all valid values from referenced tables/fields.
"""
function collect_valid_reference_values(gtfs_feed::GTFSSchedule, references, is_conditional::Bool)
    valid_values = Set()

    for ref in references
        # Get referenced table filename
        ref_filename = get_reference_filename(ref.table)
        ref_df = get_dataframe(gtfs_feed, ref_filename)

        # For conditional references, if the referenced file is missing, skip validation
        if is_conditional && ref_df === nothing
            # Referenced file is missing, this is valid for conditional references
            continue
        end

        ref_df === nothing && continue

        # Get referenced field
        ref_field = Symbol(ref.field)
        !hasproperty(ref_df, ref_field) && continue

        # Add all non-missing values to the set
        ref_column = ref_df[!, ref_field]
        for val in ref_column
            !ismissing(val) && push!(valid_values, val)
        end
    end

    return valid_values
end

"""
    get_reference_filename(table_name)

Convert table name to filename.
"""
function get_reference_filename(table_name::String)
    # Handle special case for locations (geojson)
    table_name == "locations" && return "locations.geojson"
    return table_name * ".txt"
end

"""
    is_valid_reference(value, valid_values)

Check if a value exists in the set of valid reference values.
"""
function is_valid_reference(value, valid_values::Set)
    return value in valid_values
end

"""
    format_reference_description(references)

Format a human-readable description of references.
"""
function format_reference_description(references)
    if length(references) == 1
        ref = references[1]
        return "$(ref.table).$(ref.field)"
    else
        ref_strs = ["$(ref.table).$(ref.field)" for ref in references]
        return join(ref_strs, " or ")
    end
end
