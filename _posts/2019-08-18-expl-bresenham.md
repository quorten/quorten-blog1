---
layout: post
title: Bresenham's line plotting algorithm explained
date: 2019-08-18 15:05 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

Okay, so Bresenham's line plotting algorithm has already been
explained many times, but now I want to do a good explanation in my
own words for my own reference and learning.  Also, I want to explore
how to extend the algorithm to plotting 3D lines in a voxel grid,
which I will show is fairly simple and intuitive if you understand
Bresenham's line plotting algorithm.

So, for starters.  You have a two endpoints of a line on a pixel grid,
and you want to rasterize the line in between.  Also, you must use
only integer arithmetic when performing this operation, no floating
point.  How do you do that?  One easy and intuitive way is to
recursively compute midpoints along the line, until all pixels are
connected.  However, this is an imperfect method that tends to result
in plotting extra pixels.  The ideal method would be to compute an
integer space which is right-sized so that you can uniformly step from
beginning to end by adding an integer constant.

Let's describe this better with an example.

    P1 = (7, 4)
    P2 = (14, 17)
    D = (14 - 7, 17 - 4) = (7, 13)

In this example, we know that we need to step 7 pixels along the
x-axis and 13 pixels along the y-axis.  If we only had to step along
the x-axis, we could define our integer space to be [0, 6] and add one
every time we step one pixel, and that would do the trick.

<!-- more -->

The easiest way to get a joint integer space in these two dimensions
is to multiply the deltas together:

    7 * 13 = 91

Now in this joint space, if we want to step along the x-axis
uniformly, we add 13, and we can do that up to 7 times before we reach
the limit of 91.  Likewise, for stepping along the y-axis uniformly,
we add 7, and we can do that up to 13 times before we reach the limit
of 91.

So, how do we uniformly step through both dimensions?  We simply add
one to a running total.  Every time the total is divisible by 13, we
step one pixel on the x-axis.  Every time the total is divisible by 7,
we step one pixel on the y-axis.  This will give us a nice, clean,
uniform stepping on both axes.

Now we can make some algorithmic simplifications and optimizations.
First, rather than stepping by one, the minimal increment we need to
step by to avoid missing pixel steps is, of course, the minimal delta,
which in this case is 7.  Second, rather than keeping a running total,
we really only need to keep track of the remainders for divisible by 7
and divisible by 13 in order to know when to step one pixel.  We also
know we're done when we reach the end pixel coordinates.  So we can
eliminate the need to multiply and divide.  Finally, since we are
always stepping by 7, we don't need to keep track of the remainder for
7, so we really only need one remainder variable.  We continuously add
7 to this variable while stepping along the y-axis, and when we meet
or exceed 13, we subtract 13 and step along the x-axis.

So, at this point, the question on how to extend to three dimensions
should be easy to answer.  Simply add another remainder variable.
Find the minimal stepping value, and add that continuously to the two
remainder variables.  When they meet or exceed their limits, you can
step once on the corresponding axes.

This final simplification is only really practical in the
two-dimensional case.  Rather than determining which stepping value is
larger and which one is smaller, you can implicitly combine both
remainders together, with one the opposite sign of the other.  Then
you arbitrarily choose to step by one variable first.  If you have to
step multiple times before the limit is reached, the method is exactly
the same as described previously.  But, if you step once and you
exceed the limit of the other variable, then you step by the other
variable multiple times until you are less than or equal to zero.
