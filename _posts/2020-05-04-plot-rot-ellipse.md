---
layout: post
title: "Trying to solve pixel-perfect plotting of a rotated ellipse,
        and singular value decomposition explained"
date: 2020-05-04 17:16 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

How do you plot a rotated ellipse pixel-perfect?  Well, I was almost
stymied on this one, until I applied the idea I came up with for
quadratic Bezier curves that I thankfully didn't have to use for that
problem.  I would instead linearly combine an x-axis and a y-axis
parabola using cosine and sine.  In order for it to have the same
equation result, though, we have to cosine squared and sine squared so
that they sum to one.  Here is the application for the case of an
ellipse.

```
m = cos(w)
n = sin(w)

a^2 * x^2 + b^2 * y^2 = a^2 * b^2

m^2 * (a^2 * x^2 + b^2 * y^2) + n^2 * (b^2 * x^2 + a^2 * y^2) = a^2 * b^2
(m^2 * a^2 + n^2 * b^2) * x^2 + (m^2 * b^2 + n^2 * a^2) * y^2 = a^2 * b^2
```

But alas, this does not work!  Why?  If you look at these equations,
all we are doing is computing another ellipse on aligned axes but with
different radii.  We can't just add squared components, we need to add
linear components too, just like the case of quadratic Bezier curves
that effectively allow rotated parabolas.

<!-- more -->

So, the question is, how do we compute the linear part of these
equations?  In the case of a skewed ellipse, it's easy.  But also, a
skewed ellipse is a rotated ellipse with slightly different radii.
So, we have to know how to convert a rotated ellipse into a skewed and
stretched ellipse.

So, let's go back to the equation of rotation.

```
x(t) = cos(w) * x0(t) - sin(w) * y0(t)
y(t) = cos(w) * y0(t) + sin(w) * x0(t)
```

Those rotation constants are linear factors.  We want to rephrase them
into scaling and skewing operations.  This is, in essence, the
_singular value decomposition_ (SVD).  It's a concept well-covered in
linear algebra, so let's put it in matrix form.  However, unlike the
typical explanation found in linear algebra textbooks, we'll try to
keep our explanation simpler and straight to the point for our
purposes.

```
[ cos(w), -sin(w) ] * [ x0 ]
[ sin(w),  cos(w) ]   [ y0 ]
```

The scaling matrix is easy:

```
[ sx,  0 ] * [ x0 ]
[  0, sy ]   [ y0 ]
```

Now how about the skewing matrix?  To skew the y-axis,
i.e. y-locations remain constant but increasing y-location causes an
increasing x-location:

```
[ 1, ky ] * [ x0 ]
[ 0,  1 ]   [ y0 ]
```

To skew the x-axis:

```
[  1, 0 ] * [ x0 ]
[ kx, 1 ]   [ y0 ]
```

So, putting it together, to skew the x-axis, followed by the y-axis:

```
[ 1+kx*ky, ky ] * [ x0 ]
[ kx,       1 ]   [ y0 ]
```

Alternatively, we can skew both axes at the same time:

```
[ 1, ky ] * [ x0 ]
[ kx, 1 ]   [ y0 ]
```

Let's say we want to scale first, skew x-axis second, then skew y-axis
third.  The matrices are as follows.

```
  [ 1+kx*ky, ky ] * [ sx,  0 ] * [ x0 ]
  [ kx,       1 ]   [  0, sy ]   [ y0 ]

= [ sx+sx*kx*ky, sy*ky ] * [ x0 ]
  [ sx*kx,          sy ]   [ y0 ]
```

So, as you can see, although determining one scale factor from the
matrix is trivial, determining the skew factors is not.

But, there is a simple-enough approach.

1. Determine `sy`.

2. Determine `ky = sy*ky / sy`.

3. Compute `sx * sy * ky = sx*kx * ky`.

4. Subtract that from `sx+sx*kx*ky` to determine `sx`.

5. Determine `kx = sx*kx / sx`.

Okay, so now we know how to decompose rotation into scaling and
skewing.  Since scaling is the first thing we do, we can simply work
that into our somewhat correct rotated ellipse equations mentioned
previously.  But how do we work the skewing in?  Adding the equation
of a line with the necessary slope would do the trick.

So, adding an x-axis skew, add a `y = m*x` style equation.  Namely,
that means you only add the `m*x` part.  But be careful, we must make
sure we add it correctly in relation to the squares.

```
x^2 + y^2 = r^2
y^2 = r^2 - x^2
y = sqrt(r^2 - x^2)
y = sqrt(r^2 - x^2) + m*x
y^2 = r^2 - x^2 + 2 * m * x * sqrt(r^2 - x^2) + m^2 * x^2
y^2 = r^2 - x^2 + 2 * m * x * sqrt(r^2 - x^2) + m^2 * x^2
(1 - m^2) * x^2 + y^2 = r^2 + 2 * m * x * sqrt(r^2 - x^2)
```

Okay, that's looking ugly, but I think I get the point.  Because
otherwise, if you just add directly into the squares equation, you
would just be shifting around the center of the ellipse without
actually skewing it as you want to.  Plus, you would also resize the
radii at the same time.  And if you just adjusted the coefficient of
`x^2`, you would just be adjusting the size of the radius on the same
axis.

I feel close to the solution, but unfortunately, I also still don't
feel like I get it.  The equations I'm phrasing up don't seem
efficient to compute.  I'll have to come back to solving this later.

How about going the reverse direction on the Singular Value
Decomposition (SVD)?  Let's decompose as first scaling, second
rotation.

```
[ cos(w), -sin(w) ] * [ sx,  0 ] = [ sx*cos(w), -sy*sin(w) ]
[ sin(w),  cos(w) ]   [  0, sy ]   [ sx*sin(w),  sy*cos(w) ]
```

Using the trigonometric identities is the key to decomposing.

```
cos(w)^2 + sin(w)^2 = 1
(sx*cos(w))^2 + (sx*sin(w))^2 = sx^2
```

Once you determine `sx`, you can readily determine `cos(w)`, `sin(w)`,
and `w` itself via `atan2()`.  Then determining `sy` is trivial.

Wow, I finally solved a problem I struggled with 6 years ago.  Why did
it take me so long to have that simple realization?  Well, now I know
how to issue the drawing commands for an orthographic Earth geography
graticule without issuing skew transformations, only rotated ellipse
drawing commands.

And, relating to rotated ellipses, alas, I digress.  It's a lot easier
to approximate an ellipse using a Bezier spline and rotate that to get
a rotated ellipse.  So, now you know, that's why virtually all
mainstream graphics software uses that approach to get a rotated
ellipse.
