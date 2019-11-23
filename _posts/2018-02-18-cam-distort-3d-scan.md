---
layout: post
title: Handling 3D scanning camera distortion
date: 2018-02-18 21:30 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

So, what about camera distortion?  For communicating the information
in an unambiguous manner in 2D printouts, there are a few better ways
than the raw matrix.

The first best way is to display a deformed grid.  This is readily
intuitive and obvious to a person who has worked with cameras.

The second way is to display a _normal map_.  This is readily obvious
to someone who has worked with computer graphics extensively.  Also,
this data is easier to import into your software.

Okay, great!  We have some good choices going on here for
standards-oriented data design.

* Yes, no trickery here.  Although mere angles can be indicated using
  only two angular integers, the industry standard is to use
  three-component rectangular vectors.  So, stick with that.
