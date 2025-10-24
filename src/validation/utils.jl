# =============================================================================
# TYPE VALIDATION FUNCTIONS
# =============================================================================

function validate_color(value::String)
    return match(r"^[0-9A-Fa-f]{6}$", value) !== nothing
end
validate_color(value::Missing) = true
validate_color(value::Any) = false

function validate_currency_code(value::String)
    return match(r"^[A-Za-z]{3}$", value) !== nothing
end
validate_currency_code(value::Missing) = true
validate_currency_code(value::Any) = false

function validate_currency_amount(value::String)
    return match(r"^[\d\.\-]+$", value) !== nothing
end
validate_currency_amount(value::Missing) = true
validate_currency_amount(value::Any) = false

function validate_date(value::String)
    if match(r"^\d{8}$", value) === nothing
        return false
    end

    # Parse the date and check if it's valid
    year = parse(Int, value[1:4])
    month = parse(Int, value[5:6])
    day = parse(Int, value[7:8])

    try
        Date(year, month, day)
        return true
    catch
        return false
    end
end
validate_date(value::Missing) = true
validate_date(value::Any) = false

function validate_email(value::String)
    return match(r"^[a-zA-Z0–9._%+-]+@[a-zA-Z0–9.-]+\.[a-zA-Z]{2,}$", value) !== nothing
end
validate_email(value::Missing) = true
validate_email(value::Any) = false

function validate_enum(value::Int64)
    return true  # Int64 values are always valid enums
end
validate_enum(value::Missing) = true
validate_enum(value::Any) = false

function validate_id(value::String)
    # GTFS IDs can contain any characters as long as they're not empty
    return !isempty(value)
end
validate_id(value::Missing) = true
validate_id(value::Any) = false

function validate_language_code(value::String)
    return match(r"^[a-z]{2}(-[A-Z]{2})?$", value) !== nothing
end
validate_language_code(value::Missing) = true
validate_language_code(value::Any) = false

function validate_latitude(value::Float64)
    return value >= -90.0 && value <= 90.0
end
validate_latitude(value::Missing) = true
validate_latitude(value::Any) = false

function validate_longitude(value::Float64)
    return value >= -180.0 && value <= 180.0
end
validate_longitude(value::Missing) = true
validate_longitude(value::Any) = false

validate_float(value::Float64) = true
validate_float(value::Missing) = true
validate_float(value::Any) = false

validate_integer(value::Int64) = true
validate_integer(value::Missing) = true
validate_integer(value::Any) = false

function validate_phone_number(value::String)
    if match(r"^[\+]?[\(\)\s\-\d\w]+$", value) === nothing
        return false
    end
    return !isempty(strip(value))
end
validate_phone_number(value::Missing) = true
validate_phone_number(value::Any) = false

function validate_time(value::String)
    m = match(r"^(\d{2}):(\d{2}):(\d{2})$", value)
    if m === nothing
        return false
    end

    hours = parse(Int, m.captures[1])
    minutes = parse(Int, m.captures[2])
    seconds = parse(Int, m.captures[3])

    # Hours can exceed 24 (GTFS allows this for service days that span midnight)
    # Minutes and seconds must be valid
    return hours >= 0 &&
        minutes >= 0 && minutes <= 59 &&
        seconds >= 0 && seconds <= 59
end
validate_time(value::Missing) = true
validate_time(value::Any) = false

function validate_text(value::String)
    # GTFS supports UTF-8 text, so we accept any valid string
    return true
end
validate_text(value::Missing) = true
validate_text(value::Any) = false

function validate_timezone(value::String)
    if isempty(value)
        return false
    end

    # Reject invalid formats
    if match(r"^GMT[+-]\d+$", value) !== nothing ||
            match(r"^EST$|^EDT$|^CST$|^CDT$|^MST$|^MDT$|^PST$|^PDT$", value) !== nothing
        return false
    end

    # Check valid IANA patterns
    valid_patterns = [
        r"^Africa/[A-Za-z_]+$",
        r"^America/[A-Za-z_]+$",
        r"^Antarctica/[A-Za-z_]+$",
        r"^Asia/[A-Za-z_]+$",
        r"^Atlantic/[A-Za-z_]+$",
        r"^Australia/[A-Za-z_]+$",
        r"^Europe/[A-Za-z_]+$",
        r"^Indian/[A-Za-z_]+$",
        r"^Pacific/[A-Za-z_]+$",
    ]

    for pattern in valid_patterns
        if match(pattern, value) !== nothing
            return true
        end
    end

    # Accept UTC
    return value == "UTC"
