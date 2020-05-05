---
layout: post
title: "Finally, a better explanation for plotting pixel-perfect
        Beziers"
date: 2020-05-04 10:51 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

I've seen the Wikipedia article link to using Bresenham's algorithm
for computing pixel-perfect Beziers, but it honestly wasn't all that
well explained in my opinion.  I tried once before but failed to
create my own derivation.  But this time, I am successful.

This is key to converting parametric Bezier equations into an implicit
form where you can single-step pixels for error minimization: We
assert the substitution `a*x + b*y = c` must hold true in order for it
to even be possible to compute single-pixel stepping.  So, each
parametric equation can be substituted in the `x` and `y` quantities,
the parameters removed, and the constants recomputed to make this so.

The equation as-is is obviously the equation of a line, which is why
we can do it for lines.  A short proof shows that this also holds for
circles.

```
x(t) = r*cos(t)
y(t) = r*sin(t)
cos(t)^2 + sin(t)^2 = 1

(r*cos(t))^2 + (r*sin(t))^2 = r^2
x^2 + y^2 = r^2
```

<!-- more -->

So, now how do we do this for quadratic Beziers?  First, let's start
with the base definition equations.

```
((1 - t) + t)^2
= (1 - t)^2 + 2*(1 - t)*t + t^2

a*(1 - t)^2 + 2*b*(1 - t)*t + c*t^2

x(t) = a_x*(1 - t)^2 + 2*b_x*(1 - t)*t + c_x*t^2
y(t) = a_y*(1 - t)^2 + 2*b_y*(1 - t)*t + c_y*t^2
```

Now, let's consider some base definitions of an implicit parabola.

```
a*x^2 + b*y = c
a*x + b*y^2 = c
```

Looking at the Bezier equations, we see there is both a linear and a
quadratic component in both `x` and `y`.  We can therefore assert that
it must be possible to rephrase the equation into the following form.

```
a*x^2 + b*x + c*y^2 + d*y = e
```

**Please note:** Here, `e` is **not** the constant `2.7182818284...`,
but rather an arbitrary constant we are using for our equation.

The problem is that we don't know how to compute the coefficients at
the outset.  So, let's analyze a simpler case, linear Beziers.

```
x(t) = a_x*(1 - t) + b_x*t
y(t) = a_y*(1 - t) + b_y*t
```

If we fully expand on the `t` parameter, we can see the perpendicular
vector coefficients clearly, and this is independent of the actual
length of the line, i.e. whether we range from `t = 0.0` to `t = 1.0`
or compute in screen coordinates.

```
x(t) = a_x - a_x*t + b_x*t
     = (b_x - a_x)*t + a_x
y(t) = a_y - a_y*t + b_y*t
     = (b_y - a_y)*t + a_y
```

So, now we know the slope vector is `(b_x - a_x, b_y - a_y)`, so that
is what we use when computing single-stepping to rasterize a linear
Bezier.  In implicit equation form, we must use the perpendicular
vector instead, i.e. swap the two components and negate one of them.
We also know the starting point is `(a_x, a_y)`.  And naturally, we
know the endpoint is `(b_x, b_y)`.  Since quadratic Beziers likewise
have a linear component, we can carry this knowledge forward.

Now, for the quadratic expansion.

```
x(t) = a_x*(1 - t)^2 + 2*b_x*(1 - t)*t + c_x*t^2
     = a_x - 2*a_x*t + a_x*t^2 +
       2*b_x*t - 2*b_x*t^2 +
       c_x*t^2
     = (a_x - 2*b_x + c_x)*t^2 +
       (2*b_x - 2*a_x)*t +
       a_x

y(t) = a_y*(1 - t)^2 + 2*b_y*(1 - t)*t + c_y*t^2
     = a_y - 2*a_y*t + a_y*t^2 +
       2*b_y*t - 2*b_y*t^2 +
       c_y*t^2
     = (a_y - 2*b_y + c_y)*t^2 +
       (2*b_y - 2*a_y)*t +
       a_y
```

So, likewise, now we know the following information:

* Starting point: `(a_x, a_y)`
* Endpoint: `(c_x, c_y)`
* Linear slope vector: `(2*(b_x - a_x), 2*(b_y - a_y))`
* x-axis parabola width coefficient: `a_x - 2*b_x + c_x`
* y-axis parabola width coefficient: `a_y - 2*b_y + c_y`

So, now the question is, what to do with the parabola width
coefficients?  Well, if the width coefficient is zero, that means you
definitely know there is not a parabola on that axis, which means you
set the corresponding implicit equation component to zero.  For
example:

```
a = (-1, 0)
b = (0, 1)
c = (1, 0)

x-axis parabola coeff. = -1 - 2*0 + 1 = 0
y-axis parabola coeff. = 0 - 2*1 + 0 = -2
```

Upon observation of this, you notice that packing into the implicit
equation, we actually effectively flip around the associated
variables, just like we're working with a perpendicular.  And we might
as well also negate one coefficient for consistency.  So, let's delve
deeper.

```
x-axis parabola coeff. = 0
y-axis parabola coeff. = -2
Linear slope vector: (2*(0 - -1), 2*(1 - 0)) = (2, 0)
Starting point: (-1, 0)
Endpoint: (1, 0)

a*x^2 + b*x + c*y^2 + d*y = e

-a*x^2 - b*x + c*y^2 + d*y = e
-a*x^2 + d*y = e
2*x^2 + 2*y = e
x^2 + y = e
y = -x^2 + e
```

Wow, that worked out quite swell!  Now, `e` is simply computed by
substituting the starting values and solving.

```
e = (-1)^2 + 0 = 1
y = -x^2 + 1
```

And that looks correct!

For the sake of efficiency when plotting with these equations, you
might want to subtract the starting point so that you start computing
at `(0, 0)`, and add it back during plotting.  This way, you do not
need multiply to compute the starting exponents, you just know they
are zero.  Likewise, the constant `e` is also always zero.

So this can be readily extended to cubic Beziers for pixel-perfect
computations, right?  Hold that thought for a moment.  When computing
with integer arithmetic, if you compute with cubics directly, you need
to allocate enough bits of precision to raise your base measurements
to the third power.  That means you need three times as many bits of
precision for intermediate calculations.  Double-width integers are
pretty easy to work with, but triple-width integers?  Not so much.
From a computational efficiency standpoint, it is far more efficient
to subdivide a cubic Bezier until it can be plotted reasonably
accurately using piece-wise quadratic Beziers.  This way, you only
need twice as many bits of precision for second-power intermediates.

So, to summarize plotting cubic Beziers using a piece-wise quadratic
Bezier approximation.  Use de-Casteljau's algorithm to subdivide the
Bezier into segments until the control points on each segment are
equidistant from each other along the direction of the line between
the endpoints, and the distance from the line to the control point is
also approximately the same.  Yes, use dot product methods and compare
that the distance squared is within bounds.  Then the approximate
quadratic Bezier control point can simply be computed by intersecting
two lines, formed from each endpoint and its adjacent control point.
