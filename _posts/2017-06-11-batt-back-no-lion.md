---
layout: post
title: Battery backup system alternatives to lithium-ion batteries
date: 2017-06-11 21:00 -0600
author: quorten
categories: [battery-backup, raspberry-pi]
tags: [battery-backup, raspberry-pi]
---

Yes, yes, yes.  Battery backup system notes.  Server notes.  As I have
stated in my previous notes, there is no shortage of lithium-ion
battery backup packs that can be used to power network switch and
router devices.  But those are only useful in places that have
frequent power outages.  For our place that only has a power outage of
2 hours once every 1-2 years on average, that is not going to be an
efficient system.  No, we need a system that instead runs off of
alkaline batteries.  So let's see.  Is there such a system you can buy
on the Internet?  The sort answer appears to be no.  If you want to
get a good system that works to your precise specifications, you
should build one yourself.

20170611/DuckDuckGo D battery ac dc backup power supply

Build a battery backup out of 2 x AA NiMh rechargeable batteries for
an alarm clock.  The circuit uses a DC input jack.

* Again, I reiterate, because this is important!  I searched for this
  and found it, that means it's important!

* NiCd and NiMh batteries _can_ be charged in series.  However, make
  sure you properly limit and regulate the voltage if you do this.

20170611/https://www.allaboutcircuits.com/projects/battery-backup-power-supplies/  
20170611/DuckDuckGo build AA DC battery backup power  
20170611/https://raspberrypi.stackexchange.com/questions/1360/how-do-i-build-a-ups-like-battery-backup-system

<!-- more -->

MUPS, Mini UPS & Power Sensor?  You can buy just that and it takes in
AA batteries?  Cool.  But it costs $120!  Not cool.

20170611/DuckDuckGo mini ups and power sensor  
20170611/https://avtech.com/Products/Sensors/MUPS.htm#features-specifications

The good news is that such a circuit should be relatively simple and
easy to build.  Basically, on the input end, you have your output from
your 12 V DC power supply that is powered from 110-120 V AC.  That is
connected to your circuit with a diode to prevent your battery power
from backfeeding into the DC power supply.  Next, for my particular
configuration will come some capacitors that get charged from DC input
power and can also power the output.  The purpose of this is to
provide a smooth current switching operating when DC power goes out.
Basically, this takes the place of the rechargable batteries in the
previously mentioned circuit designs.  Additionally, a relay is added
into the circuit, powered by the batteries, that detects when DC power
input is not functional and switches on to provide the battery power
to the circuit as proper.  Why a relay?  I was thinking using a
transistor, but maybe transistors can't handle 12 V?

Importantly, the speed of the power switch device is critical in
determining the needed capacity of the buffer capacitors.

Finally, on the output end, you have a switched-mode power supply to
power your electronics, so even when the battery runs low, the
electronics will still get the same input voltage.  Oh, also
importantly, you need to make sure you buy the right DC jacks to
connect with your electronics, and for convenience, I would recommend
using a single power system and multiple DC jacks to power our
separate network hardware pieces like both the router and the cable
modem.

Oh yeah, and what else does this circuit do?  When the batteries are
too weak to provide enough power, the relay can be disengaged to
prevent further battery discharge.  Oh wait, do we need a switched
mode power supply to power the relay too?  Also, I thought the
switched mode power supply itself prevents further drain when the
batteries are below 10%, so such fancies are not needed.  Okay, maybe
you're right.
