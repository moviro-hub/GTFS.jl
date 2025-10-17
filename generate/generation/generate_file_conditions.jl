"""
    generate_file_conditions(parsed_files::Vector{FileRelations}) -> Vector{String}

Generate the Julia source code for a file validator based on parsed file-level conditions.
"""
function generate_file_conditions(parsed_files::Vector{FileRelations})
    lines = String[]
    # Header
    push!(lines, "# Auto-generated file - Generic file presence validator")
    push!(lines, "# Generated from GTFS specification parsing")
    push!(lines, "")
    # Emit FILE_RULES dictionary
    push!(lines, "# Compact rule set distilled from parsed file-level conditions")
    push!(lines, "const FILE_RULES = Dict(")
    for (i, pf) in enumerate(parsed_files)
        fname = pf.filename
        presence = pf.presence
        push!(lines, "  \"$fname\" => (")
        push!(lines, "    presence = \"$presence\",")
        push!(lines, "    relations = [")
        for fr in pf.conditions
            # Serialize a FileRelation
            required = fr.required
            forbidden = fr.forbidden
            push!(lines, "      (required = $(required), forbidden = $(forbidden), when_all = [")
            for c in fr.when_all_conditions
                if isa(c, FileCondition)
                    push!(lines, "        (type = :file, file = \"$(c.file)\", must_exist = $(c.must_exist)),")
                elseif isa(c, FileFieldCondition)
                    # normalize field symbol in emitted code by leaving it as a Symbol literal on read
                    push!(lines, "        (type = :field, file = \"$(c.file)\", field = Symbol(\"$(c.field)\"), value = \"$(c.value)\"),")
                else
                    # Unknown condition -> no-op true guard in evaluator
                    push!(lines, "        (type = :unknown),")
                end
            end
            push!(lines, "      ]),")
        end
        push!(lines, "    ]");
        push!(lines, "  ),")
    end
    push!(lines, ")")
    push!(lines, "")

    return lines
end
