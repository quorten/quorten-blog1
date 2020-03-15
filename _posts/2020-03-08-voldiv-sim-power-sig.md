---
layout: post
title: "Note on resistive voltage dividers, simple way to send a
        signal down a power connection"
date: 2020-03-08 14:55 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

When building a voltage divider circuit, check how much current is
going to be drawn by the "input" (i.e. the output side of the voltage
divider).  If you have a higher current input, you will need to use
lower value resistors to get a stable voltage division.  Also, please
take into note the presence of any pull-up or pull-down resistors on
the input.  Again, these may also require you to use lower value
resistors in your voltage divider, because otherwise, those pull-up or
pull-down resistors are in effect resistors in parallel, which will
significantly decrease the resistance of one of the legs of your
voltage divider, rendering it inaccurate.

20200308/https://en.wikipedia.org/wiki/Voltage_divider#Loading_effect

Simple circuit ways to send a signal down a power line.  High voltage
communications and comparator.  The other alternative of modulating
the power supply at the same voltage is more challenging.  For data
send, design a local power supply that can store up all required
charge to consume during blanking periods, and variably modulate the
signal of consumption or high impedance (no consumption).  Then listen
for a modulated power supply signal for data receive, again using your
local energy storage to continue operating when your power supply goes
blank.

<!-- more -->

You may have to do that because of this problem... if you just have a
carrier-wave at the same voltage as the power, can you really filter
that and tune to it with just capacitors?  It's going to be a low
amplitude signal compared to your power supply, so after tuning with a
capacitor, you might need to amplify the signal quite a bit.
