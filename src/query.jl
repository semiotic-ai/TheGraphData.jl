export query

"""
    query(v, a, f)


"""
function query(v, a, f)
    vdata = @mock(GQLC.query(client, v; query_args=a, output_fields=f)).data[v]
    # TODO: Do we need to unnest? We could instead define an accessor that unnests during accessing
    # Table would store Dict for nested columns. Dict access is O(1), so wouldn't be the worst necessarily.
    # This pattern may also be more robust since we can't assume unnesting works for all fields.
    # Benchmarking shows that using dataframe with
    # t = reduce(vcat, DataFrame.(vdata))
    # is about twice as slow
    ks = keys(vdata[1])
    vd = vdata[1]
    vs = collect.(values.(vdata))
    @cast ws[i][j] := vs[j][i]
    t = Table(; (Symbol.(ks) .=> ws)...)
    return t
end
