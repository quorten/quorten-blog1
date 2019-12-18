---
layout: post
title: SPI is faster than I2C
date: 2019-12-17 03:22 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

What is the purpose of using SPI versus I2C?  The most compelling
reason to use SPI in place of I2C is that you get faster serial
communications speeds, and full duplex at that.  The faster speeds are
particularly useful for driving graphical displays.  A bus clock speed
measuring up to a few (3) megahertz can easily drive a 640 x 480 x 8
display... with one refresh per second.  With bus speed as the
bottleneck, you can trade for high refresh rates at the expense of
lower resolution and color depth.

20191217/https://en.wikipedia.org/wiki/Serial_Peripheral_Interface
