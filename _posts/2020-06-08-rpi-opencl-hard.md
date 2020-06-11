---
layout: post
title: OpenCL on Raspberry Pi is hard
date: 2020-06-08 16:07 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

OpenCL on Raspberry Pi, it should be easy because of the VidCore IV
GPU, right?  Wrong.  Apparently, for years, there was no official
software support, and only recently are we seeing some in-development
libraries crop up.  Use `VC4CL` to get real code running on the GPU,
there is another OpenCL library `` that simply so that you can write
"native kernels" in OpenCL that are pretty much worthless since they
run on the CPU.

20200608/DuckDuckGo install opencl raspbian  
20200608/https://github.com/doe300/VC4CL  
20200608/https://github.com/pocl/pocl

Unfortunately, Raspberry Pi 4 is not supported by this software
because of the newer VidCore GPU it uses.  So, that's a real bummer if
you're hoping to do OpenCL on a Raspberry Pi 4.

Also, this is another little bit of a bummer, VidCore IV is a SIMD
GPU, not a SIMT GPU like those of Nvidia fame.  But, you get what you
get.  Better than nothing, that's for sure.

OpenCL 1.2, embedded profile is the limit of support for OpenCL on
Raspberry Pi.  Sure, it leaves features to be wished, but again,
anything is better than nothing.
