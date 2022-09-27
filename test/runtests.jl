using TheGraphData

using CSV
using Mocking
using Test
using TypedTables

import GraphQLClient as GQLC

Mocking.activate()

for f in readlines(joinpath(@__DIR__, "testgroups"))
    include(f * ".jl")
end
