# GTFS.jl API Reference

## Main Functions

### `read_gtfs(filepath::String) -> GTFSSchedule`
Read GTFS feed from ZIP file or directory.

### `validate(gtfs::GTFSSchedule; max_warnings_per_file::Int=100) -> ValidationResult`
Validate GTFS feed. Returns warnings for conditional issues.

### `list_gtfs_files(filepath::String) -> Vector{String}`
List files in GTFS ZIP archive.

### `validate_gtfs_structure(filepath::String) -> Bool`
Quick structure validation check.

## Data Types

### `GTFSSchedule`
Main data structure containing all GTFS tables as DataFrames:
- `agency::DataFrame`
- `stops::DataFrame`
- `routes::DataFrame`
- `trips::DataFrame`
- `stop_times::DataFrame`
- Optional files as `Union{DataFrame, Nothing}`

### `ValidationResult`
Validation results with:
- `is_valid::Bool`
- `errors::Vector{ValidationError}`
- `summary::String`

### `ValidationError`
Individual validation issue with:
- `file::String`
- `field::Union{String, Nothing}`
- `message::String`
- `severity::Symbol` (:error or :warning)
