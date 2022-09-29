# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

"""
    splitextsym(f::AbstractString)

Get the extension of the filepath `f` as a symbol.

This function is unexported.
"""
function splitextsym(f::AbstractString)
    x = Symbol(splitext(f)[end][2:end])  # TODO: Better way?
    if x == Symbol("")
        throw(ArgumentError("$f has no extension."))
    end
    return x
end

"""
    write(f::AbstractString, d; kwargs...)
    write(::Union{Val{:csv},Val{:txt}}, f::AbstractString, d::Union{T,D}; kwargs...) where {T<:Table,D<:Dict}

Write the data `d` to the filepath `f` with kwargs.

This function is unexported.
It will raise a `MethodError` if the specified filetype and datatype are not yet implemented.
Please submit a PR or feature request if you want this particular combo to be supported.
"""
function write(f::AbstractString, d; kwargs...)
    ext = splitextsym(f)
    fout = write(Val(ext), f, d; kwargs...)
    return fout
end
function write(
    ::Union{Val{:csv},Val{:txt}}, f::AbstractString, d::Union{T,D}; kwargs...
) where {T<:Table,D<:Dict}
    @mock(CSV.write(f, d; kwargs...))
end

"""
    read(f::AbstractString; kwargs...)
    read(::Union{Val{:csv},Val{:txt}}, f::AbstractString; kwargs...)

Read the data from the filepath `f` with kwargs.

This function is unexported.
It will raise a `MethodError` if the specified filetype and datatype are not yet implemented.
Please submit a PR or feature request if you want this particular combo to be supported.
"""
function read(f::AbstractString; kwargs...)
    # FIXME: Could become type unstable when we add more `read` function
    # Check @code_warntype
    ext = splitextsym(f)
    d = read(Val(ext), f; kwargs...)
    return d
end
function read(::Union{Val{:csv},Val{:txt}}, f::AbstractString; kwargs...)
    @mock(CSV.File(f; kwargs...))
end
