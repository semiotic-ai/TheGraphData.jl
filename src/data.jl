# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

export table, unnestdict, setdefault!

"""
    table(d::AbstractVector{D}) where {D<:Dict}
    table(d::CSV.File)

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

"""
    unnestdict(d::Dict)

Unnest a dictionary `d`. The innermost key is preserved.
"""
function unnestdict(d::Dict)
    isempty(d) && return d
    return unnestdict("", d)
end
function unnestdict(kp, d::Dict)  # helper
    return merge(map(collect(d)) do p
        k, v = p
        if !isempty(kp)  # NOTE: Potential refactor, remove if
            kp = join((kp, "."))
        end
        return unnestdict(join((kp, k)), v)
    end...)
end
unnestdict(k, v) = Dict(k => v)  # helper

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
