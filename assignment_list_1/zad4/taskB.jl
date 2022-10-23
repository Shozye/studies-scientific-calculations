# Mateusz Pełechaty, indeks: 261737

function calculate(num)
    return Float64(num*Float64(1/num))
end

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
println("Found: ", found, ", bitstring: ", bitstring(found))