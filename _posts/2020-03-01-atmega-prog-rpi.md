---
layout: post
title: Program an Arduino using SPI on Raspberry Pi
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
