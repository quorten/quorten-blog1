---
layout: post
title: "Raspberry Pi 4 booting, Pi4 PXE boot, and Raspberry Pi HAT ID
        EEPROMs"
date: 2020-08-21 21:05 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Oh, interesting.  Bootcode that was ROM in previous Raspberry Pi
models is now moved to EEPROM in the Raspberry Pi 4.  This has the
potential, most importantly, to introduce boot from USB after
shipping, and eventually network boot, I would be led to believe.
Also important is mention of how to recover from a corrupted
bootloader, and the fact that boot settings are no longer One Time
Programmable (OTP), it's all in rewritable memory.

20200821/DuckDuckGo rpi-eeprom  
20200821/https://www.raspberrypi.org/documentation/hardware/raspberrypi/booteeprom.md

And the really good news about this?  Finally, PXE boot is available
in beta for Raspberry Pi 4!

20200821/DuckDuckGo raspberry pi 4 pxe boot  
20200821/https://hackaday.com/2019/11/11/network-booting-the-pi-4/

Oh, okay, I see how the ID EEPROM works.  It contains a _device tree
fragment_ that allows Linux to automagically load the required
drivers.  So then, it just comes down to making sure you have the
drivers installed into the Linux system drivers directory, no need to
include them in your `/etc/modules` startup file.

<!-- more -->

20200821/DuckDuckGo raspberry pi id eeprom  
20200821/https://raspberrypi.stackexchange.com/questions/50348/what-are-the-id-eeprom-pins-and-what-can-they-be-used-for

Wow... built-in Wi-Fi & Bluetooth, 64-bit, 4 cores, virtualization,
PXE network boot, Vulkan, it's all coming together.  Pretty soon, with
addition of a proper power management system, Raspberry Pi will be
able to take on the "big boys" in the PC industry.
