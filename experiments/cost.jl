using BenchmarkTools, LinearAlgebra
for n in (100, 200, 400, 800)
    A = randn(n, n); b = randn(n)
    t = @belapsed $A \ $b
    println(rpad(n, 6), t)
end