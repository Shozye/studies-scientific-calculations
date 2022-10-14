# Mateusz Pełechaty, indeks: 261737

function f(x)
    return sqrt(x^2 + 1) - 1
end

function g(x)
    return x^2 / (sqrt(x^2 + 1) + 1)
end

x = 1
for i in 1:20
    global x
    x /= 8
    println("x=8^-", i, " f(x)=", f(x), ", g(x)=", g(x))
end