---
layout: post
title: "Lesson learned with calculating field of view of DSLR camera
        lenses"
date: 2020-09-13 20:56 -0500
author: quorten
categories: [pentax-k-1-camera, 3d-scanning, 3d-scanner]
tags: [pentax-k-1-camera, 3d-scanning, 3d-scanner]
---

Calculating the field of view of a DSLR camera lens is easy, right?
This is the formula that you can intuitively reason up on your own and
is also repeated on many different websites online.

```
f = lens focal length
h = horizontal sensor width
hfov = horizontal field of view
hfov = 2 * atan((h/2)/f)
```

But does this really work in practice?  I did some tests, and... yes
it does work, but only under specific conditions.  Namely, the focal
length specified of a lens is only effective in this equation when the
lens is at infinity focus.  Technically speaking, the distance between
the center of the lens and the center of the sensor is what truly
determines the field of view.  So, because of the fact that lens focus
on a simple prime lens is setup to move the lens further away from the
sensor to focus on close-range objects, the field of view is
effectively narrower under close-range photography conditions.  Under
extreme circumstances, this can nearly double the effective distance,
therefore approximately halving the field of view.

<!-- more -->

So, keep that in mind when doing photogrammetry.  If your camera
system doesn't have a means of sensing and digitally encoding the lens
focus setting, make sure you note this down yourself.  If the
information is not noted but you have an idea of the scale of a
close-range object being photographed, then you can use that
information as a starting guide to determine how much you should
narrow the field of view compared to the calculation from the rated
focal length.

Another point in hand.  Are you shooting with the aperture wide open
or stopped down?  If the lens build is such that only the lens moves
during focus but the aperture stays stationary, then changing the
aperture setting will change the effective field of view.  A more
stopped down aperture will end up being closer to the field of view
calculated from the rated focal length.  Most simple prime lenses have
the aperture stationary because that simplifies the lens design,
construction, and operation.
