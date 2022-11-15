# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

@testset "client" begin
    @test TheGraphData.client[].endpoint ==
        "https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-mainnet"

    @testset "client!" begin
        client!("https://countries.trevorblades.com")
        @test TheGraphData.client[].endpoint == "https://countries.trevorblades.com"
        client!(
            GQLC.Client(
                "https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-mainnet";
                introspect=false,
            ),
        )
        @test TheGraphData.client[].endpoint ==
            "https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-mainnet"
    end
end
