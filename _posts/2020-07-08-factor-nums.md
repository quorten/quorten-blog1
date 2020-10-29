---
layout: post
title: "Efficient ways to factor numbers"
date: 2020-07-08 21:00 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

What's an efficient way to factor numbers?  Wheel factorization is the
name of the game.  But first, let's try this idea of simply dividing
by a composite number of the first few primes.

```
2 * 3 * 5 * 7 = 210
43728 % 210 = 48
```

Okay, once you get the remainder, you can check which factors are in
the remainder, via a lookup table.  Then you can divide those out.

```
48 % 2 = 0
48 % 3 = 0
48 % 5 = 3
48 % 7 = 6
```

So we can divide out 2 and 3.

```
48 / 2 / 3 = 48 / 6 = 8
```

<!-- more -->

And then we see a power of two straight away, so factoring is easy.

```
48 = 2 * 2 * 2 * 2 * 3
```

So since we've factored that nicely, now let's divide the source
number by it.

```
43728 / 48 = 911
```

And then we can try again to break this down further.

```
911 % 210 = 71
```

And that looks pretty prime to me, a lookup table may agree.
We don't know for sure since we didn't test every single prime
less than the number but for most practical applications this
is close enough.  So, the final result.

```
43728 = 2 * 2 * 2 * 2 * 3 * 911
```

The slowest, worst case method to factor a number.

First, generate a list of primes less than or equal to the number to
be factored.  Then, try to divide the number by qeach factor as many
times as possible.  You will generate your list of factors.  In the
event you generate the last entry and determine the number itself is
in fact a prime, then you just return it itself.

Remember, the trick when generating a list of primes, keep a multiple
list, rather than using trial division and incrementing.  Rather than
needing to divide by an increasing number of factors, you simply need
to add an increasing number of factors.

Can you do binning here?  For example, count by 2 and 3.

```
 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
    2     4     6     8    10    12    14    16    18    20    22    24
       3        6        9       12       15       18       21       24
```

What advantage would that bring?  You'd' start by folding into
multiples of 6.  But then you still have to test factors of 6, and how
do you determine that?

My bigger point was this... there is a limit to the largest composite
number you need to test for factorization.  Once that limit is
reached, your list is finite-sized until the end of the numeric space.
The smallest such factor is naturally 2, any larger factors in
composite numbers will just throw you outside of the numeric range.

So actually, to test if a number is prime, you only need to sieve up
to half its value, and if there are no factors less than that value,
it must be prime.  You can't have a product of huge numbers that is
not itself a huge number.

Or... let's go even further.  If you always test the first few primes,
you will always be able to do preliminary simplifications.  So, ask
yourself.  For this to be a composite number, I have to multiply at
least two primes.  If I multiplied the largest last prime that failed
and the potential next prime, would that throw me outside the range of
the number?

This is the invariant.  To factor number `a`, we've tested both primes
and composites less than or equal to `n` and verified that none of
them are evenly divisible.  So, we're moving up to testing if larger
numbers will divide evenly.  But, by definition, if one does, past the
point of the square root, the other factor has to be smaller than the
square root, which lands right in the zone of numbers already tested
and found not to be divisible.  So you actually only need to do trial
division up to the square root of a number, and as far as we are
concerned, an approximate square root with round up is plenty good for
this.

```
0b1000000 = 64
0b1000 = 8
0b10000000 = 128
0b1000 = 8
actual ~= 11
0b11111111 = 255
0b1111 = 15
actual ~= 16
```

I should have realized this.  Sure, this might not give you strict
truncation under-estimate behavior, but if you shift the original
number and keep the most significant bits, that can give you a
potentially better approximation of the square root.

This is really great because it means, at the outset, you have
exponentially less factors you need to test, in the worst case.

Okay, so what about if you do find some composites?  Well then with
the remainder, you calculate the approximate square root of that and
round up, that is how many potentially prime factors you need to test
on that.  Alternatively, to avoid computing square roots, you can
compute the running total composite number.  Then, subtract?

The key to remember, though, if we've already found factors, to their
highest power, we never need to test those numbers again.  So we
pretty quickly realize that the divided number that remains is prime.

So the same invariant is used.  We've already tested all factors less
than `n`, so if the number that remains is less than `n`, there is
nothing left we need to do.  It's definitely a prime.  If it's less
than the running factor envelope... but what about between that and
the square root envelope?  Yeah, that's another problem... the thing
about dividing by big numbers, you always get a small number as a
result.  So we also have the converse.  Really, it's take the square
root of what remains, we only need to test factors up to that
threshold.  But we've already tested a nominal number of factors and
totally divided them out, what remains to be tested beyond that up to
the threshold?

Parallel computing questions.  At what point do we need to divide out
our factors to get the remaining composite?  Really, it's up to you.
As it turns out, the main reason for doing so is to determine the
early exit criteria.

Also note that rather than computing the square root, you can square
the envelope for comparison, of course.

Actually... if you want to determine this without dividing.  Yes, you
can use a modified variant of the "Babylonian" method of square root
finding related to the running total of factors.  Multiply them all
together, then square the result.

```
composites <= envelope
composites * remainder = source
exit if sqrt(remainder) < envelope
exit if remainder < envelope^2
remainer = source / composites
```

How do composites and remainder compare?
```
composites = remainder if composities^2 = source
composites < remainder if composities^2 < source
composites > remainder if composities^2 > source
```

Without knowing what the remainder is exactly, we can determine the
relative magnitude by that comparison.  And based off of that estimate
of the relative magnitude, we can do the envelope comparison.  At the
very least, if `composites < remainder`, and we know it is too big for
the exit condition to be satisfied, we definitely know that remainder
is also too big for the exit condition to be satisfied.

Alternatively, the trick is here... we subtract and do approximate
square roots, and then add to get an approximate remainder from
composite using the quadratic formula, approximate square root of
course.

```
(a - r)^2 = c^2
a^2 - 2*a*r + r^2 = c^2
a^2 - 2*a*r = c^2 - r^2
```

Oh, and, now that I've mentioned it, that's how we get an approximate
quotient without having to actually divide.  And, you you're not
constrained to only being able to optimize division by a constant.

But, the point being, that we can factor any 32-bit integer with only
two 64K tables for the worst case, that says a lot.  But 64-bit, that
requires 4G tables... that really isn't much memory by modern measures
for a full application, but if this is just to be a subroutine in a
bigger application, it's probably too much.  GPU parallel compute can
also really speed up integer factorization.
