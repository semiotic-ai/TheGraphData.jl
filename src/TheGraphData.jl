# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

module TheGraphData

using Mocking
using TensorCast
using TypedTables
using CSV

import GraphQLClient as GQLC

include("client.jl")
include("query.jl")
include("data.jl")
include("io.jl")

end
