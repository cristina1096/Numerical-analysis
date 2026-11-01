using LinearAlgebra, Random, Printf
include(joinpath(@__DIR__, "..", "..", "src", "lu.jl"))

Random.seed!(1)
for n in (10, 100, 500)
    for (name, A) in (("random", randn(n, n)), ("diag dominant", randn(n, n) + n*I))
        xt = ones(n); b = A * xt
        x  = my_solve(A, b)
        xr = A \ b
        L, U = my_lu(A)
        @printf("%4d %-14s cond=%8.1e | mine fwd=%8.1e bwd=%8.1e | A\\b fwd=%8.1e bwd=%8.1e | ||LU-A||/||A||=%8.1e | max L=%8.1e max L*N/A%8.1e\n",
                n, name, cond(A), relerr(x, xt), backerr(A, x, b),
                relerr(xr, xt), backerr(A, xr, b), norm(L*U - A) / norm(A),
                maximum(abs.(L)), norm(abs.(L)*abs.(U))/norm(A))
    end
end