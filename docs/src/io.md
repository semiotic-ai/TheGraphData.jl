# IO

The section will take you through functions that you can use for IO.
We can divide IO into two categories: [Reading Data](@ref) and [Writing Data](@ref).

## Reading Data

Instead of querying data ([Querying Clients](@ref)), if you already have the data you care about, you can read it.

```julia
julia> TheGraphData.read("myfile.csv")
4-element CSV.File:
 CSV.Row: (X = "b",)
 CSV.Row: (X = "c",)
 CSV.Row: (X = "a",)
 CSV.Row: (X = "c",)
```

```@docs
TheGraphData.read
```

Oftentimes, you will want to chain `TheGraphData.read` with a reformatting function ([Reformatting Queried Data](@ref)) to put the data into a nicer format.

```julia
julia> TheGraphData.read("myfile.csv") |> table
Table with 1 column and 4 rows:
     X
   ┌──
 1 │ b
 2 │ c
 3 │ a
 4 │ c
```

## Writing Data

After running an experiment, you may want to save the final state.
Or perhaps you want to save the experiment's initial state so as to repeat the experiment.
We support these use cases, among others, by allowing you to write data to disk.

```julia
julia> t = Table(a = [1, 2, 3])
Table with 1 column and 3 rows:
     a
   ┌──
 1 │ 1
 2 │ 2
 3 │ 3
julia> TheGraphData.write("myfile.csv", t)
"myfile.csv"
```

```@docs
TheGraphData.write
```
