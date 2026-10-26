module FundamentalsNumericalComputation

export FNC
FNC = FundamentalsNumericalComputation

using Reexport # loads libraries

@info "Re-exporting multiple packages..."

@reexport using LinearAlgebra
@reexport using Statistics
@reexport using SparseArrays
@reexport using Polynomials
@reexport using NLsolve
@reexport using DifferentialEquations
@reexport using Plots
@reexport using PrettyTables
@reexport using Dierckx: Spline1D
@reexport using QuadGK 
@reexport using MatrixDepot
@reexport using GraphRecipes
@reexport using Images
@reexport using TestImages
@reexport using Arpack
@reexport using IterativeSolvers
@reexport using LinearMaps
@reexport using IncompleteLU
@reexport using Preconditioners
@reexport using FFTW
@reexport using FileIO
@reexport using SpecialFunctions
@reexport using LaTeXStrings
@reexport using Printf
@reexport using JLD2
@reexport using Printf

include("horner.jl")




end