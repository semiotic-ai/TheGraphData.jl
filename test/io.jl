@testset "io" begin
    write_success_patch = @patch function CSV.write(f, t; kwargs...)
        println("write stub => simulating success")
        return "success!"
    end
    @testset "TheGraphData.write" begin
        @testset "failure" begin
            @test_throws Exception TheGraphData.write("foo.bar", Dict("a" => 1))
        end
        @testset "table" begin
            d = Table(; a=[1, 2, 3], b=[3, 2, 1])
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
end
