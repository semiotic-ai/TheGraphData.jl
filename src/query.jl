# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

export query, paginated_query

"""
    query(
        v::AbstractString, a::Dict, f::AbstractVector{S}
    ) where {S<:AbstractString}

Query the client for value `v` with arguments `a` and fields `f`.

By default, the client is the gateway.
This function returns a vector of dictionaries.
Unless you know what you're doing, you should probably prefer [`paginated_query`](@ref) to
this function.
"""
function query(v::AbstractString, a::Dict, f::AbstractVector{S}) where {S<:AbstractString}
    d::Union{Vector,Dict} = @mock(GQLC.query(client[], v; query_args=a, output_fields=f)).data[v]
    return querytypehelper(d)
end

"""
    querytypehelper(v::Vector{Dict})
    querytypehelper(v::Dict)

Ensure output of [`query`](@ref) is type-stable.
"""
querytypehelper(v::Vector)::Vector{Dict} = map(x -> x, v)
querytypehelper(v::Dict)::Vector{Dict} = Dict[v,]

"""
    paginated_query(
        v::AbstractString, a::Dict, f::AbstractVector{S}
    ) where {S<:AbstractString}

Query the client using comparator-based pagination.

By default, the client is the gateway.
This function returns a vector of dictionaries.
Unless you know what you're doing, you should probably prefer this function to [`query`](@ref).
"""
function paginated_query(
    v::AbstractString, a::Dict, f::AbstractVector{S}
) where {S<:AbstractString}
    haskey(a, "orderBy") && @info "Note that paginated_query must be ordered by id."
    fo = "id"
    a["orderBy"] = fo
    f = setdefault!(f, fo)
    q = (a, f) -> query(v, a, f)
    d = q(a, f)
    ds = Vector{Dict}[]
    a = setdefault!(a, "where", Dict())
    while !isempty(d)
        ds::Vector{Dict} = vcat(ds, d)
        a["where"]["$(fo)_gt"] = ds[end][fo]
        d = q(a, f)
    end
    return ds
end
