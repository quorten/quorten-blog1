---
layout: post
title: "Generate high speed waveforms with Raspberry Pi, ChibiOS/RT,
        Raspberry Pi power-on RESET signal, and Raspberry Pi watchdog"
date: 2020-03-04 12:01 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Sure, Linux realtime threads is one way to generate high frequency
signals with Raspberry Pi reliably, but what are other methods
mentioned out of the Internet?  Oh, interesting, ChibiOS/RT is a
realtime operating system that runs on Raspberry Pi and also Arduino.
One portable operating system to write all your realtime code in.

20200304/DuckDuckGo raspberry pi generate microsecond one shot pulse  
20200304/https://raspberrypi.stackexchange.com/questions/19765/rpi-gpio-as-a-high-speed-square-wave-generator  
20200304/http://www.stevebate.net/chibios-rpi/GettingStarted.html

How do you build a power-on RESET circuit?  The simplest method
involves a capacitor and a comparator, but this won't quite work if
your power supply has a ramp-up time that is similar to the capacitor
charge time.

20200304/https://en.wikipedia.org/wiki/Power-on_reset

Is there a reliable power-on RESET signal on Raspberry Pi?  Well,
looks like it could be that pretty much all GPIO pins on Raspberry Pi
function as power-on RESET signals, so there you have it.

20200304/DuckDuckGo raspberry pi power on reset  
20200304/https://raspberrypi.stackexchange.com/questions/1032/what-is-the-power-on-state-of-the-gpios

<!-- more -->

UPDATE 2020-10-25: Please see my [newer article]({{ site.baseurl
}}/blog/2020/10/26/rpi-gpio-boot-errata) for corrections about the
RESET GPIO pin behavior.

Also, in the process of searching for this, I found that Raspberry Pi
also has a built-in watchdog timer.  Wow, now that's very nice.

20200304/https://raspberrypi.stackexchange.com/questions/1401/how-do-i-hard-reset-a-raspberry-pi#1403
