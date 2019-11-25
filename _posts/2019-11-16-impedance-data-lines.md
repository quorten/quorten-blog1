---
layout: post
title: Output impedance explained, and transmission lines
date: 2019-11-16 23:53 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Output impedance, what is that exactly?  In the simplest case, it is a
reasonable way to explain the maximum amount of current a particular
power supply can provide.  Power supplies, including batteries, can be
modeled as having an "internal resistance."  The value of this
internal resistance is the same as the "output impedance."  Then, the
circuit as a whole can be studied using the resistance and voltage
laws of voltage drop based off of resistance.  A higher output
impedance (resistance) value means that the output voltage will more
readily sag when there is a high current draw (low resistance) load
attached.  Conversely, if a low current draw (high resistance) load is
attached, the voltage drop will be negligible even if there is a high
output impedance.

Therefore, the output impedance is primarily a measure of how much
current can be supplied by a power supply.  Low current, i.e. high
resistance, outputs can alwyas be connected without issues, but high
current, i.e. low resistance, outputs need to be connected with care.
Motors are characteristic for causing high current draws and voltage
sags in power supply sources.  You may need to consider switching to a
power supply with a higher current rating, i.e. lower output
impedance, if your load's current draw is too high, i.e. resistance
too low.

20191116/https://en.wikipedia.org/wiki/Output_impedance

<!-- more -->

So, the whole characteristic impedance thing, I still don't quite
understand, maybe it is better explained in the transmission line
article?  Well, not really.  Basically, the key point to understand
about characteristic impedance is this.  Complex impedance is defined
on alternating currents, and it cannot be understood as being
identical to simple impedance on direct current circuits.

But, the transmission line article does have some useful mention of
various types of wire for high-frequency transmission, with
"microstrip" being an interesting variant for signal transmission on a
printed circuit board.

20191116/https://en.wikipedia.org/wiki/Transmission_line

Here we go!  This article explains reflections very well.

20191124/https://en.wikipedia.org/wiki/Reflections_on_copper_lines

Okay, but it doesn't quite explain enough on how to build your own
"bus-style" line, so it seems.  How would you build in side-taps that
result in minimal signal reflection?  Well, thinking this through
intuitively and thinking about some ways in which it was done
successfully in the past, I'll pitch in my guess.  With side taps, you
want to hvae minimal surface area of the side wire tap in contact with
the bus wires.  This will ensure that the current flowing out of the
wire is approximately the same as the current flowing in.  If you had
a side tap the same size as the bus wire, there would be a lower
resistance on the two outgoing branches combined than the incoming
branch, since there would be twice the wire cross-section, and that
would cause an impedance mismatch that you could get a signal
reflection off of.  So, your connections to the bus wire must be
high-impedance, and the ends of your bus wire are terminated with the
same impedance as its characteristic impedance.  This is fairly
consistent with old-fashioned "vampire-tap" style Ethernet wiring, for
example.

Well, let's keep searching.

20191124/https://en.wikipedia.org/wiki/Bus_network

Oh, yes the hint is "T connector."  Sometimes also called "tap
connector."  Let's go searching on those lines.

20191124/DuckDuckGo rs-485 t connector

Ah, yes, here I find more useful information on how to do RS-485
wiring.  The head-end of a bus should be wired to a transceiver, and
only the opposite tail-end should be terminated with a resistor.  As
for the T connector design themselves, that I need more information
on.

20191124/https://www.se.com/ww/en/product/TCSCTN011M11F/network-%e2%80%9ct%e2%80%9d-connector---rs485-network-or-canopen---m12---5-pin-1-male--2-female  
20191124/https://eeci.com/rs-485.pdf

how to do rs-485 t connector  
http://www.bb-elec.com/Learning-Center/All-White-Papers/Serial/RS-485-Connections-FAQ/faq_rs485_connections.pdf  
https://blog.opto22.com/optoblog/rs-485-to-terminate-bias-or-both

Okay, okay, I think I've searched enough.  Looks like there actually
isn't too much formality in the T connections of RS-485 wires, for
instance.  It is rather primitive, just find a way to make a
connection, no need to worry about different wire sizes affecting
overall impedance, and that works good enough.  Speeds less than 19.2
kbits/sec on cables less than 4000 feet will have no issues.
