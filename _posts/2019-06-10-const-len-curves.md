---
layout: post
title: Editing curves with constant length
date: 2019-06-10 22:59 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

I have this paricular problem, well, it's not particularly unique,
I've encountered it time and time again before but have not had a
reasonable solution to it.  Until now.  How do you virtually edit
surfaces where the length must be kept constant, but the surface
geometry may be changed?  This seems like quite a difficult problem,
but let's consider a simplified case where you have a sheet of paper
that can only really flex and curl around one axis, rather than two or
three.  Here, the solution is simple.  You define a 2D Bezier with a
base curve where the total length must be held constant.  Now you
stretch the curve in one direction, how do you know how to adjust the
length?  The solution is simple.  By the dot product, you can split
into X and Y components and measure the length of those.  The total
length can then be computed by the distance formula, a^2 + b^2 = c^2.
c^2 is simply a constant since the total length is a constant.  So
after you adjust a curve along one axis, you can automatically compute
the scalar value for the other axis with the given constraints.

Now there are a few other specifics of this curve editing that also
need to be taken into consideration.  How many points are pinned?
Which parts of the curve can be flexibly adjusted and modified?  Once
these additional constraints are determined, the equation solving can
be performed in a simplified context.  One particular case that you do
want to be able to support that is a bit non-trivial is if you hold
one end of the curve and rotate around the other end to give a round
page curl.
