"""
GTFS.jl - Reader module for GTFS Schedule data

This module provides functions to read GTFS Schedule data from ZIP files
or unzipped directories and construct GTFSSchedule structs.
"""

# DataFrames.DataFrames, CSV, JSON3 imported in main module

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
            file_names = readdir(temp_dir)
        end

        # Read required files
        agency = _read_csv_file(temp_dir, "agency.txt", required=true)
        stops = _read_csv_file(temp_dir, "stops.txt", required=true)
        routes = _read_csv_file(temp_dir, "routes.txt", required=true)
        trips = _read_csv_file(temp_dir, "trips.txt", required=true)
        stop_times = _read_csv_file(temp_dir, "stop_times.txt", required=true)

        # Read conditionally required files
        calendar = _read_csv_file(temp_dir, "calendar.txt", required=false)
        calendar_dates = _read_csv_file(temp_dir, "calendar_dates.txt", required=false)

        # Validate that at least one calendar file is present
        if calendar === nothing && calendar_dates === nothing
            throw(ArgumentError("At least one of calendar.txt or calendar_dates.txt must be present"))
        end

        # Read optional files
        fare_attributes = _read_csv_file(temp_dir, "fare_attributes.txt", required=false)
        fare_rules = _read_csv_file(temp_dir, "fare_rules.txt", required=false)
        shapes = _read_csv_file(temp_dir, "shapes.txt", required=false)
        frequencies = _read_csv_file(temp_dir, "frequencies.txt", required=false)
        transfers = _read_csv_file(temp_dir, "transfers.txt", required=false)
        pathways = _read_csv_file(temp_dir, "pathways.txt", required=false)
        levels = _read_csv_file(temp_dir, "levels.txt", required=false)
        feed_info = _read_csv_file(temp_dir, "feed_info.txt", required=false)
        translations = _read_csv_file(temp_dir, "translations.txt", required=false)
        attributions = _read_csv_file(temp_dir, "attributions.txt", required=false)

        # Fares v2 files
        fare_media = _read_csv_file(temp_dir, "fare_media.txt", required=false)
        fare_products = _read_csv_file(temp_dir, "fare_products.txt", required=false)
        fare_leg_rules = _read_csv_file(temp_dir, "fare_leg_rules.txt", required=false)
        fare_leg_join_rules = _read_csv_file(temp_dir, "fare_leg_join_rules.txt", required=false)
        fare_transfer_rules = _read_csv_file(temp_dir, "fare_transfer_rules.txt", required=false)
        timeframes = _read_csv_file(temp_dir, "timeframes.txt", required=false)
        rider_categories = _read_csv_file(temp_dir, "rider_categories.txt", required=false)

        # Additional optional files
        areas = _read_csv_file(temp_dir, "areas.txt", required=false)
        stop_areas = _read_csv_file(temp_dir, "stop_areas.txt", required=false)
        networks = _read_csv_file(temp_dir, "networks.txt", required=false)
        route_networks = _read_csv_file(temp_dir, "route_networks.txt", required=false)
        location_groups = _read_csv_file(temp_dir, "location_groups.txt", required=false)
        location_group_stops = _read_csv_file(temp_dir, "location_group_stops.txt", required=false)
        locations_geojson = _read_geojson_file(temp_dir, "locations.geojson", required=false)
        booking_rules = _read_csv_file(temp_dir, "booking_rules.txt", required=false)

        return GTFSSchedule(
            agency, stops, routes, trips, stop_times,
            calendar, calendar_dates,
            fare_attributes, fare_rules, shapes, frequencies, transfers, pathways, levels,
            feed_info, translations, attributions,
            fare_media, fare_products, fare_leg_rules, fare_leg_join_rules, fare_transfer_rules,
            timeframes, rider_categories,
            areas, stop_areas, networks, route_networks, location_groups, location_group_stops,
            locations_geojson, booking_rules
        )
    finally
        # Clean up temporary directory
        rm(temp_dir, recursive=true)
    end
end

