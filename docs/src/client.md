# Client

In order to query data, this package must have access to a valid GraphQL client.
By default, this client is the gateway (https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-mainnet).
However, you can change the client to another.

```julia
julia> client!("mynewclient.com/endpoint")
```

```@docs
TheGraphData.client!
```

This sets the global client, so all subsequent calls to functions in [Querying](@ref) do not need you to track and pass the client around.
