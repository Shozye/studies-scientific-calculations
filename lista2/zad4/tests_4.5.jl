include("wielomian_changed.jl")
using Polynomials
using Printf

function pad(str, size=23)
    return lpad(str, size, " ")
end

function main()
    Z = roots(polynomial_changed)
    @printf("%s,%s,%s,%s\n", pad("k",2), pad("Z_k"), pad("|P(Z_k)|"), pad("|Z_k - k|"))
    for k in 1:20
        Z_k = Z[k]
        @printf("%s,%s,%s,%s\n", pad(k, 2), pad(Z_k), pad(abs(P_changed(Z_k))), pad(abs(Z_k-k)))
    end
end
main()