# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

@testset "mutate" begin
    @testset "mutate" begin
        v = "queueActions"
        a = Dict("actions" => Dict("a" => 1, "b" => 2))
        apply(mutate_success_patch) do
            @test mutate(v, a) == [Dict("a" => 1, "b" => 2)]
        end
    end
end
