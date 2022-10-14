# Mateusz Pełechaty, indeks: 261737

include("utils.jl")
using Plots

function generate_sequence(x_0, c, max_n)
    seq = []
    for i in 0:max_n
        push!(seq, x_0)
        x_0 = x_next(x_0, c)
    end
    return seq
end

function main()
    amount_iterations = 40
    c = -2
    linewidth=2
    titlefontsize=11
    x_0 = 1.6

    xs = collect(0:amount_iterations)
    plot_data = generate_sequence(x_0, c, amount_iterations)
    p = plot(xs, 
            plot_data,
            title="Graphic representation of xₙ₊₁ = xₙ² - $(abs(c)) for x₀=$x_0",
            xguide="n - iteration",
            yguide="xₙ",
            label=nothing,
            linewidth=linewidth,
            titlefontsize=titlefontsize)
    savefig(p, "plot.png")
end

main()