"""
    _read_gtfs_from_directory(dirpath::String) -> GTFSSchedule

Internal function to read GTFS data from an unzipped directory.

# Arguments
- `dirpath::String`: Path to directory containing GTFS files

# Returns
- `GTFSSchedule`: Complete GTFS Schedule dataset

# Throws
- `ArgumentError`: If required files are missing
"""
function _read_gtfs_from_directory(dirpath::String)
    # Validate that directory contains at least some GTFS files
    files_in_dir = readdir(dirpath)
    gtfs_files = filter(f -> endswith(f, ".txt") || endswith(f, ".geojson"), files_in_dir)

    if isempty(gtfs_files)
        throw(ArgumentError("Directory does not contain any GTFS files (.txt or .geojson): $dirpath"))
    end

    # Read required files
    agency = _read_csv_file(dirpath, "agency.txt", required=true)
    stops = _read_csv_file(dirpath, "stops.txt", required=true)
    routes = _read_csv_file(dirpath, "routes.txt", required=true)
    trips = _read_csv_file(dirpath, "trips.txt", required=true)
    stop_times = _read_csv_file(dirpath, "stop_times.txt", required=true)

    # Read conditionally required files
    calendar = _read_csv_file(dirpath, "calendar.txt", required=false)
    calendar_dates = _read_csv_file(dirpath, "calendar_dates.txt", required=false)

    # Validate that at least one calendar file is present
    if calendar === nothing && calendar_dates === nothing
        throw(ArgumentError("At least one of calendar.txt or calendar_dates.txt must be present"))
    end

    # Read optional files
    fare_attributes = _read_csv_file(dirpath, "fare_attributes.txt", required=false)
    fare_rules = _read_csv_file(dirpath, "fare_rules.txt", required=false)
    shapes = _read_csv_file(dirpath, "shapes.txt", required=false)
    frequencies = _read_csv_file(dirpath, "frequencies.txt", required=false)
    transfers = _read_csv_file(dirpath, "transfers.txt", required=false)
    pathways = _read_csv_file(dirpath, "pathways.txt", required=false)
    levels = _read_csv_file(dirpath, "levels.txt", required=false)
    feed_info = _read_csv_file(dirpath, "feed_info.txt", required=false)
    translations = _read_csv_file(dirpath, "translations.txt", required=false)
    attributions = _read_csv_file(dirpath, "attributions.txt", required=false)

    # Fares v2 files
    fare_media = _read_csv_file(dirpath, "fare_media.txt", required=false)
    fare_products = _read_csv_file(dirpath, "fare_products.txt", required=false)
    fare_leg_rules = _read_csv_file(dirpath, "fare_leg_rules.txt", required=false)
    fare_leg_join_rules = _read_csv_file(dirpath, "fare_leg_join_rules.txt", required=false)
    fare_transfer_rules = _read_csv_file(dirpath, "fare_transfer_rules.txt", required=false)
    timeframes = _read_csv_file(dirpath, "timeframes.txt", required=false)
    rider_categories = _read_csv_file(dirpath, "rider_categories.txt", required=false)

    # Additional optional files
    areas = _read_csv_file(dirpath, "areas.txt", required=false)
    stop_areas = _read_csv_file(dirpath, "stop_areas.txt", required=false)
    networks = _read_csv_file(dirpath, "networks.txt", required=false)
    route_networks = _read_csv_file(dirpath, "route_networks.txt", required=false)
    location_groups = _read_csv_file(dirpath, "location_groups.txt", required=false)
    location_group_stops = _read_csv_file(dirpath, "location_group_stops.txt", required=false)
    locations_geojson = _read_geojson_file(dirpath, "locations.geojson", required=false)
    booking_rules = _read_csv_file(dirpath, "booking_rules.txt", required=false)

    return GTFSSchedule(
        agency, stops, routes, trips, stop_times,
        calendar, calendar_dates,
        fare_attributes, fare_rules, shapes, frequencies, transfers, pathways, levels,
        feed_info, translations, attributions,
        fare_media, fare_products, fare_leg_rules, fare_leg_join_rules, fare_transfer_rules,
        timeframes, rider_categories,
        areas, stop_areas, networks, route_networks, location_groups, location_group_stops,
        locations_geojson, booking_rules
    )
end

