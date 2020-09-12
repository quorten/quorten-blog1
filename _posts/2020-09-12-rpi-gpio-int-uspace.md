---
layout: post
title: "A more elegant way to get Raspberry Pi GPIO interrupts in
        user-space"
date: 2020-09-12 06:38 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Raspberry Pi GPIO interrupts.  Yes, interrupts on inputs are always a
convenience to have for any system that processes input, but the fact
that Raspberry Pi runs the Linux kernel means you must go through
Linux first before your user-space programs can process them.  And
yes, often times on Raspberry Pi your user-space code will be the
first point of contact with hardware devices, rather than writing a
kernel driver that exposes a software interface to user-land.

One method I've mentioned previously is registering a GPIO interrupt
as a Linux key event that is then propagated to your user-mode
software.  But that looks rather ugly in C source code that is
otherwise direct with hardware.  Surely there's a better way?

Okay, now I'm seeing leads.  RPI.GPIO has support for interrupts.  But
unfortunately, RPI.GPIO is now unmaintained, it never did make it to
GitHub proper.  It simply got replaced with `gpiozero`.

<!-- more -->

20200912/DuckDuckGo raspberry pi gpio interrupts  
20200912/https://raspi.tv/2013/how-to-use-interrupts-with-python-on-the-raspberry-pi-and-rpi-gpio  
20200912/DuckDuckGo github RPI.GPIO  
20200912/DuckDuckGo RPI.GPIO  
20200912/https://code.google.com/archive/redirect/a/code.google.com/p/raspberry-gpio-python?movedTo=https:%2F%2Fsourceforge.net%2Fprojects%2Fraspberry-gpio-python%2F  
20200912/DuckDuckGo github raspberry-gpio-python  
20200912/https://github.com/wuestkamp/raspberry-gpio-python  
20200912/https://github.com/wuestkamp/raspberry-gpio-python/blob/master/source/event_gpio.c

So, how is it done in RPI.GPIO?  Oh, I come back to revisit this one.
Linux `epoll` is the name of the game for registering Raspberry Pi
GPIO interrupts into your user-space code.

DuckDuckGo linux epoll  
https://en.wikipedia.org/wiki/Epoll
