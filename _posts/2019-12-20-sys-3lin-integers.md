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

   How do we pick or define this in-plane this vector?  Out of the two
   source vectors, we want to pick the one that is most perpendicular
   to the target plane.  Or, in other words, the vector that has the
   largest normalized dot product.  Normalization can be skipped if
   the two in-plane vectors are assumed to be approximately the same
   length, which they shoul be assuming the source data is well-formed
   for numerical stability.

   We can compute a new vector by projecting a point to the target
   plane to get a perpendicular ray, then projecting the distant point
   again to our source plane.  Then we solve the intersection using
   that new ray.

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

Eliminate one vector component from another like "A - B":

vec_elim(A, B) =  A - B * dot_product(A, B) / magnitude(B)

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

Project a point to a plane along the perpendicular:

Let L = location vector of point,
    A = plane surface normal vector,
    P = plane location vector

L - A * dist_point_to_plane(L, P, A) / magnitude(A)

Pay attention to the sign here: The distance from the point to the
plane is positive when we are in front (normal and point vector facing
the same direction), negative when we are behind. Since we want to
travel opposite this distance to reach the plane, we must subtract,
not add.	       

Because we are dividing by magnitude twice, the division quantity is
squared so we therefore can avoid computing the square root and
simplify as follows:

L_rel_P = L - P;
L - A * dot_product(L_rel_P, A) / dot_product(A, A);

Bi-directional intersection of ray/line with plane:

Let D = ray/line direction vector,
    L = ray/line location vector,
    A = plane surface normal vector,
    P = plane location vector

comm_dir_len = dot_product(D, A);
A_along_D = comm_dir_len / magnitude(A);

// Fixed-point intermediate, can be substituted directly to avoid
// fixed-point.  Multiplier of distance to plane in units of A_along_D.
direct_dist_scalar = -dist_point_to_plane(L, P, A) / A_along_D;

result = L + direct_dist_scalar * D;

If you look at these equations carefully, you'll see we actually carry
cancel out magnitude(A) on both the numerator and denominator.  Hence,
we can completely avoid computing this quantity and avoid the
associated square root computation.  Let's simplify.

All equations laid out:

comm_dir_len = dot_product(D, A);
A_along_D = comm_dir_len / magnitude(A);
L_rel_P = L - P;
direct_dist_scalar = -dot_product(L_rel_P, A) / magnitude(A) / A_along_D;
result = L + direct_dist_scalar * D;

Substituting A_along_D, we clearly have `magnitude(A)` in both the
numerator and denominator.  Cancel them.

L_rel_P = L - P;
direct_dist_scalar = -dot_product(L_rel_P, A) / dot_product(D, A);
result = L + direct_dist_scalar * D;

Now we can perform the final substitution to avoid fixed-point
arithmetic.

L_rel_P = L - P;
result = L - D * dot_product(L_rel_P, A) / dot_product(D, A);

If you want a directed intersection computation, i.e. you do not want
to extend rays backwards to complete an intersection, then check the
ratio of dot products.  If `-dot_product(L_rel_P, A) / dot_product(D,
A)` is negative (alternatively, if the ratio of dot products without
the negative sign is positive), that means you're traveling the
opposite direction of the ray vector, so there is no solution.

Also, note that if we would be about to get a divide-by-zero in the
intersection equations, that means the ray is parallel to the plane,
so there is no solution.
```

Now, how does this compare overall to Gaussian elimination?  With
Gaussian elimination, you can do it with 9 divisions, by skipping over
the entries known to be zero.  This optimized method requires only two
divisions (since we run the subroutine twice to solve the whole
system), much better than Gaussian elimination.

Not only is this more computationally efficient, this also has a
semblance of staying close to the source data, and therefore is more
numerically stable in that sense.  Also, since every single time we do
a divide it is matched by a corresponding multiply, we have a
computational form that is similar to the benefits of rational
arithmetic, but using only integers, provided that we allocate enough
integer range to square numbers.

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

----------

Actually, in the midst of this discussion, the idea of performing
"pre-conditioning" checks on the data is a prudent one.  So, when we
want to do this what do we check for?  Basically, we want to check the
forms of the equations of the planes and how they relate to each
other.

1. Check the lengths of the two in-plane vectors and verify they are
   similar to each other.  If one is way longer than the other, you
   have poorly formed source data.

2. Check the angle between the two in-plane vectors and verify they
   are reasonably separate in angle, right angle being the extreme.
   If the two in-plane vectors are so close in angle as to almost be
   identical, you have poorly formed data.  Poorly formed angles
   include near zero degrees and near 180 degrees.

3. Check the angles of the plane surface normals relative to each
   other.  These should also be well-formed angles, so if anything is
   close to zero degrees or 180 degrees, you have poorly formed data.

4. Check that plane reference points are reasonably close to each
   other, within some kind of bounding box.  If a plane reference
   point is way further away from the others, chances are you will not
   get well-formed numerical results and you therefore have poorly
   formed data.

   Beyond that simple heuristic, the main understanding of this
   numerical stability is in proportion to the surface normal lengths.
   The main thing to watch out for is how many times the length of a
   surface normal you must extend to reach another plane.  Remember,
   with integer arithmetic, we use non-normalized surface normals so
   that we can stay close to the original data points.  If we have to
   extend way too many times the length of a surface normal, that
   means we are multiplying an uncertainty in direction because we
   didn't measure the angle that precisely in the original data.  But,
   if you extend only a fraction the length of a surface normal, you
   have extreme confidence in the accuracy of the resulting position
   since your original data measured the angle more precisely than is
   being used in the computation.

   So, if you are solving a system of equations and find out that you
   have to over-extend a ray to get a plane intersection, this is a
   good opportunity to try to see if you can solve the system picking
   a different ordering for the first, second, and third planes.  If
   you cannot reorder the data and maintain this constraint, you have
   poorly formed data.

----------

Coming back to solving a quadratic regression, you will start with the
`Ax = b` equation form, which uses a scalar for the reference point
rather than a point vector.  So, how do you use the integer method to
solve such a system of equations?

The ray-plane intersection subroutine can operate with equations of
planes defined as an origin offset rather than a starting point, so
nothing needs to change there.  The main question, then, is how do you
pick the starting point and starting direction?  The key to remember
here is the form of the primary data: you are principally given planes
defined in terms of a direction vector and a scalar offset from the
origin.  When your goal is to pick a point sticking as close to the
original data as possible, naturally that means you pick your starting
point from the point closest to the origin.  As for the starting
direction, the best way to get that is to take the surface normal of
the second plane and project it into the first plane, which will give
you an in-plane vector perpendicular to the second plane.  So, after
doing that, you simply follow the same procedure to solve the system,
and if numerical stability all checks out, you're done!

Please see my blog article on [linear regression algorithm
implementation]({{ site.baseurl }}/blog/2018/02/18/linreg-impl)
information for more insight for an efficient implementation algorithm
for a 3D scanner for setting up the `Ax = b` matrix.
