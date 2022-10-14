# Mateusz Pełechaty, indeks: 261737

include("utils.jl")
using Plots

function step!(plot_data, c)
    for i in 1:length(plot_data)
        plot_data[i] = x_next(plot_data[i], c)
    end
end

function get_title(c, pointamount, n)
    return "Graphic representation of xₙ₊₁ = xₙ² - $(abs(c)) for $pointamount points, n=$n" 
end

function get_yguide(n)
    return "x_$n"
end

function main()
    frames_amount = 41
    pointamountperunit = 100
    c = -3
    xlims = (-1,2)
    pointamount = (xlims[2] - xlims[1])*pointamountperunit + 1
    ylims = (c-0.1, 9)
    linewidth=2
    titlefontsize=11

    xs = LinRange(-1, 2, pointamount)
    plot_data = [xs;]

    anim = @animate for i ∈ 0:frames_amount-1
        plot(xs, 
            plot_data, 
            xlims=xlims, 
            ylims=ylims, 
            linewidth=linewidth, 
            label=nothing, 
            title=get_title(c,pointamount,i), 
            titlefontsize=titlefontsize,
            xguide="x_0",
            yguide=get_yguide(i))
        step!(plot_data, c)
    end 
    gif(anim, "anim.gif", fps = 2)
end

main()