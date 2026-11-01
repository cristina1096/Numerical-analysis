# ref: https://github.com/fncbook/FundamentalsNumericalComputation.jl/tree/main

module MyNum

export horner
export forwardSub, backSub, my_lu, my_solve

include("horner.jl")
include("lu.jl")

end