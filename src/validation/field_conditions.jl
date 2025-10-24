# =============================================================================
# FIELD CONDITIONS VALIDATION
# =============================================================================

"""
    validate_field_conditions(gtfs::GTFSSchedule) -> ValidationResult

Validate field presence for a GTFS feed against FIELD_RULES.
Returns ValidationResult with messages and summary.
"""
function validate_field_conditions(gtfs::GTFSSchedule)
    messages = ValidationMessage[]
    validate_all_field_rules!(messages, gtfs)
    return create_validation_result(messages, "Field presence validation")
end

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

"""
    validate_all_field_rules!(messages, gtfs)

Validate all field rules across all files.
"""
function validate_all_field_rules!(messages::Vector{ValidationMessage}, gtfs::GTFSSchedule)
    for (filename, rules) in FIELD_RULES
        validate_file_rules!(messages, gtfs, filename, rules)
    end
    return
end

"""
    validate_file_rules!(messages, gtfs, filename, rules)

Validate all rules for a specific file.
"""
function validate_file_rules!(messages::Vector{ValidationMessage}, gtfs::GTFSSchedule, filename::String, rules)
    df = get_dataframe(gtfs, filename)
    df === nothing && return

    for rule in rules
        validate_single_rule!(messages, gtfs, df, filename, rule)
    end
    return
end

"""
    validate_single_rule!(messages, gtfs, df, filename, rule)

Validate a single field rule.
"""
function validate_single_rule!(messages::Vector{ValidationMessage}, gtfs::GTFSSchedule, df, filename::String, rule)
    field_name = rule.field
    presence = rule.presence

    # Check if column exists
    if !df_has_column(df, Symbol(field_name))
        # For conditionally required/forbidden fields, we need to check conditions even when field is missing
        if presence in ["Conditionally Required", "Conditionally Forbidden"]
            check_conditional_field!(messages, gtfs, df, filename, rule)
        else
            handle_missing_column!(messages, filename, field_name, presence)
        end
        return
    end

    col_data = getproperty(df, Symbol(field_name))

    # Dispatch based on presence type
    if presence == "Required"
        check_required_field!(messages, filename, field_name, col_data)
    elseif presence == "Optional"
        # Optional fields are always valid
        return
    else
        # Conditional presence
        check_conditional_field!(messages, gtfs, df, filename, rule)
    end
end

"""
    handle_missing_column!(messages, filename, field_name, presence)

Handle cases where a required column is missing.
"""
function handle_missing_column!(messages::Vector{ValidationMessage}, filename::String, field_name::String, presence::String)
    return if presence == "Required"
        push!(messages, ValidationMessage(filename, field_name, "Required field '$field_name' not present in table", :error))
    elseif presence == "Optional"
        push!(messages, ValidationMessage(filename, field_name, "Optional field '$field_name' validation skipped", :info))
    else
        push!(messages, ValidationMessage(filename, field_name, "Field '$field_name' not present - conditional validation skipped", :info))
    end
end

"""
    check_required_field!(messages, filename, field_name, col_data)

Check a required field for missing values.
"""
function check_required_field!(messages::Vector{ValidationMessage}, filename::String, field_name::String, col_data)
    missing_count = count(ismissing, col_data)
    return if missing_count > 0
        push!(messages, ValidationMessage(filename, field_name, "Required field '$field_name' has $missing_count missing values", :error))
    else
        push!(messages, ValidationMessage(filename, field_name, "Required field '$field_name' has no missing values", :info))
    end
end

"""
    check_conditional_field!(messages, gtfs, df, filename, rule)

Check a conditionally present field.
"""
function check_conditional_field!(messages::Vector{ValidationMessage}, gtfs::GTFSSchedule, df, filename::String, rule)
    field_name = rule.field
    conditions = get(rule, :conditions, [])

    # Separate same-file and cross-file conditions
    same_file_conditions = filter(c -> !haskey(c, :file) || c[:file] == filename, conditions)
    cross_file_conditions = filter(c -> haskey(c, :file) && c[:file] != filename, conditions)

    # Evaluate cross-file conditions once (not per-row)
    cross_file_met = _evaluate_cross_file_conditions(gtfs, cross_file_conditions)
    if !cross_file_met
        return
    end

    # Check if field exists
    field_exists = df_has_column(df, Symbol(field_name))
    column = field_exists ? df[!, Symbol(field_name)] : nothing

    # Validate each row
    for (row_idx, row) in enumerate(eachrow(df))
        _validate_conditional_row!(
            messages, gtfs, df, filename, rule, row, row_idx,
            same_file_conditions, cross_file_met, field_exists, column
        )
    end
    return
end

"""
    _evaluate_cross_file_conditions(gtfs, cross_file_conditions) -> Bool

Evaluate cross-file conditions once for the entire validation.
"""
function _evaluate_cross_file_conditions(gtfs::GTFSSchedule, cross_file_conditions)
    return isempty(cross_file_conditions) ||
        any(c -> _condition_holds_for_row_cross_file(gtfs, c), cross_file_conditions)
end

"""
    _validate_conditional_row!(messages, gtfs, df, filename, rule, row, row_idx,
                             same_file_conditions, cross_file_met, field_exists, column)

Validate a single row for conditional field requirements.
"""
function _validate_conditional_row!(
        messages::Vector{ValidationMessage}, gtfs::GTFSSchedule, df,
        filename::String, rule, row, row_idx,
        same_file_conditions, cross_file_met, field_exists, column
    )
    field_name = rule.field

    # Evaluate same-file conditions for this row
    same_file_met = _evaluate_same_file_conditions(row, same_file_conditions, rule)

    # Both conditions must be met
    conditions_met = same_file_met && cross_file_met

    if !conditions_met
        return
    end

    # Get cell value
    cell_value = field_exists ? column[row_idx] : missing

    # Validate based on rule type
    return if get(rule, :required, false)
        _validate_conditionally_required!(messages, filename, field_name, row_idx, cell_value)
    elseif get(rule, :forbidden, false)
        _validate_conditionally_forbidden!(messages, filename, field_name, row_idx, cell_value)
    end
