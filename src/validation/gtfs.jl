# =============================================================================
# COMPREHENSIVE GTFS VALIDATION
# =============================================================================

"""
    validate_gtfs(gtfs_feed::GTFSSchedule) -> ValidationResult

Apply all GTFS validators to a feed and return comprehensive results.

This function runs:
- Field type validation
- Field conditions validation
- File conditions validation
- Enum values validation
- Field constraints validation

# Arguments
- `gtfs_feed::GTFSSchedule`: The GTFS feed to validate

# Returns
- `ValidationResult`: Combined validation results from all validators

# Examples
```julia
using GTFS

gtfs = read_gtfs("path/to/gtfs")
result = GTFS.Validations.validate_gtfs(gtfs)
GTFS.Validations.print_validation_results(result)

if GTFS.Validations.has_validation_errors(result)
    println("Validation failed!")
else
    println("All validations passed!")
end
```
"""
function validate_gtfs(gtfs_feed::GTFSSchedule)
    all_messages = ValidationMessage[]

    # Run all validators and collect messages
    result1 = validate_field_types(gtfs_feed)
    append!(all_messages, result1.messages)

    result2 = validate_field_conditions(gtfs_feed)
    append!(all_messages, result2.messages)

    result3 = validate_file_conditions(gtfs_feed)
    append!(all_messages, result3.messages)

    result4 = validate_enum_values(gtfs_feed)
    append!(all_messages, result4.messages)

    result5 = validate_field_constraints(gtfs_feed)
    append!(all_messages, result5.messages)

    result6 = validate_id_references(gtfs_feed)
    append!(all_messages, result6.messages)

    # Create comprehensive result
    return create_validation_result(all_messages, "Comprehensive GTFS validation")
end
