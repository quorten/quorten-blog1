---
layout: post
title: OpenCL versus Vulkan for parallel compute API
author: quorten
date: 2018-11-21 12:20 -0600
categories: [random-software, important]
tags: [random-software, important]
---

Important!

So you're wondering about Vulkan API support for progrmaming parallel
compute code?  Well, yes, indeed Vulkan can be used to program
parallel compute code.  But, it goes further than that.  Matter of
fact, OpenCL's long-term plans are to be merged into Vulkan.  So, if
you want to program for the future, then try programming your GPGPU
compute code against Vulkan API today.  But, no worries.  If your
GPGPU code is small, simple, and easy to write, then it is also
correspondingly simple to rewrite too.  Not to mention, it appears
that OpenCL will still be around for a long while, and maybe Vulkan
API may have direct backwards compatible support for OpenCL too,
eventually.

20181121/https://en.wikipedia.org/wiki/Vulkan_(API)  
20181121/https://en.wikipedia.org/wiki/OpenCL  
20181121/https://www.pcper.com/reviews/General-Tech/Breaking-OpenCL-Merging-Roadmap-Vulkan
