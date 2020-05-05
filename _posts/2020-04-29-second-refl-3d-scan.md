---
layout: post
title: Review of mitigating secondary reflections in 3D scanning
date: 2020-04-29 01:29 -0500
author: quorten
categories: [3d-scanning, 3d-scanner, reiterate]
tags: [3d-scanning, 3d-scanner, reiterate]
---

Again, I reiterate, because this is important!

One of the prime limitations of all forms of structured light 3D
scanning is that you get interference from secondary reflections.
Ideally, you want to programmatically select points on the object by
shining light onto the object's surface and only observing the results
from the first bounce of such light off the object's surface.  This is
not strictly possible in the real world; however, there are
mitigations you can take to approach this ideal.

The primary one applied universally is to powder coat the object.  The
very simplest powder coats simply assure that the object has a diffuse
surface.  By having a diffuse surface, light shined on the object can
be observed equally from all angles.  Also, although there will still
be interference from secondary reflections, it will be exponentially
reduced due to the fact that diffuse reflections scatter incident
light in all directions, hence reducing the intensity of the
reflection from every angle.

To have a more extreme exponential reduction in secondary reflections,
the powder coat can have a darker color.  For example, rather than a
white color, it can have a dark gray color.  The primary problem with
this is that you need a brighter light source to capture the same
quality of data at the same camera exposure settings, and therefore at
the same camera speed.  With lasers in particular, high power lasers
are often commercially restricted due to their inherent danger to
human eyesight, which means that simply increasing the brightness may
be impractical.

<!-- more -->

Another obvious implication, of course, is the total amount of light
you shine on your object.  The more light you shine, the more
secondary reflection there will be.  But particularly, this means that
slower forms of structured light, like scanning a single laser line
across an object, or even slower, scanning a single laser point across
an object, will suffer less from secondary reflection than faster
forms, such as using a video projector to scan a repeating pattern of
zebra stripes across the entire object's surface.
