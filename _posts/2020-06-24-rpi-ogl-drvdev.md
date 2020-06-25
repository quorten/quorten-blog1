---
layout: post
title: Raspberry Pi OpenGL driver development
date: 2020-06-24 00:29 -0500
author: quorten
categories: [raspberry-pi, media-prog]
tags: [raspberry-pi, media-prog]
---

This is a very insightful article on Raspberry Pi OpenGL driver
development.  Unfortunately, due to the advent of the Raspberry Pi 4
and its incompatible VidCore VI GPU, development effort has shifted
away from VidCore IV.

20200624/DuckDuckGo raspberry pi v3d mesa  
20200624/https://noise.getoto.net/2019/10/11/vc4-and-v3d-opengl-drivers-for-raspberry-pi-an-update/

But, the point of my original search I wanted to bring up.  The name
of the Mesa 3D driver is VC4 for early Raspberry Pi computers and V3D
for Raspberry Pi 4.  Remember that.  And remember, unfortunately, you
cannot run both OpenCL and OpenGL at the same time on the older
Raspberry Pi computers.  Yep... so if you want software that lets you
use both at once, you have to use Raspberry Pi 4, simply because
software for the alternative path hasn't been developed and it looks
like there might not be enough momentum to develop it.

In the meantime, you must use OpenGL ES 3.1 compute shaders on
Raspberry Pi 4, Vulkan is still in development and a few months out.
