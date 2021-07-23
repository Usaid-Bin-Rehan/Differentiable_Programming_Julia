function Babylonian(x ; N = 10)
    t = (1+x) / 2
    for i = 2 : N ; t = (t + x/t) / 2 end
        t
end

α = π
Babylonian(α), √α

x = 2; Babylonian(x), √x

import Pkg; Pkg.add("Plots")
using Plots
plotly()

i = 0:0.01:49
plot([x->Babylonian(x,N=i) for i=1:5],i,label=["iteration $j" for i=11,j=1:5])
plot!(sqrt,i,c="black",label="sqrt",title="Those Babylonians really knew how to Square Root")

# D for Dual-number is a function-Derivative pair
struct D <: Number
    f::Tuple{Float64,Float64}
end

import Base: +, /, convert, promote_rule
+(x::D,y::D) = D(x.f + y.f)
/(x::D,y::D) = D( x.f[1]/y.f[1], (y.f[1]*x.f[2]-x.f[1]*y.f[2]/y.f[1]^2) )
convert(::Type{D},x::Real) = D((x,zero(x)))
promote_rule(::Type{D},::Type{<:Number}) = D
