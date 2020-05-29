---
layout: post
title: Another way to compute carry bit in software
date: 2020-05-27 19:51 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

Ah, yes, when working with implementing an arithmetic math API
library, another solution to the problem of computing the carry bit in
software came up.  It's rather easy.

Consider the case of subtraction, `a - b`.  When you want to know what
the "carry" bit is in this case, the purpose is to determine if you
need to "borrow" during subtraction.  Obviously, from some simple
arithmetic analysis, a borrow will be required when `b > a`.  This is
easy to determine since `a - b` is the basis of a `cmp` (compare)
instruction.

* If `a - b == 0`, then `a == b`
* If `a - b > 0`, then `a > b`
* If `a - b < 0`, then `a < b`

If we don't have a means of sign bits on our processor architecture,
we simply first check if the result of the subtraction is equal to
zero.  If not, then we check the sign by checking the value of the
most significant bit, and from there we can determine whether we are
greater than zero (`sign == 0`) or less than zero (`sign == 1`).

So, subtract with borrow.

1. Compute `r = a - b`.
2. Test if `r == 0`.
3. If `r != 0 && sign_bit(r) == 1`, then there is a borrow.

<!-- more -->

Since subtraction is the same for both signed and unsigned integers,
this all works nicely.

So, now what about addition?  That's a little tougher, but a bit of
refactoring does the trick.  For unsigned addition, we want to know if
`a + b > UINT_MAX`.  Rewriting this, a mathematically equivalent
(though not necessarily bit-wise) expression is `a > UINT_MAX - b`.
Now actually, `UINT_MAX - b` is quite easy to determine, it is simply
the same as computing `-b` with two's complement arithmetic.  So now
we have the expression `a > -b`, we can change this into a compare by
rewriting as `a - (-b) > 0`, or `a + b > 0`.  Bit-wise interpretation,
of course!  So the final procedure is quite similar with addition too.

1. Compute `r = a + b`.
2. Test if `r == 0`.
3. If `r != 0 && sign_bit(r) == 0`, then there is a carry.

Now that's a fail... we can't just drop UINT_MAX out of the equations,
this will claim there is a carry on every nonzero positive result.  I
guess for now, we're back to testing sign bits for addition.  But at
least we have a better method for subtraction.

By the way, in the case of addition, if we really don't want to store
the result of the initial sign bits check, we can use code branching
instead.  Yeah, to be honest, that's actually exactly the solution I'm
looking for, I just didn't want to have to store a byte in C code just
for the sake of keeping track of one bit.  Alas, we still have the
problem in C.  If you're creating a function and you want to return
the carry bit, then you still need to pack one bit into a whole byte.
So really, this all comes down to inlining your code whenver you want
to process a 1-bit return value, or maybe even using `goto` with
macros as an alternative.  Yeah, to be honest, I believe the `goto`
macro approach is cleanest.  Here is an example.

```
/* 32-bit `a = b + c`, `if (carry) goto d`.  We also support `a += c`
   notation.  */
#define ADD32(a, b, c, d) \
  if (((b) & 0x80000000) || ((c) & 0x80000000)) { \
    (a) = (b) + (c); \
    if (((a) & 0x80000000) == 0) \
      goto d; /* Carry bit set */ \
  } else { \
    (a) = (b) + (c); \
  }

/* 32-bit `a = b + c + 1`, `if (carry) goto d`.  We also support `a +=
   c` notation.  */
#define ADC32(a, b, c, d) \
  if (((b) & 0x80000000) || ((c) & 0x80000000)) { \
    (a) = (b) + (c) + 1; \
    if (((a) & 0x80000000) != 0) \
      goto d; /* Carry bit set */ \
  } else { \
    (a) = (b) + (c) + 1; \
  }
```

Now. integrating this into a multi-word adder is going to look like
this.

```
unsigned char adc128(unsigned int *a, unsigned int *b, unsigned int *c,
                     unsigned char d)
{
  if (d != 0)
    goto CARIN;
/* NOCARIN: */
  ADD32(a[0], b[0], c[0], CAR0);
  goto NOCAR0;
CARIN:
  ADC32(a[0], b[0], c[0], CAR0);
  /* goto NOCAR0; */
NOCAR0:
  ADD32(a[1], b[1], c[1], CAR1);
  goto NOCAR1;
CAR0:
  ADC32(a[1], b[1], c[1], CAR1);
  /* goto NOCAR1; */
NOCAR1:
  ADD32(a[2], b[2], c[2], CAR2);
  goto NOCAR2;
CAR1:
  ADC32(a[2], b[2], c[2], CAR2);
  /* goto NOCAR2; */
NOCAR2:
  ADD32(a[3], b[3], c[3], CAR3);
  goto NOCAR3;
CAR2:
  ADC32(a[3], b[3], c[3], CAR3);
  /* goto NOCAR3; */
NOCAR3:
  return 0;
CAR3:
  return 1;
}
```

Yeah, it's kind of messy, but you get the idea.  You pass around one
bit of data by branching and implicitly encoding it in the value of
the program counter register rather than needing to sacrifice a whole
register to store the value of the sign bit.  Heck, now I realize this
is obvious, even if the architecture doesn't support automatically
setting carry bits, for the sake of user boolean variables in code,
the architecture should still provide a few user-controlled condition
flags that they can set, clear, and test as they please.  This would
make implementing carry in software much easier, although we would
still have the problem that the C programming language has no built-in
way to specify single-bit variables.

Then again, I guess this is the crux of the problem.  You could argue
that if you desire to have a handful of user-controlled condition code
bits, you might as well allocate a whole register to yourself to use
for that dedicated purpose, and you can let the compiler map out its
usage.  Essentially, functions could get the condition codes passed in
as an argument, and they would return the updated condition codes in
the return value.
