---
layout: post
title: "Solve a system of 3 linear equations using only integer
        arithmetic"
date: 2019-12-20 20:33 -0600
author: quorten
categories: [3d-scanning, 3d-scanner, media-prog]
tags: [3d-scanning, 3d-scanner, media-prog]
---

How do you solve a system of equations using only integer arithmetic?
At the outset, it doesn't seem easy or possible.  Gaussian elimination
with partial pivoting is our first go-to tool for solving a system of
equations, and this requires floating point arithmetic and lots of
division computations.  Sure, you could take this one step simpler by
modifying it to define it across rational or fixed-point numbers.
However, the fact still remains that you've got to do extra
book-keeping computations with those kind of numbers that you don't if
you could compute straight off on integer arithmetic.  So, is it
possible to solve a system of equations using straight integer
arithmetic?

Yes, it is.  The key is to look at the method by which you are
defining your equations, and redefine them at the source.  The reason
why Gaussian elimination requires floating point arithmetic is because
the equation form `ax + by + cz + d = 0` is because you must divide
each leading coefficient to normalize it to one, so even if you start
out with only integer inputs and would be able to receive an integer
solution, your computation process necessarily introduces rational
numbers.  However, the key to realize is that you can rephrase this
equation as a _vector equation_: `Ax + b = 0`, where `A` and `x` are
vectors.  `A` is a row vector, `x` is a column vector, when the two
are multiplied together, you get a constant as the output.

<!-- more -->

Now, here's the next key to understand.  Now we have two main types of
vectors being put together, a "point vector" and a "direction vector."
A point vector, obviously, can be specified in integers if you are
constrained to an integer coordinate space, which is especially the
case if your data is coming from spatial measurement sensors.  A
direction vector, now that is generally something that is derived from
two points in the coordinate space.  So, your direction vector too can
also be specified in integers.

Okay, so that's nice and all for reformulating the equations, but how
do we solve this?  Now, here is the key that comes from properly
understanding the geometric analogy.  When you have a point and a
direction, you can specify the equation of a plane.  The equation of a
plane can also be specified as a ray and an offset from the origin
along that ray, hence the euqation `Ax + b = 0`.  A "point vector" can
be understood as a displacement vector from the origin point.  When
you multiply the two vectors together, you are in effect taking the
dot product, and the equation is asserting that the dot product, the
distance of the point vector along the direction of the direction
vector, is equal to the offset `b`.  The direction vector itself
defines the surface normal, the perpendicular vector, of the given
plane.

Geometrically, you can solve a system of equations in a triangular
fashion, and in fact this is a variant of the triangular method for
solving a system of equations.  First you intersect two planes to get
a line.  Then you intersect the line with a third plane to get a
point.  And although I've principally defined this in three
dimensions, it can be extended to any number of dimensions.  By
definition, a linear equation contrains one linear variable, one axis,
effectively subtracting one dimension.  So each time you compute the
intersection of two equations, you are subtracting one dimension,
until you get to the zero-dimensional quantity, a point.  This is why
you need two equations to solve for a point in two dimensions, three
equations to solve for a point in three dimensions, and so on.

For my purposes of being able to compute quadratic regressions in
integer arithmetic and solve for points in three dimensions
constrained by a system of linear equations, solving systems in up to
3 dimensions is good enough for me.  So, how do you do this more
specifically?

First, you need to know how to define each equation that contraints
`n` dimensions in your stated dimensionality.  For 3D, this is easy:

* 0: Point: One [x, y, z] location vector
* 1: Line/Ray: Two [x, y, z] vectors, location and direction
* 2: Plane: Three [x, y, z] vectors, location and two in-plane vectors
* 3: No constraints, no equation whatsoever

Yes, there is more than one way to specify the line, ray, and plane
equations, but for our purposes, those specification forms work best
because they remain close to the form of the original data points from
which they were computed, and ultimately we want our solution to be a
data point in the same coordinate space.

So, given these equation forms, the solution process follows fairly
simply:

1. Collect your three planes.  Pick a primary plane where your
   starting location will be, and a secondary plane to target.

2. Compute the surface normals of these planes by taking the cross
   products of their in-plane vectors.

3. The direction vector of the intersection line will be the same as
   the cross product of the two surface normals.  Compute that.

4. The location point of the intersection line must be a mutually
   shared point between the two planes.  Compute this by defining an
   in-plane ray from your primary plane and intersecting that with the
   secondary plane.

