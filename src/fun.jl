import Base.call

export Fun, AND, OR, XOR, NAND, NOR, NOT, ZERO, ONE, DEFAULT_FUNCS

@doc """A function of arity `A`.

When called, `fun` will be passed exactly `A` `BitString`s and should return a
single `BitString`.
"""
immutable Fun{A}
  fun::Function
  name::AbstractString
end

Fun(f::Function, a::Integer, name::AbstractString) = Fun{a}(f, name)
Fun(f::Function, a::Integer) = Fun(f, a, string(f))

call{A}(f::Fun{A}, args::BitString...) = f.fun(args[1:A]...)

const AND = Fun(&, 2)
const OR = Fun(|, 2)
const XOR = Fun($, 2)
const NAND = Fun((x,y) -> ~(x & y), 2, "^&")
const NOR = Fun((x,y) -> ~(x | y), 2, "^|")
const NOT = Fun(~, 1)
const ZERO = Fun(() -> convert(BitString, 0), 0, "0")
const ONE = Fun(() -> ~convert(BitString, 0), 0, "1")

const DEFAULT_FUNCS = [AND, OR, XOR, NOT, ZERO, ONE]
