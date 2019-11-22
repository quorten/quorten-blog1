---
layout: post
title: "Why Raspberry Pi production capacity is so low, info on AA
        battery power and camera"
date: 2016-06-03 21:00 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, now time to search for some information on the Raspberry Pi
Zero.  What's up with it?  Why is the production supply so low?
Here's the answer: Raspberry Pi Foundation did not want to scale up
the factory floor space required to keep up with the demand for
Raspberry Pi Zeros, as it would have competed with their
more-expensive Raspberry Pi 3 model's factory floor space, right at
the point in time when they were preparing to deliver their new model
in February.

However, at least one good thing came out of this delay.  During the
hiatus, engineer was able to use the spare time to design in the
much-asked-for Raspberry Pi camera connector.

DuckDuckGo raspberry pi zero production availability factory

20160603/https://www.raspberrypi.org/

* Again, I reiterate, because this is important!  I searched for this
  and found it, that means it's important!  The following article
  shows a photo of a Raspberry Pi Zero being powered by three AA
  lithium batteries.  So indeed, it is definitely possible to use
  three batteries to power a Raspberry Pi, although you might be safer
  if you use 4 and the buck/boost switched-mode power supply.

<!-- more -->

20160603/https://www.raspberrypi.org/blog/zero-grows-camera-connector/  
20160603/https://www.raspberrypi.org/blog/raspberry-pi-3-on-sale/  
20160603/https://www.raspberrypi.org/blog/holopainting/  
20160603/https://en.wikipedia.org/wiki/Light_painting  
20160603/https://www.raspberrypi.org/blog/camera-board-comparisons-pi-noir-v1-vs-pi-noir-v2/

Oh yeah, I also have to note.  One major caveat with the Raspberry Pi
camera.  The camera has an adjustable focusing lens; however, it is
glued to the infinite focus position by default, so closer objects
will tend to be out of focus.

Oh, very important comment:

> This is after all intended for experimentation and tinkering and it
> is not like you are going to destroy a £10K professional lens and
> camera system. All I can say is that the £10K cameras do not produce
> images that are £10K significantly better than the RasPi.

So, after all, it turns out that it doesn't make economic sense to buy
those DSLR cameras when there are cheaper solutions available, with
the exceptiono of the high-quality lens.

Yes, this time I succumbed to including Unicode characters in my
quote.

20160603/https://www.raspberrypi.org/blog/whats-that-blue-thing-doing-here/

More links on the Raspberry Pi Zero.

20160603/https://www.raspberrypi.org/products/pi-zero/  
20160603/https://www.raspberrypi.org/magpi/new-pi-zero-now-with-added-camera-port/

Okay, so this kind of introduces a problem, here.  The Raspberry Pi
Zero is apparently just one model, well, the Raspberry Pi Zero.  But
based off of the manufacturing run you buy, you may end up getting
something slightly different.  In one case, you get a fine pitch
connector for the Raspberry Pi Camera, but in another case, you don't.
Version 1.3 is apparently the quantifying information for the latest
model of Raspberry Pi Zero that has the fine pitch connector for the
Raspberry Pi camera.  Oh yeah, indeed, the cost of the Raspberry Pi
camera in US Dollars is $25.
