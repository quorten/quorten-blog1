---
layout: post
title: More ideas on processing methods for 3D scanning
date: 2016-11-19 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

Okay, so now we have some rather interesting ideas to integrate with
how we design our 3D scanner.

First of all, just to get the quick one out of the way, our naming for
our "offset map."  To make this more of a coherent metaphor with the
photography profession, we can call this "circles of confusion."
After all, that is what we call the artifacts seen in photographs that
are out of focus.  Anyways, yes, the map that shows the size of the
same-time-colored dot in relation to the position of the pixel.

Second, on thresholding.  In addition to recording the ambient light
photograph to compare against for thresholding laser light, we can
also use the _color_ of the pixel in the ambient light map to
determine the reflectivity of the material at that point to the laser
light.  For example, bright red or white will be very reflective to
our red laser light, while blue surfaces are going to need more
sensitive thresholding.  So in the case of the bright red or white
surfaces, we can adjust our algorithms to use the least sensitive
thresholding, or the highest thresholding in other words.  The purpose
of this is to reduce our margin of error in detecting whether a pixel
is very closest to the center of our laser, thus opting for the
minimum "circle of confusion" and getting the highest resolution.

<!-- more -->

Now, for the third new idea.  On detecting the position of the laser.
There is a very ingenious technique that we can use for this.  It is
almost too simple: shadowing.  So, first of all, we have our known
scanning structure that is computer printed and can be used to
triangulate the position of the camera based off of the dot positions
in the photograph.  Now we shine our laser line generator on this
structure.  We have this particular structure setup so that there are
two white paper poles in front of the flat white cardboard background.
This will cause a laser to appear on the background cardboard, with
visible shadows caused by the poles, and laser light visibly
illuminating some positions on the poles.  This can be used to draw
two lines through the shadows to the illuminated positions on the
poles that point us directly to the laser's position.  Now that we
know the exact position of the laser, we can use our laser profile map
to map the exact directions of the laser rays, in the case that our
laser does not project a perfectly straight line, and for the sake of
laser intensity thresholding.

Also, we can rotate the laser around its axis a little bit and do a
few more such exposures to determine our axis of rotation and even our
laser module's offset from the axis of rotation.

Finally, we can use our recognized background during the course of the
scan to calibrate the laser's angular position in relation to time.
And we don't need to know all of this other information during the
scan, which means we can remove the poles from the set during the
scan.
