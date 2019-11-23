---
layout: post
title: Mask ROM and PROM
date: 2019-11-22 21:06 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Mask ROM?  Mask ROM is the type of ROM that requires sending a custom
mask to the manufacturer to make.  It is the most expensive type, but
also has the highest storage density and is highly durable, aspired
for the possibility of high-density durable archiving but out of reach
simply due to the costs.

20191122/https://en.wikipedia.org/wiki/Mask_ROM

PROM is the much more practical alternative for conventional use, if
you need true read-only memory.  Writing out a PROM is quite easy, use
a 6 V pulse to burn away a gate to convert the default "1" to a "0".
Not much different than programming EPROM at 12 V.

20191122/https://en.wikipedia.org/wiki/Programmable_read-only_memory  
20191122/https://en.wikipedia.org/wiki/EPROM

**Note** that some EPROM chips can run off of a lower voltage when
programming.  See my [old blog post]({{ site.baseurl
}}/blog/2017/03/05/pull-up-down-gpio-1-wire) for an example of such a
chip.
