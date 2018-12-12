---
layout: post
title: Raspberry Pi One-Time Programmable (OTP) documentation
author: quorten
date: 2018-09-24 17:00 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Wondering about the full documentation about the Raspberry Pi One-Time
Programmable (OTP) configuration?  Here it is.  What I am not sure
about is if you can set multiple bits cumulatively or they must be set
all at once.  However, what looks to be true for sure is that separate
words can be programmed at separate times.  The bits within a single
word, in theory this must work too so that you can have boot from SD
set by default, but then add more bits to also boot off of USB and
network boot.

20180924/DuckDuckGo raspberry pi otp  
20180924/https://www.raspberrypi.org/documentation/hardware/raspberrypi/otpbits.md

Okay, answers found on this.  OTP memory is cumulative set, even when
a word has already been written once before.  The end when you can't
do anything else is when all bits in a word are set.

<!-- more -->

Also, I've found great documentation here on the Raspberry Pi boot
process.  Wondering what "GPIO bootmode" is?  Basically, when set, you
can use a hardware switch on GPIO pins to set the boot mode of the
Raspberry Pi.  **Do not** set this unless you are sure you want to
forfeit the use of a few GPIO pins to configure boot mode!  Also, if
you have this set but no GPIO pins set, your Raspberry Pi will not
boot!

20180924/DuckDuckGo raspberry pi gpio bootmode  
20180924/https://www.raspberrypi.org/documentation/hardware/raspberrypi/bootmodes/bootflow.md

Also, this is interesting.  Raspberry Pi can be booted also via the
use of connecting to a PC.  That is, the Raspberry Pi will present
itself as a "programmable device."  Then the PC can bootstrap the
Raspberry Pi with code and such, similar to communicating with a ROM
programmer, I believe.  Okay, never mind that thought I wrote, here is
the program you use to do a "USB device boot":

20180924/https://github.com/raspberrypi/usbboot

Indeed, this works well with the Raspberry Pi Zero, but other
Raspberry Pi devices that are more like a "PC," such as the Model B,
don't work with it.

So, for Raspberry Pi Zero development, I should have known better.
You don't even need a USB card to get started on your Raspberry Pi
Zero development board!
