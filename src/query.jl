export query

"""
    query(v::AbstractString, a::Dict, f::AbstractVector{S}) where {S<:AbstractString}

Query the client for value `v` with arguments `a` and fields `f`.

By default, the client is the gateway.
This function returns a vector of dictionaries.
"""
function query(v::AbstractString, a::Dict, f::AbstractVector{S}) where {S<:AbstractString}
    # TODO: Better way to convert the type?
    # TODO: Catch MethodError: no method matching getindex(::Nothing, String)
    data::Vector{<:Dict} = Dict[
        x for x in @mock(GQLC.query(client[], v; query_args=a, output_fields=f)).data[v]
    ]
    return data
end
