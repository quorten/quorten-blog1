---
layout: post
title: "Raspberry Pi maximum voltage and TVS diode voltage regulator"
date: 2020-03-22 16:45 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

What is the maximum input voltage that Raspberry Pi can handle?
5.25 V is what is claimed to be the maximum.  Beyond that, damage can
result to your Raspberry Pi.  Unless you have a Raspberry Pi 3, then
it handles this in an interesting way... there is a TVS diode that
will short if there is an overvoltage, and that will cause a high
current that will trip the polyfuse, thereby preventing any damage
from the overvoltage.

20200322/DuckDuckGo raspberry pi 5.2 maximum voltage  
20200322/https://lb.raspberrypi.org/forums/viewtopic.php?p=1604897

So, what is a TVS diode?  Ah, yes, the missing link that I was merely
hinting at in my summary of protective circuits.  Yes, indeed this is
the missing link... if you want a semiconductor diode voltage
regulator to provide a barrier against higher voltages in your
circuit, but you want something that can specifically tolerate higher
voltage transient spikes, a TVS diode will do that.  Also, note that a
TVS diode can double as a typical Schottky diode to protect against
polarity inversion.

20200322/https://en.wikipedia.org/wiki/Transient-voltage-suppression_diode

Also related is a "crowbar device."  Unlike a TVS diode that
dissipates all access energy as heat from itself, a crowbar device
creates a short circuit path for the excess current to flow through.
