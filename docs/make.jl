using TheGraphData
using Documenter

DocMeta.setdocmeta!(TheGraphData, :DocTestSetup, :(using TheGraphData); recursive=true)

makedocs(;
    modules=[TheGraphData],
    authors="Semiotic Labs, Inc.",
    sitename="TheGraphData.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://semiotic-ai.github.io/TheGraphData.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Querying Clients" => "querying.md",
        "IO" => "io.md",
        "Handling Data" => "data.md",
        "API Reference" => "api.md",
    ],
)

deploydocs(; repo="github.com/semiotic-ai/TheGraphData.jl", devbranch="main")
