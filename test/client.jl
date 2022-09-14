@testset "client" begin
    @test TheGraphData.client[].endpoint ==
        "https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-mainnet"

    @testset "client!" begin
        client!("https://countries.trevorblades.com")
        @test TheGraphData.client[].endpoint == "https://countries.trevorblades.com"
        client!(
            GQLC.Client(
                "https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-mainnet",
            ),
        )
        @test TheGraphData.client[].endpoint ==
            "https://api.thegraph.com/subgraphs/name/graphprotocol/graph-network-mainnet"
    end
end
