# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

using TheGraphData

using CSV
using Mocking
using Test
using TypedTables

import GraphQLClient as GQLC

Mocking.activate()

include("patch.jl")
for f in readlines(joinpath(@__DIR__, "testgroups"))
    include(f * ".jl")
end
