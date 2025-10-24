"""
    create_type_mapping(extracted_types::Vector{FileTypeInfo}) -> Dict{String,String}

Create a dynamic mapping from extracted type names to GTFS type constants using rule-based logic.
"""
function create_type_mapping(extracted_types::Vector{FileTypeInfo})
    # Collect all unique type names
    all_types = Set{String}()
    for file_type_info in extracted_types
        for field_type_info in file_type_info.fields
            push!(all_types, field_type_info.primary_type)
            for alt_type in field_type_info.alternative_types
                push!(all_types, alt_type)
            end
        end
    end

    type_mapping = Dict{String,String}()
    for type_name in all_types
        gtfs_type = "GTFS" * join(uppercasefirst.(split(type_name, r"\s+")), "")
        type_mapping[type_name] = gtfs_type
    end

    return type_mapping
end

"""
    map_type_to_gtfs_type(type_name::String, type_mapping::Dict{String,String}) -> String

Map extracted type names to GTFS type constants using dynamic mapping.
"""
function map_type_to_gtfs_type(type_name::String, type_mapping::Dict{String,String})
    if haskey(type_mapping, type_name)
        return type_mapping[type_name]
    else
        # Warning for unmapped types and fallback to GTFSText
        @warn "No GTFS type mapping found for '$type_name', using GTFSText as fallback"
        return "GTFSText"
    end
end

"""
    generate_field_types(extracted_types::Vector{FileTypeInfo}) -> Vector{String}

Generate source code for field type validation rules:
- `const FIELD_TYPES` with per-file field type information
"""
function generate_field_types(extracted_types::Vector{FileTypeInfo})
    lines = String[]
    # Header
    push!(lines, "# Auto-generated file - Field type validation rules")
    push!(lines, "# Generated from GTFS specification parsing")
    push!(lines, "")

    # Create dynamic type mapping from input data
    type_mapping = create_type_mapping(extracted_types)

    # Emit FIELD_TYPES dictionary
    push!(lines, "# Compact rule set distilled from parsed field type information")
    push!(lines, "const FIELD_TYPES = Dict(")

    for file_type_info in extracted_types
        filename = file_type_info.filename
        push!(lines, "  \"$filename\" => [")

        for field_type_info in file_type_info.fields
            fieldname = field_type_info.fieldname
            primary_type = field_type_info.primary_type
            alternative_types = field_type_info.alternative_types

            # Map types to GTFS type constants using dynamic mapping
            primary_gtfs_type = map_type_to_gtfs_type(primary_type, type_mapping)
            alternative_gtfs_types = [map_type_to_gtfs_type(alt_type, type_mapping) for alt_type in alternative_types]

            # Create field type entry
            push!(lines, "    (")
            push!(lines, "      field = \"$fieldname\",")
            push!(lines, "      type_symbol = :$primary_gtfs_type,")

            if !isempty(alternative_gtfs_types)
                push!(lines, "      alternative_types = [")
                for alt_gtfs_type in alternative_gtfs_types
                    push!(lines, "        :$alt_gtfs_type,")
                end
                push!(lines, "      ],")
            else
                push!(lines, "      alternative_types = [],")
            end

            push!(lines, "    ),")
        end

        push!(lines, "  ],")
    end

    push!(lines, ")")
    push!(lines, "")

    return lines
end
