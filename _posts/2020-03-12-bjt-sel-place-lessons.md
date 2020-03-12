---
layout: post
title: "Lessons learned with BJT transistor selection and placement"
date: 2020-03-12 17:22 -0500
author: quorten
categories: [raspberry-pi, reiterate]
tags: [raspberry-pi, reiterate]
---

When it comes down to picking transistors for modern computer-grade
electronics projects, the question is between BJT and MOSFET.  When
you know for sure that you will only be controlling low current
signals and are looking for the cheapest transistor to fit the bill,
BJT is the clear winner.  But what kind of BJT transistor should you
choose, NPN or PNP?  Looking at various circuits online, you'll see
that people use both, one or the other, without really any rhyme or
reason.  Except... that NPN tends to be preferred because it is
conceptually easiser to understand: positive voltage turns the
transistor on, no voltage or negative voltage turns the transistor
off.

Well, after thinking about this for a little while, I came to some
enlightenment.  Let's review some of my recent projects to analyze the
problems I've made and what I could have and should have done better,
especially if they are going through a V2 revision.

First of all, I had a 4-digit 7-segment common cathode LED display
that I needed to control.  How should I control it?  Well, I looked at
an example circuit that drive all the contacts directly from a
microcontroller, and they used NPN transistors to sink the currents
from the cathodes.  Sounds fair enougn, I can just take the analog
regulation components and paste them right into my own design.  Wrong.

<!-- more -->

In my own design, I ended up connecting the common cathodes to a
demultiplexer chip rather than directly to a microcontroller.  After
the fact, searching around, I saw active low demultiplexer chips were
way more abundant and available in more configurations than active
high demultiplexer chips.  I should have known this in advance of
purchasing my NPN transistors, because then I could have switched to
using PNP instead and all would be good.  Instead, I had to make a few
compromises on my selection of demultiplexer chip, but I was fortunate
to get what I was looking for.  Again, I reiterate, because this is
important!  The reason why active low demultiplexer chips are way more
abundant than active high demultiplexer chips is because that has kind
of become de facto in the industry for chip select, especially in the
case of SPI.

Also, when you think about it, when you are switching the common
cathode, in the event that your microcontroller **is** capable of
sinking all the output current, you would configure pull-down GPIO
outputs, not pull-up GPIO outputs.  To control an NPN transistor, you
need to use pull-up GPIO outputs (active high), but you use pull-down
outputs (active low) to control a PNP transistor.

The second lesson to be learend with PNP versus NPN.  What if you are
using a transistor to switch current to a remote load?  Now, this is
key: with a BJT transistor (this is also true to some extent with
MOSFETs), you always have two current loops flowing through the
transistor, the current flowing between the base to the
emitter/collector, and the current flowing the emitter and the
collector.  Of course your remote load's current is going through the
emitter and collector, but which way is your small base switching
control current going?  Is it taking the shortest path possible back
to the device, or must it detour through the long wires to the remote
device before it makes its way back to its home device?  The path to
the remote device being longer will cause more resistance to your
small control signal, which will in turn multiply the decrease in
current that can flow between the emitter and collector for the main
power supply purpose.

Therefore, when using BJT transistors to switch remote loads, take
care to select your transistor or position it so that the switching
current takes the shortest path.  For NPN transistors, this means you
should switch the negative or ground return current path coming from
your remote device.  For PNP transitors, this means you should switch
the positive current path heading out to your remote device.  This
way, both the positive and negative ends of your control current will
be sourced and sinked directly to your local device, without needing
to take a detour out to the remote device being power switched.
