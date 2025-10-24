"""
    Ingestion Utilities

Common utilities for parsing GTFS specification markdown content.
Provides consistent patterns for text cleaning, table parsing, and data extraction.
"""

# =============================================================================
# REGEX PATTERNS
# =============================================================================

# Markdown formatting patterns
const MARKDOWN_BOLD_PATTERN = r"\*\*([^*]+)\*\*"
const MARKDOWN_LINK_PATTERN = r"\[([^\]]+)\]\([^)]+\)"

# HTML formatting patterns
const HTML_BREAK_PATTERN = r"<br>"
const HTML_DOUBLE_BREAK_PATTERN = r"<br><br>"

# Data extraction patterns
const PRIMARY_KEY_PATTERN = r"Primary key \(`([^`]+(?:`, `[^`]+)*)`\)"
const TYPE_ENTRY_PATTERN = r"^([^-–:]+)\s*[-–:]\s*(.+)$"
const SIGN_ENTRY_PATTERN = r"^([A-Za-z][A-Za-z0-9\-]*)\s*[-–:]\s*(.+)$"

# =============================================================================
# TABLE HEADER PATTERNS
# =============================================================================

const TABLE_HEADER_PATTERNS = [
    "Field Name", "File Name", "Type", "Presence", "Description",
]

# =============================================================================
# TEXT CLEANING CONSTANTS
# =============================================================================

# HTML break replacements
const HTML_BREAK_REPLACEMENTS = (
    "<br><br>" => "\n\n",
    "<br>" => "\n",
)

# Common separators for parsing
const FIELD_SEPARATORS = ["-", "–", ":"]
const LIST_SEPARATORS = ["-", "•", "*"]

# =============================================================================
# TEXT CLEANING FUNCTIONS
# =============================================================================

"""
    strip_markdown_bold(text::String) -> String

Remove markdown bold formatting from text.

# Arguments
- `text::String`: Text with markdown bold formatting

# Returns
- `String`: Text with bold formatting removed

# Examples
```julia
julia> strip_markdown_bold("**Bold text**")
"Bold text"
```
"""
function strip_markdown_bold(text::String)
    if isempty(text)
        return text
    end
    return replace(text, MARKDOWN_BOLD_PATTERN => s"\1")
end

"""
    strip_markdown_link(text::String) -> String

Extract text from markdown link format [text](link).

# Arguments
- `text::String`: Text with markdown links

# Returns
- `String`: Text with link text extracted

# Examples
```julia
julia> strip_markdown_link("[Google](https://google.com)")
"Google"
```
"""
function strip_markdown_link(text::String)
    if isempty(text)
        return text
    end

    match_result = match(MARKDOWN_LINK_PATTERN, text)
    return match_result !== nothing ? match_result[1] : text
end

"""
    normalize_html_breaks(text::String) -> String

Replace HTML break tags with newlines.

# Arguments
- `text::String`: Text with HTML break tags

# Returns
- `String`: Text with HTML breaks normalized to newlines

# Examples
```julia
julia> normalize_html_breaks("Line 1<br>Line 2<br><br>Line 3")
"Line 1\nLine 2\n\nLine 3"
```
"""
function normalize_html_breaks(text::String)
    if isempty(text)
        return text
    end

    # Apply HTML break replacements
    for (html_break, newline) in HTML_BREAK_REPLACEMENTS
        text = replace(text, html_break => newline)
    end

    return text
end

# =============================================================================
# SECTION DETECTION FUNCTIONS
# =============================================================================

"""
    is_section_header(line::String, section_name::String, level::Int) -> Bool

Check if line is a specific section header at the given level.

# Arguments
- `line::String`: The line to check
- `section_name::String`: The section name to match
- `level::Int`: The header level (number of # symbols)

# Returns
- `Bool`: Whether the line is the specified section header

# Examples
```julia
julia> is_section_header("## File Definitions", "File Definitions", 2)
true
```
"""
function is_section_header(line::String, section_name::String, level::Int)
    if isempty(line) || level < 1
        return false
    end

    header_prefix = "#"^level
    expected_header = "$header_prefix $section_name"
    return occursin(expected_header, strip(line))
end

