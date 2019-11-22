---
layout: post
title: Research paper and info on 3D scanners
date: 2016-07-03 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

This is an interesting paper on laser triangulation sensors.  However,
it appears to be old and may be a little bit outdated.

20160703/https://www.ogpnet.com/Assets/uploads/files/OGP/TriangulationSensors.pdf

One thing particular about this research paper is that it comments a
lot on 3D scanners that use a position sensitive device (PSD) for the
image sensor.

So, are these position-sensitive devices 1D only and must they be
lined up in an array to sense an image?  Well, let's see what
Wikipedia has to say.  Wikipedia has some information on this, but
it's not very interesting.

* Particularly, it became apparent to me that you could use a PSD
  sensitive to infrared light as the trackpad on a laptop computer.

20170319/https://en.wikipedia.org/wiki/Position_sensitive_device

So, it turns out that there are actually 2D position-sensitive
devices.  So, no need to build an array if you are only using a
point-laser light source, which is what the paper appears to describe
is recommended for such 3D scanners.

Also, the paper notes that a small spot size is needed for good
resolution on such devices since they are threshold-driven.  Note that
this is rather different than the requirement.

<!-- more -->

So, if you do want to do swept-line laser triangulation using such a
device, it has to be done using an array of 1D position sensitive
devices.  Otherwise, the PSD will get confused.  And, even then, this
can only be done under certain conditions when the laser line appears
in the correct direction so that there is only one dot apparent on
each 1D PSD.  Even then, you still won't get as good image quality as
the 3D scanner is threshold-driven.  So yes, you know what the
Stanford Computer Graphics Lab research paper was saying about that?
It results in poor quality 3D scans with various aliasing artifacts
due to material property variations.

Wheras, in the case of CCD/CMOS image sensor based devices, you can
use phase-shift profiliometry.  This allows you to not only get better
results, but it allows you to get results limited by the resolution of
the imaging device, not that of the laser line thickness.  Also, even
without perfectly thin laser lines, you can still get better results
due to the use of multisampling for each single point in the picture.

To summarize, although at first, it may appear that the CCD/CMOS
method is inferior, it turns out that there are lots of advantages of
using the particular method, not just in level of detail but also in
ease of use by being able to use a laser line rather than a laser dot.
In the end, the cheaper solution using commodity image sensors
actually gives better results.
