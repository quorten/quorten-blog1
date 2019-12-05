---
layout: post
title: "What is SDXC versus UHS and why high-capacity cards typically
        aren't used with Raspberry Pi"
date: 2017-07-06 21:00 -0500
author: quorten
categories: [pentax-k-1-camera, raspberry-pi]
tags: [pentax-k-1-camera, raspberry-pi]
---

SDXC I?  What's that?  Looks like it's just UHS-I.

But, this note is particularly interesting.  The performance of
high-performance cards is generally better for sequential access and
may not provide good random access performance.  Also, some of the
slower cards may have better random access performance, making them
better for smartphones, whereas sequential access matches the pattern
commonly used by cameras and camcorders.

Well, good to know.  Good to know as to the reason why super-high
capacity cards are generally not used with Raspberry Pi.

20170706/https://en.wikipedia.org/wiki/Secure_Digital  
20170706/http://static.usenix.org/events/fast/tech/full_papers/Kim.pdf
