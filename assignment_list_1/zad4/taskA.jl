# Mateusz Pełechaty, indeks: 261737

include("common.jl")

function find()
    amount = 0
    while true
        num = rand() + 1
        amount += 1
        if(calculate(num) != 1)
            return num, amount
        end
    end
end

x, _ = find()
println("Znaleziona liczba: ", x)
println("Bitstring: ", bitstring(x))

n = 10000000
total = 0
for i in 1:n
    global total
    _, amount = find()
    total += amount
end
println("Średnio potrzeba ", total/n, " sprawdzeń. n=", n)

