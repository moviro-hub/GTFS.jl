# GTFS Code Generation

This directory contains the code generation system for GTFS.jl, which automatically creates Julia source files from the official GTFS specification.

## Directory Structure

```
generation/
├── download/          # Step 1: Download GTFS specification
├── ingestion/         # Step 2: Parse specification markdown
├── extraction/        # Step 3: Process data into type mappings
├── generation/        # Step 4: Generate Julia source files
└── main.jl           # Main orchestration script
```

## Process Overview

The generation follows 4 main steps:

### 1. Download (`download/`)
- Downloads the official GTFS specification from Google's repository
- Stores the markdown file locally for processing

### 2. Ingestion (`ingestion/`)
- Parses the GTFS specification markdown
- Extracts file definitions, field definitions, and enum values
- Creates structured data representations

### 3. Extraction (`extraction/`)
- Processes parsed data into type mappings and conditions
- Handles field types, presence requirements, and validation rules
- Prepares data for code generation

### 4. Generation (`generation/`)
- Creates Julia source files from extracted data:
  - `column_types.jl` - Field type mappings
  - `gtfs_types.jl` - Main GTFSSchedule struct
  - `*_validator.jl` - Validation functions
  - `file_mapping.jl` - File-to-field mappings

## Usage

```bash
julia main.jl
```

This will run the complete pipeline and generate all source files in the `../src/` directory.
