---
layout: post
title: More info on compilers
author: quorten
date: 2018-05-19 20:00 -0500
categories: [tour-de-force, unlipic]
tags: [tour-de-force, unlipic]
---

So, you're wondering what it takes to create a compiler for small
8-bit systems?  For small 8-bit systems, a mixed mode compiler is
ideal: byte code plus native machine code.  Byte code is required for
compact program representation with large amounts of source code,
whereas native machine code is required for highly optimized tight
inner loops.
