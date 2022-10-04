struct Data
    data
end

query_success_patch = @patch function GQLC.query(
    c::GQLC.Client, v; query_args, output_fields
)
    println("query stub ==> simulating allocations")
    a = get(query_args, "where", Dict())

    isempty(a) && return Data(
        Dict(
            "allocations" => [
                Dict(
                    "id" => "0xa",
                    "subgraphDeployment" => Dict("ipfsHash" => "Qma"),
                    "allocatedTokens" => "1",
                ),
            ],
        ),
    )

    a["id_gt"] == "0xa" && return Data(
        Dict(
            "allocations" => [
                Dict(
                    "id" => "0xb",
                    "subgraphDeployment" => Dict("ipfsHash" => "Qmb"),
                    "allocatedTokens" => "2",
                ),
            ],
        ),
    )

    return Data(Dict("allocations" => Dict[]))
end
write_success_patch = @patch function CSV.write(f, t; kwargs...)
    println("write stub => simulating success")
    return "success!"
end
read_csv_success_patch = @patch function CSV.File(f; kwargs...)
    println("read stub => simulating success")
    return CSV.File(IOBuffer("X\nb\nc\na\nc"))
end
