# GTFS Rule Generation

This system automatically generates Julia validation rules from the official GTFS specification. It downloads the specification, parses it, and creates type-safe validation code.

## Concept

The GTFS specification is a markdown document that defines transit data formats. This system:

1. **Downloads** the official GTFS specification from Google's repository
2. **Parses** the markdown to extract field definitions, types, and constraints
3. **Generates** Julia source files with validation rules in `../src/rules/`

## Generated Files

- `file_conditions.jl` - File-level validation rules
- `field_conditions.jl` - Field presence requirements
- `field_enum_values.jl` - Enum value validation
- `field_types.jl` - Field type mappings
- `field_id_references.jl` - Foreign key relationships
- `field_constraints.jl` - Field constraints (Unique, Non-negative, etc.)

## How to Run

```bash
# From the generate/ directory
julia --project=. main.jl
```

This will:
- Download the latest GTFS specification
- Parse and extract all validation rules
- Generate Julia source files in `../src/rules/`
- Show progress for each step

Intermediate JSON files are saved in `tmp/` for debugging and inspection.

## Requirements

- Julia 1.10+
- Internet connection (to download specification)
- Project dependencies (automatically managed via `--project=.`)
