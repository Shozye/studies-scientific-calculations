# Mateusz Pełechaty, indeks: 261737

function f(x)
    return sin(x) + cos(3x)
end

function derivative_f(x)
    return cos(x) - 3sin(3x)
end

function approx_derivative_f(x, h)
    return (f(x + h) - f(x)) / h
end

function abs_error(a, b)
    return abs(a-b)
end

function pad(x)
    return lpad(x, 23, ' ')
end

function make_tests(x, max_n)
    println("Testy wykonane dla x=", x)
    println("f'(x) = ", derivative_f(x))
    println(lpad("n", 2, " "), ", ", pad("approximate derivative"), ", ", pad("error"), "", pad("1+h"))
    for n in 0:max_n
        h = 2.0^(-n)
        derivative = derivative_f(x)
        approx = approx_derivative_f(x, h)
        err = abs_error(derivative, approx)
        println(lpad(n, 2, ' '), ", ", pad(approx), ", ", pad(err), pad(1+h))
    end
end

make_tests(1, 54)

