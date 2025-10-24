# =============================================================================
# FILE CONDITIONS VALIDATION
# =============================================================================

"""
    validate_file_conditions(gtfs::GTFSSchedule) -> ValidationResult

Validate file presence for a GTFS feed against FILE_RULES.
Returns ValidationResult with messages and summary.
"""
function validate_file_conditions(gtfs::GTFSSchedule)
    messages = ValidationMessage[]
    validate_all_file_rules!(messages, gtfs)
    return create_validation_result(messages, "File presence validation")
end

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

"""
    validate_all_file_rules!(messages, gtfs)

Validate all file rules.
"""
function validate_all_file_rules!(messages::Vector{ValidationMessage}, gtfs::GTFSSchedule)
    for (filename, spec) in FILE_RULES
        validate_file_spec!(messages, gtfs, filename, spec)
    end
    return
end

"""
    validate_file_spec!(messages, gtfs, filename, spec)

Validate a single file specification.
"""
function validate_file_spec!(messages::Vector{ValidationMessage}, gtfs::GTFSSchedule, filename::String, spec)
    presence = spec.presence
    exists = gtfs_has_table(gtfs, filename_to_table_symbol(filename))

    return if presence == "Required"
        check_required_file!(messages, filename, exists)
    elseif presence == "Optional"
        push!(messages, ValidationMessage(filename, nothing, "Optional file '$filename' validation skipped", :info))
    else
        # Conditional presence
        check_conditional_file!(messages, gtfs, filename, spec)
    end
end

"""
    check_required_file!(messages, filename, exists)

Check if a required file is present.
"""
function check_required_file!(messages::Vector{ValidationMessage}, filename::String, exists::Bool)
    return if !exists
        push!(messages, ValidationMessage(filename, nothing, "Required file '$filename' is missing", :error))
    else
        push!(messages, ValidationMessage(filename, nothing, "Required file '$filename' is present", :info))
    end
end

"""
    check_conditional_file!(messages, gtfs, filename, spec)

Check a conditionally present file.
"""
function check_conditional_file!(messages::Vector{ValidationMessage}, gtfs::GTFSSchedule, filename::String, spec)
    exists = gtfs_has_table(gtfs, filename_to_table_symbol(filename))
    any_relation_met = false

    for rel in spec.relations
        if _evaluate_file_relation_conditions(gtfs, rel)
            any_relation_met = true
            _validate_file_relation!(messages, filename, exists, rel)
        end
    end

    return if !any_relation_met
        push!(messages, ValidationMessage(filename, nothing, "File '$filename' conditions not met - no validation required", :info))
    end
end

"""
    _evaluate_file_relation_conditions(gtfs, rel) -> Bool

Evaluate conditions for a file relation.
"""
function _evaluate_file_relation_conditions(gtfs::GTFSSchedule, rel)
    conditions = get(rel, :when_all, [])
    return all(cond -> _condition_holds(gtfs, cond), conditions)
end

"""
    _validate_file_relation!(messages, filename, exists, rel)

Validate a file relation based on its type.
"""
function _validate_file_relation!(messages::Vector{ValidationMessage}, filename::String, exists::Bool, rel)
    return if get(rel, :required, false)
        _validate_conditionally_required_file!(messages, filename, exists)
    elseif get(rel, :forbidden, false)
        _validate_conditionally_forbidden_file!(messages, filename, exists)
    else
        # Optional case - file can be absent without error
        push!(messages, ValidationMessage(filename, nothing, "File '$filename' is optional (alternative exists)", :info))
    end
end

"""
    _validate_conditionally_required_file!(messages, filename, exists)

Validate a conditionally required file.
"""
function _validate_conditionally_required_file!(messages::Vector{ValidationMessage}, filename::String, exists::Bool)
    return if !exists
        push!(messages, ValidationMessage(filename, nothing, "Conditionally required file '$filename' is missing", :error))
    else
        push!(messages, ValidationMessage(filename, nothing, "Conditionally required file '$filename' is present", :info))
    end
end

"""
    _validate_conditionally_forbidden_file!(messages, filename, exists)

Validate a conditionally forbidden file.
"""
function _validate_conditionally_forbidden_file!(messages::Vector{ValidationMessage}, filename::String, exists::Bool)
    return if exists
        push!(messages, ValidationMessage(filename, nothing, "Conditionally forbidden file '$filename' is present", :error))
    else
        push!(messages, ValidationMessage(filename, nothing, "Conditionally forbidden file '$filename' is correctly absent", :info))
    end
end
