# Mateusz Pełechaty, indeks: 261737

include("utils.jl")
using Printf

function pad(x, size=18)
    return lpad(x, size, ' ')
end
function main()
    @printf("%s %s %s %s\n", pad("i",2), pad("normal"), pad("interrupted"), pad("|difference|"))

    p_1 = Float32(0.01)
    p_2 = Float32(0.01)
    for i in 0:40
        if i == 10
            p_2 = round(p_2; digits=3)
        end
        @printf("%s %s %s %s\n", pad(i,2), pad(p_1), pad(p_2), pad(abs(p_1-p_2)))
        p_1 = p_next(p_1, Float32(3.0))
        p_2 = p_next(p_2, Float32(3.0))

    end
end

main()