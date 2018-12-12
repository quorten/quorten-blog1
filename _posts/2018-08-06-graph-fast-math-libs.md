---
layout: post
title: "Rational integers, fixed point, fast graphics numerical
        techniques, Allegro library still doing well"
author: quorten
date: 2018-08-06 20:20 -0500
categories: [media-prog]
tags: [media-prog]
---

Looking for a good rational integer arithmetic library in C to build
off of?  Look here for a really simple implementation.  Sure,
Wikipedia is recommending much more complicated implementations, as
typical.

20180806/DuckDuckGo rational arithmetic library c  
20180806/http://www.spiration.co.uk/post/1400/fractions%20in%20c%20-%20a%20rational%20arithmetic%20library  
20180806/https://en.wikipedia.org/wiki/Rational_data_type

As unfortunate as it is from a practical standpoint, fixed-point
arithmetic libraries have a huge rift between fixed-point arithmetic
libraries and rational arithmetic libraries.  For sure, there is a lot
more software development activity in fixed-point arithmetic than in
rational integer arithmetic, and much less in combined
rational-fixed-point libraries.

20180806/https://en.wikipedia.org/wiki/Fixed-point_arithmetic  
20180806/https://en.wikipedia.org/wiki/Libfixmath

And as it turns out, there is a nice fixed-point graphics library
written against Libfixmath, FGL.  Also, don't forget!  The Allegro
library also has fixed-point arithmetic routines.

Popular numeric libraries in increasing order of complexity:

1. Integer arithmetic
2. Quotient-remainder functions
3. Fixed-point arithmetic
4. Floating-point arithmetic
5. Rational integer arithmetic

Although rational integer arithmetic is easier to setup conceptually,
I classified it as more complex as it can involve integer
factorization algorithms, themself very complex.  This is by far the
good thing about floating point, that it restricts the denominator to
an integer power of a integer base number.

So the verdict?  What kinds of library functions would be most useful
to see in a general arithmetic library?  Fixed-point and
floating-point routines are well covered by existing code.  Given the
previous discussion, the main thing I would want to add is
quotient-remainder functions.  Especially, step-increments involving a
quotient-remainder.

<!-- more -->

Note that rather than multiplying two rational numbers together for
step-wise functions, you can instead step on each rational number
individually to determine when to increment.  Matter of fact, multiple
quotient-remainder step incrementing is used directly in Bressenham's
line plotting algorithm to avoid needing to divide to compute the
slope, with a particular simplification that is possible since the
stepping is only happening across two variables.

Indeed, on the Wikipedia page, this is well covered, relating to the
similarity of other algorithms where the same concept is used.
Verdict: Of course we need a shared library function for this!

20180811/https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm  
20180811/https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm#Similar_algorithms  
20180811/https://en.wikipedia.org/wiki/Digital_differential_analyzer_%28graphics_algorithm%29

The name of the quotient-remainder game?  Incremental error algorithm.
So if you want to make sure you are using industry standard terms, use
these.

As far as conceptual implementation goes, rational integers are a good
unifying concept, but practical implementations will generally
restrict such numbers to be realized either as fixed-point,
floating-point, or quotient-remainder stepping.  If factorization on
rational numbers is to be allowed, the denominator should be
restricted in size to a relatively small integer.

That being said, that's also your answer as to why there aren't many C
libraries that implement rational integer arithmetic.  It's just too
complicated to be practical for most performance-critical
applications, i.e. the applications most frequently written in the C
programming language.

20180811/https://en.wikipedia.org/wiki/Integer_factorization
