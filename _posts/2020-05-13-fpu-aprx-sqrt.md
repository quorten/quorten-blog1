---
layout: post
title: Fast approximate inverse square root for floating point
date: 2020-05-13 12:51 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

Wow, now this is an interesting find.  Are there methods to doing an
approximate square root in floating point?  Yes, it would merely be a
modification of the method to do an approximate inverse square root in
floating point.  Indeed, the method does use the trick I've been
using, base 2 logarithms are the key for the first approximation.
With floating point, it's merely a shift right on the integer
interpretation of the bits.  This manipulates the exponent fairly
cleanly but turns the significand/mantissa into garbage.  So then, it
goes further and uses one iteration of Newton's method to obtain a
better approximation.

However, please note that on modern hardware, there are direct
instructions for computing square roots and inverse square roots with
floating point numbers.  Because they are so fast... purportedly it's
not necessary to provide approximate variations. from an instruction
set architecture standpoint.  The approximate method in software was
only fast for a short period of time when CPUs lacked the instruction.

20200513/DuckDuckGo floating point approximate square root  
20200513/https://en.wikipedia.org/wiki/Fast_inverse_square_root
