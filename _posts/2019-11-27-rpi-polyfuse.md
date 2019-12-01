---
layout: post
title: Polyfuse to use with Raspberry Pi Zero
date: 2019-11-27 01:53 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

What polyfuse should be used with Raspberry Pi Zero in a larger board
circuit?  Look to the Raspberry Pi B+ or original Raspberry Pi
schematics for guidance.  Then, you simply search around for a part
with similar specifications to use in your own circuit.  One design
note in particular, you should place the polyfuse immediately after
your power input source.  Your first isolating capacitor should come
after the polyfuse.

20191127/DuckDuckGo raspberry pi zero polyfuse  
20191127/https://raspberrypi.stackexchange.com/questions/61302/does-raspberry-pi-zero-have-a-polyfuse

In particular, the MF-MSMF200 is used on the Raspberry Pi A+, a 2 A
hold polyfuse with 4 A trip.

20191128/https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_1aplus_1p1_reduced.pdf

The original Raspberry Pi used a 750 mA hold polyfuse with 1.1 A trip.

20191128/https://elinux.org/RPi_HardwareDuckDuckGo raspberry pi polyfuse  
20191128/https://www.element14.com/community/thread/19575/l/f1f2-polyfuses-gone  
20191128/https://elinux.org/RPi_Hardware
