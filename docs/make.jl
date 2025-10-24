using Documenter, GTFSSchedule

# Set up the documentation environment
makedocs(;
    sitename="GTFSSchedule.jl",
    authors="MOVIRO",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://moviro-hub.github.io/GTFSSchedule.jl",
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
    repo="github.com/moviro-hub/GTFSSchedule.jl.git",
    target="build",
    branch="gh-pages",
    devbranch="main",
)
