var documenterSearchIndex = {"docs":
[{"location":"data/#Handling-Data","page":"Handling Data","title":"Handling Data","text":"","category":"section"},{"location":"data/","page":"Handling Data","title":"Handling Data","text":"This section will take you through functions that will clean up your data just after querying it, as well as functions to convert your data into more friendly formats.","category":"page"},{"location":"data/#Cleaning-Queried-Data","page":"Handling Data","title":"Cleaning Queried Data","text":"","category":"section"},{"location":"data/","page":"Handling Data","title":"Handling Data","text":"After querying data (Querying Clients), you'll have a vector of dictionaries. Because of the nature of GraphQL, each of these dictionaries might actually be nested dictionaries. Depending on your query and application, this nesting may prove to be a headache. When your nested dictionaries have unique keys, you can flatten the dictionary to be nicer to handle. Remember, you can apply this function to a vector of dictionaries by using the broadcast operator!","category":"page"},{"location":"data/","page":"Handling Data","title":"Handling Data","text":"julia> d = Dict(\"a\" => 1, \"b\" => Dict(\"c\" => Dict(\"d\" => 4)))\njulia> unnestdict(d)\nDict(\"a\" => 1, \"d\" => 4)","category":"page"},{"location":"data/","page":"Handling Data","title":"Handling Data","text":"TheGraphData.unnestdict","category":"page"},{"location":"data/#TheGraphData.unnestdict","page":"Handling Data","title":"TheGraphData.unnestdict","text":"unnestdict(d::Dict)\n\nUnnest a dictionary d. The innermost key is preserved.\n\nNote that this function assumes no duplicate keys. Else, the function may behave in unexpected ways.\n\n\n\n\n\n","category":"function"},{"location":"data/#Reformatting-Queried-Data","page":"Handling Data","title":"Reformatting Queried Data","text":"","category":"section"},{"location":"data/","page":"Handling Data","title":"Handling Data","text":"A vector of dictionaries is not the nicest data format to work with. To this end, we provide helper functions to put the data into nicer formats.","category":"page"},{"location":"data/#TypedTable","page":"Handling Data","title":"TypedTable","text":"","category":"section"},{"location":"data/","page":"Handling Data","title":"Handling Data","text":"In Julia, the Tables.jl interface is quite powerful. Hence, you may find it useful to format your data as a TypedTable. Once your data is a TypedTable, you can use powerful packages like SplitApplyCombine.jl to manipulate your data. A typical workflow using the default client from beginning to TypedTable might look like","category":"page"},{"location":"data/","page":"Handling Data","title":"Handling Data","text":"julia> qvalue = \"indexers\"\njulia> qargs = Dict(\"first\" => 1)\njulia> qfields = [\"id\"]\njulia> query(qvalue, qargs, qfields) .|> unnestdict |> table\nTable with 1 column and 1 row:\n     id\n   ┌───────────────────────────────────────────\n 1 │ 0x011bdfea664ece919d895d174f57331460056236","category":"page"},{"location":"data/","page":"Handling Data","title":"Handling Data","text":"TheGraphData.table","category":"page"},{"location":"data/#TheGraphData.table","page":"Handling Data","title":"TheGraphData.table","text":"table(d::AbstractVector{D}) where {D<:Dict}\ntable(d::CSV.File)\n\nConvert the queried data d to a TypedTable.\n\n\n\n\n\n","category":"function"},{"location":"querying/#Querying-Clients","page":"Querying Clients","title":"Querying Clients","text":"","category":"section"},{"location":"querying/","page":"Querying Clients","title":"Querying Clients","text":"This section will take you through setting a client and querying it.","category":"page"},{"location":"querying/","page":"Querying Clients","title":"Querying Clients","text":"In order to query data, this package must have access to a valid GraphQL client. By default, this client is the gateway (https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-mainnet). However, you can change the client to another.","category":"page"},{"location":"querying/","page":"Querying Clients","title":"Querying Clients","text":"julia> client!(\"mynewclient.com/endpoint\")","category":"page"},{"location":"querying/","page":"Querying Clients","title":"Querying Clients","text":"TheGraphData.client!","category":"page"},{"location":"querying/#TheGraphData.client!","page":"Querying Clients","title":"TheGraphData.client!","text":"client!(u::AbstractString)\nclient!(c::GraphQLClient.Client)\n\nSet the provided url (u) or client (c) as the new global client.\n\n\n\n\n\n","category":"function"},{"location":"querying/","page":"Querying Clients","title":"Querying Clients","text":"This sets the global client, so all subsequent calls to querying function do not need you to track and pass the client around.","category":"page"},{"location":"querying/","page":"Querying Clients","title":"Querying Clients","text":"After ensuring that you've correctly set the client, you can now query the client for data.","category":"page"},{"location":"querying/","page":"Querying Clients","title":"Querying Clients","text":"julia> qvalue = \"subgraphDeployments\"\njulia> qargs = Dict(\"first\" => 1000, \"orderBy\" => \"signalledTokens\")\njulia> qfields = [\"ipfsHash\"]\njulia> query(qvalue, qargs, qfields)","category":"page"},{"location":"querying/","page":"Querying Clients","title":"Querying Clients","text":"TheGraphData.query","category":"page"},{"location":"querying/#TheGraphData.query","page":"Querying Clients","title":"TheGraphData.query","text":"query(v::AbstractString, a::Dict, f::AbstractVector{S}) where {S<:AbstractString}\n\nQuery the client for value v with arguments a and fields f.\n\nBy default, the client is the gateway. This function returns a vector of dictionaries.\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = TheGraphData","category":"page"},{"location":"#TheGraphData","page":"Home","title":"TheGraphData","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"This package aims to simplify querying and transforming data read from The Graph Protocol. You'll get best use out of this package by composing its functions. If you find you can often use the pipe operator |>, you're probably on the right track.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Make sure you've installed Julia 1.8 or greater.","category":"page"},{"location":"","page":"Home","title":"Home","text":"This package is hosted on SemioticJLRegistry. To add this package, first add the registry to your Julia installation. Then, install this package by running ] add TheGraphData from the Julia REPL.","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> ]registry add https://github.com/semiotic-ai/SemioticJLRegistry\njulia> ]add TheGraphData","category":"page"},{"location":"io/#IO","page":"IO","title":"IO","text":"","category":"section"},{"location":"io/","page":"IO","title":"IO","text":"The section will take you through functions that you can use for IO. We can divide IO into two categories: Reading Data and Writing Data.","category":"page"},{"location":"io/#Reading-Data","page":"IO","title":"Reading Data","text":"","category":"section"},{"location":"io/","page":"IO","title":"IO","text":"Instead of querying data (Querying Clients), if you already have the data you care about, you can read it.","category":"page"},{"location":"io/","page":"IO","title":"IO","text":"julia> TheGraphData.read(\"myfile.csv\")\n4-element CSV.File:\n CSV.Row: (X = \"b\",)\n CSV.Row: (X = \"c\",)\n CSV.Row: (X = \"a\",)\n CSV.Row: (X = \"c\",)","category":"page"},{"location":"io/","page":"IO","title":"IO","text":"TheGraphData.read","category":"page"},{"location":"io/#TheGraphData.read","page":"IO","title":"TheGraphData.read","text":"read(f::AbstractString; kwargs...)\nread(::Union{Val{:csv},Val{:txt}}, f::AbstractString; kwargs...)\n\nRead the data from the filepath f with kwargs. This function is unexported.\n\n\n\n\n\n","category":"function"},{"location":"io/","page":"IO","title":"IO","text":"Oftentimes, you will want to chain TheGraphData.read with a reformatting function (Reformatting Queried Data) to put the data into a nicer format.","category":"page"},{"location":"io/","page":"IO","title":"IO","text":"julia> TheGraphData.read(\"myfile.csv\") |> table\nTable with 1 column and 4 rows:\n     X\n   ┌──\n 1 │ b\n 2 │ c\n 3 │ a\n 4 │ c","category":"page"},{"location":"io/#Writing-Data","page":"IO","title":"Writing Data","text":"","category":"section"},{"location":"io/","page":"IO","title":"IO","text":"After running an experiment, you may want to save the final state. Or perhaps you want to save the experiment's initial state so as to repeat the experiment. We support these use cases, among others, by allowing you to write data to disk.","category":"page"},{"location":"io/","page":"IO","title":"IO","text":"julia> t = Table(a = [1, 2, 3])\nTable with 1 column and 3 rows:\n     a\n   ┌──\n 1 │ 1\n 2 │ 2\n 3 │ 3\njulia> TheGraphData.write(\"myfile.csv\", t)\n\"myfile.csv\"","category":"page"},{"location":"io/","page":"IO","title":"IO","text":"TheGraphData.write","category":"page"},{"location":"io/#TheGraphData.write","page":"IO","title":"TheGraphData.write","text":"write(f::AbstractString, d; kwargs...)\nwrite(::Union{Val{:csv},Val{:txt}}, f::AbstractString, d::Union{T,D}; kwargs...) where {T<:Table,D<:Dict}\n\nWrite the data d to the filepath f with kwargs. This function is unexported.\n\n\n\n\n\n","category":"function"}]
}
