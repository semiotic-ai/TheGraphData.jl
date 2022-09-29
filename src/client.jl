# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

export client!

const client = Ref(
    GQLC.Client(
        "https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-mainnet"
    ),
)

"""
    client!(u::AbstractString)
    client!(c::GraphQLClient.Client)

Set the provided url (`u`) or client (`c`) as the new global client.
"""
client!(u::AbstractString) = client[] = GQLC.Client(u)
client!(c::GQLC.Client) = client[] = c
