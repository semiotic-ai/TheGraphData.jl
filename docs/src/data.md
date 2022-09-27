# Handling Data

This section will take you through functions that will clean up your data just after querying it, as well as functions to convert your data into more friendly formats.

## Cleaning Queried Data

After querying data ([Querying Clients](@ref)), you'll have a vector of dictionaries.
Because of the nature of GraphQL, each of these dictionaries might actually be nested dictionaries.
Depending on your query and application, this nesting may prove to be a headache.
When your nested dictionaries have unique keys, you can flatten the dictionary to be nicer to handle.
Remember, you can apply this function to a vector of dictionaries by using the broadcast operator!

```julia
julia> d = Dict("a" => 1, "b" => Dict("c" => Dict("d" => 4)))
julia> unnestdict(d)
Dict("a" => 1, "d" => 4)
```

```@docs
TheGraphData.unnestdict
```

## Reformatting Queried Data

A vector of dictionaries is not the nicest data format to work with.
To this end, we provide helper functions to put the data into nicer formats.

### TypedTable

In Julia, the [Tables.jl](https://github.com/JuliaData/Tables.jl) interface is quite powerful.
Hence, you may find it useful to format your data as a [TypedTable](https://typedtables.juliadata.org/stable/).
Once your data is a TypedTable, you can use powerful packages like [SplitApplyCombine.jl](https://github.com/JuliaData/SplitApplyCombine.jl) to manipulate your data.
A typical workflow using the default client from beginning to TypedTable might look like

```julia
julia> qvalue = "indexers"
julia> qargs = Dict("first" => 1)
julia> qfields = ["id"]
julia> query(qvalue, qargs, qfields) .|> unnestdict |> table
Table with 1 column and 1 row:
     id
   ┌───────────────────────────────────────────
 1 │ 0x011bdfea664ece919d895d174f57331460056236
```

```@docs
TheGraphData.table
```