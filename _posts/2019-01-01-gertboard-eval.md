---
layout: post
title: Evaluation of the Gertboard
date: 2019-01-01 17:55 -0600
author: quorten
categories: [raspberry-pi, 3d-scanning, 3d-scanner]
tags: [raspberry-pi, 3d-scanning, 3d-scanner]
---

So, now that I am getting underway with learning more about
electronics and Raspberry Pi, it is clear that I need to not be so
hyper-focused on building the final "project" based off of the minimal
specifications and requirements of it, but to also have some leeway of
some kits that integrate many useful components together that I can
experiment with and learn from.

Also, I might just happpen to find a board that does exactly what I
want it to do for my 3D scanning project.  However, I must
re-emphasize that many of the reasons I am going on technically extra
Raspberry Pi excursions is simply to learn more about electronics
hardware for my own sake.  For example, I don't _need_ a 4-digit,
7-segment LCD screen and 16-key matrix keyboard for a 3D scanner.
However, I do need that kind of interface for other interesting and
related electronics projects, some of which _are_ related to spatial
measurement, although not in a direct 3D scanning sense.

Anyways, the Gertboard is purportedly a good place to start looking if
you want an easy way to experiment with different ways to interface
external devices with the Raspberry Pi via the GPIO pins.  So, let's
take a look at features and functions it provides.

20181230/DuckDuckGo gertboard  
20181230/https://www.sparkfun.com/products/retired/11773  
20181230/https://projects.drogon.net/raspberry-pi/gertboard/  
20181230/http://www.farnell.com/datasheets/1683444.pdf

I'll summarize the strengths/weaknesses here:

<!-- more -->

* It shows an example of "buffered I/O."  Don't get too eager,
  these are 1-bit buffers in question on the I/O pins.

* The documentation has some good recommendations of resistors to put
  on the GPIO pins simply for the sake of protecting your Raspberry Pi
  in case you miswire outputs with inputs.

* The board showcases how to use a rather direct link to an AVR series
  ATmega microcontroller, without going through the hoops of a full
  Arduino board.

* Unfortunately, the board can only control one motor, and it's for
  relatively high-voltage motors at that.

So, alas, I conclude that the _documentation_ for the Gertboard is
extremely useful and helpful, but the Gertboard itself may not be so
valuable for the average hobbyist.  Matter of fact, this may be the
reason why it is discontinued from Sparkfun.
