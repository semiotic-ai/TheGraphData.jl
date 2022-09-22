export table, unnestdict

"""
    table(data::AbstractVector{D}) where {D<:Dict}

Convert the queried `data` to a TypedTable.
"""
function table(data::AbstractVector{D}) where {D<:Dict}
    # Benchmarking shows that using dataframe with t = reduce(vcat, DataFrame.(data))
    # is about twice as slow
    ks = keys(data[1])
    vs = collect.(values.(data))
    @cast ws[i][j] := vs[j][i]
    t = Table(; (Symbol.(ks) .=> ws)...)
    return t
end

"""
    unnestdict(d::Dict)

Unnest a dictionary `d`. The innermost key is preserved.

Note that this function assumes no duplicate keys.
Else, the function may behave in unexpected ways.
"""
function unnestdict(d::Dict)
    isempty(d) && return d
    return unnestdict("", d)
end
function unnestdict(_, d::Dict)  # helper
    return merge(map(collect(d)) do p
        k, v = p
        return unnestdict(k, v)
    end...)
end
unnestdict(k, v) = Dict(k => v)  # helper
