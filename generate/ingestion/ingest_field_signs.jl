"""
    parse_field_signs(lines::Vector{String}) -> Dict{String, String}

Parse the dedicated Field Signs section where entries look like:
"Name - Description...\nExample: ..."
Returns a Dict mapping the left-hand name to the full description (including examples and following lines until the next type entry or section end).
"""
function parse_field_signs(lines::Vector{String})
    # Pattern for sign entries: "SignName - Description" (with hyphens allowed in sign names)
    return parse_section_with_entries(lines, "Field Signs", SIGN_ENTRY_PATTERN, true)
end
