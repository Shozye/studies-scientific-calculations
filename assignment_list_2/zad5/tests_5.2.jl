# Mateusz Pełechaty, indeks: 261737

include("utils.jl")
using Printf

function pad(x, size=22)
    return lpad(x, size, ' ')
end

function main()
    @printf("%s %s %s %s\n", pad("i",2), pad("Float32", 12), pad("Float64"), pad("|Float32 - Float64|"))
    start = 0.01
    p_f32 = Float32(start)
    p_f64 = Float64(start)
    for i in 0:40
        @printf("%s %s %s %s\n", pad(i,2), pad(p_f32, 12), pad(p_f64), pad(abs(p_f32 - p_f64)))
        p_f32 = p_next(p_f32, Float32(3))
        p_f64 = p_next(p_f64, Float64(3))
    end
end

main()