"""
    is_section_boundary(line::String, level::Int) -> Bool

Check if line starts a new section at the given level.

# Arguments
- `line::String`: The line to check
- `level::Int`: The header level (number of # symbols)

# Returns
- `Bool`: Whether the line starts a new section at the specified level

# Examples
```julia
julia> is_section_boundary("## New Section", 2)
true
```
"""
function is_section_boundary(line::String, level::Int)
    if isempty(line) || level < 1
        return false
    end

    header_prefix = "#"^level
    return startswith(strip(line), header_prefix)
end

# =============================================================================
# TABLE PARSING FUNCTIONS
# =============================================================================

"""
    find_markdown_table(lines::Vector{String}, start_idx::Int, max_lookahead::Int) -> Union{Tuple{Int, Int}, Nothing}

Find the start of a markdown table (header and separator).

# Arguments
- `lines::Vector{String}`: Lines to search through
- `start_idx::Int`: Starting index to search from
- `max_lookahead::Int`: Maximum number of lines to look ahead

# Returns
- `Union{Tuple{Int, Int}, Nothing}`: (header_line, separator_line) or nothing if not found
"""
function find_markdown_table(lines::Vector{String}, start_idx::Int, max_lookahead::Int)
    if isempty(lines) || start_idx < 1 || start_idx > length(lines)
        return nothing
    end

    header_line = nothing
    separator_line = nothing
    end_idx = min(start_idx + max_lookahead, length(lines))

    for i in start_idx:end_idx
        stripped = strip(lines[i])

        # Look for header line (starts with | and contains another |)
        if header_line === nothing && is_table_header_line(String(stripped))
            header_line = i
            continue
        end

        # Look for separator line (starts with |-- or contains ---)
        if header_line !== nothing && separator_line === nothing && is_table_separator_line(String(stripped))
            separator_line = i
            return (header_line, separator_line)
        end
    end

    return nothing
end

"""
    is_table_header_line(line::String) -> Bool

Check if a line is a markdown table header.

# Arguments
- `line::String`: The line to check

# Returns
- `Bool`: Whether the line is a table header
"""
function is_table_header_line(line::String)
    return startswith(line, "|") && occursin("|", line[2:end])
end

"""
    is_table_separator_line(line::String) -> Bool

Check if a line is a markdown table separator.

# Arguments
- `line::String`: The line to check

# Returns
- `Bool`: Whether the line is a table separator
"""
function is_table_separator_line(line::String)
    return startswith(line, "|--") || (startswith(line, "|") && occursin("---", line))
end

"""
    parse_markdown_row(line::String, skip_headers::Bool=true) -> Union{Vector{String}, Nothing}

Parse a markdown table row into its column values.

# Arguments
- `line::String`: The table row line to parse
- `skip_headers::Bool=true`: Whether to skip header and separator rows

# Returns
- `Union{Vector{String}, Nothing}`: Parsed column values or nothing if skipped

# Examples
```julia
julia> parse_markdown_row("| Field | Type | Description |")
["Field", "Type", "Description"]
```
"""
function parse_markdown_row(line::String, skip_headers::Bool = true)
    if isempty(line)
        return nothing
    end

    parts = split(line, "|")
    cleaned_parts = [strip(part) for part in parts if !isempty(strip(part))]

    if isempty(cleaned_parts)
        return nothing
    end

    # Skip header and separator rows if requested
    if skip_headers && is_header_or_separator_row(String(cleaned_parts[1]))
        return nothing
    end

    return cleaned_parts
end

"""
    is_header_or_separator_row(first_part::String) -> Bool

Check if a row is a header or separator row.

# Arguments
- `first_part::String`: The first part of the row

# Returns
- `Bool`: Whether the row is a header or separator
"""
function is_header_or_separator_row(first_part::String)
    # Check for separator pattern
    if occursin("---", first_part)
        return true
    end

    # Check for header patterns
    return any(occursin(pattern, first_part) for pattern in TABLE_HEADER_PATTERNS)
end


# =============================================================================
# PRESENCE AND VALIDATION FUNCTIONS
# =============================================================================


"""
    clean_presence(presence_text::String) -> String

Clean and normalize presence/requirement text.
DEPRECATED: Use normalize_presence() from ingest_presence.jl instead.

# Arguments
- `presence_text::String`: The presence text to clean

# Returns
- `String`: Cleaned presence text
"""
function clean_presence(presence_text::String)
    return normalize_presence(presence_text)
end

