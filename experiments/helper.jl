relerr(x, xtrue)  = norm(x - xtrue) / norm(xtrue)           # forward error
backerr(A, x, b)  = norm(b - A*x) / (norm(A) * norm(x))     # backward error