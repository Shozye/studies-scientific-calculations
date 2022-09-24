# Mateusz Pełechaty, indeks: 261737
function getMax(type)
    max = type(2)
    prev_prev_max = type(0.5)
    prev_max = type(1)
    while (prev_max < max)
        prev_prev_max = prev_max
        prev_max = max
        max *= 2
    end
    return prev_prev
end

floats = [Float16, Float32, Float64]

for float in floats
    println(float)
    println(getMax(float))
    println(floatmax(float))
end
