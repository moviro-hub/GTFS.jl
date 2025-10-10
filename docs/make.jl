using Documenter, GTFS

# Set up the documentation environment
makedocs(;
    sitename="GTFS.jl",
    authors="MOVIRO",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://moviro-hub.github.io/GTFS.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API Reference" => "api.md",
        "Examples" => "examples.md",
    ],
    checkdocs=:exports,
)

deploydocs(;
    repo="github.com/moviro-hub/GTFS.jl.git",
    target="build",
    branch="gh-pages",
    devbranch="main",
)
