# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

export client!

const client = Ref(
    GQLC.Client(
        "https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-mainnet";
        introspect=false,
    ),
)

"""
    client!(u::AbstractString; introspect=false)
    client!(c::GraphQLClient.Client)

Set the provided url (`u`) or client (`c`) as the new global client.

By default, we decide to not introspect as its much slower to do so if you don't need to.
However, if your use-case could benefit from introspection, you should set it to `true`.
If you're unsure, benchmark both approaches in the context of your code and see what works.
"""
function client!(u::AbstractString; introspect=false)
    return client[] = GQLC.Client(u; introspect=introspect)
end
client!(c::GQLC.Client) = client[] = c
