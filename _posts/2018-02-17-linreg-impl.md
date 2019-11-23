---
layout: post
title: Linear regression algorithm implementation
date: 2018-02-17 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

So, to discuss the implementation of the linear regression algorithm
in more detail.  What algorithms will be used?  Which libraries will I
pick that implement my desired algorithm?  Will I end up writing my
own algorithm?

So, to answer these questions, we need to discuss the math in more
detail so we know what we need and what we don't need.

As discussed earlier, 16-bit linear unsigned integers will be used for
light intensity data.  The only other variable that needs to be
correlated is time index or angle index.  That, as I've just hinted,
needs only an integer, not a floating point number.  As it turns out,
this means that the linear regression computation needs only integer
arithmetic.  Additionally, it turns out that there are more accurate
and efficient methods for computing the row-reduced echelon solution
of an integer matrix, namely the Bareiss algorithm.  Gaussian
elimination generally only works on floating point matrices.

Unfortunately, as it turns out, BLAS and LAPACK, the math libraries I
was planning on using, do not have integer arithmetic methods, only
floating point.  Thus, I have to consider different libraries.  IML --
Integer Matrix Library, may be one choice, but it looks like that may
actually use floating point under the covers because it depends on
BLAS.  Another option may be fflas-fpack, designed specifically for
computing on finite fields (i.e. machine integers), but I think we are
getting ahead of ourselves here.

<!-- more -->

As a matter of fact, I've played around in GNU Octave to compute
quadratic regressions and it worked quite well.  Upon a closer
examination of the source code, the method used is Gaussian
elimination with partial pivoting.

* Finally, let's think about the common sources of error in a typical
  3D scan.  It appears that the samples for the Gaussian elimination
  will almost always be well-conditioned, which means that the main
  source of error I'll be seeing will be from the 3D scanning process
  itself, not from the algorithms I use to collect the data.

Furthermore, the actual regression computation itself.  There are two
methods.

1. ```
   A = matrix of x-variable values (1, x, x^2, etc)
   b = column vector of y-variable values

   A^T * A * x = A^T * b
   ```

2. ```
   A = matrix of x-variable values (1, x, x^2, etc)
   b = column vector of y-variable values

   A = QR = QR factorization of A
   ```

* That is, Q = orthonormal basis of column space of A and R = m x n
  matrix to match A.  R = Q^T * A.

Calculation:

```
R * x = Q^T * b
```

The second, QR factorization method is preferred to the first method
because the matrix A could be ill-conditioned such that small numbers
are multiplied in intermediate steps and result in loss of precision.
However, the second method requires more computation than the first
method.

Again, as it turns out from practical use, I've been using the first
method just fine a few times in GNU Octave.  Also, when you think
about this in detail, the described loss of precision can only happen
when multiplying floating point numbers.  Integers will not loose
precision unless there is overflow, and it turns out that because one
matrix multiplication results in at most one integer multiplication,
simply provisioning for double-width resulting integers practically
eliminates the risk of overflow.  The only remaining integer overflow
would result from carry bits from multiple additions.

Because of our citation on practical limits on phase shift
profilometry, we can assume a maximum of 25 addition steps in our
intermediate matrix.  This corresponds to a maximum of 5 overflow
bits, because each addition can overflow by a single bit.  We can
compensate for this by using quadruple-width integers for the final
addition accumulation in the destination matrix.  This is perfectly
acceptable because we will only be working with a 3 x 3 matrix at this
final step.

* In the case of limiting the samples to 10, overflow is limited to 4
  bits.

Now that we've required 40-bit integers, it makes rational sense to do
the final Gaussian elimination using double-precision floating point
arithmetic.  Again, we are using floating point simply because we want
to get some algorithm working quickly in our working software
implementation.  Our goal in this scanner design is to save the
original scan data as faithfully as possible so that we can play
around with different processing algorithms at a later date.

Oh, wait, let's not get ahead of ourselves.  What is the final output
precision?  Because we are looking for a "angle index" with possibly
just a little bit more precision, this will be 16-bit.  Suppose we
have 35 degree max field of view.  This gives us angular precision up
to 35 / 65536 = 0.0005341 degrees.  Or, in other words, a max image
resolution of 65536 pixels.  Is that good enough?  For sure it is when
we allow for fixed point integers... well, a group of "floating point
integers," but all with the same decimal position.

That being said, converting to single-precision floating point for the
final row reduction is also adequate.  Another option is to discard
the 5 least significant bits before doing the addition accumulate in
the matrix multiply and accumulating to still 32-bit integers.  Okay,
actually I like that method the best.  Remember, we're still going to
drop down to 16-bit, so even if we uniformly throw away the five least
significant bits before accumulating, this still results in good
precision.  The alternative, shifting by one bit just before we
overflow by one bit, requires more complicated, and hence slower,
looping constructs.

Okay, another question.  Do we need block matrix multiplication?  No.
With a maximum of 25 columns and 3 rows, that amounts to hardly 150
bytes with 2-byte (16-bit) integers.  For sure there is no problem
fitting that in the cache.

----------

I've done quite a bit of Internet research to get to the conclusions
that I've documented above.  These are all my sources.

20180217/http://www.netlib.org/blas/  
20180217/http://www.netlib.org/lapack/  
20180217/https://en.wikipedia.org/wiki/Basic_Linear_Algebra_Subprograms  
20180217/https://en.wikipedia.org/wiki/Bareiss_algorithm  
20180217/DuckDuckGo Bareiss algorithm c source code

Interesting, Ruby Core uses the Bareiss algorithm for computing
determinants.

20180217/https://bugs.ruby-lang.org/issues/2772

Important!  Useful sources for implementing my own Bareiss algorithm,
for lack of finding a readymade modern library.

20180217/https://math.stackexchange.com/questions/663391/bareiss-algorithm

The original 1967 paper.  Note that partial pivoting **is** required for
good results.

20180218/http://www.ams.org/journals/mcom/1968-22-103/S0025-5718-1968-0226829-0/S0025-5718-1968-0226829-0.pdf

A useful source describing the workaround to avoid division by zero.

20180219/http://www.math.usm.edu/perry/Research/Thesis_DRL.pdf

Source code that only implements the method for computing
determinants.

20180217/https://cs.nyu.edu/exact/core/download/core_v1.4/core_v1.4/progs/bareiss/bareiss.cpp  
20180218/DuckDuckGo linear algebra integer arithmetic library  
20180218/https://cs.uwaterloo.ca/~astorjoh/p92-chen.pdf  
20180218/DuckDuckGo integer matrix library  
20180218/https://cs.uwaterloo.ca/~astorjoh/iml.html  
20180218/http://linbox-team.github.io/fflas-ffpack/

Finite fields, they're almost the same as your understanding of
machine arithmetic.

20180218/https://en.wikipedia.org/wiki/Finite_field  
20180218/https://en.wikipedia.org/wiki/Finite_field_arithmetic

There is in fact no CBLAS/CLAPACK except for one automatically
translated via `f2c`.

20180218/DuckDuckGo CLAPACK  
20180218/https://people.sc.fsu.edu/~jburkardt/c_src/aclapack/clapack.html
