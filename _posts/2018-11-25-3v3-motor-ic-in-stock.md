---
layout: post
title: Looking for an actual 3.3 V motor driver IC for sale
author: quorten
date: 2018-11-25 12:13 -0600
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, yeah I've previously noted that there are 3.3 V motor driver ICs
available on the modern market, but I have not yet found an actual
module for purchase.  I've got to search out such models.

20181125/DuckDuckGo 3.3 v logic motor driver

Ah, yes, there are some modules available from Pololu that can run off
of 3.3 V logic.

20181125/https://forum.pololu.com/t/high-power-motor-drivers-for-3-3v-micros/8572

There a line of "high-power" motor drivers and another one of "simple"
motor drivers.  What makes the simple motor drivers "simple" is that
they include lots of interface options to make it easy for
inexperienced hobbyists to get something up and running quickly.
Unfortunately, those interfaces increase the cost and complexity of
the board, not to mention that they are redundant since you will only
be using one of the many interfaces available.  So, that being said,
go with the "high-power" motor driver instead of the "simple" one as
it is cheaper and more straight to the point.

20181130/https://www.pololu.com/product/2992  
20181130/https://www.pololu.com/category/94/pololu-simple-motor-controllers

<!-- more -->

Almost, but not quite.  This one requires 5 V logic too.

20181125/http://ww1.microchip.com/downloads/en/DeviceDoc/21421E.pdf

Now, here's the back story.  Recently, there has beeen a lot of good
new motor control ICs coming on the market, but all of them are
packaged as surface-mount technology (SMT).  This is one of the
reasons why some of the newer modules are more difficult to search for
and come by.

There is also a Toshiba TB6612FNG IC available that runs off of 3.3 V,
but the principal packaging is surface-mount technology (SMT).
Previously there was at least one reseller that soldered this onto a
PCB with through holes for you to mount with modular hobbyist
electronic designs, but the referenced URL is out of stock,
unfortunately.

20181125/https://www.reddit.com/r/electronics/comments/i4y6m/motor_controller_for_6v_motors_and_33v_logic/  
20181125/https://web.archive.org/web/20120129170648/http://www.solarbotics.com:80/products/50646
