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

```
Point2D delta = { p2.x - p1.x, p2.y - p1.y };
Point2D cur = { p1.x, p1.y };
Point2D signs = { (delta.x > 0) ? 1 : -1, (delta.y > 0) ? 1 : -1 };
unsigned limit = delta.x * delta.y;
unsigned i;
for (i = 0; i < limit; i++) {
  if (i % delta.y == 0) {
    /* Step by one x pixel.  */
    cur.x += signs.x;
  }
  if (i % delta.x == 0) {
    /* Step by one y pixel.  */
    cur.y += signs.y;
  }
  PutPixel (cur);
}
```

Please note that straight horizontal and straight vertical lines need
to be handled separately.

Now we can make some algorithmic simplifications and optimizations.
First, rather than stepping by one, the minimal increment we need to
step by to avoid missing pixel steps is, of course, the minimal delta,
which in this case is 7.  Second, rather than keeping a running total,
we really only need to keep track of the remainders for divisible by 7
and divisible by 13 in order to know when to step one pixel.  We also
know we're done when we reach the end pixel coordinates.  So we can
eliminate the need to multiply and divide.

```
Point2D delta = { p2.x - p1.x, p2.y - p1.y };
Point2D adelta = { ABS(delta.x), ABS(delta.y) };
Point2D cur = { p1.x, p1.y };
Point2D signs = { (delta.x > 0) ? 1 : -1, (delta.y > 0) ? 1 : -1 };
Point2D rems = { 0, 0 };
unsigned step = MIN(adelta.x, adelta.y);
while (cur.x != p2.x || cur.y != p2.y) {
  rems.x += step;
  rems.y += step;
  if (rems.x >= adelta.y) {
    cur.x += signs.x;
    rems.x -= adelta.y;
  }
  if (rems.y >= adelta.x) {
    cur.y += signs.y;
    rems.y -= adelta.x;
  }
  PutPixel (cur);
}
```

Please note that interestingly, this algorithmic simplification
eliminates the need for code to handle a special case for straight
horizontal and straight vertical lines.

Finally, since we are always stepping by 7, we don't need to keep
track of the remainder for 7, so we really only need one remainder
variable.  We continuously add 7 to this variable while stepping along
the y-axis, and when we meet or exceed 13, we subtract 13 and step
along the x-axis.

```
Point2D delta = { p2.x - p1.x, p2.y - p1.y };
Point2D adelta = { ABS(delta.x), ABS(delta.y) };
Point2D cur = { p1.x, p1.y };
Point2D signs = { (delta.x > 0) ? 1 : -1, (delta.y > 0) ? 1 : -1 };
unsigned rem = 0;
unsigned step;
if (adelta.x <= adelta.y) {
  step = adelta.x;
  while (cur.x != p2.x || cur.y != p2.y) {
    rem += step;
    cur.y += signs.y;
    if (rem >= adelta.y) {
      cur.x += signs.x;
      rem -= adelta.y;
    }
    PutPixel (cur);
  }
} else { /* adelta.y < adelta.x */
  step = adelta.y;
  while (cur.x != p2.x || cur.y != p2.y) {
    rem += step;
    cur.x += signs.x;
    if (rem >= adelta.x) {
      cur.y += signs.y;
      rem -= adelta.x;
    }
    PutPixel (cur);
  }
}
```

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

```
Point2D delta = { p2.x - p1.x, p2.y - p1.y };
Point2D adelta = { ABS(delta.x), ABS(delta.y) };
Point2D cur = { p1.x, p1.y };
Point2D signs = { (delta.x > 0) ? 1 : -1, (delta.y > 0) ? 1 : -1 };
unsigned rem = 0;
unsigned step = adelta.x;
while (cur.x != p2.x || cur.y != p2.y) {
  rem += step;
  if (adelta.y != 0)
    cur.y += signs.y;
  while (rem >= adelta.y && cur.x != p2.x) {
    cur.x += signs.x;
    rem -= adelta.y;
    PutPixel (cur);
  }
  PutPixel (cur);
}
```

A good practical use of the final simplified form is for scan-filling
triangles.  When you scan-fill a triangle, you always want to step
vertically in the master outer loop of the line plot computation,
i.e. just as we do in the given code example.  Then it is easy to step
down by both lines coming from the top-most vertex, and again for both
lines to the bottom-most vertex.

Finally, an important note on practical implementation.  In all of
these code samples, we've been initializing the remainder to zero, but
in practice, you probably want to initialize the remainder to 50% so
that you get a nice 50% rounding pattern on the line rasterizations.
The last simplification probably doesn't play nicely with 50%
initialization because we technically code it up without truly knowing
which remainder is our primary one for the 50% rounding.  Also, we've
been writing our line plotting algorithms such that we plot the last
point on the line, but not the first point.  You may want to tweak
this behavior so thbat we plot the first point, but not the last
point, or maybe something else.

----------

As a good epilogue, I wanted to show the code for an intuitively
designed floating point arithmetic line plotter for reference and
comparison.  This is based off of the Bezier definition of a line.

```
int num_steps = 100;
float limit = 1.0f;
float step = 1.0f / num_steps;
float i;
for (i = 0.0f; i < limit; i += step) {
  Point2D plot = { (int)(i * p1.x + (1.0f - i) * p2.x),
                   (int)(i * p2.y + (1.0f - i) * p2.y) };
  PutPixel (plot);
}
```

Here, we are dividing to compute the floating point step size.  In the
Cartesian definition of a line, we would be dividing to compute the
slope for plotting.

```
Point2D delta = { p2.x - p1.x, p2.y - p1.y };
Point2D cur = { p1.x, p1.y };
Point2D signs = { (delta.x > 0) ? 1 : -1, (delta.y > 0) ? 1 : -1 };
float slope = (float)delta.y / delta.x;
while (cur.x != p2.x) {
  cur.y = (int)(slope * (cur.x - p1.x)) + p1.y;
  cur.x += signs.x;
  PutPixel (cur);
}
```

----------

Now that I've derived my own line plotting algorithm and I check back
with the ones specified on Wikipedia, I am amazed that I have bested
the implementations on Wikipedia.  When I first saw those
implementations, I was in shock.  How can you possibly understand how
those plot perfect lines with only integer arithmetic and not needing
to divide to compute the slope?  But, now I know.  Careful
explanation, and by all means, the utility of multiple different
equations of a line to help you frame up the most optimal mathematical
model.

20190828/https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
