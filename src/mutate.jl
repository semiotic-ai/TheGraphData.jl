# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

export mutate

"""
    mutate(v::AbstractString, a::AbstractDict)

Send a mutation to the client for value `v` with arguments `a`.

By default, the client is the gateway.
This function returns a vector of dictionaries.
"""
function mutate(v::AbstractString, a::Dict)
    d::Union{Vector,Dict} = @mock(GQLC.mutate(client[], v, a)).data[v]
    return querytypehelper(d)
end