end
validate_timezone(value::Missing) = true
validate_timezone(value::Any) = false

function validate_url(value::String)
    return match(r"^https?://[^\s]+$", value) !== nothing
end
validate_url(value::Missing) = true
validate_url(value::Any) = false

# =============================================================================
# CONSTRAINT VALIDATION FUNCTIONS
# =============================================================================

function validate_non_negative(value::Real)
    return value >= zero(value)
end
validate_non_negative(value::Missing) = true
validate_non_negative(value::Any) = false

function validate_positive(value::Real)
    return value > zero(value)
end
validate_positive(value::Missing) = true
validate_positive(value::Any) = false

function validate_non_zero(value::Real)
    return value != zero(value)
end
validate_non_zero(value::Missing) = true
validate_non_zero(value::Any) = false

# per list validates
validate_unique(values::Vector{T}) where {T} = allunique(skipmissing(values))
# for pooled arrays
validate_unique(values) = validate_unique(collect(values))


# =============================================================================
# VALIDATOR MAPPINGS
# =============================================================================

const GTFS_TYPE_VALIDATORS = Dict(
    :GTFSID => validate_id,
    :GTFSEnum => validate_enum,
    :GTFSTimezone => validate_timezone,
    :GTFSDate => validate_date,
    :GTFSTime => validate_time,
    :GTFSLocalTime => validate_time,
    :GTFSLatitude => validate_latitude,
    :GTFSLongitude => validate_longitude,
    :GTFSFloat => validate_float,
    :GTFSInteger => validate_integer,
    :GTFSText => validate_text,
    :GTFSEmail => validate_email,
    :GTFSPhoneNumber => validate_phone_number,
    :GTFSURL => validate_url,
    :GTFSLanguageCode => validate_language_code,
    :GTFSCurrencyCode => validate_currency_code,
    :GTFSCurrencyAmount => validate_currency_amount,
    :GTFSColor => validate_color,
)

const GTFS_CONSTRAINTS_VALIDATORS = Dict(
    "Unique" => validate_unique,
    "Non-negative" => validate_non_negative,
    "Positive" => validate_positive,
    "Non-zero" => validate_non_zero,
)


# =============================================================================
# COMMON HELPER FUNCTIONS
# =============================================================================

"""
    filename_to_table_symbol(filename::String) -> Symbol

Convert filename to table symbol for GTFS table lookup.
"""
function filename_to_table_symbol(filename::String)
    tbl = replace(filename, ".txt" => "", ".geojson" => "")
    return Symbol(replace(tbl, "." => "_"))
end

"""
    get_dataframe(gtfs::GTFSSchedule, filename::String) -> Union{DataFrame, Nothing}

Safely get a DataFrame from GTFS feed, returning nothing if not found.
"""
function get_dataframe(gtfs::GTFSSchedule, filename::String)
    gtfs_has_table(gtfs, filename_to_table_symbol(filename)) || return nothing
    return get(gtfs, filename, nothing)
end

"""
    count_by_severity(messages::Vector{ValidationMessage}) -> NamedTuple

Count validation messages by severity level.
"""
function count_by_severity(messages::Vector{ValidationMessage})
    errors = count(m -> m.severity == :error, messages)
    warnings = count(m -> m.severity == :warning, messages)
    return (errors = errors, warnings = warnings)
end

"""
    create_validation_result(messages::Vector{ValidationMessage}, context::String) -> ValidationResult

Create a ValidationResult with summary statistics.
"""
function create_validation_result(messages::Vector{ValidationMessage}, context::String)
    counts = count_by_severity(messages)
    is_valid = counts.errors == 0
    summary = "$context: $(counts.errors) errors, $(counts.warnings) warnings"
    return ValidationResult(is_valid, messages, summary)
end

# =============================================================================
# RESULT UTILITIES
# =============================================================================

