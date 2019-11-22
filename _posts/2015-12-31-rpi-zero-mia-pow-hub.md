---
layout: post
title: Raspberry Pi Zero still sold out, powered USB hubs
date: 2015-12-31 21:00 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Well, there you go.  Raspberry Pi all sold out, still unknown when the
next batch will be available.  Oh, no, for you, both the first and
second batches are all sold out, and the third batch is still in
waiting.

20151231/http://www.christianpost.com/news/raspberry-pis-5-zero-computer-sells-out-in-24-hours-151318/  
20151231/http://www.element14.com/community/docs/DOC-79280/l/five-things-you-need-to-know-about-the-raspberry-pi-zero

How do you get a powered Raspberry Pi USB hub setup properly?  Here's
how:

20151231/http://elinux.org/RPi_Powered_USB_Hubs

Unfortunately, the hub I purchased is not listed in the article above.

Wait, though maybe the above article is outdated.  Note that
backfeeding power is no longer an issue with modern Raspberry Pis.

20151231/https://www.raspberrypi.org/forums/viewtopic.php?f=46&t=29696  
20151231/https://www.raspberrypi.org/forums/viewtopic.php?f=46&t=58452

<!-- more -->

Good news!  The "power" USB connector on the Raspberry Pi does not
transfer any data through it.  So, you can connect the "power" USB
port to a hub downstream, and even if the data pins are wired up, you
will not get any weird malfunctioning.  Actually, the data pins are in
fact necessary so that the Raspberry Pi can digitally negotiate the
correct amount of power drain.

OpenArena.  I just take note of this, maybe so that I can download the
game package in Debian?  Oh yes, of course!