5. Now that you have your intersection line between the two planes,
   simply intersect that with the third plane.  You will get your
   final destination point as the output.

As you can see, this is all very good integer arithmetic that sticks
close and true to the original integer coordinates that would have
been received as input to your system of equations.  Principally, when
solving a quadratic regression, for example, you start with a list of
points, and from there, you compute your mutual equations that need to
be intersected.  Or, with a geometric solution, you probably measured
your planes by geolocating three points on each plane, and from there
you can define the two in-plane direction vectors.  Every single time
we take a step away from the primary data, we are defining a clear
path and rationale as to why we must take that step.

The only question left for novices in computer graphics is the
definition of these subroutines that I've referenced.  So, I will
briefly review them here.

```
Dot product: dot_product(A, B) = A_x * B_x + A_y * B_y + A_z * B_z

Vector magnitude: magnitude(A) = sqrt(dot_product(A, A))

Vector normalization: normalize(A) = A / magnitude(A)

Cross product: cross_product(A, B) =
               [ A_y * B_z - A_z * B_y,
                 A_z * B_x - A_x * B_z,
                 A_x * B_y - A_y * B_x ]

Shortest distance from point to plane:

Let L = location vector of point,
    A = plane surface normal vector,
    d = plane offset from origin times magnitude(A),
    plane equation = Ax - d = 0

dot_product(L, A) / magnitude(A) - d / magnitude(A)
= (dot_product(L, A) - d) / magnitude(A)

Let L = location vector of point,
    A = normalized plane surface normal vector,
    d = plane offset from origin
    plane equation = Ax - d = 0

dot_product(L, A) - d

Alternatively, rather than using a scalar `d`, you can define a point
in the plane as a vector and subtract it from L before computing.

Let L = location vector of point,
    A = plane surface normal vector,
    P = plane location vector

L_rel_P = L - P;
dot_product(L_rel_P, A) / magnitude(A);

Intersection of ray/line with plane:

Let D = ray/line direction vector,
    L = ray/line location vector,
    A = plane surface normal vector,
    P = plane location vector

comm_dir_len = dot_product(D, A);
D_sub_A = D - A * comm_dir_len / magnitude(A);
D_along_A = dist_point_to_plane(L, P, A) * D_sub_A / magnitude(D);
```

Now, how does this compare overall to Gaussian elimination?  With
Gaussian elimination, you can do it with 11 divisions, by skipping
over the entries known to be zero.  This method requires 18 divisions.
So, yes, it does require more divisions, but it has a semblance of
staying close to the source data, and therefore is more numerically
stable in that sense.  Also, since every single time we do a divide it
is matched by a corresponding multiply, we have a computational form
that is similar to the benefits of rational arithmetic, but using only
integers, provided that we allocate enough integer range to square
numbers.

But, there is still room for simplifications.  If you normalize A in
advance, you can reduce those divisions since you only need to divide
by `magnitude(A)` once.  This brings you to 12 divisions, competitive
with Gaussian elimination.  However... this is only under the
assumption that you represent the normalized vector using the
fixed-point format.  In this case, you simply need to do some final
bit-shifting operations in place of a divide.

Also, another note when computing the cross product.  The cross
product, like the dot product, contains factors of the magnitude of
both vectors within it.  This means that you have squared quantities
in the resulting vector.  All of our equations generally require
integer range to be specified to handle square quantities of the
maximum dimensions of the source coordinate space, but in order to
avoid cube quantities, you must divide by one of the two factors.
Which one?  Naturally, you'd want to divide by the smallest magnitude
to get the best numerical range, but if you can safely assume that
both magnitudes must be specified to a reasonable length, then you can
just arbitrarily pick either one.

Also, this assumption hinges on the assumption that the angle between
the two vectors is sufficiently large: the cross product also has a
factor of the sine of the angles between the two vectors within it.
If, however, you want good numerical stability even when the angle
between the vectors is narrow, then you can multiply by a fixed
integer to add fixed-point precision based off of what your target is.
For example, if you want to be able to support a sine factor that
works out to be 0.0625 with ease, then you may want to multiply by a
factor of 16, or shift for 4 bits after the decimal.

```
Let N = surface normal vector
cross_product(A, B) = magnitude(A) * magnitude(B) * sin(theta) * N
```
