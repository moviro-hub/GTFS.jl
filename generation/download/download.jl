"""
GTFS Specification Download Module

Handles downloading the official GTFS specification from GitHub.
"""

"""
    download_gtfs_spec(output_file::String="gtfs_reference.md") -> String

Download the official Google Transit GTFS reference markdown file.

# Arguments
- `output_file::String`: Path where to save the downloaded file (default: "gtfs_reference.md")

# Returns
- `String`: Path to the downloaded file

# Throws
- `ErrorException`: If download fails
"""
function download_gtfs_spec(output_file::String="gtfs_reference.md")
    url = "https://raw.githubusercontent.com/google/transit/master/gtfs/spec/en/reference.md"

    println("Downloading GTFS specification from: $url")

    try
        # Use Julia's built-in download function
        download(url, output_file)
        println("Successfully downloaded GTFS specification to: $output_file")
        return output_file
    catch e
        error("Failed to download GTFS specification: $e")
    end
end

"""
    download_gtfs_spec_to_dir(directory::String=".") -> String

Download the GTFS specification to a specific directory.

# Arguments
- `directory::String`: Directory to save the file in (default: current directory)

# Returns
- `String`: Full path to the downloaded file
"""
function download_gtfs_spec_to_dir(directory::String=".")
    # Ensure directory exists
    if !isdir(directory)
        mkpath(directory)
    end

    output_file = joinpath(directory, "gtfs_reference.md")
    return download_gtfs_spec(output_file)
end
