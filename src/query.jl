export query

"""
    query(v::AbstractString, a::Dict, f::AbstractVector{S}) where {S<:AbstractString}

Query the client for value `v` with arguments `a` and fields `f`.

By default, the client is the gateway.
This function returns a vector of dictionaries.
"""
function query(v::AbstractString, a::Dict, f::AbstractVector{S}) where {S<:AbstractString}
    # TODO: Better way to convert the type?
    data::Vector{<:Dict} = map(  # Convert Vector{Dict{Any, Any}} to proper types
        x -> x,
        @mock(GQLC.query(client[], v; query_args=a, output_fields=f)).data[v],
    )
    return data
end
