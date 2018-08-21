---
layout: post
title: USB to parallel port adapters
author: quorten
date: 2018-08-20 1:04 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Short answer: They can't exist, the USB protocol makes them physically
impossible relative to their performance requirements.

Long answer: At one point in the historic past, in the year 2010,
there was a bit of a heyday of Windows driver development to
approximate the kind of direct hardware control of a USB-connected
parallel port that you'd otherwise be able to get from a directly
connected port.  The critical problem remaining was that IN
instructions to the parallel port were significantly slow due to USB
protocol limitations.  Given that issue, the primary recommendation
remained with buying a PCI connected parallel port interface card if
you really needed parallel port access.

That being said, if you are interested in parallel port control over
the Raspberry Pi, that would mean that you do something over the GPIO,
I2C, or SPI buses, **not** the USB bus.

20180820/DuckDuckGo linux full usb emulation parallel port adapter  
20180820/https://stackoverflow.com/questions/4217352/can-i-access-the-parallel-port-normally-when-using-usb-to-parallel-port-adapter#4218431  
20180820/http://web.archive.org/web/20151004081304/https://www-user.tu-chemnitz.de/~ygu/bastelecke/PC/USB2LPT/index.en.htm

Finally, last note.  If all you care about is accessing printers over
the parallel port, there are many adapters that can do that just fine.
But, if you want to do more advanced things like control a JTAG
programmer, then you better look elsewhere, my primary recommendation
being to look toward using the Raspberry Pi GPIO pins in today's
world.
