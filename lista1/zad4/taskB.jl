# Mateusz Pełechaty, indeks: 261737

include("common.jl")

function find()
    start = Float64(1.0)
    amount = 0
    while true
        if calculate(start) != 1
            return start, amount
        end
        amount += 1
        start = nextfloat(start)
    end
end
found, nextfloat_uses = find()
println("Po uzyciu nextfloat ", nextfloat_uses, " razy otrzymałem liczbę ")
println(found, ", bitstring: ", bitstring(found))