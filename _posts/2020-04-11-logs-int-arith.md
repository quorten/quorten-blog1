---
layout: post
title: Build a table of logarithms using integer arithmetic
date: 2020-04-11 11:44 -0500
author: quorten
categories: [3d-scanning, 3d-scanner, unlipic, media-prog]
tags: [3d-scanning, 3d-scanner, unlipic, media-prog]
---

Previously I've discussed a number of mathematical tricks with integer
arithmetic and vectors, square roots, and systems and equations.  Next
up is a new challenge: How do you construct a table of logarithms
using only integer arithmetic?

The first thing to master is the algebra of exponents, and logarithms,
of course.  Let's do a brief review here.

```
x^a * x^b = x^(a + b)
x^a^b = x^(a * b)
sqrt(x) = x^(1/2)
sqrt(sqrt(x)) = x^(1/2)^1/2) = x^(1/2*1/2) = x^(1/4)
```

Okay, so that last equation is key.  You might be wondering, "How do I
compute the nth root of a number?"  The answer is right there, in the
rules of exponents.  You can actually do just fine if you only have
the square root operator implemented directly.  Using the rules of
exponents, you can constructively implement any other nth root or
raising any number to a fractional power.

So, with that in place, here's another question.  Suppose you don't
have a table of logarithms, but you want to compute the logarithm of a
number iteratively by multiplying or dividing.  How do you do that?
Remember these rules.

<!-- more -->

```
base = x
exponent = n
result = y
if y >= x, then n >= 1
if 1 < y < x, then 0 < n < 1
if y == 1, then n == 0
if 0 < y < 1, then n < 0
```

Please note that if `y` is less than zero, the result can only be
defined if `n` is odd.  In general, we can ignore cases where `y` is
less than zero and require the input to be negated to be greater than
zero if we must compute with such values and they can be assumed to be
valid.

So now, we have a concerted approach to computing the logarithm of a
number based off of which range bucket it falls in.  If the exponent
is greater than one, we start dividing by the base an integer number
of times to obtain the integer part, until we get down to the
fractional part.  When we're working with the fractional part between
one and the base, we use the square root and exponent rules to
approach the final fractional value.  And when we know the exponent is
negative rather than positive, we multiply rather than divide.

Okay, so the high-level mathematical tools at your disposal now seem
clear for one-off computation cases, but how do we actually work with
these to build a table of logarithms?  What method do we take?

Let's start with the discussion of significant figures.  You might be
tempted to start by stepping through fractional exponents like
`x^(1/65536), x^(2/65536), x^(3/65536), ...`.  But that approach will
not work well because `x^(1/65536)` may just as well be so small that
it is equal to zero.  In that case, with zero significant figures,
multiplying it will achieve nothing.

So, first off, with the size of the base, you should find the largest
power it can be raised to without overflowing, and the smallest root
that can be taken without falling to zero.  The low end defines how
fine-grained your fractional exponents can be computed.  The high end
defines how large an integer exponent you can compute before you have
to divide it (take a root of it) before you can keep going.

Your primary approach is to try to compute fractional exponents while
preserving as many intermediate significant figures as possible.  So,
discussion of significant figures covered, this is the approach.

```
x^1, x^2, x^3, x^4, x^5, x^6, x^7
Now you've reached the high end.  Divide by two to keep going.
x^(8/2), x^(9/2), x^(10/2), x^(11/2), x^(12/2)
```

What does this do?  It's pre-computing some starting point numerators
that you can use with the denominator of your choice, provided that
the denominator you choose is larger than the pre-baked one.  When we
compute larger numerators, in order to keep going, we have to also
increase the denominator, so that's what we do.  Now with those
starting points, you can compute other derived fractions by taking
roots of those ones.  For example:

```
x^(11/16) = sqrt(sqrt(sqrt(x^(11/2)))) = x^(11/2)^(1/8) = x^(11/16)
```

It works just like that.  Now you can use that logic to keep going to
compute more fine-grained fractional exponents, until you reach the
lower limit defined by the minimum fractional exponent that still has
significant figures.  At that point, you stop.

One problem that's apparent here is that the naive method repeats
computations that were already performed.  With some modifications, we
can check if a numerator and denominator combination already matches
an existing one, and if it does, we don't need to compute the actual
value.  Rather, we copy the pre-computed value for use in computing
the next value that logically comes after it in sequence.  For example.

```
x^(8/2) == x^4
So, don't compute x^(8/2), but copy the result of x^4.
Then use that to assist in computing x^(9/2).
```

Here, it is clear that we cannot multiply by x another time, but
instead we would multiply by x^(1/2) another time to get the next
value.  That is clear evidence about the reasoning behind the purpose
of determining the minimum fractional exponent.  When that additional
value is too small to add anything useful, you know you cannot do any
more computations.

When you think about it, you actually can turn this into an iterative
method that sweeps through the integer space of the fraction
numerator, but you have to change the rules of the game somewhat.

```
Determine your constructive base exponents:
1, 1/2, 1/4, 1/8, 1/16
Below 1/16 is insignificant.

Now, define a plan of action to sweep the integer space, adding
together the largest possible fractions with the smallest multipliers.

1/16, 1/8, 1/8 + 1/16, 1/4, 1/4 + 1/16, 1/4 + 1/8, ...

= 1/16, 2/16, 3/16, 4/16, 5/16, 6/16, ...
```

You get the idea.  Basically, what you do is determine the smallest
exponent fraction, then when you sweep the integer space, you want to
reduce the fraction as much as possible, then if you do not correspond
directly to one of your constructive base exponents, you want to
subtract away the largest such fractions possible so you get a sum of
such fractions with ideally no multiplication of each term.

And that's how you do it!  That's how you build up your own table of
logarithms, all the way down.
