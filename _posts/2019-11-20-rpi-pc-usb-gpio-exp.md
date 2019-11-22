---
layout: post
title: "Raspberry Pi Zero PC USB GPIO expander, old distributors
        expansion news"
date: 2019-11-20 23:05 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Wow, this is interesting.  The idea of boot from USB and USB gadgets?
That has been expanded to create a Raspberry Pi Zero that can be used
as a USB attached GPIO expander for the Raspberry Pi Debian x86 PC
distribution.  How do they do this?  With power of udev... ugh, that
sounds like a very ephemeral and brittle solution that is going to
break at the earliest moment that a incompatible change allows it to.
Yeah, it's an interesting demo short-term, and useful at that in so
far as the price points of Raspberry Pi Zero (and the amount of money
saved) are so low.

Also, note that the Raspberry Pi Zero uses BCM2708, not BCM2835.  Only
the Raspberry Pi Compute Modules have the newer BCM chip revisions in
them.

20191120/https://www.raspberrypi.org/blog/gpio-expander/  
20191120/https://www.raspberrypi.org/documentation/hardware/computemodule/cm-emmc-flashing.md

Also, I found this otther interesting article announcing the expansion
of Raspberry Pi Zero W distributors.  Gosh, I thought the Raspberry Pi
Zero was hard to come by inside the United States, but I've been told,
outside the United States, it is heck to get hold of a Raspberry Pi
Zero W!

20191120/https://www.raspberrypi.org/blog/pi-zero-distributors-annoucement/
