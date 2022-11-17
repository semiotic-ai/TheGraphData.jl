# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

export table, flatten, setdefault!, symbolkeys, dicttont

"""
    table(d::AbstractVector{D}) where {D<:Dict}
    table(d::CSV.File)
    table(d::NamedTuple)

Convert the queried data `d` to a TypedTable.
"""
function table(d::AbstractVector{D}) where {D<:Dict}
    # Benchmarking shows that using dataframe with t = reduce(vcat, DataFrame.(d))
    # is about twice as slow
    # TODO: still slow
    ks = keys(d[1])
    vs = collect.(values.(d))
    @cast ws[i][j] := vs[j][i]
    t = Table(; (Symbol.(ks) .=> ws)...)
    return t
end
function table(d::CSV.File)
    return Table(d)
end
table(d::NamedTuple) = Table(d)

"""
    flatten(d::Dict)

Flatten a dictionary `d`.

For example, for `Dict(:a => Dict(:b => 2))`, the resulting dictionary would be
`Dict(:(a.b) => 2)`.
"""
function flatten(d::Dict)
    isempty(d) && return d
    return flatten("", d)
end
function flatten(kp, d::Dict)  # helper
    return merge(map(collect(d)) do p
        k, v = p
        if !isempty(kp)  # NOTE: Potential refactor, remove if
            kp = join((kp, "."))
        end
        return flatten(join((kp, k)), v)
    end...)
end
flatten(k, v) = Dict(k => v)  # helper

"""
    setdefault!(d::Dict, k, v)

Set the value in the collection if it doesn't exist.

Similar to Python's `setdefault` when used on dictionaries.
On vectors, this checks if the value is in the vector, and adds it if it isn't.
This does not work on nested vectors.
"""
function setdefault!(d::Dict, k, v)
    if !haskey(d, k)
        d[k] = v
    end
    return d
end
setdefault!(d::Vector, v) = v in d ? d : push!(d, v)

"""
    symbolkeys(d::Dict)

Convert a dictionary's string keys to symbols
"""
symbolkeys(d::Dict) = Dict(Symbol.(keys(d)) .=> values(d))

"""
    dicttont(d::Dict)

Convert a dictionary to a namedtuple. The keys of the dictionary must be symbols.
"""
dicttont(d::Dict{Symbol}) = (; d...)
dicttont(d::Dict) = (; symbolkeys(d)...)
