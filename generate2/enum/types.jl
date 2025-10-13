"""
Enum Types

Data structures for enum values and parsed enum fields.
"""

# Data structures for enum values
struct EnumValue
    value::String          # e.g., "0", "1", "empty"
    description::String    # e.g., "Tram, Streetcar, Light rail"
end

struct ParsedEnumField
    file::String           # e.g., "routes.txt"
    field::String          # e.g., "route_type"
    enum_values::Vector{EnumValue}
end

# Exports
export EnumValue
export ParsedEnumField
