# Querying Clients

This section will take you through setting a client and querying it.

In order to query data, this package must have access to a valid GraphQL client.
By default, this client is the gateway (https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-mainnet).
However, you can change the client to another.

```julia
julia> client!("mynewclient.com/endpoint")
```

```@docs
TheGraphData.client!
```

This sets the global client, so all subsequent calls to querying function do not need you to track and pass the client around.

After ensuring that you've correctly set the client [Client](@ref), you can now query the client for data.
```julia
julia> qvalue = "subgraphDeployments"
julia> qargs = Dict("first" => 1000, "orderBy" => "signalledTokens")
julia> qfields = ["ipfsHash"]
julia> query(qvalue, qargs, qfields)
```

```@docs
TheGraphData.query
```
