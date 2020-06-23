---
layout: post
title: RPi OpenCL Compute Shaders, CLBlast
date: 2020-06-18 04:23 -0500
author: quorten
categories: [raspberry-pi, media-prog]
tags: [raspberry-pi, media-prog]
---

Wondering about the equivalent of cuBLAS for OpenCL?  CLBlast is the
nearest match, clBLAS is also available but not as performant.  The
"t" is for tuned.

20200618/https://github.com/CNugteren/CLBlast  
20200618/https://github.com/clMathLibraries/clBLAS

Vulkan is not yet available for Raspberry Pi 4, but OpenGL ES 3.1
Compute Shaders are available, so you can use this in the intermin.

20200618/https://blogs.igalia.com/itoral/2020/01/17/raspberry-pi-4-v3d-driver-gets-opengl-es-3-1-conformance/
