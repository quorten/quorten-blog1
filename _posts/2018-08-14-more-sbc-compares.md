---
layout: post
title: Still more comparisons on single-board computers
author: quorten
date: 2018-08-14 21:49 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So now I'm reading up on getting the ODROID-C2... and upon a revist to
Raspberry Pi, I've found out there was a new model of Raspberry Pi
with a lot of competitive features... Raspberry Pi Model 3B+.  Almost
all the missing features you could have longed for from the previous
Raspberry Pi models.

* Power over Ethernet (via additional HAT)
* USB boot
* Network Boot
* SD card no longer required to boot

20180814/https://en.wikipedia.org/wiki/Raspberry_Pi  
20180814/https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/

Also intersting is that.nowadays Raspberry Pi has an official power
supply.  However, I wouldn't recommend it simply due to its size,
which means surely it must not be as efficient as the mass market
smartphone power supplies.

20180814/https://www.raspberrypi.org/products/raspberry-pi-universal-power-supply/

So how to you setup network boot?  You have to write a value to
one-time programmable memory: Network boot is disabled by default.  So
once you enable it, you cannot disable it.

20180814/https://www.raspberrypi.org/documentation/hardware/raspberrypi/bootmodes/net_tutorial.md

<!-- more -->

So the ODROID-C2, is it obsolete?  Well, looks like it.  Raspberry Pi
Model 3B+ has faster Gigabit Ethernet than ODROID-C2, though the CPU
is still slower.  Also, Raspberry Pi Model 3B+ looks like it might
demand a little bit more power from its power supply: 2.5A is
recommended over 2A.

But that's not all.  In the meantime, yet another powerful competitor
board has come out, Asus Tinker Board.  Alas, the main problem with
this board, at least for my concerns, is that it consumes too much
energy to get that compute power.  So it's a no-go.

20180814/https://en.wikipedia.org/wiki/Asus_Tinker_Board
20180814/https://www.amazon.com/Tinker-Board-Quad-Core-connectivity-Motherboards/dp/B00FS83U42/ref=sr_1_3?ie=UTF8&qid=1534301016&sr=8-3&keywords=ASUS+Tinker+Board

Okay, now let's take a careful look at power consumption.

20180814/DuckDuckGo raspberry pi 3 use 2a power supply  
20180814/https://www.wirelesshack.org/what-is-a-good-power-supply-for-the-raspberry-pi-3.html  
20180814/https://raspi.tv/2018/how-much-power-does-raspberry-pi-3b-use-power-measurements

Verdict: I think Raspberry Pi 3B+ consumes too much power for my
taste, and unfortunately this is probably due to the Gigabit Ethernet
adapter having a higher idle power consumption than the older, slower
100 Mbps adapters.  With that in mind, I would go for a slower
Ethernet interface.  Finally, the question comes down to this:
Raspberry Pi Zero with USB Ethernet adapter or Raspberry Pi B+?  I
think there may be wasted power overhead if you use a physically
separate adapter compared to the one built onto the board.  Besides,
both adapters connect via USB, so you might as well go for the more
efficient out of the two.
