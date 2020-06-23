---
layout: post
title: Explaining power series on polynomials
date: 2020-06-22 14:29 -0500
author: quorten
categories: [media-prog, unlipic]
tags: [media-prog, unlipic]
---

Why does it not make sense to use a power series to evaluate a
polynomial?  Here I copy my explanation that I started writing
elsewhere but edited out because this should be obvious to the
mathematically inclined.

The power rule is the principle means of differentiation on
polynomials, but can we compute this in parallel?  Let's see if we can
reformulate this.

```
f(x) = c*x^y
f'(x) = c*y*x^(y - 1)
f''(x) = c*y*(y - 1)*x^(y - 2)
f^(n)(x) = c * P(y, n) * x^(y - n)
P(n, r) = n! / (n - r)!
```

So, here's the trick with power series on polynomials.  Permutations
can be computed in parallel by virtue of computing factorials in
parallel.  Ideally, we can leverage our need to compute a factorial
sequence in parallel to generate a factorial lookup table and simply
use that when computing permutations.  But, why are you computing a
power series to approximate a polynomial when you can just evaluate
the polynomial directly?  Look at what happens in the big picture of
the overall equation!

<!-- more -->

```
sum_{n = 0}^oo f^(n)(a) * (x - a)^n / n!
= sum_{n = 0}^oo c * P(y, n) * a^(y - n) * (x - a)^n / n!
= sum_{n = 0}^oo c * y! / (y - n)! * a^(y - n) * (x - a)^n / n!
= sum_{n = 0}^oo c * y! / (n! * (y - n)!) * a^(y - n) * (x - a)^n
= sum_{n = 0}^oo c * C(y, n) * a^(y - n) * (x - a)^n
```

Now... to fully understnad this, also review what happens when you try
to compute a power series on a term of a polynomial, centered at zero.
Maclaurin series, in other words.

```
f(x) = x^3
f(2) = 8
f'(x) = 3*x^2
f''(x) = 6*x
f'''(x) = 6
f''''(x) = 0
f(0) = 0
f'(0) = 0
f''(0) = 0
f'''(0) = 6
f''''(0) = 0
6 * (2 - 0)^3 / 3! = 6 * 8 / 6 = 8
```

The term is only non-zero when the derivative is equal to the degree
of the term.  The value of the term is then `P(n, n) = n! / (n - n)! =
n!`.  So if we only consider that special term of the power series
expansion, this is what we get.

```
c * n! * a^(y - n) * (x - a)^n / n!
= c * a^(y - n) * (x - a)^n
= c * (x - a)^n
= c * x^n
```

The factorials cancel out!  Centered at zero, it is exactly the same
as evaluating a single term.
