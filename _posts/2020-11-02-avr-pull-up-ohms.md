---
layout: post
title: Pull-up resistor values in AVR microcontrollers
date: 2020-11-02 11:29 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

What is the value of the pull-up resistors in AVR microcontrollers
like the ATMega328P?  In general, there is no defined value.  These
are not implemented as true resistors because that would take up a
significant amount of chip space, they're likely implemented as just
transistors that provide an approximate resistive function when used
in a clever way.  Therefore, there is a range of uncertainty from 20K
to 50K.  But, hey, that's all I needed to know for my intended
purpose.  Mainly, I was interested in exactly how viable it would be
to connect a small keypad with wires formed entirely out of conductive
carbon ink directly to an AVR microcontroller.  At 100 ohms of
resistance per inch of trace, this sounds viable, 10 inches of such
traces would provide a resistance of 1K, and 20K is still well ahead
of that resistance, so the voltage swings should still work properly
with key presses.  Use the shortest traces possible in your keyboard
matrix.

20201102/DuckDuckGo atmega328 pull up resistance  
20201102/https://idle-spark.blogspot.com/2015/04/arduino-avr-328p-internal-pull-up.html  
20201102/https://forum.arduino.cc/index.php?topic=134077.0

Now, as for the BCM2835 in Raspberry Pi, from what I've heard about
the information on it so far, it sounds like the pull-up and pull-down
resistance values are more stable in that chip.  Well maybe they don't
use true resistor implementation in there, but it could be that the
self-heating of the chip due to the high-speed core helps provide a
more stable resistance value.
