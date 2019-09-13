---
layout: post
title: Explaining fast and efficient factorization
date: 2019-09-04 14:02 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

One of the early programs I've written was the _sieve of
Eratosthenes_.  I tried computing prime numbers up to 2010, but it was
terribly slow.  Then, for comparison, I've tested prime numbers using
my TI-89 Titanium graphing calculator's built-in `isprime()` function,
and it was whopping fast!  How?  After some preliminary research, I
came upon the _sieve of Atkin_, which I could see to be understandably
faster due to the use of checking for multiple prime factors with one
divisor of 60.

20190904/https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes  
20190904/https://en.wikipedia.org/wiki/Sieve_of_Atkin

Now, let me try to explain efficient factoring from first principles,
in a very simple manner.  Let's start by discussing even and odd
numbers.  Every other number is an even number, and every even number
is divisible by two.  Therefore, half of all numbers in any number
space are not prime numbers.  Wow, that's great.  50% of the time,
we'll be able to factor 2 out of an arbitrary numbers.  And if we are
doing factorization for fraction reduction, this means we will be able
to reduce fractions at least a good... 25% of the time.  Not great,
but right off the bat, that's a lot better than nothing.

So, let's keep going with larger integer factors.

* every 2nd number is divisible by 2
* every 3rd bnumber is divisible by 3
* every 5th number is divisible by 5
* every 7th number is divisible by 7

<!-- more -->

So now we want to compute what fraction of all numbers are divisible
by any one of these factors.  But don't be fooled.  Some numbers are
divisible by two or more of these factors.  We must be careful not to
double count them.

* every 6th number is divisible by 6
* every 10th number is divisible by 10
* every 15th number is divisible by 15
* every 14th number is divisible by 14
* every 21st number is divisible by 24
* every 35th number is divisible by 35

```
1
2  a
3  b
4  a
5  c
6  a b
7  d
8  a
9  b
10 a c
```

So, how do we know the equation for all numbers?  Any number divisible
by one or more of these factors.  So remember, start with the combined
and subtract those to add in the remainders that are divisible by only
one number.

```
div2 = div6 + div10 + div14 + only_div2
div3 = div6 + div15 + div21 + only_div3
div5 = div10 + div15 + div35 + only_div5
div7 = div14 + div21 + div35 + only_div7

only_div7 = div7 - (div14 + div21 + div35)
only_div5 = div5 - (div10 + div15 + div35)
only_div3 = div3 - (div6 + div15 + div21)
only_div2 = div2 - (div6 + div10 + div14)
```

Now, let's try computing an example for the number of factorable
numbers from 1 to 100.

```
100 / 6 = 16
100 / 10 = 10
100 / 15 = 6
100 / 14 = 7
100 / 21 = 4
100 / 35 = 2

100 / 7 = 14
100 / 5 = 20
100 / 3 = 33
100 / 2 = 50

only_div7 = 14 - (7 + 4 + 2) = 1
only_div5 = 20 - (10 + 6 + 2) = 2
only_div3 = 33 - (16 + 6 + 4) = 7
only_div2 = 50 - (16 + 10 + 7) = 17

1 + 2 + 7 + 17 + 16 + 10 + 6 + 7 + 4 + 2 = 72
```

Okay, so just with these factors, we sieve 72% of the number space.
And the bigger we get, the closer we get to sieving 100% of the number
space with a finite number of factors.  The fastest way to factor is
to start dividing by composites since they consume the majority of the
composite number space.  You can then analyze the remainder to
determine if a number is divisible by only one of the factors, and
which one.

We can maintain counters for each prime number when running our sieve
to determine if it has already been taken.

Well, I guess it's good enough to say you can simplify a fraction in a
reasonable amount of computational time about 52% of the time, and for
all numbers in the 64K integer space.  And a nudge beyond that to
support 60*60*60...  Better than nothing.

The Wikipedia article on the formalization of this described technique
is _wheel factorization_.

20190904/https://en.wikipedia.org/wiki/Wheel_factorization
