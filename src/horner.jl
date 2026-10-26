"""
Horner's alg: 

horner(c, x)

Evaluate a polynomial whose coefficients are given in ascending
order in 'c', at the point 'x', using horner's rule

y = c1 + ... + c_n * x^n-1
"""

function horner(c, x)
    n = length(c)
    y = c[n]
    for i in n-1:-1:1
        y = y * x + c[i]
    end
    return y
end