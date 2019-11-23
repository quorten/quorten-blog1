---
layout: post
title: Still trying to get at Minolta camera digital interface pins
date: 2018-03-18 21:30 -0600
author: quorten
categories: [minolta-cam]
tags: [minolta-cam]
---

Trying to get at that electronic interface?  Well, there's no point in
trying any harder to search the Internet for documentation on that
interface.  No, that is private knowledge only found in the heads of
camera repairpeople who have been working on that technology at the
time.  So, that problem aside, let's look toward reverse engineering
the interface.

20180318/Google reverse engineer electronic communication interface
  logic level 5 v

Oh, this is really helpful, but it only scratches the surface, with an
emphasis on modern devices.

20180318/http://resources.infosecinstitute.com/reverse-engineering-of-embedded-devices/

Not so helpful.

20180318/=https://www.element14.com/community/thread/37817/l/reverse-engineering-old-serial-devices-and-cloning-with-arduino?displayFullThread=true

<!-- more -->

Okay, so what did I find from doing my own analysis.  Put the battery
inside the camera and use a volt meter to analyze the 10 contacts
inside the film bay.  I find that all voltages are in the 4 V - 5 V
range.  Good, so we know that this interface is somewhat similar to
RS-232/RS-422 serial interfaces, at least in terms of voltage/logic
levels.  Also, we observe a similar number of pins: 10 pins is quite
similar top the 9 pin plus ground shield serial connectors.  But, the
fact that I observe a range of voltages means that these are likely
analog connections.

What's more, this is really weird.  Even after I remove the battery
from the camera, some pin pairs still have a significant voltage
reading for quite some time.  Well, there must be some pins that are
meant to measure the proportional voltage inside the flash capacitor,
I presume.  Either that, or this is simply an artifact of the general
functioning of the camera logic where the LCD screen logic still
operates for a few seconds even after the battery has been removed.
