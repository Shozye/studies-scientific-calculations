# Mateusz Pełechaty, indeks: 261737

include("utils.jl")
using Printf

function pad(x, size=23)
    return lpad(x, size, ' ')
end

input_data = [[-2,1], 
                [-2,2],
                [-2,1.99999999999999],
                [-1,1],
                [-1,-1],
                [-1,0.75],
                [-1,0.25]]

function generate_sequence(x, n)
    (c, x_0) = input_data[x]
    output = []
    for i in 0:n
        push!(output, x_0)
        x_0 = x_next(x_0, c)
    end
    return output
end

function main()
    max_n = 40
    pads = [5,5,23,5,5,23,23]    
    @printf("%s %s %s %s %s %s %s %s\n", pad("ID", 2), [pad(i, pads[i]) for i in 1:7]...)
    data = [generate_sequence(i, max_n) for i in 1:7]
    for i in 0:max_n
        @printf("%s %s %s %s %s %s %s %s\n", pad(i, 2), [pad(data[seq_i][i+1], pads[seq_i]) for seq_i in 1:7]...)
    end
end

main()