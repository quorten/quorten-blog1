---
layout: post
title: "Powering the Raspberry Pi Zero on 3.3 V"
date: 2018-03-15 21:00 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Powering the Raspberry Pi?

20180315/DuckDuckGo raspberry pi power supply voltage board

Oh, interesting.  You can also power the Raspberry Pi via the 3.3 volt
outputs, with some more caveats compared to using the 5 volt input.

20180315/https://raspberrypi.stackexchange.com/questions/1617/how-do-i-supply-power-through-the-gpio

* UPDATE 2019-12-04: That is not recommended, however.  Rather, you
  should put the 3.3 V power on the 5 V outputs and that will also
  work, while providing 3.3 V power on the 5 V power supply rails.

Okay, so there are other recommendations here too.  Use a 12 volt (12
V) input for other electronics in your system that you step down to 5
volts (5 V) and feed through the USB input to power the Raspberry Pi.

20180315/https://www.modmypi.com/blog/how-do-i-power-my-raspberry-pi
