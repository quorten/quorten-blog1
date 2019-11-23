---
layout: post
title: "\"Synthetic aperture\" and 3D scanning"
date: 2018-03-04 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

"Synthetic aperture" you ask?  Yeah, that's what people are trying to
do with modern smartphone cameras to reduce the size, but they are
using different terms like "light field."  Synthetic aperture is not a
new idea, and the terminology has been used with radar for many years.

20180304/https://en.wikipedia.org/wiki/Synthetic-aperture_radar  
20180304/https://en.wikipedia.org/wiki/Aperture_synthesis  
20180304/https://en.wikipedia.org/wiki/Synthetic_aperture_sonar  
20180304/https://en.wikipedia.org/wiki/Synthetic_Aperture_Ultrasound  
20180304/https://en.wikipedia.org/wiki/Synthetically_thinned_aperture_radar  
20180304/https://en.wikipedia.org/wiki/Beamforming

----------

The best is by far the swept line methods in terms of noise.  You can
do swept line with either a laser module or a video projector.  The
video projector method is faster, but the laser method is cheaper.

There is also another video projector method where you shine a series
of varying bar width patterns, one after another, which gives each
"pixel" a binary code.  Two cameras measure the same object, and that
creates images where you can cast rays with common binary codes.  The
nearest points on those rays will give you a 3D point.  This method is
very sensitive to noise because one uncertain time value can
completely throw off your binary code.  Suffice it to say, it is not
recommended from a quality standpoint, not to mention that the cost of
such a method is higher too.

<!-- more -->

* Again, I reiterate.  All processes are the same in this regard.  You
  start by collecting some sort of raw sensor data, then you decode
  the sensor data to get the 3D data format.

* Additionally, most structured light 3D scanners suffer from another
  artifact reducing scan quality: secondary bounce light.  The
  algorithms are designed to assume that only direct lighting from the
  structured light source illuminates the material.  Secondary
  lighting from interreflections on the material effectively degrade
  the accuracy of the structured light methods.

    * These light artifacts mostly degrade the quality of scanning
      highly rough surfaces, but they do not significantly affect the
      quality of smooth surfaces, relative to the size of the laser.

    * Laser interferometry, which measures by detecting phase shift
      patterns, may be different in this regard, but it is
      prohibitively expensive and typically only used by scientific
      researchers, not by engineers or artists.  Now, as you
      understand, that's a euphemism for saying that the technology is
      not very widely used, period.  In other words, a "commercial
      failure" from a commercial standpoint.

----------

So, you were wondering about the accuracy of optical angle measurement
compared to a manual or electronic device?  What kind of accuracy do
you really get from an HD video camera?  Assuming the video camera
field of view is 90 degrees, the angular width of a pixel is 0.09
degrees.  Because in practice we cannot measure angles accurate to a
single pixel, we round up to two pixels, effectively doubling the
angular width to 0.18 degrees.  Finally, we can be pessimistic and
round up further to 0.5 degrees, because we might need space to
identify a barcode pattern.  So there you have it.  You've been told
that the turntable mechanism in FabScan is accurate to about half a
degree, so optical measurement gets you that same angular accuracy,
but at a lower cost because you do not need to buy your turntable
devices.  Yep, optical measurement is definitely the way to go, don't
take second place with a manual paper/cardboard turntable with reading
angles off of a compass.
