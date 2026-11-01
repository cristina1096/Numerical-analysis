using LinearAlgebra

"""
Ax = b
A = LU
LUx = Lz = b with z = Ux
L, forward
U, backward

forward to solve z: Lz = b
backward to solve x: Ux = z
"""

"Solve Lz = b for lower triangular L. With unit_diag=true, assume L[i,i] = 1."
function forwardSub(L::AbstractMatrix, b::AbstractVector; unit_diag::Bool=false)
    n = size(L, 1)
    T = float(promote_type(eltype(L), eltype(b)))
    x = zeros(T, n)
    for i in 1:n
        s = T(b[i])
        for j in 1:i-1
            s -= L[i,j] * x[j]
        end
        x[i] = unit_diag ? s : s / L[i,i]
    end
    return x
end

"Solve Ux = b for upper triangular U (back substitution)."
function backSub(U::AbstractMatrix, b::AbstractVector)
    n = size(U, 1)
    T = float(promote_type(eltype(U), eltype(b)))
    x = zeros(T, n)
    for i in n:-1:1
        s = T(b[i])
        for j in i+1:n
            s -= U[i, j] * x[j]
        end
        x[i] = s / U[i, i]
    end
    return x
end

"LU factorization without pivoting. Return unit lower L and upper U."
function my_lu(A::AbstractMatrix)
    n = size(A, 1)
    size(A, 2) == n || throw(DimensionMismatch("A must be square"))
    U = copy(float(A))
    L = diagm(0=>ones(eltype(U), n))
    for k in 1:n
        U[k,k] == 0 && error("zero pivot at step $k: no LU without pivoting")
        for i in k+1:n
            ℓ = U[i, k] / U[k, k]
            L[i, k] = ℓ
            U[i, k] = 0
            for j in k+1:n
                U[i, j] -= ℓ*U[k, j]
            end
        end
    end
    return L, U
end    

"Solve Ax = b via my_lu, then a forward and a back substitution."
function my_solve(A::AbstractMatrix, b::AbstractVector)
    L, U = my_lu(A)
    z = forwardSub(L, b, unit_diag=true)
    x = backSub(U, z)
    return x
end    