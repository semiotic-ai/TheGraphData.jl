@testset "query" begin
    struct Data
        data
    end

    query_success_patch = @patch function GQLC.query(c, v; query_args, output_fields)
        if v == "subgraphDeployments"
            println("query stub ==> simulating subgraphs")
            return Data(
                Dict(
                    "subgraphDeployments" => [
                        Dict("ipfsHash" => "Qma", "signalledTokens" => "1"),
                        Dict("ipfsHash" => "Qmb", "signalledTokens" => "2"),
                    ],
                ),
            )
        end
        if v == "indexers"
            println("query stub ==> simulating indexers")
            return Data(
                Dict(
                    "indexers" => [
                        Dict(
                            "id" => "0xa",
                            "delegatedTokens" => "1",
                            "stakedTokens" => "10",
                            "lockedTokens" => "100",
                        ),
                        Dict(
                            "id" => "0xb",
                            "delegatedTokens" => "2",
                            "stakedTokens" => "20",
                            "lockedTokens" => "200",
                        ),
                    ],
                ),
            )
        end
        if v == "allocations"
            println("query stub ==> simulating allocations")
            return Data(
                Dict(
                    "allocations" => [
                        Dict(
                            "indexer" => Dict("id" => "0xa"),
                            "subgraphDeployment" => Dict("ipfsHash" => "Qma"),
                            "allocatedTokens" => "1",
                        ),
                        Dict(
                            "indexer" => Dict("id" => "0xb"),
                            "subgraphDeployment" => Dict("ipfsHash" => "Qmb"),
                            "allocatedTokens" => "2",
                        ),
                    ],
                ),
            )
        end
    end

    @testset "query" begin
        apply(query_success_patch) do
            t = TheGraphData.query("subgraphDeployments", Dict("foo" => 1), ["foo"])
            @test t.ipfsHash == ["Qma", "Qmb"]
            @test t.signalledTokens == ["1", "2"]

            t = TheGraphData.query("indexers", Dict("foo" => 1), ["foo"])
            @test t.id == ["0xa", "0xb"]
            @test t.delegatedTokens == ["1", "2"]
            @test t.stakedTokens == ["10", "20"]
            @test t.lockedTokens == ["100", "200"]

            t = TheGraphData.query("allocations", Dict("foo" => 1), ["foo"])
            @test t.allocatedTokens == ["1", "2"]
            @test t.indexer == [Dict("id" => "0xa"), Dict("id" => "0xb")]
            @test t.subgraphDeployment == [Dict("ipfsHash" => "Qma"), Dict("ipfsHash" => "Qmb")]
        end
    end
end
