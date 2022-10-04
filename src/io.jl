# Copyright 2022-, Semiotic AI, Inc.
# SPDX-License-Identifier: Apache-2.0

abstract type FiletypeTrait end
struct IsCSV <: FiletypeTrait end

FiletypeTrait(::Val{:csv}) = IsCSV()
FiletypeTrait(::Val{:txt}) = IsCSV()

"""
    splitextsym(f::AbstractString)

Get the extension of the filepath `f` as a symbol.

This function is unexported.
"""
function splitextsym(f::AbstractString)
    x = Symbol(splitext(f)[end][2:end])
    if x == Symbol("")
        throw(ArgumentError("$f has no extension."))
    end
    return x
end

"""
    write(f::AbstractString, d; kwargs...)
    write(v::Val, f::AbstractString, d; kwargs...)
    write(::IsCSV, f::AbstractString, d::Union{T,D}; kwargs...) where {T<:Table,D<:Dict}

Write the data `d` to the filepath `f` with kwargs.

This function is unexported.
It will raise a `MethodError` if the specified filetype and datatype are not yet implemented.
Please submit a PR or feature request if you want this particular combo to be supported.
"""
function write(f::AbstractString, d; kwargs...)
    ext = splitextsym(f)
    _ = mkpath(dirname(f))
    fout = write(Val(ext), f, d; kwargs...)
    return fout
end
write(v::Val, f::AbstractString, d; kwargs...) = write(FiletypeTrait(v), f, d; kwargs...)
function write(
    ::IsCSV, f::AbstractString, d::Union{T,D}; kwargs...
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
read(v::Val, f::AbstractString; kwargs...) = read(FiletypeTrait(v), f; kwargs...)
function read(::IsCSV, f::AbstractString; kwargs...)
    @mock(CSV.File(f; kwargs...))
end
