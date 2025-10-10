"""
Documentation generation for GTFS.jl
"""

using Documenter
using GTFS

makedocs(
    sitename = "GTFS.jl",
    format = Documenter.HTML(),
    pages = [
        "Home" => "index.md",
        "API Reference" => "api.md",
        "Examples" => "examples.md"
    ]
)
