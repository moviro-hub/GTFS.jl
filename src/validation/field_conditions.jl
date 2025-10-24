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
    if presence == "Required"
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
    if missing_count > 0
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
    cross_file_met = isempty(cross_file_conditions) ||
                     any(c -> _condition_holds_for_row_cross_file(gtfs, c), cross_file_conditions)

    # If cross-file conditions not met, skip this rule entirely
    if !cross_file_met
        return
    end

    # Check if field exists
    field_exists = df_has_column(df, Symbol(field_name))
    column = field_exists ? df[!, Symbol(field_name)] : nothing

    # Iterate through each row for same-file conditions
    for (row_idx, row) in enumerate(eachrow(df))
        # Check same-file conditions for this specific row
        # Use different logic based on rule type:
        # - Required rules: use AND logic (all conditions must be true)
        # - Forbidden rules: use OR logic (any condition being true triggers the rule)
        if get(rule, :required, false)
            same_file_met = isempty(same_file_conditions) ||
                            all(cond -> _condition_holds_for_row(row, cond), same_file_conditions)
        elseif get(rule, :forbidden, false)
            same_file_met = isempty(same_file_conditions) ||
                            any(cond -> _condition_holds_for_row(row, cond), same_file_conditions)
        else
            same_file_met = true  # Optional rules
        end

        # Condition is met if both same-file and cross-file conditions are satisfied
        conditions_met = same_file_met && cross_file_met

        if conditions_met
            if field_exists
                cell_value = column[row_idx]
            else
                cell_value = missing
            end

            if get(rule, :required, false)
                # Conditionally required: value must not be missing
                if ismissing(cell_value)
                    push!(messages, ValidationMessage(
                        filename,
                        field_name,
                        "Row $row_idx: Conditionally required field '$field_name' is missing (condition met)",
                        :error
                    ))
                end
            elseif get(rule, :forbidden, false)
                # Conditionally forbidden: value must be missing or empty
                if !ismissing(cell_value) && cell_value != ""
                    push!(messages, ValidationMessage(
                        filename,
                        field_name,
                        "Row $row_idx: Conditionally forbidden field '$field_name' has value '$cell_value' (condition met)",
                        :error
                    ))
                end
            end
        end
    end
end

"""
    should_skip_conditional_validation(gtfs, df, filename, rule)

Determine if conditional validation should be skipped based on the actual data structure.
This makes validation more lenient for real-world GTFS feeds by analyzing the rules and data dynamically.
Uses both field_conditions.jl and field_enum_values.jl rules to make intelligent decisions.
"""
function should_skip_conditional_validation(gtfs::GTFSSchedule, df, filename::String, rule)
    field_name = rule.field
    conditions = get(rule, :conditions, [])

    # Use enum rules to understand the field's purpose and requirements
    enum_info = get_enum_info_for_field(filename, field_name)

    # Analyze the conditions to understand what triggers the requirement
    # This is completely data-driven - no hardcoded values

    # Analyze conditions dynamically to understand what triggers the requirement
    # This is completely data-driven - no hardcoded field names or filenames

    # Extract the field that triggers the condition from the rules
    trigger_field = nothing
    trigger_values = Set()

    for cond in conditions
        if haskey(cond, :field) && haskey(cond, :value)
            if trigger_field === nothing
                trigger_field = cond[:field]
            end
            if trigger_field == cond[:field]
                push!(trigger_values, cond[:value])
            end
        end
    end

    # If we found a trigger field and values, check if the data actually has those values
    if trigger_field !== nothing && !isempty(trigger_values) && hasproperty(df, Symbol(trigger_field))
        trigger_column = df[!, Symbol(trigger_field)]
        has_triggering_values = any(row ->
            !ismissing(getproperty(row, Symbol(trigger_field))) &&
            string(getproperty(row, Symbol(trigger_field))) in trigger_values,
            eachrow(df)
        )

        # Only validate if there are actually values that would trigger the requirement
        return !has_triggering_values
    end

    # For other fields, use enum rules to determine if validation should be skipped
    if enum_info !== nothing
        # If the field has allow_empty = true, be more lenient with validation
        if get(enum_info, :allow_empty, false)
            # For fields that allow empty values, only validate if the field is actually used
            # Check if there are any non-empty values in the field
            if hasproperty(df, Symbol(field_name))
                column = df[!, Symbol(field_name)]
                has_non_empty_values = any(value -> !ismissing(value) && value != "", column)

                # If field allows empty and has no non-empty values, skip validation
                if !has_non_empty_values
                    return true
                end
            end
        end
    end

    # For fields that are conditionally required but the conditions are complex,
    # be more lenient if the field is not actually used in the data
    if hasproperty(df, Symbol(field_name))
        column = df[!, Symbol(field_name)]
        has_any_values = any(value -> !ismissing(value), column)

        # If the field has no values at all, skip validation for conditional requirements
        if !has_any_values
            return true
        end
    end

    # For other fields, analyze the conditions dynamically
    # This could be extended for other field relationships

    return false
