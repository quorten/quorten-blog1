---
layout: post
title: Multiple UARTs on Raspberry Pi?
author: quorten
date: 2018-08-05 16:00 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

How do you get multiple UARTs on a Raspberry Pi?  Is there an elegant
way to do this?

So, as it turns out, there isn't.  There is a single hardware PL011
and a software-assisted "mini-UART" that comes with limitations.  If
you want more than this, your best option is to use bit-banging on the
GPIO pins.  As it turns out, wiring up additional UARTs over I2C or
SPI is more trouble than its worth.  The best alternative if you want
to connect more UARTs to the Raspberry Pi is through USB devices.
Otherwise, there are other boards you can get that are better than
Arduinos and Raspberry Pis in this respect, I heard they are called
"mega".

* UPDATE 2018-12-09: "Mega" is the ATMega microcontroller, part of the
  AVR series.  This is the same microcontroller that is used in
  Arduino.  So, "get a mega" is just a more advanced way to be
  recommending an Arduino, at the component level.

20180805/DuckDuckGo raspberry pi uart gpio

This is great UART documentation here from the Raspberry Pi website.

20180805/https://www.raspberrypi.org/documentation/configuration/uart.md

20180805/DuckDuckGo raspberry pi multiple uart
20180805/https://raspberrypi.stackexchange.com/questions/3475/how-to-get-more-than-one-uart-interface  
20180805/https://www.raspberrypi.org/forums/viewtopic.php?p=966034
