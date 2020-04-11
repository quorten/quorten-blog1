---
layout: post
title: "Compute square roots with binary integer arithmetic, and
        discussion of shifting without shift instructions"
date: 2020-01-31 22:32 -0600
author: quorten
categories: [3d-scanning, 3d-scanner, unlipic, media-prog]
tags: [3d-scanning, 3d-scanner, unlipic, media-prog]
---

The standard C library has subroutines for computing square roots on
floating point numbers, but what if you want to compute square roots
on integers?  Then you have to write your own square root subroutines.
But no worries, this is actually rather simple to do in an efficient
manner.

Basically, you use an iterative square root computation approach that
revolves around this formula:

```
(x + n)^2
= x^2 + 2*x*n + n
```

`n` is a power of two... so 2*n*x is wholly bit shifting.  `x` is your
running total of your guessed square root so far.  The idea is that
you incrementally test adding one bit value to your total.  Of course,
you need a starting guess, and for that, counting the number of
significant bits using the bit-scan reverse instruction (`bsr` on x86)
works very well.  Divide that by two (shift right by one) to get a
starting value for `x`.

If you don't have bit scanning instructions, then you must use an
iterative square root method.  Then you can cache the results in a
lookup table, of course.  Note that a square root **is** a polynomial,
so there is no "polynomial approximation", just polynomial
computation.

<!-- more -->

UPDATE 2020-04-11: Actually, implementing bit-scanning in software is
not that hard, and I've written such an implementation in my coding
playground.  It is lack of bit shifting in hardware that is the
troublemaker.

Technically this iterative square root method **is** a variant of
Newton's method, but optimized for power-of-two computations.

What if your processor lacks bit shifting instructions, can you
construct a lookup table for shifting by up to 32 bits?  That's a
challenge, but doable.  First, you want to decompose your shift into a
sum of power-of-two shifts.

```
31 = 16 + 8 + 4 + 2 + 1
```

Do that via a lookup table.  Only need 32 entries, remember.

Then once you have that decomposition, you can do a binary shift
construction approach.  But the problem still remains.  Principally,
each lookup table needs 4,294,967,296 entries, and we need 5 of those,
4 if you exclude the shift by one bit (since you can add a number to
itself to multiply by two or shift by one bit).  How much memory is
that?

```
4 * 2^32 * 4 = 2^40 = 1 TiB
```

That is unacceptably huge!

Worst case, you iteratively add a number to itself to shift by one bit
at a time.

Nevertheless, if you only need to shift left by one bit at a time,
adding works great.  So that solves the problem for computing square
roots on machines without bit-shifting instructions, under some
circumstances.  Namely, shift by half of significant bits
approximation.  So yes, even without bit-scan instructions, it can
still be faster, just not a whole lot faster.

And in the second form, indeed we are only stepping n up or down one
power-of-two at a time.

Okay, how do you do shift right without a shift right instruction?
Well, you can build a lookup table for single shift right bit
shifts...  yeah, but that's still a storage problem for large
integers.  Or you can do iterative method... again.  For some cases,
shifting left by one bit to rotate and wrap around in a loop and build
a lookup table just for that particular case will work.  Once you
count up and wrap all the way around and store the results in a table,
counting down on the table values is easy to "shift right" by one bit
at a time.

Easiest form is to be able to break a large number up into smaller
components... like 4 bits or 8 bits at a time.

Otherwise, just about everything must be solved with an iterative
binary search to construct the result.  Well yeah, that's technically
what you do when you operate a chunk at a time on a number, but the
speed difference may be too great for typical use since your
wastefully repeating low-level computation.

Otherwise, how can you mathematically pre-condition to reduce the size
of the lookup table?  You can do a binary search for the first few
terms, then do the lookup table for the remainder.

UPDATE 2020-04-11: But, in my experience thus far, I have found that
when the space is too large to fit entirely in a lookup table, a
partial lookup table provides negligible performance gains.