"""
    _read_geojson_file(dir_path::String, filename::String; required::Bool=false) -> Union{DataFrames.DataFrames.DataFrames.DataFrame, Nothing}

Internal function to read a GeoJSON file from a directory.

# Arguments
- `dir_path::String`: Directory containing the GeoJSON files
- `filename::String`: Name of the GeoJSON file to read
- `required::Bool`: Whether the file is required (default: false)

# Returns
- `Union{DataFrames.DataFrame, Nothing}`: DataFrames.DataFrame if file exists and is readable, nothing otherwise

# Throws
- `ArgumentError`: If required file is missing or cannot be read
"""
function _read_geojson_file(dir_path::String, filename::String; required::Bool=false)
    file_path = joinpath(dir_path, filename)

    if !isfile(file_path)
        if required
            throw(ArgumentError("Required file '$filename' not found in GTFS feed"))
        end
        return nothing
    end

    try
        # Read GeoJSON file using JSON3
        geojson_data = JSON3.read(read(file_path, String))

        # Validate that it's a FeatureCollection
        if get(geojson_data, :type, "") != "FeatureCollection"
            throw(ArgumentError("GeoJSON file must be a FeatureCollection"))
        end

        # Extract features
        features = get(geojson_data, :features, [])
        if isempty(features)
            return DataFrames.DataFrame()
        end

        # Create DataFrames.DataFrame from feature properties
        rows = []
        for feature in features
            # Extract properties and create a mutable copy
            properties = Dict(get(feature, :properties, Dict()))

            # Add feature ID if present
            if haskey(feature, :id)
                properties[:id] = feature.id
            end

            # Add geometry type
            geometry = get(feature, :geometry, Dict())
            properties[:geometry_type] = get(geometry, :type, "Unknown")

            push!(rows, properties)
        end

        if isempty(rows)
            return DataFrames.DataFrame()
        end

        # Convert to DataFrames.DataFrame
        df = DataFrames.DataFrame(rows)

        return df
    catch e
        if required
            throw(ArgumentError("Failed to read required file '$filename': $e"))
        else
            @warn "Failed to read optional file '$filename': $e"
            return nothing
        end
    end
end

"""
    _read_csv_file(dir_path::String, filename::String; required::Bool=false) -> Union{DataFrames.DataFrame, Nothing}

Internal function to read a CSV file from a directory.

# Arguments
- `dir_path::String`: Directory containing the CSV files
- `filename::String`: Name of the CSV file to read
- `required::Bool`: Whether the file is required (default: false)

# Returns
- `Union{DataFrames.DataFrame, Nothing}`: DataFrames.DataFrame if file exists and is readable, nothing otherwise

# Throws
- `ArgumentError`: If required file is missing or cannot be read
"""
function _read_csv_file(dir_path::String, filename::String; required::Bool=false)
    file_path = joinpath(dir_path, filename)

    if !isfile(file_path)
        if required
            throw(ArgumentError("Required file '$filename' not found in GTFS feed"))
        end
        return nothing
    end

    try
        # Read the file content
        df = CSV.read(file_path, DataFrames.DataFrames.DataFrames.DataFrame; stringtype=String)
        return df
    catch e
        if required
            throw(ArgumentError("Failed to read required file '$filename': $e"))
        else
            @warn "Failed to read optional file '$filename': $e"
            return nothing
        end
    end
end

"""
    list_gtfs_files(filepath::String) -> Vector{String}

List all files contained in a GTFS ZIP file or directory.

# Arguments
- `filepath::String`: Path to the GTFS ZIP file or directory

# Returns
- `Vector{String}`: List of file names in the GTFS source

# Example
```julia
# List files in ZIP
files = list_gtfs_files("transit_feed.zip")

# List files in directory
files = list_gtfs_files("transit_feed/")

println("GTFS feed contains: ", join(files, ", "))
```
"""
function list_gtfs_files(filepath::String)
    if !isfile(filepath) && !isdir(filepath)
        throw(ArgumentError("File or directory does not exist: $filepath"))
    end

    if isfile(filepath)
        if !endswith(filepath, ".zip")
            throw(ArgumentError("File must be a ZIP archive: $filepath"))
        end

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
                file_names = readdir(temp_dir)
            end

            return file_names
        finally
            # Clean up temporary directory
            rm(temp_dir, recursive=true)
        end
    elseif isdir(filepath)
        # List files in directory
        return readdir(filepath)
    else
        throw(ArgumentError("Path must be either a ZIP file or directory: $filepath"))
    end
end

"""
    validate_gtfs_structure(filepath::String) -> Bool

Quick validation to check if a file appears to be a valid GTFS feed.

# Arguments
- `filepath::String`: Path to the GTFS ZIP file

# Returns
- `Bool`: True if the file appears to be a valid GTFS feed

# Example
```julia
if validate_gtfs_structure("transit_feed.zip")
    println("File appears to be a valid GTFS feed")
else
    println("File does not appear to be a valid GTFS feed")
end
```
"""
function validate_gtfs_structure(filepath::String)
    try
        files = list_gtfs_files(filepath)

        # Check for all required files
        for required_file in REQUIRED_FILES
            if !(required_file in files)
                return false
            end
        end

        # Check for at least one calendar file
        has_calendar = "calendar.txt" in files
        has_calendar_dates = "calendar_dates.txt" in files

        if !has_calendar && !has_calendar_dates
            return false
        end

        return true
    catch
        return false
    end
end
