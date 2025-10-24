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
function read_gtfs(filepath::String, field_types::Dict{String, Vector} = FIELD_TYPES)
    if !isfile(filepath) && !isdir(filepath)
        throw(ArgumentError("File or directory does not exist: $filepath"))
    end

    if isfile(filepath)
        if !endswith(filepath, ".zip")
            throw(ArgumentError("File must be a ZIP archive: $filepath"))
        end
        return _read_gtfs_from_zip(filepath, field_types)
    elseif isdir(filepath)
        return _read_gtfs_from_directory(filepath, field_types)
    else
        throw(ArgumentError("Path must be either a ZIP file or directory: $filepath"))
    end
end

"""
    _read_gtfs_from_zip(filepath::String) -> GTFSSchedule

Internal function to read GTFS data from a ZIP file.
"""
function _read_gtfs_from_zip(filepath::String, field_types::Dict{String, Vector})
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
        return _read_gtfs_from_directory(temp_dir, field_types)
    finally
        # Clean up temp directory
        try
            rm(temp_dir, recursive = true, force = true)
        catch
            # Ignore cleanup errors
        end
    end
end

"""
    _read_gtfs_from_directory(dirpath::String) -> GTFSSchedule

Internal function to read GTFS data from an unzipped directory.
"""
function _read_gtfs_from_directory(dirpath::String, field_types::Dict{String, Vector})
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
    gtfs_schedule = GTFSSchedule()

    for filename in gtfs_files
        filepath = joinpath(dirpath, filename)
        try
            # Route to appropriate parser based on file extension
            if endswith(filename, ".geojson")
                df = _read_geojson_file(filepath)
            else
                df = _read_csv_file(filepath, field_types)
            end
            gtfs_schedule[filename] = df
        catch e
            @warn "Error reading $filename: $e"
            gtfs_schedule[filename] = nothing
        end
    end

    return gtfs_schedule
end


"""
    _read_csv_file(filepath::String, field_types::Dict{String,Vector}) -> DataFrames.DataFrame

Read a single GTFS CSV file with appropriate column types.
Flexible reader - only applies types for columns that actually exist in the file.
"""
function _read_csv_file(filepath::String, field_types::Dict{String, Vector})
    # Read CSV file with CSV.jl type inference and custom column types
    # The reader is forgiving and doesn't require specific column types
    try
        file_field_types = get(field_types, basename(filepath), [])
        column_types = Dict{String, Type}(field_def.field => GTFS_TYPES[field_def.type_symbol] for field_def in file_field_types)
        df = CSV.read(
            filepath,
            DataFrames.DataFrame;
            silencewarnings = true,
            strict = false,
            missingstring = ["", "NA", "N/A", "null"],
            types = column_types,
            validate = false
        )
        return df
    catch e
        # If type mapping fails, try reading without type constraints
        @warn "Type mapping failed for $filepath, reading with default types: $e"
        df = CSV.read(
            filepath,
            DataFrames.DataFrame;
            silencewarnings = true,
            strict = false,
            missingstring = ["", "NA", "N/A", "null"]
        )
        return df
    end
end

"""
    _read_geojson_file(filepath::String, column_types::Dict{String,Type}) -> DataFrames.DataFrame

Read a GeoJSON file and convert it to a DataFrame format.
"""
function _read_geojson_file(filepath::String)
    # Read the GeoJSON file using GeoJSON.jl as DataFrame
    return DataFrames.DataFrame(GeoJSON.read(filepath))
end
