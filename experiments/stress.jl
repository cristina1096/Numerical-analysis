using LinearAlgebra
hilb(n) = [1 / (i + j - 1) for i in 1:n, j in 1:n]   # famously ill-conditioned
for n in 2:2:14
    A = hilb(n); xtrue = ones(n); b = A * xtrue
    x = A \ b
    fwd = norm(x - xtrue) / norm(xtrue)
    bwd = norm(b - A*x) / (norm(A) * norm(x))
    println("n=$n  cond=$(round(cond(A), sigdigits=2))  fwd=$(round(fwd, sigdigits=2))  bwd=$(round(bwd, sigdigits=2))")
end
