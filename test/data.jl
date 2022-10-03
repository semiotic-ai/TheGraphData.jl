# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

@testset "data" begin
    @testset "table" begin
        t = table([
            Dict("ipfsHash" => "Qma", "signalledTokens" => "1"),
            Dict("ipfsHash" => "Qmb", "signalledTokens" => "2"),
        ])
        @test t.ipfsHash == ["Qma", "Qmb"]
        @test t.signalledTokens == ["1", "2"]

        t = table([
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
        ])
        @test t.id == ["0xa", "0xb"]
        @test t.delegatedTokens == ["1", "2"]
        @test t.stakedTokens == ["10", "20"]
        @test t.lockedTokens == ["100", "200"]

        t = table([
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
        ])
        @test t.allocatedTokens == ["1", "2"]
        @test t.indexer == [Dict("id" => "0xa"), Dict("id" => "0xb")]
        @test t.subgraphDeployment == [Dict("ipfsHash" => "Qma"), Dict("ipfsHash" => "Qmb")]

        t = table(CSV.File(IOBuffer("X\nb\nc\na\nc")))
        @test t.X == ["b", "c", "a", "c"]
    end
    @testset "unnestdict" begin
        d = Dict("a" => 1, "b" => 2, "c" => 3)
        v = unnestdict(d)
        @test v == d

        d = Dict()
        v = unnestdict(d)
        @test v == d

        d = Dict("a" => 1, "b" => Dict("c" => 3))
        v = unnestdict(d)
        @test v == Dict("a" => 1, "c" => 3)

        d = Dict("a" => 1, "b" => Dict("c" => Dict("d" => 4)))
        v = unnestdict(d)
        @test v == Dict("a" => 1, "d" => 4)
    end
    @testset "setdefault!" begin
        @testset "dict" begin
            d = Dict("a" => 1, "b" => 2)
            _ = setdefault!(d, "c", 3)
            @test d["c"] == 3
            _ = setdefault!(d, "c", 4)
            @test d["c"] == 3
        end
        @testset "vector" begin
            d = ["a", "b"]
            _ = setdefault!(d, "c")
            @test d == ["a", "b", "c"]
            _ = setdefault!(d, "c")
            @test d == ["a", "b", "c"]
        end
    end
end
