In some contest systems, files are used for input and output. An easy solution
for this is to write the code as usual using standard streams, but add the following
lines to the beginning of the code

```c
freopen("input.txt", "r", stdin);
freopen("output.txt", "w", stdout);
```

it is good to know that the g++ compiler also provides a 128-bit type __int128_t


-----------------------

An easy way to make sure there are no negative remainders is to first
calculate the remainder as usual and then add m if the result is negative:

```c
x = x%m;
if (x < 0) x += m;
```

----------------------------

A difficulty when using floating point numbers is that some numbers cannot
be represented accurately as floating point numbers, and there will be rounding
errors.

```c
double x = 0.3*3+0.1;
printf("%.20f\n", x); // 0.99999999999999988898
```


-------------------------------

It is risky to compare floating point numbers with the == operator, because it
is possible that the values should be equal but they are not because of precision
errors. A better way to compare floating point numbers is to assume that two
numbers are equal if the difference between them is less than ε, where ε is a
small number.

In practice, the numbers can be compared as follows (ε = 10−9 ):

```c
if (abs(a-b) < 1e-9) {
// a and b are equal
}
```

----------------------------------------

arithmetic progression

$$
\begin{equation}
\begin{cases}
a_{n+1} = a_{n} + r \\
a_s\ + ... +\ a_n = r. \frac{a_s + b_n}{2} \\
\end{cases}
\end{equation}
$$


geometric progression
$$
\begin{equation}
\begin{cases}
a_{n+1} = a_n * k \\
a_s + a_1 +\ ...\ + a_n = \frac{a_nk-a_s}{k - 1}
\end{cases}
\end{equation}
$$
harmonic sum
$$ \sum_1^n \frac{1}{i} \le log_2(n) + 1 $$

-------------------------------------------------------------------

Set theory

A set S always has $2^{|S|}$ subsets.
$A\setminus B = A \cap \bar{B}$

-------------------------------------------------------------------
Logic

¬ (negation)
∧ (conjunction) and
∨ (disjunction) or
⇒ (implication)
⇔ (equivalence)

A quantifier
∀ (for all) and ∃ (there is)

A predicate is an expression that is true or false depending on its parameters.
- P ( x) that is true exactly when x is a prime number. Using this
definition, P (7) is true but P (8) is false.

-------------------------------------------------------------------
ceil(x)
floor(x)
min(a, b, c, ...)
max(a, b, c, ...)
factorial
Fibonacci numbers

----

A useful property of logarithms is that $log_k(x)$ equals the number of times we have to divide x by k before we reach the number 1.

Another property of logarithms is that the number of digits of an
integer x in base b is $\lfloor{log_b(x)}\rfloor + 1$ . For example, the representation of 123 in base 2 is 1111011 and `floor(log_b(123)) + 1 = 7`.