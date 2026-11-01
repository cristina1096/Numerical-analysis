using Plots
f(x) = sin(x); df(x) = cos(x); x0 = 1.0
hs   = [10.0^(-k) for k in 1:14]
errs = [abs((f(x0 + h) - f(x0)) / h - df(x0)) for h in hs]
plot(hs, errs, xscale=:log10, yscale=:log10, marker=:o,
     xlabel="h", ylabel="error", label="forward difference")
# estimated order between consecutive points:
[log(errs[i+1]/errs[i]) / log(hs[i+1]/hs[i]) for i in 1:length(hs)-1]