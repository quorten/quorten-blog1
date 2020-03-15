---
layout: post
title: "More info on AWG wire ratings, USB, telephone, and Ethernet
        cables"
date: 2020-03-07 12:47 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, okay, so the question keeps coming up.  What is the typical AWG
used in the wires of USB cables?  If I had to guess by looking at a
USB cable for a mouse, I'd say 26 AWG.

But, according to these StackOverflow answers, most USB cables use 26
AWG or 26 AWG wire for the power pair.  Okay, so I'm pretty much good
on that one.

20200307/DuckDuckGo usb cable awg  
20200307/https://electronics.stackexchange.com/questions/361321/awg-for-connecting-a-usb

But the other subject brought up.  What is the typical AWG of Ethernet
and telephone wire?  22 AWG to 26 AWG is typical.

Also, here's another good point.  According to these answers, 24 AWG
wire can handle up to 2 A.  That doesn't quite cope with one of my
previous statements...

20200307/https://www.engineeringtoolbox.com/wire-gauges-d_419.html

<!-- more -->

But there's also another point... you still get voltage sag across
long distances, especially when there is a high current draw.  So you
might opt to use 22 AWG wire to cope with this.  But there's still
another point.  If you use this not just on power but on data too, you
introduce another problem that you change the characteristic impedance
of the cable, and that's not good for long distance communications.

The Adafruit USB power supply for Raspberry Pi uses 20 AWG wire.

20200307/https://www.adafruit.com/product/1995

How do you compute the characteristic impedance of the wires you use?
It depends not just on the AWG and dielectric constant of the wire,
but also the wire spacing and twisting.

20200307/DuckDuckGo awg characteristic impedance  
20200307/https://www.allaboutcircuits.com/tools/twisted-pair-impedance-calculator/
