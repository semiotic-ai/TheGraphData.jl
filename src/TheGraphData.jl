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
