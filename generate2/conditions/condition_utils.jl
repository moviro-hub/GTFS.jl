"""
Condition Utilities Module

Shared utility functions for parsing conditional requirements.
Used by both file-level and field-level parsers.
"""

include("condition_types.jl")

"""
    extract_file_references(text::String) -> Vector{String}

Extract file references from markdown links like [filename.txt](#filename).
"""
function extract_file_references(text::String)
    files = String[]
    pattern = r"\[([^\]]+)\]"

    for m in eachmatch(pattern, text)
        file = m.captures[1]
        # Remove markdown link part (e.g., "filename.txt" from "filename.txt](#filename)")
        file = replace(file, r"\(#[^)]*\)" => "")
        file = strip(file)
        if !isempty(file)
            push!(files, file)
        end
    end

    return files
end

"""
    extract_field_references(text::String) -> Vector{String}

Extract field references from backticks like `field_name=value`.
"""
function extract_field_references(text::String)
    fields = String[]
    pattern = r"`([^`]+)`"

    for m in eachmatch(pattern, text)
        push!(fields, m.captures[1])
    end

    return fields
end

"""
    infer_file_from_field(field_name::String, context_files::Vector{String}) -> String

Infer which file a field belongs to based on context.
"""
function infer_file_from_field(field_name::String, context_files::Vector{String})
    # If we have context files, use the first one
    if !isempty(context_files)
        return context_files[1]
    end

    # Try to infer from field name patterns
    if startswith(field_name, "pathway")
        return "pathways.txt"
    elseif startswith(field_name, "stop")
        return "stops.txt"
    elseif startswith(field_name, "route")
        return "routes.txt"
    elseif startswith(field_name, "trip")
        return "trips.txt"
    elseif startswith(field_name, "agency")
        return "agency.txt"
    elseif startswith(field_name, "calendar")
        return "calendar.txt"
    elseif startswith(field_name, "fare")
        return "fare_attributes.txt"
    elseif startswith(field_name, "shape")
        return "shapes.txt"
    elseif startswith(field_name, "frequency")
        return "frequencies.txt"
    elseif startswith(field_name, "transfer")
        return "transfers.txt"
    elseif startswith(field_name, "level")
        return "levels.txt"
    elseif startswith(field_name, "translation")
        return "translations.txt"
    elseif startswith(field_name, "feed")
        return "feed_info.txt"
    elseif startswith(field_name, "attribution")
        return "attributions.txt"
    end

    return "unknown.txt"
end

# Exports
export extract_file_references
export extract_field_references
export infer_file_from_field
