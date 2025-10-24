"""
    PresenceInfo

Represents presence/requirement information for GTFS fields.
"""
struct PresenceInfo
    presence::String
    description::String
end

# =============================================================================
# PRESENCE KEYWORDS (extracted from specification)
# =============================================================================

"""
    parse_presence(lines::Vector{String}) -> Vector{PresenceInfo}

Extract presence types and their descriptions from the GTFS specification.
Looks for the presence definitions in the "Document Conventions" section.
"""
function parse_presence(lines::Vector{String})
    presence_types = PresenceInfo[]

    for line in lines
        stripped = strip(line)

        # Look for presence definitions in the format: "* **Required** - Description"
        if startswith(stripped, "* **") && occursin(" - ", stripped)
            # Extract presence type and description
            # Remove the bullet point and extract content
            content = replace(stripped, r"^\*\s*" => "")

            # Split on " - " to separate presence type from description
            parts = split(content, " - ", limit = 2)
            if length(parts) == 2
                presence_type = strip(replace(parts[1], r"\*\*" => ""))
                description = strip(parts[2])

                # Clean up description (remove trailing periods, normalize)
                description = replace(description, r"\.$" => "")
                description = strip(description)

                # Only add if it looks like a presence type
                if presence_type in ["Required", "Optional", "Conditionally Required", "Conditionally Forbidden", "Recommended"]
                    push!(presence_types, PresenceInfo(presence_type, description))
                end
            end
        end
    end

    return presence_types
end

"""
    normalize_presence(presence_text::String, presence_types::Vector{PresenceInfo}) -> String

Clean and normalize presence/requirement text to a standard form.

# Arguments
- `presence_text::String`: Raw presence text from the specification
- `presence_types::Vector{PresenceInfo}`: Available presence types

# Returns
- `String`: Normalized presence type

# Examples
```julia
julia> presence_types = parse_presence(lines)
julia> normalize_presence("**Required**", presence_types)
"Required"

julia> normalize_presence("Conditionally Required", presence_types)
"Conditionally Required"

julia> normalize_presence("Unknown", presence_types)
"Unknown"
```
"""
function normalize_presence(presence_text::String, presence_types::Vector{PresenceInfo})
    # Clean markdown formatting and whitespace
    clean_text = strip_markdown_bold(presence_text)
    clean_text = strip(clean_text)

    # Sort presence types by length (longest first) to prioritize more specific matches
    sorted_presence_types = sort(presence_types, by = x -> length(x.presence), rev = true)

    # Find matching presence type (check longest first)
    for presence_info in sorted_presence_types
        if occursin(presence_info.presence, clean_text)
            return presence_info.presence
        end
    end

    return "Unknown"
end

"""
    get_presence_description(presence_type::String, presence_types::Vector{PresenceInfo}) -> String

Get the description for a normalized presence type.

# Arguments
- `presence_type::String`: Normalized presence type
- `presence_types::Vector{PresenceInfo}`: Available presence types

# Returns
- `String`: Description of the presence requirement
"""
function get_presence_description(presence_type::String, presence_types::Vector{PresenceInfo})
    for presence_info in presence_types
        if presence_info.presence == presence_type
            return presence_info.description
        end
    end
    return "Unknown presence requirement"
end

"""
    is_valid_presence(presence_type::String, presence_types::Vector{PresenceInfo}) -> Bool

Check if a presence type is valid.

# Arguments
- `presence_type::String`: Presence type to validate
- `presence_types::Vector{PresenceInfo}`: Available presence types

# Returns
- `Bool`: True if the type is valid
"""
function is_valid_presence(presence_type::String, presence_types::Vector{PresenceInfo})
    return any(presence_info.presence == presence_type for presence_info in presence_types)
end