"""
    is_example_line(line::String) -> Bool

Check if line contains example content that should be filtered out.

# Arguments
- `line::String`: The line to check

# Returns
- `Bool`: Whether the line contains example content

# Examples
```julia
julia> is_example_line("Example: This is an example")
true

julia> is_example_line("_Example: Another example")
true
```
"""
function is_example_line(line::String)
    if isempty(line)
        return false
    end

    example_indicators = ["Example:", "_Example"]
    return any(occursin(indicator, line) for indicator in example_indicators)
end

# =============================================================================
# SECTION PARSING HELPERS
# =============================================================================

"""
    match_entry_pattern(line::String, pattern::Regex) -> Union{RegexMatch, Nothing}

Match an entry pattern in a line, handling bullet markers and markdown formatting.

# Arguments
- `line::String`: The line to match against
- `pattern::Regex`: The regex pattern to match

# Returns
- `Union{RegexMatch, Nothing}`: Match result or nothing if no match

# Examples
```julia
julia> match_entry_pattern("- Text: Description", r"^([^:]+):\\s*(.+)\$")
RegexMatch("Text: Description", 1="Text", 2="Description")
```
"""
function match_entry_pattern(line::String, pattern::Regex)
    if isempty(line)
        return nothing
    end

    stripped = String(strip(line))
    # Normalize leading bullet markers
    stripped = replace(stripped, r"^[-*]\s+" => "")
    # Remove markdown bold formatting
    stripped = strip_markdown_bold(stripped)
    # Match entry pattern
    return match(pattern, stripped)
end

"""
    flush_entry_description(result::Dict{String, String}, key::String, desc_lines::Vector{String}, skip_examples::Bool)

Flush the current entry description to the result dictionary.

# Arguments
- `result::Dict{String, String}`: The result dictionary to update
- `key::String`: The key for the entry
- `desc_lines::Vector{String}`: The description lines to join
- `skip_examples::Bool`: Whether to skip example content
"""
function flush_entry_description(result::Dict{String, String}, key::String, desc_lines::Vector{String}, skip_examples::Bool)
    if isempty(key) || isempty(desc_lines)
        return
    end

    desc = join(desc_lines, "\n")
    desc = normalize_html_breaks(desc)

    if skip_examples
        desc = rstrip(desc)
    end

    return result[key] = desc
end

"""
    parse_section_with_entries(lines::Vector{String}, section_name::String, entry_pattern::Regex, skip_examples::Bool=false) -> Dict{String, String}

Parse a section with entry patterns (like Field Types or Field Signs).

# Arguments
- `lines::Vector{String}`: Lines to parse
- `section_name::String`: Name of the section to parse
- `entry_pattern::Regex`: Regex pattern for matching entries
- `skip_examples::Bool=false`: Whether to skip example content

# Returns
- `Dict{String, String}`: Dictionary mapping entry names to their descriptions

# Examples
```julia
julia> parse_section_with_entries(lines, "Field Types", r"^([^:]+):\\s*(.+)\$")
Dict("Text" => "A string of text", "URL" => "A valid URL")
```
"""
function parse_section_with_entries(lines::Vector{String}, section_name::String, entry_pattern::Regex, skip_examples::Bool = false)
    if isempty(lines) || isempty(section_name)
        return Dict{String, String}()
    end

    result = Dict{String, String}()
    in_section = false
    current_key = ""
    current_desc_lines = String[]

    for line in lines
        # Check for section start
        if !in_section
            if is_section_header(line, section_name, 3)
                in_section = true
            end
            continue
        end

        # Check for section end
        if is_section_boundary(line, 3) && !occursin(section_name, strip(line))
            flush_entry_description(result, current_key, current_desc_lines, skip_examples)
            break
        end

        # Try to match a new entry
        match_result = match_entry_pattern(line, entry_pattern)
        if match_result !== nothing
            # Skip example lines if requested
            if skip_examples && is_example_line(line)
                continue
            end

            flush_entry_description(result, current_key, current_desc_lines, skip_examples)
            empty!(current_desc_lines)

            current_key = String(strip(match_result.captures[1]))
            first_desc = String(strip(match_result.captures[2]))
            push!(current_desc_lines, first_desc)
            continue
        end

        # Treat as continuation of current description
        if !isempty(current_key)
            # Skip example lines even when they're continuation lines if requested
            if skip_examples && is_example_line(line)
                continue
            end
            push!(current_desc_lines, String(line))
        end
    end

    flush_entry_description(result, current_key, current_desc_lines, skip_examples)
    return result
end
