# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

export mutate

"""
    mutate(v::AbstractString, a::AbstractDict)

Send a mutation to the client for value `v` with arguments `a`.

By default, the client is the gateway.
This function returns a GQL response.
"""
function mutate(v::AbstractString, a::Dict)
    d = @mock(GQLC.mutate(client[], v, a))
    return d
end
