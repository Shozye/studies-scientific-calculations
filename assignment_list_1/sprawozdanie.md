# Lista 1. Sprawozdanie | Mateusz Pełechaty 261737

## Zadanie 1

### 1.1 Macheps
Cel: Wyznaczenie Machine Epsilona kodem, Porownanie wartości z funkcją eps i Float.h
Rozwiązanie: `find_macheps.jl`, `epsilons.c`  
Wyniki:
Według moich wyników uzyskanych z plikow `find_macheps.jl` oraz `epsilons.c` wynika następująca tabela
eta

Według [dokumentacji](https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/#Machine-epsilon) Julii, funkcja eps wyznacza machine epsilon.
Wedlug [wikipedii](https://en.wikipedia.org/wiki/Machine_epsilon) macheps jest wyliczany poprawnie i jest to macheps `widespread definition`. 
Wnioski: macheps wyznaczony z `eps` oraz z mojego sposobu jest `widespread definition` macheps  
Formal definition jest $\frac{eps}{2}$ czyli maximum error
### 1.2 Eta
Wedlug uzyskanych wynikow za pomocą pliku `find_eta.jl` i informacji na temat $MIN_{sub}$ wzietych z `W. Kahan` wynika:
|         | eta ($\eta$)      | nextfloat | $MIN_{sub}$    |
|---------|----------|-----------|----------------|
| Float16 | 6.0e-8   | 6.0e-8    | -----          |
| Float32 | 1.0e-45  | 1.0e-45   | 1.4 e-45       |
| Float64 | 5.0e-324 | 5.0e-324  | 4.9 e-324      |  

Z wiedzy czym są `denormal numbers` lub `subnormal numbers` mozemy latwo sie domyslić, że
$bitstring(eta(floatX)) = concat((X-1)*"0", "1")$ co można sprawdzic w kodzie.  
Wnioski: Eta jest rzędu wartości $MIN_{sub}$ ale z moich wyliczen i wiedzy na jej temat nie wiem dlaczego `W. Kahan` ma inne wartości.

### 1.3 Jaki związek ma liczba `macheps` z `precyzją arytmetyki` (oznaczaną na wykładzie przez $\epsilon$)?
`Precyzja arytmetyki` to dokładność reprezentowania liczby przez komputery. 
Dla liczby zmiennoprzecinkowej $x$, ktorą chcemy przedstawić jako liczba w systemie zmiennoprzecinkowym $rd_v(x)$ 
Wtedy precyzja jest ograniczeniem górnym błędu względnego reprezentacji czyli:
$|\frac{rd_v(x) - x}{x}| \leq \frac{1}{2^{t+1}} = \epsilon $, gdzie t to liczba bitów `significand`  
`Machine epsilon` z kolei to jest najmniejsza możliwa liczba większa od 1.  
Błąd względny dla liczby $ 1+x $ gdzie $ x = \frac{macheps}{2}$ wynosi $ \frac{1+x - 1}{1+x} = \frac{x}{1+x} $  
Z mojej perspektywy $ \epsilon = \frac{x}{1+x} $

### 1.4 Jaki związek ma liczba `eta` z liczbą $MIN_{sub}$
$MIN_{sub}$ to najmniejsza `subnormalna` liczba.  
Subnormalna liczba to taka, która ma eksponent równy 0. Wtedy uznajemy że mantysa nie jest napisana w formie  
$ 1 + mantissa $ tylko raczej w formie $ 0 + mantissa $, a bias eksponentu wynosi 126 zamiast 127.  
Z mojej perspektywy zatem $ \eta = MIN_{sub} $.   
Jednakże z jakiegoś powodu tak nie jest. i są różnice w przyblizeniach.

### 1.5 Co zwracaja funkcje floatmin i jaki jest zwiazek z liczbą $MIN_{nor}$
Floatmin zwraca minimalną liczbę typu `float`, która posiada niezerową `significand`. 
Matematycznie robi to to samo co $MIN_{nor}$
|         | floatmin                | $MIN_{nor}$   |
|---------|-------------------------|---------------|
| Float16 | 6.104e-5                | -----         |
| Float32 | 1.1754944e-38           | 1.2E-38       |
| Float64 | 2.2250738585072014e-308 | 2.2E-308      |
  
Możemy to potwierdzić sprawdzając bitstringi floatmin.

Przykładowo:  
$bitstring(floatmin(Float16)) = 0000010000000000$

## Zadanie 2

### 2.1 Sprawdź szluszność twierdzenia: macheps = 3 (4/3 - 1) - 1

Rozwiązanie znajduje się w pliku `calculate_macheps.jl`

Wyniki:
|         | Macheps               | KahanMacheps           |
|---------|-----------------------|------------------------|
| Float16 | 0.000977              | -0.000977              |
| Float32 | 1.1920929e-7          | 1.1920929e-7           |
| Float64 | 2.220446049250313e-16 | -2.220446049250313e-16 |

Wnioski: Macheps Kahana faktycznie jest równy machepsowi z dokladnoscia do znaku

## Zadanie 3
We float64 posiadamy 52 bity mantysy nie licząc jedynki z przodu. Jako że reprezentacja liczby to
$ x = 2 ^ c * (1 + f) $ to tylko dla $ c = 0 $ możemy otrzymać liczbę pomiędzy $ x \in [1, 2) $
A liczby te nalezace do $[1, 2)$ to różnią się mantysą.  
Eksperyment znajdujący się w pliku `experiment.jl`:
1. Wylosuj liczbę z przedzialu $[1,2)$
2. Weź jej nextfloata
3. Sprawdz ich bitstringi
Wyniki:
```bash
shozy@base:~/Desktop/repos/scientific-calculations/lista1/zad3$ julia experiment.jl 
Random number: 1.434651593333003 type:Float64
Num1: 1.434651593333003, bitstring: 0011111111110110111101000101010100111010101010000101000000001001
Num1: 1.4346515933330033, bitstring: 0011111111110110111101000101010100111010101010000101000000001010
```
```bash
shozy@base:~/Desktop/repos/scientific-calculations/lista1/zad3$ julia experiment.jl 
Random number: 1.5328675227283726 type:Float64
Num1: 1.5328675227283726, bitstring: 0011111111111000100001101010000000011000011100111000000010011010
Num1: 1.5328675227283728, bitstring: 0011111111111000100001101010000000011000011100111000000010011011
```
Jak widzimy róznica znajduje sie tylko w bitach mantysy i $nextMantysa_{10} - Mantysa_{10} = 1$

## Zadanie 4
### 4.a) Napisz w języku Julia program znajdujący liczbę 1 < x < 2, taką że x * 1/x != 1

Do zrobienia zadania użyłem pliku `taskA.jl`, w którym znajduje taką liczbę poprzez losowanie liczby i sprawdzanie na niej warunku z zadania.  
Przykładowy output:
```bash
Znaleziona liczba: 1.5694265039174653
Bitstring: 0011111111111001000111000101111011110111001111001101000101101101
Średnio potrzeba 6.4841 sprawdzeń. n=10000
```
Wnioski:  
Rozmieszczenie liczb ktore spelniaja takie warunki jest calkiem gęste. To pozwala na niematematyczne podejscie do znajdowania najmniejszej takiej liczby.

### 4.b) Znajdź najmniejszą liczbę 1< x < 2 taką że x * 1/x != 1
Postanawiam skorzystac z funkcji `nextfloat` i po prostu pokolei od 1 szukać liczby która spełnai ten warunek
Pseudokod:
```
x = 1
while true
    if f(x) != 1
        return x
    end
    x = nextfloat(x)
end
```
Wynik:
```bash
shozy@base:~/Desktop/repos/scientific-calculations/lista1/zad4$ julia taskB.jl 
Po uzyciu nextfloat 257736490 razy otrzymałem liczbę 
1.000000057228997, bitstring: 0011111111110000000000000000000000001111010111001011111100101010
```
## Zadanie 5
Cel: Mając podane dwa wektory, policz ich iloczyn skalarny na 4 sposoby. Sposoby różnią się w zależności od kolejności sumowania
#### 5.1 Sumuj w przód - z lewa na prawo
#### 5.2 Sumuj w tył - z prawo na lewo
#### 5.3 Sumuj dwie sumy częściowe. Jedna to suma posortowanego malejąco dodatnich, druga to posortowanego rosnąco ujemnych
#### 5.4 Sumuj dwie sumy częściowe. Jedna to suma posortowanego rosnąco dodatnich, druga to posortowanego malejąco ujemnych
Rozwiązanie znajduje się w pliku `solution.jl`, a funkcje w nim użyte sa z pliku `functions.jl`
Program daje nastepujacy wynik:
```bash
Testing Float32
Real value:  1.0065710699999998e-11
Front        -0.4999443 Error: 4.96680576632828e12%
Back         -0.4543457 Error: 4.51379655820096e12%
Big to small -0.5 Error: 4.96735913550611e12%
Small to big -0.5 Error: 4.96735913550611e12%
###==================================================###
Testing Float64
Real value:  1.0065710699999998e-11
Front        1.0251881368296672e-10 Error: 918.5%
Back         -1.5643308870494366e-10 Error: 1654.12%
Big to small 0.0 Error: 100.0%
Small to big 0.0 Error: 100.0%
###==================================================###
```
Wyniki są przedstawiane w postaci:  
Rodzaj sumowania, wynik, błąd względny  
Wnioski:  
Zdecydowanie nie można ufać komputerowi przy małych liczbach. Najblizej osiagniecia wyniku bylo zwykle dodawanie liczb z lewej do prawej.  
Najgorzej wynikło dodawanie od tyłu, ponieważ wynik wyszedł ujemny

## Zadanie 6
Cel: Policz wyniki funkcji f i g dla argumentów $ x = 8^{-1} , 8^{-2}, 8^{-3}, ...$. Sprawdź wyniki i porównaj. W teorii $f = g$

$ f(x) = \sqrt{x^2 + 1} - 1$, $ g(x) = \frac{x^2}{\sqrt{x^2 + 1} + 1}$  

Rozwiązanie znajduje się w pliku `tests.jl`  
Wyniki:
```bash
x=8^-1 f(x)=0.0077822185373186414, g(x)=0.0077822185373187065
x=8^-2 f(x)=0.00012206286282867573, g(x)=0.00012206286282875901
x=8^-3 f(x)=1.9073468138230965e-6, g(x)=1.907346813826566e-6
x=8^-4 f(x)=2.9802321943606103e-8, g(x)=2.9802321943606116e-8
x=8^-5 f(x)=4.656612873077393e-10, g(x)=4.6566128719931904e-10
x=8^-6 f(x)=7.275957614183426e-12, g(x)=7.275957614156956e-12
x=8^-7 f(x)=1.1368683772161603e-13, g(x)=1.1368683772160957e-13
x=8^-8 f(x)=1.7763568394002505e-15, g(x)=1.7763568394002489e-15
x=8^-9 f(x)=0.0, g(x)=2.7755575615628914e-17
x=8^-10 f(x)=0.0, g(x)=4.336808689942018e-19
x=8^-11 f(x)=0.0, g(x)=6.776263578034403e-21
x=8^-12 f(x)=0.0, g(x)=1.0587911840678754e-22
x=8^-13 f(x)=0.0, g(x)=1.6543612251060553e-24
x=8^-14 f(x)=0.0, g(x)=2.5849394142282115e-26
x=8^-15 f(x)=0.0, g(x)=4.0389678347315804e-28
```
Wnioski:  
Możemy zapisać funkcje $f$ i $g$ następująco:  
$f(x) = C(x) - 1$,   
$g(x) = \frac{x^2}{C(x) + 1}$  
Przy czym $C(x) = 1 + \epsilon$ przy czym $\epsilon$ jest mały
Zauważmy, że w $f(x)$ od razu przechodzimy do wyniku poprzez odjęcie 1. Z kolei w $g(x)$ pierw dodajemy jeden przez co $C(x) + 1 \in [2,4)$, przez co tracimy precyzje z $\delta = 2^{-52}$ do gorszej precyzji.
Z tego względu bardziej wiarygodne są wyniki $f(x)$

## Zadanie 7
Cel: Porównaj błędy przybliżenia pochodnej funkcji $f(x) = sin(x) + cos(3x)$ dla przybliżenia danego wzorem $f'(x_0) \approx \overline{f'}(x_0) = \frac{f(x_0 + h) - f(x_0)}{h}$ w punkcie $x_0 = 1$ dla $ h = 2^{-n}$, przy czym $n=1,2,3...,54$

Liczenie $f'(x)$ oraz $\overline{f'}(x)$ wykonuje w pliku `calculations.jl`
Wyniki: 
```bash
Testy wykonane dla x=1
real derivative of f(x) = 0.11694228168853815
 n,  approximate derivative,                   error                    1+h
 0,      2.0179892252685967,      1.9010469435800585                    2.0
 1,      1.8704413979316472,       1.753499116243109                    1.5
 2,      1.1077870952342974,      0.9908448135457593                   1.25
 3,      0.6232412792975817,      0.5062989976090435                  1.125
 4,      0.3704000662035192,       0.253457784514981                 1.0625
 5,     0.24344307439754687,      0.1265007927090087                1.03125
 6,     0.18009756330732785,      0.0631552816187897               1.015625
 7,      0.1484913953710958,     0.03154911368255764              1.0078125
 8,      0.1327091142805159,    0.015766832591977753             1.00390625
 9,      0.1248236929407085,    0.007881411252170345            1.001953125
10,     0.12088247681106168,   0.0039401951225235265           1.0009765625
11,     0.11891225046883847,    0.001969968780300313          1.00048828125
12,     0.11792723373901026,   0.0009849520504721099         1.000244140625
13,     0.11743474961076572,   0.0004924679222275685        1.0001220703125
14,     0.11718851362093119,   0.0002462319323930373       1.00006103515625
15,     0.11706539714577957,  0.00012311545724141837      1.000030517578125
16,     0.11700383928837255,    6.155759983439424e-5     1.0000152587890625
17,     0.11697306045971345,    3.077877117529937e-5     1.0000076293945312
18,     0.11695767106721178,   1.5389378673624776e-5     1.0000038146972656
19,     0.11694997636368498,    7.694675146829866e-6     1.0000019073486328
20,     0.11694612901192158,   3.8473233834324105e-6     1.0000009536743164
21,      0.1169442052487284,   1.9235601902423127e-6     1.0000004768371582
22,     0.11694324295967817,    9.612711400208696e-7      1.000000238418579
23,     0.11694276239722967,    4.807086915192826e-7     1.0000001192092896
24,     0.11694252118468285,    2.394961446938737e-7     1.0000000596046448
25,       0.116942398250103,   1.1656156484463054e-7     1.0000000298023224
26,     0.11694233864545822,   5.6956920069239914e-8     1.0000000149011612
27,     0.11694231629371643,    3.460517827846843e-8     1.0000000074505806
28,     0.11694228649139404,    4.802855890773117e-9     1.0000000037252903
29,     0.11694222688674927,    5.480178888461751e-8     1.0000000018626451
30,     0.11694216728210449,   1.1440643366000813e-7     1.0000000009313226
31,     0.11694216728210449,   1.1440643366000813e-7     1.0000000004656613
32,     0.11694192886352539,   3.5282501276157063e-7     1.0000000002328306
33,     0.11694145202636719,    8.296621709646956e-7     1.0000000001164153
34,     0.11694145202636719,    8.296621709646956e-7     1.0000000000582077
35,     0.11693954467773438,   2.7370108037771956e-6     1.0000000000291038
36,          0.116943359375,   1.0776864618478044e-6      1.000000000014552
37,      0.1169281005859375,   1.4181102600652196e-5      1.000000000007276
38,          0.116943359375,   1.0776864618478044e-6      1.000000000003638
39,        0.11688232421875,   5.9957469788152196e-5      1.000000000001819
40,         0.1168212890625,   0.0001209926260381522     1.0000000000009095
41,          0.116943359375,   1.0776864618478044e-6     1.0000000000004547
42,           0.11669921875,   0.0002430629385381522     1.0000000000002274
43,            0.1162109375,   0.0007313441885381522     1.0000000000001137
44,               0.1171875,   0.0002452183114618478     1.0000000000000568
45,              0.11328125,    0.003661031688538152     1.0000000000000284
46,                0.109375,    0.007567281688538152     1.0000000000000142
47,                0.109375,    0.007567281688538152      1.000000000000007
48,                 0.09375,    0.023192281688538152     1.0000000000000036
49,                   0.125,    0.008057718311461848     1.0000000000000018
50,                     0.0,     0.11694228168853815     1.0000000000000009
51,                     0.0,     0.11694228168853815     1.0000000000000004
52,                    -0.5,      0.6169422816885382     1.0000000000000002
53,                     0.0,     0.11694228168853815                    1.0
54,                     0.0,     0.11694228168853815                    1.0
```
### Pytanie 1. Jak wytłumaczyć, że od pewnego momentu zmniejszanie wartości h nie poprawia przybliżenia wartości pochodnej?
Odpowiedź:  
Zauważmy, że $\frac{f(x_0 + h) - f(x_0)}{h} = \frac{L}{h} = 2^n \cdot L $   
Mnożenie przez $2^n$ to bardzo duże zwiększanie liczby. Stąd wynika, że wraz ze zwiększaniem $n$, $L$ musi maleć. W pewnym momencie brakuje precyzji dla $L$ by było tak niskie. Stąd $L$ = 0 dla pewnej wielkości h, a od pewnego momentu zwyczajnie się pogarsza.
### Pytanie 2. Jak zachowują się wartości 1+h? 
Odpowiedź:
Maleją (?) 
