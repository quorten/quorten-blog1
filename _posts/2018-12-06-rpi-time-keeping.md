---
layout: post
title: Time-keeping with Arduino and Raspberry Pi
author: quorten
date: 2018-12-06 11:44 -0600
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, I'm wondering.  What provisions does the Arduino have for
time-keeping during runtime, and how does it compare with the
Raspberry Pi?  Oh, so this is interesting.  The Arduino board has a
crystal oscillator on it.  So, that could function for it to get more
accurate time-keeping than the Raspberry Pi, maybe.

So, how exactly does the Raspberry Pi do its time-keeping?  What
hardware does it use?  Well, apparently it uses a built-in timer
circuit on the SoC of some sort that is comparable to the timer
circuit that other modern computers use to synchronize the operating
system timer ticks.  Also, modern operating systems don't really
continuously synchronize with the real-time clock (RTC) circuit, but
rather generally only query it at boot time.  So, suffice it to say,
Raspberry Pi and Arduino are approximately equivalent in time-keeping
functionality when properly calibrated.  Maybe Arduino can do a little
bit better at accurate time-keeping, but don't expect anything
particularly drastic.

20181206/https://en.wikipedia.org/wiki/Arduino  
20181206/DuckDuckGo raspberry pi internal timer accuracy crystal oscillator  
20181206/https://raspberrypi.stackexchange.com/questions/1397/how-accurate-is-raspberry-pis-timekeeping  
20181206/https://raspberrypi.stackexchange.com/questions/7400/how-does-pi-keep-track-of-time-interval
