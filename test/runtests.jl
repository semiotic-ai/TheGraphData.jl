using TheGraphData
using Test
using Mocking
import GraphQLClient as GQLC

Mocking.activate()

for f in readlines(joinpath(@__DIR__, "testgroups"))
    include(f * ".jl")
end
