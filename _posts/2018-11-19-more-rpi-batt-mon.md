---
layout: post
title: More info on Raspberry Pi battery power monitoring
author: quorten
date: 2018-11-19 13:54 -0600
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Still wondering about battery monitoring in a Raspberry Pi?  Yes, I'm
still wondering about that.  Sure, there is that VBAT pin or whatever
on the Broadcom BCM microcontroller that the Raspberry Pi uses, and
purportedly that is for the microcontroller to measure the battery
level, but for now, let's assume that software access and control to
that pin is off limits on the Raspberry Pi.  If so, your only next
best option is to set up your own circuit and software on the GPIO
pins.  Use a power management integrated circuit (PMIC) is another
option.

20181119/DuckDuckGo raspberry pi battery voltage monitoring  
20181119/https://github.com/kmcallister/rpi-battery-monitor  
20181119/https://raspi.tv/2013/controlled-shutdown-duration-test-of-pi-model-a-with-2-cell-lipo  

UPDATE: VBAT looks to be a voltage supply pin, not a measurement pin.
Also, it is only directly accessible on the Raspberry Pi compute
module.

20181119/DuckDuckGo raspberry pi VBAT  
20181119/https://www.raspberrypi.org/forums/viewtopic.php?p=707418
