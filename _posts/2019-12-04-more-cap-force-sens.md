---
layout: post
title: More information on capacitive force sensors
date: 2019-12-04 22:13 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, so I'm looking for more information on capacitive pressure,
force, or weight sensors.  The technology in its earnest is simple, so
surely there are commercial implementations with better accuracy,
aren't there?  Indeed there are, I found some designed for heavier
objects, but I have to keep searching for ones designed for small
objects.  Unfortunately, there are no capacitive force sensors on
Digi-Key, only resistive force sensors.

Also, the Dummies link has some interesting information on the various
terminology used for force-related sensors.  The very simplest is just
a button or a crude change in force sensor.

20191204/DuckDuckGo capacitive pressure force weight sensor  
20191204/https://www.dummies.com/computers/arduino/what-you-should-know-about-arduino-pressure-force-and-load-sensors/  
20191204/DuckDuckGo capacitive load sensor  
20191204/https://www.loadstarsensors.com/why-build-capacitive-load-cells.html  
20191204/https://www.loadstarsensors.com/capacitive-load-cells.html

Indeed, the same vendor has low capacity sensors too.

20191205/https://www.loadstarsensors.com/rapg-low-capacity-single-point-aluminum-load-cell.html

<!-- more -->

Actually, it's just what I need!  6 inch by 6 inch scale plate?  Wow,
that's almost large enough for a full sheet of paper.  The 100 g
sensor version with 16-bit ADC is more than sufficient for my needs
for paper scanning sheet counting, and the 16-bi ADC comes with TTL
serial output too, so interfacing with Raspberry Pi or Arduino is easy
and simple.

Also, it does note that 4 such sensors can be used to construct a
weighing platform.

But, the question.  Is that particular load cell capacitive or
resistive?  If it's resistive, well then that's basically the same as
buying off of Digi-Key as far as I am concerned, nothing to be gained
there.  The specifications appear to be indicative of the resistive
ones on Digi-Key.  Well, keep in mind its accuracy is +/- 0.1% of Full
Scale output using the 16-bit ADC.  The 24-bit ADC can get even higher
accuracy with the same sensors, so keep that in mind.  No, it
definitely can't be resistive, it has more accuracy than what Adafruit
touts for force-sensing resistors.

20191204/https://learn.adafruit.com/force-sensitive-resistor-fsr/overview
