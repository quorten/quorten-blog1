---
layout: post
title: Inflating a Bezier curve
date: 2020-05-04 13:37 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

How do you inflate a Bezier cuves?  That is, move each point a
constant distance from its current position.  Circles are easy, just
increase or decrease the radius accordingly.  But Beziers, come on, a
quadratic Bezier is a parabola, if you just increase the scale of a
the parabola, you'll end up with the endpoints being skinnier than the
vertex.  But, couldn't you just stretch the envelope wider/narrower
and be done with it?  Okay, okay... well I guess that's a pretty good
approximation.  Just be careful about very sharp quadratic Beziers,
ideally I'd recommend subdividing this down into something close to
linear then using the mentioned approximation technique.

Now, cubic Beziers are not so easy.  I'd say in general with Beziers,
with the exception of lines, there is not an exact solution to
inflating a Bezier, only approximate ones.  For cubic Beziers, if you
are just rendering, yeah you can subdivide into approximate quadratic
Beziers and then use the mentioned approximate inflation technique.

<!-- more -->

For rendering thick geometric strokes, often times converting the
stroke into a path and then scan-filling the region is the best
technique.  Otherwise, repeatedly plotting circles along each point is
another easy way, though this means you can't control the joint and
cap style.  Oh, and I didn't mention METAFONT-style pens, but that's
not in the PostScript, PDF, and SVG and standards.  METAFONT-style
pents are technically polyline approximations of an ellipse, polylines
are another simple way to inflate Bezier curves.  Within the threshold
of two polyline angles, you simply offset the Bezier curve by the
corresponding distance of a polyline point from its center.  This is
exact to the geometry of the polyline and the Bezier.

But, what if you don't just want to render, but want to generate some
clean data directly for artist use?  Like the Inkscape command to
convert a stroke into a path?  Well, I'll say this, follow in the
footsteps of the Inkscape source code.  Just like Inkscape, after
computing your approximation, you then simplify the path as much as
possible, while still remaining within your target margin of error.