end

"""
    _evaluate_same_file_conditions(row, same_file_conditions, rule) -> Bool

Evaluate same-file conditions for a specific row.
"""
function _evaluate_same_file_conditions(row, same_file_conditions, rule)
    if isempty(same_file_conditions)
        return true
    end

    if get(rule, :required, false)
        # Required rules: use AND logic (all conditions must be true)
        return all(cond -> _condition_holds_for_row(row, cond), same_file_conditions)
    elseif get(rule, :forbidden, false)
        # Forbidden rules: use OR logic (any condition being true triggers the rule)
        return any(cond -> _condition_holds_for_row(row, cond), same_file_conditions)
    else
        return true  # Optional rules
    end
end

"""
    _validate_conditionally_required!(messages, filename, field_name, row_idx, cell_value)

Validate a conditionally required field.
"""
function _validate_conditionally_required!(
        messages::Vector{ValidationMessage}, filename::String,
        field_name::String, row_idx::Int, cell_value
    )
    return if ismissing(cell_value)
        push!(
            messages, ValidationMessage(
                filename,
                field_name,
                "Row $row_idx: Conditionally required field '$field_name' is missing (condition met)",
                :error
            )
        )
    end
end

"""
    _validate_conditionally_forbidden!(messages, filename, field_name, row_idx, cell_value)

Validate a conditionally forbidden field.
"""
function _validate_conditionally_forbidden!(
        messages::Vector{ValidationMessage}, filename::String,
        field_name::String, row_idx::Int, cell_value
    )
    return if !ismissing(cell_value) && cell_value != ""
        push!(
            messages, ValidationMessage(
                filename,
                field_name,
                "Row $row_idx: Conditionally forbidden field '$field_name' has value '$cell_value' (condition met)",
                :error
            )
        )
    end
end


# =============================================================================
# CONDITION EVALUATION HELPERS
# =============================================================================

"""
    _condition_holds_for_row(row, cond) -> Bool

Check if a condition holds for a specific row.
"""
function _condition_holds_for_row(row::DataFrames.DataFrameRow, cond)
    if !haskey(cond, :type)
        return true
    end

    if cond[:type] === :field
        return _evaluate_field_condition_for_row(row, cond)
    end

    # For other condition types, return true (not row-specific)
    return true
end

"""
    _evaluate_field_condition_for_row(row, cond) -> Bool

Evaluate a field condition for a specific row.
"""
function _evaluate_field_condition_for_row(row::DataFrames.DataFrameRow, cond)
    field_name = _extract_field_name(cond[:field])
    row_value = _get_row_field_value(row, field_name)
    expected_value = cond[:value]

    return _compare_field_values(row_value, expected_value)
end

"""
    _extract_field_name(field_name) -> String

Extract field name, handling prefixed names (e.g., "stop_times.location_type" -> "location_type").
"""
function _extract_field_name(field_name::String)
    return occursin(".", field_name) ? split(field_name, ".")[end] : field_name
end

"""
    _get_row_field_value(row, field_name) -> Any

Get field value from row, returning missing if field doesn't exist.
"""
function _get_row_field_value(row::DataFrames.DataFrameRow, field_name::String)
    field_sym = Symbol(field_name)
    return hasproperty(row, field_sym) ? getproperty(row, field_sym) : missing
end

"""
    _compare_field_values(row_value, expected_value) -> Bool

Compare field values based on expected value type.
"""
function _compare_field_values(row_value, expected_value)
    if expected_value == ""
        # Empty string condition: check if field is missing or empty
        return ismissing(row_value) || string(row_value) == ""
    elseif expected_value == "defined"
        # Defined condition: check if field is not missing and not empty
        return !ismissing(row_value) && string(row_value) != ""
    else
        # Exact match: compare string representations
        return !ismissing(row_value) && string(row_value) == string(expected_value)
    end
end

"""
    _condition_holds_for_row_cross_file(gtfs::GTFSSchedule, cond) -> Bool

Handle conditions that reference other files by checking across the entire target file.
"""
function _condition_holds_for_row_cross_file(gtfs::GTFSSchedule, cond)
    if !haskey(cond, :type) || cond[:type] !== :field
        return true
    end

    target_file = cond[:file]
    field_name = _extract_field_name(cond[:field])

    # Get the target dataframe
    df = get_dataframe(gtfs, target_file)
    df === nothing && return false

    # Check if field exists
    field_sym = Symbol(field_name)
    if !df_has_column(df, field_sym)
        return cond[:value] == ""  # Field missing treated as empty for "" condition
    end

    # Check the condition across all rows in the target file
    return _evaluate_cross_file_field_condition(df, field_sym, cond[:value])
end

"""
    _evaluate_cross_file_field_condition(df, field_sym, expected_value) -> Bool

Evaluate field condition across all rows in a cross-file reference.
"""
function _evaluate_cross_file_field_condition(df, field_sym::Symbol, expected_value)
    column = df[!, field_sym]

    if expected_value == ""
        # True if all values are missing or empty
        return all(v -> ismissing(v) || string(v) == "", column)
    elseif expected_value == "defined"
        # True if any value is defined
        return any(v -> !ismissing(v) && string(v) != "", column)
    else
        # True if any value matches
        return any(v -> !ismissing(v) && string(v) == string(expected_value), column)
    end
end
