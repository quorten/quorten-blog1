---
layout: post
title: Choice of 3D scanning technology continued
date: 2016-12-15 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

Choice of technology continued.  Photogrammetry provides a practical
way to make 3D scans of landscapes and other large objects where it is
impractical to project structured light onto the surface.

* Like Mount Chiginaugua.

Alternatively, structured light can be used to assist in scanning
objects that do not have enough texture of their own for
photogrammetry.

Also, another technique with similar characteristics is depth-of-field
3D scanning, using the contrast of a large depth-of-field lens to
compute depth.  However, this is another technique that requires
surface texture in order to work well, so the same rule applies with
structured light.

----------

Another idea for 3D scanning.  Rather than sweeping a laser across an
object, you entirely use contrast thresholding and sweeping the camera
focus with a narrow depth-of-field lens to determine depth.
Advantage: faster photography is possible with a wider aperture, and
there is better noise stabilization in the recorded images.
Disadvantage: it might not be possible to increment the focus of your
camera lens in as small increments as are the case with a low-cost,
continuous sweep DC motor.

Again, note that you may need to project a light pattern onto your
object in order to get sufficient surface texture.

<!-- more -->

----------

Okay, wait.  For 3D scanning via laser triangulation, in order to
obtain good results fast, you're going to want to be able to take
single photographs with the entire object in complete focus.  That
means that you need a small aperture size.  Hey, and guess what?
Smartphone cameras already come in a small aperture size.  Does that
mean that the extra sensor area of a DSLR camera is not needed.  I'm
wondering what the difference is between sensor size is with identical
aperture size.  Let's see if I can find good information about this
on the Internet.  Indeed I can, just not so much on Wikipedia.  For
starters, that is.

20161215/DuckDuckGo small aperture dslr versus smartphone camera

Why aperture matters on your smartphone camera

20161215/http://newatlas.com/smartphone-camera-aperture/42524/

Camera sensor size: Why does it matter and exactly how big are they?

20161215/http://newatlas.com/camera-sensor-size-guide/26684/

Okay, so here's the thing.  Apparently, larger sensor size can get a
lower noise floor even with the same aperture size.  BUT, more
importantly, from reading the first article, it appears that DSLR
camera sensors simply have more advanced electronics in the
fundamental characteristics.  In particular, they can take photos at
much faster ISO film speeds than are the case with compact smartphone
image sensors, which, in comparison, are distinctively limited in
their available parametrization.

SOoo, the point I wanted to make was that in theory, as low-cost
small-aperture smartphone camera sensors improve, it should be
entirely possible to take excellent quality 3D scans using those
low-cost sensors.  In the mean time, however, if you want additional
sensor quality characteristics, you'll more likely find those in a
DSLR camera.

----------

Okay, I've got to make this point absolutely clear with a good
explanation.  Why do you want to orient your laser line vertically?
Well, here's the point.  If you place your laser module and your
camera with horizontal adjacency, and the laser line shines completely
level at one point, you won't be able to extract any depth information
from such an image, and that would effectively correspond to wasted
time.  Also, the frames just around that particular frame will have
less precision in their depth information.  But, when the alignment of
the camera, laser module, and laser line are perpendicular to each
other, there is never such a frame where that is an issue.  So, that's
the reason why you need that camera alignment.
