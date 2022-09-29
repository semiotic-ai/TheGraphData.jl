# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

@testset "query" begin
    struct Data
        data
    end

    query_success_patch = @patch function GQLC.query(
        c::GQLC.Client, v; query_args, output_fields
    )
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
            v = TheGraphData.query("subgraphDeployments", Dict("foo" => 1), ["foo"])
            @test v == [
                Dict("ipfsHash" => "Qma", "signalledTokens" => "1"),
                Dict("ipfsHash" => "Qmb", "signalledTokens" => "2"),
            ]

            v = TheGraphData.query("indexers", Dict("foo" => 1), ["foo"])
            @test v == [
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
            ]

            v = TheGraphData.query("allocations", Dict("foo" => 1), ["foo"])
            @test v == [
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
            ]
        end
    end
end
