module TheGraphData

using TOML
using TypedTables
using TensorCast
using Mocking

import GraphQLClient as GQLC

include("client.jl")
include("query.jl")
include("data.jl")

end
