using LinearAlgebra, Plots
include(joinpath(@__DIR__, "..", "..", "src", "lu.jl"))
include(joinpath(@__DIR__, "..", "helper.jl"))
outdir = joinpath(@__DIR__, "..", "..", "results", "linear_system")

ϵs = [10.0^(-k) for k in 1:20]
err_mine = Float64[]; err_julia = Float64[]
for ϵ in ϵs
    A = [ϵ 1.0; 1.0 1.0]
    b = [1.0, 2.0]
    xt = [1 / (1 - ϵ), (1 - 2ϵ) / (1 - ϵ)]
    push!(err_mine, max(relerr(my_solve(A, b), xt), 1e-17))
    push!(err_julia, max(relerr(A \ b, xt), 1e-17))
end

p = plot(ϵs, [err_mine, err_julia]; xscale=:log10, yscale=:log10, marker=:o,
     label=["no pivoting (my_solve)" "partial pivoting (A \\ b)"],
     xlabel="pivot ε", ylabel="relative error", xflip=true, legend=:topleft)
savefig(p, joinpath(outdir, "lu_tiny_pivot.png"))
