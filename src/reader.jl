"""
GTFS.jl - Reader module for GTFS Schedule data

This module provides functions to read GTFS Schedule data from ZIP files
or unzipped directories and construct GTFSSchedule structs.

All file information is spec-driven - no hardcoded file lists!
"""

# DataFrames, CSV, JSON3 imported in main module

"""
    read_gtfs(filepath::String) -> GTFSSchedule

Read a GTFS Schedule feed from a ZIP file or unzipped directory and return a GTFSSchedule struct.

# Arguments
- `filepath::String`: Path to the GTFS ZIP file or directory containing GTFS files

# Returns
- `GTFSSchedule`: Complete GTFS Schedule dataset

# Example
```julia
# Read from ZIP file
feed = read_gtfs("path/to/transit_feed.zip")

# Read from unzipped directory
feed = read_gtfs("path/to/transit_feed/")

println("Loaded GTFS feed with \$(DataFrames.nrow(feed.agency)) agencies")
```

# Throws
- `ArgumentError`: If the file/directory doesn't exist or is not a valid GTFS source
- `GTFSError`: If required files are missing or data is invalid
"""
function read_gtfs(filepath::String)
    if !isfile(filepath) && !isdir(filepath)
        throw(ArgumentError("File or directory does not exist: $filepath"))
    end

    if isfile(filepath)
        if !endswith(filepath, ".zip")
            throw(ArgumentError("File must be a ZIP archive: $filepath"))
        end
        return _read_gtfs_from_zip(filepath)
    elseif isdir(filepath)
        return _read_gtfs_from_directory(filepath)
    else
        throw(ArgumentError("Path must be either a ZIP file or directory: $filepath"))
    end
end

"""
    _read_gtfs_from_zip(filepath::String) -> GTFSSchedule

Internal function to read GTFS data from a ZIP file.
"""
function _read_gtfs_from_zip(filepath::String)
    # Extract ZIP file to temporary directory
    temp_dir = mktempdir()
    try
        # Use system unzip command
        run(`unzip -q $filepath -d $temp_dir`)

        # Get list of files in the extracted directory
        file_names = readdir(temp_dir)

        # Handle case where ZIP contains a subdirectory
        if length(file_names) == 1 && isdir(joinpath(temp_dir, file_names[1]))
            temp_dir = joinpath(temp_dir, file_names[1])
        end

        # Read GTFS data from the directory
        return _read_gtfs_from_directory(temp_dir)
    finally
        # Clean up temp directory
        try
            rm(temp_dir, recursive=true, force=true)
        catch
            # Ignore cleanup errors
        end
    end
end

"""
    _read_gtfs_from_directory(dirpath::String) -> GTFSSchedule

Internal function to read GTFS data from an unzipped directory.
"""
function _read_gtfs_from_directory(dirpath::String)
    if !isdir(dirpath)
        throw(ArgumentError("Directory does not exist: $dirpath"))
    end

    # Get list of all files in directory
    all_files = readdir(dirpath)
    gtfs_files = filter(f -> endswith(f, ".txt") || endswith(f, ".geojson"), all_files)

    if isempty(gtfs_files)
        throw(ArgumentError("Directory does not contain any GTFS files (.txt or .geojson): $dirpath"))
    end

    # Read all available GTFS files
    files_data = Dict{String, Union{DataFrames.DataFrame, Nothing}}()

    for filename in gtfs_files
        filepath = joinpath(dirpath, filename)
        if haskey(COLUMN_TYPES, filename)
            try
                df = _read_csv_file(filepath, filename)
                files_data[filename] = df
            catch e
                @warn "Error reading $filename: $e"
                files_data[filename] = nothing
            end
        end
    end

    # Validate required files are present
    for required_file in REQUIRED_FILES
        if !haskey(files_data, required_file) || files_data[required_file] === nothing
            throw(ArgumentError("Required file '$required_file' not found or could not be read"))
        end
    end

    # Validate calendar requirement (at least one must be present)
    if !haskey(files_data, "calendar.txt") && !haskey(files_data, "calendar_dates.txt")
        throw(ArgumentError("At least one of calendar.txt or calendar_dates.txt must be present"))
    end

    # Build GTFSSchedule struct dynamically using field mapping
    return _construct_gtfs_schedule(files_data)
end

"""
    _construct_gtfs_schedule(files_data::Dict{String, Union{DataFrames.DataFrame, Nothing}}) -> GTFSSchedule

Construct a GTFSSchedule struct from a dictionary of file data using the generated FILE_TO_FIELD mapping.
"""
function _construct_gtfs_schedule(files_data::Dict{String, Union{DataFrames.DataFrame, Nothing}})
    # Get all struct field names in order
    struct_fields = fieldnames(GTFSSchedule)

    # Build field values in the correct order
    field_values = []

    for field_name in struct_fields
        # Find the filename that maps to this field
        filename = nothing
        for (file, field) in FILE_TO_FIELD
            if field == field_name
                filename = file
                break
            end
        end

        if filename === nothing
            # Field doesn't have a corresponding file (shouldn't happen with generated code)
            push!(field_values, nothing)
        else
            # Get the data for this file, or nothing if not present
            push!(field_values, get(files_data, filename, nothing))
        end
    end

    # Construct the struct with values in the correct order
    return GTFSSchedule(field_values...)
end

"""
    _read_csv_file(filepath::String, filename::String) -> DataFrames.DataFrame

Read a single GTFS CSV file with appropriate column types.
Flexible reader - only applies types for columns that actually exist in the file.
"""
function _read_csv_file(filepath::String, filename::String)
    # Get column types from generated COLUMN_TYPES
    if !haskey(COLUMN_TYPES, filename)
        throw(ArgumentError("Unknown GTFS file: $filename"))
    end

    spec_col_types = COLUMN_TYPES[filename]

    # First, read the file to detect which columns actually exist
    # Read just the header to get column names
    header_df = CSV.read(filepath, DataFrames.DataFrame; limit=0, silencewarnings=true)
    actual_columns = names(header_df)

    # Build a types dict with only the columns that exist in the file
    col_types_symbols = Dict{Symbol, Type}()
    for col_name in actual_columns
        col_symbol = Symbol(col_name)
        if haskey(spec_col_types, col_name)
            col_types_symbols[col_symbol] = spec_col_types[col_name]
        end
        # If column not in spec, let CSV.jl infer the type
    end

    # Read CSV with specified types for known columns only
    df = CSV.read(
        filepath,
        DataFrames.DataFrame;
        types=col_types_symbols,
        silencewarnings=true,
        strict=false,
        missingstring=["", "NA", "N/A", "null"]
    )

    return df
end

"""
    validate_gtfs_structure(gtfs::GTFSSchedule) -> Bool

Validate that a GTFSSchedule has all required files.
"""
function validate_gtfs_structure(gtfs::GTFSSchedule)
    # Check required files using generated REQUIRED_FILES list
    for required_file in REQUIRED_FILES
        field_name = FILE_TO_FIELD[required_file]
        if !hasproperty(gtfs, field_name) || getproperty(gtfs, field_name) === nothing
            return false
        end
    end

    # Check calendar requirement
    has_calendar = gtfs.calendar !== nothing
    has_calendar_dates = gtfs.calendar_dates !== nothing

    if !has_calendar && !has_calendar_dates
        return false
    end

    return true
end
