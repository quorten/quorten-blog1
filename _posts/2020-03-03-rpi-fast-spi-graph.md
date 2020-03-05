---
layout: post
title: Faster SPI graphics displays on Raspberry Pi
date: 2020-03-03 23:39 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, when searching for information on SPI graphics displays on the
Raspberry Pi, I found this nice custom driver that allows for faster
framerates on SPI displays by sending only changed pixels rather than
doing a whole refresh.

20200303/DuckDuckGo raspberry pi spi graphics display  
20200303/https://hackaday.com/2018/10/21/blazing-fast-raspberry-pi-display-driver-will-melt-your-face-then-teach-you-how/  
20200303/https://github.com/juj/fbcp-ili9341#how-it-works

Also, the driver documentation lists the compatible display
controllers and the products that use the compatible display
controllers.  Great for making the buying decisions.

Please note that the driver custom codes directly against the
low-level BCM2835 interface the assigned SPI interface, so you may not
be able to use more than one SPI device through slave selects.  In
that case, you'll need to wire your project to use SPI0 for the
graphics display and SPI1 for all other SPI devices.
