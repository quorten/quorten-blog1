---
layout: post
title: "Draw a circle using Bresenham's algorithm starting at an
        arbitrary point"
date: 2020-05-19 19:12 -0500
author: quorten
categories: [media-prog, unlipic]
tags: [media-prog, unlipic]
---

How do you draw a circle or circular arc using Bresenham's algorithm
with the ability to start at an arbitrary point along the circle?
It's definitely possible, it's just that it requires more computation
up-front, here's how.

What factors are you given?

* The current point.

* The starting angle, vectors are preferred.

* The radius.  This may be expressed in the starting angle vector.

So now we need to compute the non-trivial starting parameters.  `y0`
aned `y^2` are easy to directly compute from the current point and
angle vector.  What about `y_odd`?  Well, remember the sum of odd
numbers formula to iteratively compute `y`.

```
(y + 1)^2 == y^2 + 2*y + 1
```

So now this means that we simply compute `(2 * y + 1)` to get `y_odd`.
And for proper rounding, we add one more on top of that.

Computing `x0` and `x^2`?  That is almost as easy, but remember we
must be subtracting from the radius.  So, after making that adjustment
the rest of the parameters can be computed with ease.