"""
    print_validation_results(result::ValidationResult)

Print validation results in a human-readable format.
"""
function print_validation_results(result::ValidationResult)
    println("GTFS Validation Results")
    println("======================")
    println(result.summary)
    println()

    if result.is_valid
        println("✓ All validations passed!")
        return
    end

    # Group messages by file and field
    file_groups = Dict{String, Dict{Union{String, Nothing}, Vector{ValidationMessage}}}()
    for msg in result.messages
        if !haskey(file_groups, msg.file)
            file_groups[msg.file] = Dict{Union{String, Nothing}, Vector{ValidationMessage}}()
        end
        if !haskey(file_groups[msg.file], msg.field)
            file_groups[msg.file][msg.field] = ValidationMessage[]
        end
        push!(file_groups[msg.file][msg.field], msg)
    end

    for (filename, file_errors) in file_groups
        println("File: $filename")
        for (fieldname, field_errors) in file_errors
            field_display = fieldname === nothing ? "File-level" : "Field: $fieldname"
            println("  $field_display ($(length(field_errors)) messages)")
            for error in field_errors
                println("    $(error.message)")
            end
        end
        println()
    end
    return
end

"""
    has_validation_errors(result::ValidationResult) -> Bool

Check if validation results contain any errors.
"""
function has_validation_errors(result::ValidationResult)
    return !result.is_valid
end

# =============================================================================
# GTFS HELPER PREDICATES
# =============================================================================

"""
    gtfs_has_table(gtfs, table_sym::Symbol) -> Bool

Check if GTFS feed contains a table (either .txt or .geojson).
"""
function gtfs_has_table(gtfs, table_sym::Symbol)
    # Check for .txt files first
    txt_file = string(table_sym) * ".txt"
    if haskey(gtfs, txt_file) && get(gtfs, txt_file, nothing) !== nothing
        return true
    end
    # Check for .geojson files
    geojson_file = string(table_sym) * ".geojson"
    if haskey(gtfs, geojson_file) && get(gtfs, geojson_file, nothing) !== nothing
        return true
    end
    return false
end

"""
    df_has_column(df, col_sym::Symbol) -> Bool
    df_has_column(df, col_str::String) -> Bool

Check if DataFrame has a column with the given name.
"""
df_has_column(df, col_sym::Symbol) = hasproperty(df, col_sym)
df_has_column(df, col_str::String) = hasproperty(df, Symbol(col_str))

# =============================================================================
# CONDITION EVALUATION
# =============================================================================

"""
    _condition_holds(gtfs, cond) -> Bool

Evaluate a single condition tuple against GTFS feed.
"""
function _condition_holds(gtfs, cond)::Bool
    if !haskey(cond, :type)
        return true
    end

    if cond[:type] === :file
        return _evaluate_file_condition(gtfs, cond)
    elseif cond[:type] === :field
        return _evaluate_field_condition(gtfs, cond)
    else
        return true  # unknown cond type is a no-op
    end
end

"""
    _evaluate_file_condition(gtfs, cond) -> Bool

Evaluate file existence condition.
"""
function _evaluate_file_condition(gtfs, cond)
    tbl = replace(cond[:file], ".txt" => "", ".geojson" => "")
    sym = Symbol(replace(tbl, "." => "_"))
    exists = gtfs_has_table(gtfs, sym)
    return cond[:must_exist] ? exists : !exists
end

"""
    _evaluate_field_condition(gtfs, cond) -> Bool

Evaluate field value condition.
"""
function _evaluate_field_condition(gtfs, cond)
    tbl = replace(cond[:file], ".txt" => "", ".geojson" => "")
    tsym = Symbol(replace(tbl, "." => "_"))
    if !gtfs_has_table(gtfs, tsym)
        return false
    end

    df = get(gtfs, cond[:file], nothing)
    df === nothing && return false

    col = cond[:field]
    if !df_has_column(df, col)
        return false
    end

    val = cond[:value]
    if val == "defined"
        return _check_field_defined(df, col)
    else
        return _check_field_value(df, col, val)
    end
end

"""
    _check_field_defined(df, col) -> Bool

Check if field has any defined (non-missing) values.
"""
function _check_field_defined(df, col)
    for row in eachrow(df)
        if !ismissing(getproperty(row, col))
            return true
        end
    end
    return false
end

"""
    _check_field_value(df, col, val) -> Bool

Check if field contains the specified value.
"""
function _check_field_value(df, col, val)
    parsed = tryparse(Float64, String(val))
    for row in eachrow(df)
        cell = getproperty(row, col)
        if ismissing(cell)
            continue
        end
        if string(cell) == string(val)
            return true
        end
        if parsed !== nothing && (cell == parsed)
            return true
        end
    end
    return false
end
