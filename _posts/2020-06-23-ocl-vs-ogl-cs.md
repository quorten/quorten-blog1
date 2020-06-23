---
layout: post
title: OpenCL versus OpenGL compute shaders
date: 2020-06-23 16:54 -0500
author: quorten
categories: [unlipic, media-prog]
tags: [unlipic, media-prog]
---

When OpenCL is not available on Raspberry Pi 4, you can use OpenGL 3.0
ES compute shaders instead.  Yeah, sure.  But, driver issues aside,
what really is the difference between OpenCL and OpenGL compute
shaders?  Mainly, the purpose of using OpenGL compute shaders is to
integrate general purpose GPU compute into an existing, predominantly
graphics application.  OpenGL compute shaders have easier access to
OpenGL state, but OpenCL needs state synchronization primitives and
such.

Also, I found a little bit of useful information about how to use
OpenGL compute shaders.

20200623/DuckDuckGo opengl compute shader  
20200623/https://www.khronos.org/opengl/wiki/Compute_Shader  
20200623/DuckDuckGo compute shaders versus opencl  
20200623/https://stackoverflow.com/questions/15868498/what-is-the-difference-between-opencl-and-opengls-compute-shader
