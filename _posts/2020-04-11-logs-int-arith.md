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
it is equal to one.  In that case, multiplying it will achieve
nothing.

So, first off, with the size of the base, you should find the largest
power it can be raised to without overflowing, and the smallest root
that can be taken without falling to one.  The low end defines how
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

But, hold on.  We're steping backwards on one of the numerical
stability ideals we brought forth earlier.  But, no worries, it's
easier to reason out how to do it with this starting point.  If you've
counted to 4/16, then first you reduce to 1/4.  Now you want to search
for a base number of 1/2 or greater.  When you find that, you take the
square root of it to get your desired result.  If there is no such
base number available, you extend your table by multiplying.

Another subject about numerical stability is when you are computing
exponents with both a whole and a fractional part.  How do you
approach this?  Remember this key.  Multiplying by a large integer is
generally shifting left, multiplying by a fixed point number less than
one is generally shifting right.  If you are shifting right, you
simply need to make sure your fractions are computed with a sufficient
number of extra bits of precision, and with integers, this is simple
to determine: you just need twice as many bits in the worst case.
Then you can just use the decomposition `x^(a + b) = x^a * x^b`.

Okay, another question.  What if you are computing a precise fraction
just below 1.0?  Like `x^(65535/65536)`?  How do you approach this?
There's another trick here you can use.  Rather than multiplying, you
can divide.  Is this numerically stable?  For computing fractional
exponents, yes.  Remember, when `0 < n < 1`, `1 < y < x`.  This means
you're dividing by a number greater than one, so the quotient will be
smaller than the dividend.  Therefore, you will not be multiplying an
uncertainty.  But there is still uncertainty in the divisor, which
results in uncertainty in how much smaller your number gets.  So
anyways, compute it as follows:

```
x^(65535/65536) = x^(1 - 1/65536) = x / x^(1/65536)
```

Okay, that being said, let's take a look at the full sequence in the
case of 1/16.

```
1/1, 1/2, 1/4, 1/8, 1/16

1/16, 2/16, 3/16, 4/16, 5/16, 6/16, 7/16, 8/16, 9/16, 10/16, 11/16,
  12/16, 13/16, 14/16, 15/16, 16/16

Add only:

1/16, 1/8, 1/8 + 1/16, 1/4, 1/4 + 1/16, 1/4 + 1/8, 1/4 + 1/8 + 1/16,
  1/2, 1/2 + 1/16, 1/2 + 1/8, 1/2 + 1/8 + 1/16, 1/2 + 1/4,
  1/2 + 1/4 + 1/16, 1/2 + 1/4 + 1/8, 1/2 + 1/4 + 1/8 + 1/16, 1/1

Subtract only:

1/16, 1/8, 1/4 - 1/16, 1/4, 1/2 - 1/8 - 1/16, 1/2 - 1/8, 1/2 - 1/16,
  1/2, 1/1 - 1/4 - 1/8 - 1/16, 1/1 - 1/4 - 1/8, 1/1 - 1/4 - 1/16,
  1/1 - 1/4, 1/1 - 1/8 - 1/16, 1/1 - 1/8, 1/1 - 1/16, 1/1
```

Okay, so even with subtracting (dividing), there are some areas where
we need to put three four together rather than only two.  So, a method
that uses both add and subtract is more numerically stable than
add-only or subtract-only, simply because we are combining less
components.  However, we will still have to typically combine more
than two components.

```
Add and subtract:

1/16, 1/8, 1/8 + 1/16, 1/4, 1/4 + 1/16, 1/4 + 1/8, 1/2 - 1/16,
  1/2, 1/2 + 1/16, 1/2 + 1/8, 1/2 + 1/8 + 1/16, 1/2 + 1/4,
  1/2 + 1/4 + 1/16, 1/2 + 1/4 + 1/8, 1/1 - 1/16, 1/1
```

But still, the question remains.  How do you efficiently and stably
compute `x^(65535/65536)`?  There are always limits with these kinds
of tough computations, but here's the way to reduce the limits and
sources of error.

Rather than computing directly with the fractions in the target scale,
you compute with fractions in a multiplied scale.  For example, rather
than `1/2 + 1/4`, you compute `1 + 1/2` and divide the result by two.
Immediately, you've eliminated a source of error.  When you compute
with larger fractions, some large fractions will become integers, and
those integer exponents can, of course, be computed without error.
This is especially important if you need to add multiple fractions,
because each addition of a fraction contributes to overall error.
This method allows you to minimize that error, until the end where you
need to take the nth root to get the fractions into the desired scale.

Of course, the problem is, the maximum power you can raise the base to
is limited.  Most bases used with typical tables of logarithms are
less than 16.  When you raise an integer to the nth power, you are
multiplying the number of bits required by n.  So, for 16-bit
integers, typically the maximum power you can raise a base to is 4.
Nevertheless, this does help us reduce our sources of error as we will
show with our example at hand.

```
x^(65535/65536) = x^(1 - 1/65536) = x^1 / x^(1/65536)
(x^1 / x^(1/65536))^4 = x^4 / x^(4/65536)
= x^4 / x^(1/16384)
= x^4 / x^(1/2^14)

x^(65535/65536) = sqrt(sqrt(x^4 / x^(1/16384)))
```

Of course if we use 64 bits of precision, the numbers are even more
favorable.

```
x^16 / x^(1/4096)
= x^16 / x^(1/2^12)
x^(65535/65536) = sqrt(sqrt(sqrt(x^8 / x^(1/4096))))
```

Also, another note when building a table of logarithms, ideally you
want to use division and square root operators that gives you the
closest rounded solution rather than one that strictly underestimates.
Because, it seems like with our computation method in general, keeping
error far away in the deep bits of precision and just truncating at
the end will not be feasible.
