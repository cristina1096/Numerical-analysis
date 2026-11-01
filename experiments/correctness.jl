using LinearAlgebra
n = 100
A = randn(n, n)
xtrue = ones(n)
b = A * xtrue                     # now xtrue is the exact solution
x = A \ b                         # replace with your own solver
fwd = norm(x - xtrue) / norm(xtrue)             # forward error
bwd = norm(b - A*x) / (norm(A) * norm(x))       # backward error (relative residual)
println("forward = $fwd, backward = $bwd, cond = $(cond(A))")