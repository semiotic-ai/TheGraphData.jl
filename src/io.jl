"""
    write(f::AbstractString, d; kwargs...)
    write(::Union{Val{:csv},Val{:txt}}, f::AbstractString, d::Union{T,D}; kwargs...) where {T<:Table,D<:Dict}

Write the data `d` to the filepath `f` with kwargs.
NOTE: This function is unexported.
"""
function write(f::AbstractString, d; kwargs...)
    ext = Symbol(splitext(f)[end][2:end])  # TODO: Better way?
    try
        fout = write(Val(ext), f, d; kwargs...)
        return fout
    catch e
        if e isa MethodError
            error(
                "The function `write` does not support filetype $ext and datatype $(typeof(d)) together. " *
                "Please submit a feature request or PR if you want this functionality.",
            )
        end
    end
    return f
end
function write(
    ::Union{Val{:csv},Val{:txt}}, f::AbstractString, d::Union{T,D}; kwargs...
) where {T<:Table,D<:Dict}
    @mock(CSV.write(f, d; kwargs...))
end
