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

20200912/DuckDuckGo linux epoll  
20200912/https://en.wikipedia.org/wiki/Epoll

Well... looking further into the programming interface, it isn't ideal
for what I was thinking.  `epoll` needs to be used in a waiting loop,
so if you want an interrupt service routine style interface, then you
need to spawn a thread to handle the waiting loop.  Also, `epoll`
registers with the Linux `sysfs` files created for individual GPIO
pins.  That's more trouble than it's worth.  Searching around on the
Internet, there isn't a whole lot more knowledge about how to do this
well in the Raspberry Pi community, unfortunately.  They just don't
know things.

However, I did find this important piece of information.  Originally,
the Raspberry Pi Linux kernel had absolutely no support whatsoever for
handling GPIO interrupts, even the hardware was capable.  This only
got added to the software later.

20200902/DuckDuckGo raspberry pi gpio interrupt  
20200902/http://wiringpi.com/reference/priority-interrupts-and-threads/

I guess, after all, `gpio-keys` is the most elegant way to get GPIO
interrupts into user-space.  On the other hand... yes, for
`gpio-keys`, you must also open the file `/dev/input/event0`.  Well,
if it's a bummer either way, I'm guessing Linux`epoll` may be easier
if you only have one GPIO pin to monitor, otherwise `gpio-keys` is
better.

Linux has been slow to adopt user-space driver functionality, but UIO
is one of the newer features that is a step in the right direction.

20200902/https://stackoverflow.com/questions/7986260/linux-interrupt-handling-in-user-space
