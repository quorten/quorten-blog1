---
layout: post
title: "Program an Arduino using SPI on Raspberry Pi, and configuring
        the stock ATmega 328 chip to run at 3.3 V"
date: 2020-03-01 13:57 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Want to get started with Arduino by buying just the plain ATmega 328
chip rather than a full development board?  The first question to
answer is how to get the initial programming performed to setup the
bootloader.  For that, the ATmega's common programming mode is
In-System-Programming (ISP), which is basically an interface over SPI
with a little other pin wiring magic.  It's really simple to build the
circuit to interface with Raspberry Pi, then you can just use
`avrdude` on the Raspberry Pi to complete the programming.

20200301/https://en.wikipedia.org/wiki/AVR_microcontrollers#Programming_interfaces  
20200301/DuckDuckGo raspberry pi spi isp program atmega  
20200301/https://www.instructables.com/id/AVRArduino-Flashing-With-Raspberry-Pi/

Also related, can an ATmega 328 operate at 3.3 V?  Yes it can, the
main point to be aware of is that you can only run at half the clock
frequency of 5 V operation.  Also, you must reprogram the ATmega 328
to use the proper "fuse settings" that allow it to run at 3.3 V logic.
This programming can be done over SPI.  In particular, due to the
clock frequency switchover, you want to configure it so that it uses
its internal clock rather than external crystal.

20200303/DuckDuckGo atmega 328 run at 3.3 v  
20200303/https://forum.arduino.cc/index.php?topic=122783.0
