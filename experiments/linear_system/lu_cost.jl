using LinearAlgebra, BenchmarkTools, Plots
include(joinpath(@__DIR__, "..", "..", "src", "lu.jl"))

outdir = joinpath(@__DIR__, "..", "..", "results", "linear_system")

ns = [100, 200, 400, 800]
t_mine = Float64[]; t_lapack = Float64[]; t_back = Float64[]
for n in ns
    A = randn(n, n) + I*n
    b = randn(n)
    L, U = my_lu(A)
    push!(t_mine, @belapsed my_lu($A))
    push!(t_lapack, @belapsed lu($A))
    push!(t_back,   @belapsed backSub($U, $b))
end

slope(t) = log(t[end] / t[end-1]) / log(ns[end] / ns[end-1])
println("slopes: my_lu = ", slope(t_mine), 
"   lu = ", slope(t_lapack), "   back_sub = ", slope(t_back))

p = plot(ns, [t_mine t_lapack t_back]; xscale=:log10, yscale=:log10, marker=:o,
     label=["my_lu" "LAPACK lu" "back_sub"], xlabel="n", ylabel="time (s)", legend=:topleft)
savefig(p, joinpath(outdir, "E2_timing.png"))
