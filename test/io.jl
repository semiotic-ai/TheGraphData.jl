# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

@testset "io" begin
    @testset "extsym" begin
        @test TheGraphData.splitextsym("this/is/a/file.txt") == :txt
        @test_throws ArgumentError TheGraphData.splitextsym("this/is/not/a/file")
    end
    @testset "TheGraphData.write" begin
        @testset "failure" begin
            @test_throws MethodError TheGraphData.write("foo.bar", Dict("a" => 1))
        end
        @testset "table" begin
            d = Table(; a=[1, 2, 3], b=[3, 2, 1])
            apply(write_success_patch) do
                @test TheGraphData.write("fpath.csv", d; delimiter=" ") == "success!"
                @test TheGraphData.write("fpath.txt", d; delimiter=" ") == "success!"
            end
        end
        @testset "flextable" begin
            d = FlexTable(; a=[1, 2, 3], b=[3, 2, 1])
            apply(write_success_patch) do
                @test TheGraphData.write("fpath.csv", d; delimiter=" ") == "success!"
                @test TheGraphData.write("fpath.txt", d; delimiter=" ") == "success!"
            end
        end
        @testset "dictionary" begin
            d = Dict("a" => 1, "b" => 2)
            apply(write_success_patch) do
                @test TheGraphData.write("fpath.csv", d; delimiter=" ") == "success!"
                @test TheGraphData.write("fpath.txt", d; delimiter=" ") == "success!"
            end
        end
    end
    @testset "TheGraphData.read" begin
        apply(read_csv_success_patch) do
            @test TheGraphData.read("fpath.csv")[1][:X] == "b"
            @test_throws MethodError TheGraphData.read("fpath.foo")
        end
    end
end
