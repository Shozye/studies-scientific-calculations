include("wielomian_base.jl")
using Polynomials
using Printf

function pad(str, size=23)
    return lpad(str, size, " ")
end

function main()
    Z = roots(polynomial_base)
    @printf("%s,%s,%s,%s,%s\n", pad("k",2), pad("Z_k"), pad("|P(Z_k)|"), pad("p(Z_k)"), pad("|Z_k - k|"))
    for k in 1:20
        Z_k = Z[k]
        @printf("%s,%s,%s,%s,%s\n", pad(k, 2), pad(Z_k), pad(abs(P(Z_k))), pad(p(Z_k)), pad(abs(Z_k-k)))
    end
end
main()