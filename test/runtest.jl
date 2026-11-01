#using FundamentalsNumericalComputation
using Test
using LinearAlgebra
using Random
using Printf
include("../src/MyNum.jl")
using .MyNum

# ---- test helpers ----
"Forward error and backward error"
relerr(x, xtrue)  = norm(x - xtrue) / norm(xtrue)           # forward error
backerr(A, x, b)  = norm(b - A*x) / (norm(A) * norm(x))     # backward error


@testset "horner" begin
	@test horner([-1,3,-3,1],1.6) ≈ 0.6^3
end

@testset "forwardSub" begin
	L = [2.0 0 0; 1 3 0; 4 -1 5]
    b = [2.0, 5, 3]
    @test L * forwardSub(L, b) ≈ b

    L1 = [1.0 0 0; 2 1 0; 3 4 1]           # unit diagonal
    @test L1 * forwardSub(L1, b; unit_diag=true) ≈ b
end

@testset "backSub" begin
	U = [2.0 1 -1; 0 3 2; 0 0 4]
	b = [1.0, 2, 3]
	@test U * backSub(U, b) ≈ b
end

@testset "my_lu" begin
	# small example worked by hand
	A = [2.0 1 1; 4 3 3; 8 7 9]
	L, U = my_lu(A)
	@test L ≈ [1 0 0; 2 1 0; 4 3 1]
	@test U ≈ [2 1 1; 0 1 1; 0 0 2]

	# random matrices; adding n*I makes A diagonally dominant, so no zero pivots
	Random.seed!(1)
	for n in (1, 2, 5, 20)
		A = rand(n, n) + n * I 	# ensure pivot is not zero
		L, U = my_lu(A)
		@test istril(L) && istriu(U)
		@test all(diag(L) .== 1)
		@test L * U ≈ A

		F = lu(A, NoPivot())
		@test L ≈ F.L
		@test U ≈ F.U
	end

	# no LU without pivoting when the first pivot is zero
	@test_throws ErrorException my_lu([0.0 1; 1 0])
end

@testset "my_solve" begin
	# hand example
	A = [2.0 1 1; 4 3 3; 8 7 9]
	b = [4.0, 10, 24]
	x = my_solve(A, b)
	@test A * x ≈ b
	@task x ≈ [1, 1, 1]

	# random matrics: recover a known solution and match A \ b
	Random.seed!(2)
	for n in (5, 10, 100, 500)
		for (name, A) in (("random", randn(n, n)), ("diag dominant", randn(n, n) + n * I))
			xt = ones(n)
			b = A * xt
			x = my_solve(A, b)
			xr = A \ b
			L, U = my_lu(A)
			@printf("%4d %-14s cond=%8.1e | mine fwd=%8.1e bwd=%8.1e | A\\b fwd=%8.1e bwd=%8.1e | ||LU-A||/||A||=%8.1e | max L=%8.1e max L*N/A%8.1e\n",
                n, name, cond(A), relerr(x, xt), backerr(A, x, b),
                relerr(xr, xt), backerr(A, xr, b), norm(L*U - A) / norm(A),
				maximum(abs.(L)), norm(abs.(L)*abs.(U))/norm(A))
		end
	end

end