end

"""
    get_enum_info_for_field(filename, field_name)

Get enum information for a specific field from the enum rules.
"""
function get_enum_info_for_field(filename::String, field_name::String)
    # ENUM_RULES is already imported in the Validations module
    try
        # Check if the file has enum rules
        if haskey(ENUM_RULES, filename)
            file_rules = ENUM_RULES[filename]

            # Find the rule for this specific field
            for rule in file_rules
                if rule.field == field_name
                    return rule
                end
            end
        end

        return nothing
    catch
        return nothing
    end
end

"""
    _condition_holds_for_row(row, cond)

Check if a condition holds for a specific row.
"""
function _condition_holds_for_row(row::DataFrames.DataFrameRow, cond)
    if !haskey(cond, :type)
        return true
    end

    if cond[:type] === :field
        # Get the field value from the current row
        field_name = cond[:field]

        # Handle prefixed field names (e.g., "stop_times.location_type" -> "location_type")
        if occursin(".", field_name)
            field_name = split(field_name, ".")[end]
        end

        # Check if field exists in this row
        field_sym = Symbol(field_name)
        if !hasproperty(row, field_sym)
            # Field doesn't exist - treat as missing/empty
            row_value = missing
        else
            # Get the value from this row
            row_value = getproperty(row, field_sym)
        end

        expected_value = cond[:value]

        # Handle different comparison cases
        if expected_value == ""
            # Empty string condition: check if field is missing or empty
            return ismissing(row_value) || string(row_value) == ""
        elseif expected_value == "defined"
            # Defined condition: check if field is not missing and not empty
            return !ismissing(row_value) && string(row_value) != ""
        else
            # Exact match: compare string representations
            if ismissing(row_value)
                return false
            end
            return string(row_value) == string(expected_value)
        end
    end

    # For other condition types, return true (not row-specific)
    return true
end

"""
    _condition_holds_for_row_cross_file(gtfs::GTFSSchedule, cond)

Handle conditions that reference other files by checking across the entire target file.

# Arguments
- `gtfs::GTFSSchedule`: The complete GTFS dataset
- `cond`: The condition to evaluate

# Returns
- `Bool`: True if the condition is met
"""
function _condition_holds_for_row_cross_file(gtfs::GTFSSchedule, cond)
    # Handle conditions that reference other files
    if !haskey(cond, :type) || cond[:type] !== :field
        return true
    end

    target_file = cond[:file]
    field_name = cond[:field]

    # Strip table prefix from field name
    if occursin(".", field_name)
        field_name = split(field_name, ".")[end]
    end

    # Get the target dataframe
    df = get_dataframe(gtfs, target_file)
    df === nothing && return false

    # Check if field exists
    field_sym = Symbol(field_name)
    if !df_has_column(df, field_sym)
        # Field missing treated as empty for "" condition
        return cond[:value] == ""
    end

    # Check the condition across all rows in the target file
    expected_value = cond[:value]
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
