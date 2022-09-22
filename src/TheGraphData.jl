module TheGraphData

using Mocking
using TensorCast
using TypedTables

import GraphQLClient as GQLC

include("client.jl")
include("query.jl")
include("data.jl")

end
