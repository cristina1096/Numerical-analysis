#using FundamentalsNumericalComputation
using Test
using LinearAlgebra

include("../src/horner.jl")

@testset "horner" begin
	@test horner([-1,3,-3,1],1.6) ≈ 0.6^3
end