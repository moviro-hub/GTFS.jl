"""
Type Mapping Definitions

Defines structures and functions for mapping GTFS field types to Julia types.
"""

include("../ingestion/types.jl")

# Data structures for type mapping
struct JuliaTypeInfo
    base_type::Type            # e.g., String, Float64, Int
    is_nullable::Bool          # Based on presence (Optional, Conditionally Required, etc.)
    constraints::Vector{Function} # Validation functions
end

struct FieldTypeMapping
    file::String
    field::String
    gtfs_type::String
    julia_type::JuliaTypeInfo
end

"""
    determine_nullability(presence::String) -> Bool

Determine if a field should be nullable based on its presence requirement.
"""
function determine_nullability(presence::String)
    # Required fields are not nullable
    if presence == "Required"
        return false
    end

    # All other presence types allow null/missing values
    # Optional, Conditionally Required, Conditionally Forbidden, Recommended
    return true
end

"""
    extract_constraints(gtfs_type::String) -> Vector{Function}

Extract validation functions from GTFS type string (e.g., "Non-negative", "Positive").
"""
function extract_constraints(gtfs_type::String)
    constraints = Function[]

    # Check for numeric constraints
    if occursin("Non-negative", gtfs_type)
        push!(constraints, x -> x >= 0)
    elseif occursin("Positive", gtfs_type)
        push!(constraints, x -> x > 0)
    elseif occursin("Non-zero", gtfs_type)
        push!(constraints, x -> x != 0)
    end

    # Check for specific types with range constraints
    if occursin("Latitude", gtfs_type)
        push!(constraints, x -> -90.0 <= x <= 90.0)
    elseif occursin("Longitude", gtfs_type)
        push!(constraints, x -> -180.0 <= x <= 180.0)
    end

    return constraints
end

"""
    get_base_julia_type(gtfs_type::String) -> Type

Map GTFS type to base Julia type.
"""
function get_base_julia_type(gtfs_type::String)
    # Normalize type string (lowercase for comparison)
    type_lower = lowercase(gtfs_type)

    # Numeric types
    if occursin("latitude", type_lower) || occursin("longitude", type_lower)
        return Float64
    elseif occursin("float", type_lower)
        return Float64
    elseif occursin("integer", type_lower)
        return Int
    elseif occursin("currency amount", type_lower)
        return String  # Use String for now, could be Decimal later
    end

    # Date/Time types
    if occursin("date", type_lower)
        return Date
    elseif occursin("time", type_lower)
        return String  # Use String for now due to > 24:00:00 support
    end

    # Enum type
    if occursin("enum", type_lower)
        return Int  # Enums are typically represented as integers
    end

    # String-based types (default for most)
    # ID, Text, URL, Email, Phone number, Color, Currency code,
    # Language code, Timezone, etc.
    return String
end

"""
    gtfs_type_to_julia(gtfs_type::String, presence::String) -> JuliaTypeInfo

Convert GTFS field type and presence to Julia type information.
"""
function gtfs_type_to_julia(gtfs_type::String, presence::String)
    base_type = get_base_julia_type(gtfs_type)
    is_nullable = determine_nullability(presence)
    constraints = extract_constraints(gtfs_type)

    return JuliaTypeInfo(base_type, is_nullable, constraints)
end

# Exports
export JuliaTypeInfo
export FieldTypeMapping
export determine_nullability
export extract_constraints
export get_base_julia_type
export gtfs_type_to_julia
