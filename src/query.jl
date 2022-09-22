export query, table

"""
    query(v::AbstractString, a::Dict, f::AbstractVector{S}) where {S<:AbstractString}

Query the client for value `v` with arguments `a` and fields `f`.

By default, the client is the gateway.
This function returns a vector of dictionaries.
"""
function query(v::AbstractString, a::Dict, f::AbstractVector{S}) where {S<:AbstractString}
    vdata = @mock(GQLC.query(client, v; query_args=a, output_fields=f)).data[v]
    return vdata
end
