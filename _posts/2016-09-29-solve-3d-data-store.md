---
layout: post
title: Solutions to 3D data storage problem
date: 2016-09-29 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

3D scanner notes continued.  Okay, after some long and careful
thought, I came to some very interesting solutions for the 3D data
storage problem.

First of all, let me remind you of the conventional method.  The
conventional method of 3D data storage is to store a mesh as a list of
points and a list of point indices defining the triangles that connect
them.

However, I've found an alternative method that is not only easier to
store via analog means, but also is more intuitive to someone who is
not experienced in 3D computer graphics, but is experienced in the
current state-of-the-art of "non-technical" or "basic" computer use.

In short, we define a 3D model using a series of 2D images.

The most important 2D images for the definition of the 3D geometry are
the _depth maps_.  These are basically 2D images where the color of
each pixel defines the distance of a point from the camera, in some
sort of way.  Note at this point that I am thinking of at least two
different ways to define this.

So anyways, you can also store some _metadata_ in addition to that
image recording various parameters like focal length, camera position,
and camera angle.  You see, it is very easy to print out such data,
and it may also be possible to perform lossless digital scanning and
printing of such data, so it works as both a data storage format and
an archival format.

<!-- more -->

Okay, so here's how things go.  Note that there are many image
processing properties that are simplified in the case of spatial
geometric data compared to color image data.  Let's start with how to
build a mesh from only a single depth map.  This is easy.  First you
start with "edge detection."  An edge is by definition a boundary
between two adjacent pixels that exceeds threshold value.  With color
images, image noise makes this process more complicated, as you may
have a logical object with some bright and dark spots in the middle,
but with depth maps, that cannot happen.  Points have to be spatially
adjacent to each other in order for them to define logically part of a
continuous surface that is within the measurement resolution of the
sensor system, so you can just use simple absolute thresholding here
to detect the edges.  Once you've identified the edges, all other
pixels form continuous surfaces and can therefore be connected
directly to each other in the 3D polygon mesh.

Then, with enough such images and their positional data, you can lay
them all out in a single 3D space and "stich" them together like you
would a 2D panorama image.  Here, you'll need to use various
algorithms to determine which surfaces to include and exclude, namely
when you have conflicting points, you want to choose only the highest
quality scan points as the tie-breaker, and then when there are no
other tie breakers left, you use conventional tie-breaking mechanisms
such as first-scanned point, last-scanned point, blend, or some other
user manual intervention.  Finally, you can store such
parameterization to recreate a series of 2D images that can completely
automatically be turned into a single 3D model.

Cool!  And it turns out that with today's conventional data storage
technologies, all of those techniques can be cleanly contained as a
mapping reduction within the current state-of-the-art of standardized
mass-market storage formats such as PDF and printed paper sources.

Now, you may be thinking, "Yeah, that works and all, but can't you
make a 3D system that uses binocular vision just like the human visual
system?"  Yes, you can, but you see, we all know that the human visual
system is not remotely similar to our photographic technologies and
storage systems.  You see, the big difference between human memory and
photographs are that photographs provide an exact recording of sensor
values of the real world, whereas human memory goes through this
finicky recording process that may produce erroneous results.  The
same is true with human binocular vision.  With optical binocular
vision, you actually don't know _for sure_ the distance of certain
points because the most important step in making such a system work is
to **guess** which points in the left image match with points in the
right image.  You see, right there, that's where you are breaking the
rules of recording only "known sensor values" from photographic input
sources.  Furthermore, it is sometimes not possible to extract any
depth perception information if the colors are too similar within an
image region.  So, although such a vision system can work some of the
time, it is far from a uncompromised photographic recording of the
real world.

Hence, only the real-world measurement techniques presented below are
to be used for depth mapping of objects.  Note that these techniques
come with caveats too, but their caveats are not as great as those of
optical binocular vision systems for depth perception.

----------

Also note.  Medical imaging uses very dense 3D image maps.  One way to
store this would be to use one sheet of paper as a slice in the 3D
data.  Yes, conceptually easy, but such a method consumes a
prohibitive amount of material and space for storage.

So, you see, what's going on here with this 3D storage technique.
We're not trying to store all available 3D data.  Clearly doing so
would be prohibitive in storage requirements using traditional paper,
but I demonstrate this technique to show that indeed, for typical 3D
scans and 3D models of objects, there exists a readily straightforward
way to export the data to printed paper documents, then import it back
into a computer system.  This is important because computer systems
tend to be finicky with lots of upgrades and incompatibility as an
older generation of technology becomes obsolete and is no longer
supported by the newer generation of technology.
