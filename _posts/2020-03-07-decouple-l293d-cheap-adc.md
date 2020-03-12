---
layout: post
title: "Great discussion on proper decoupling capacitors with L293D,
        and note on cheap ADC with Raspberry Pi"
date: 2020-03-07 21:55 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, I was studying my motor control designs, and it came to my mind:
When I am controlling motors, don't I need larger decoupling
capacitors on the motor power supply path?  I remember when just
taking a crack open at the Lego MINDSTORMS RCX programmable brick, I
saw four very large electrolytic capacitors.  Surely, three of those
were devoted just to the three available motors you could drive, and
the fourth was for the board-level power supply.  Surely, what I've
seen about the absolute basic schematics.

And indeed, I am in agreement with the expert advice.  Here is a great
discussion about the subject on this Arduino forum.  Use 100 nF
ceramic for decoupling the logic power supply, and 100/470 uF
electrolytic plus 100 nF ceramic to decouple the motor power supply.
Yes, indeed the Raspberry Pi schematics that show just the L293D
directly connected from the Raspberry Pi to the motor are too simple.

20200307/DuckDuckGo L293D decoupling capacitors  
20200307/https://forum.arduino.cc/index.php?topic=293864.0

Also, I learned about another curious tidbit.  If you are wiring up
sensitive analog circuits, you may also need inductors to decouple
your circuit.  For digital, inductors are generally overkill and not
needed for sufficient decoupling.  That's good... go easy on the
novices, come on!

<!-- more -->

Oh, another thing I should note after having looked around... cheap
analog to digital conversion with a variable resistor?  You don't even
need a 555 timer chip for one-shot RC network timing.  Thanks to GPIO
being able to be switched between both input and output, you can just
wire up a capacitor directly to your variable resistor.  You switch
the pin to output to charge it, then switch to input to measure the
time to discharge it.  You get a comparator and a voltage sink for
free.  Where does the voltage sink come from?  It comes from the
built-in pull-down resistor, that's why you can get it to work with so
little glue logic.

A prime use in portable applications is, of course, a battery voltage
indicator circuit.  When the battery voltage runs low, you know you
don't have much time left until your next recharge or battery
replacement.
