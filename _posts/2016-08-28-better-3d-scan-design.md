---
layout: post
title: Better ideas for 3D scanner deisgn
date: 2016-08-28 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

Better design for 3D scanner.  Okay, so you were noting that we have
this problem where you want to be able to scan using a light source
that doesn't give you exactly a straight line.  This is in fact a very
good problem to solve, because in theory, even projection displays
don't give you a perfectly square picture either.  So how do you do
this?  First of all, you need a sensor calibration stage.  First you
have to calibrate your camera's angles (obviously), then you have to
calibrate you line generator source.  You do this using your camera
and a flat sheet of paper.  A first assumption that is very important.
Your line generator or light source has to shine from a small object
that can be considered a point light source.  This makes subsequent
calculations much easier.  And in fact, when you think about digital
projection displays, this same principle applies to then just like it
applies to laser line generatiors.

So, you have a flat white surface that you know exactly where it is
located and therefore know its exact 3D geometry, you shine your light
source on it, which is situated at a known location and known angle,
and you photograph the result.  This allows you to turn that laser
light source into a series of straight lines that emanate from your
point light source.  Then, during 3D scanning, provided that you know
the position and angle of your light source, you can solve for more
accurate point positions based off of the light intersections.  But
still, it is helpful if your light source is approximately a
line/plane, for the purpose of simplifying the computations.

<!-- more -->

Now, there are also a few other guidelines that I must recommend for
the 3D scanning process.  First of all, one thing that makes 3D
scanning dramatically simpler is to limit the number of different
camera angles that you use during the scanning.  Look at things this
way.  Let's consider the extreme where you allow only one camera
angle.  You know the problem you've raised ealier?  Yes, when you scan
over the same surface twice, how do you know which points to replacte?
How do you even know that such points correspond to the same
"surface"?  With a single camera angle, the answer is simple: if the
point occupies the same 2D position in the camera image, it is the
same surface point.  The laser light is then just used to figure out
the depth of the selected point in question.  A single camera angle
also makes for very straightforward connection of mesh points: just
connect spatial neighbors in the camera image.

Given the above statement for the purpose of the laser light, it is
best for the laser light and camera to form a right triangle at the
intersection on the object surface, as you already know the X and Y
information from the camera image, the purpose of the laser light is
only to get the Z information.  So, that answers your question about
what angle is the ideal angle for the laser and the camera.

Now, this raises another issue.  What about the angle of the laser
light and the object surface?  If the angle the laser strikes the
object surface is too steep, the light will be too dim and thus will
be too hard to register in the camera image.

Finally, using a single camera angle and moving the laser line source
allows for easy application of the phase shift method to get higher
resolution scans than the stripe width.

Using a small number of camera angles still leaves for the need to
stitch together the results of the scans.  Specifically, there needs
to be tie-breaking algorithms to patch together the pieces.  This
seems to be best done by ranking scan points by a quality factor, then
choosing only the highest quality points at the boundaries.  If there
are any further gaps, manual human intervention may be necessary, but
at least this will be much easier and faster than manual human
intervention for the entire modeling process, and there will already
be an outline for a human to trace over, which is much simpler than
creating the entire geometry from a blank slate.

Oh yeah, and what about the software that users use to conduct the
scanning?  How are they going to remember all the calibration steps
that they have to go through?  Are they going to read the
documentation?  Well, this is where it is helpful to encode the steps
in software through a wizard.  Like I was saying, the fastest way to
train someone into a new business process is to deploy software to
them that enforces that process.  Otherwise, people are going to have
much more inertia with adopting new business processes.

Or, even better, use bots!  Next-generation style, ones that control
advanced user interfaces.
