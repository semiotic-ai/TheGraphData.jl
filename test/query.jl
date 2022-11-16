# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

@testset "query" begin
    @testset "query" begin
        a = Dict("foo" => 1)
        f = ["foo"]
        apply(query_success_patch) do
            v = TheGraphData.query("allocations", a, f)
            @test v == [
                Dict(
                    "id" => "0xa",
                    "subgraphDeployment" => Dict("ipfsHash" => "Qma"),
                    "allocatedTokens" => "1",
                ),
            ]
        end
    end
    @testset "paginated_query" begin
        a = Dict("foo" => 1, "bar" => "foobar")
        f = ["foo"]
        apply(query_success_patch) do
            v = TheGraphData.paginated_query("allocations", a, f)
            @test v == [
                Dict(
                    "id" => "0xa",
                    "subgraphDeployment" => Dict("ipfsHash" => "Qma"),
                    "allocatedTokens" => "1",
                ),
                Dict(
                    "id" => "0xb",
                    "subgraphDeployment" => Dict("ipfsHash" => "Qmb"),
                    "allocatedTokens" => "2",
                ),
            ]
        end
    end
end
