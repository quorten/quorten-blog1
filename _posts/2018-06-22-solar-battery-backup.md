---
layout: post
title: Solar power to charge network equipment battery backup system
author: quorten
date: 2018-06-22 10:27 -0500
categories: [battery-backup]
tags: [battery-backup]
---

Solar panel energy output?  How do you know if your panel is large
enough to power your network equipment?  Okay, here's what to do.
Find the wattage, and multiply by the time in sunlight to get the
energy.  Then assess the continuous power drain of your network
equipment is within bounds.  Finally, select an appropriate battery
pack size based off of energy supply uncertainty beyond regular
day-night cycling.

Multiply voltage and current to get Watts.

20180622/DuckDuckGo solar panel size energy output  
20180622/https://news.energysage.com/what-is-the-power-output-of-a-solar-panel/
20180622/https://en.wikipedia.org/wiki/Watt

----------

Wondering about multiple 12 volt power supplies?  What exactly do you
need to know to get that to work?

Okay, so naturally, I found _a lot_ of useful information in relation
to the PC world of power supply affairs.

Basically, this is the most important thing you need to know: logic
chips don't run off of 12 volts, they run off of 3.3 volts for 5
volts.  In PCs, 12 volts were primarily used for motor control in disk
drives such as floppy disk drives, hard disk drives, CD-ROM drives,
and so on.  Eventually PC circuits were reworked so that 12 volts was
used as the standard input voltage for everything, and logic chips
would include their own converters to step it down to 5 volts or 3.3
volts needed for the chip.

As it turns out, these boards that run off of 12 volts can therefore
run off of noisier, less ideal power inputs.  That being said, this
opens up the option for you to share a single regulated power output
across all your 12 volt boards without issue, rather than the more
expensive option of using multiple voltage regulators and dedicating
them to each board, or each to a sub-grouping of boards.

The other thing to consider: multiple current-limited outputs on a
single voltage regulator.  This is mainly a thing for 12 volts greater
than 20 amps as a safety means (IED 60950 standard), but in practice
it doesn't improve safety that much, so it is recommended that you
avoid these as they can cause power supply headaches.  But, most
importantly, if you strictly supply less than a total of 12 volts at
20 amps to all your circuits, you don't need to worry about the
potential power supply problems at all.  Not to mention, in the world
of PC power supplies, most power supplies are not IED 60950 compliant.

Oh, also PC power supplies, they are a world of poorly documented
standards and specifications.  The primary motivation is minimum cost,
so that almost always means they only have a single voltage conversion
circuit.

Anyways, answering the final question.  You don't need to buy a
special "multiple 12 volt output" power supply, you can just buy a
single 12 volt output power supply and make sure it can supply
sufficient current in amperes.  Not too much, of course, because then
you can be wasting energy at the power supply due to unused excess
capacity, which tends to get dissipated as heat.

20180620/DuckDuckGo multiple 12 volt power supply
20180620/http://www.playtool.com/pages/psumultirail/multirails.html  
20180620/http://www.playtool.com/pages/psuoverload/overload.html  
20180620/http://www.playtool.com/pages/psurailhistory/rails.html

----------

12 volt power?  What is the wiring distance of that?  Surely
the energy losses may be too high for the longest of distances.

20180625/DuckDuckGo 12 volt power wiring distance  
20180625/https://www.engineeringtoolbox.com/12-volt-wire-loss-chart-d_1689.html  
20180625/https://www.treehugger.com/sustainable-product-design/big-steps-in-building-change-our-wiring-to-12-volt-dc.html

Indeed, if you keep 12 volts within the confines of a small house, it
will work okay.  But if you want to run it the length of a larger
backyard... you may run into problems.  Alternatively, in the
datacenter case, you can put it this way: when you have a large number
of tap points along the length of even a long wire, the tradeoffs
between using extra wire and a tree-structured step-down converters
put using only 12 volts in favor, even in spite of the losses.

Li-Fi is commercially available!  For only $1650... okay, that's quite
expensive.  No thanks, not now, maybe later when the prices go down.
So for now, the main customer of such equipment is hospitals that are
concerned about interference, well, those that can pay for this
technology.

20180625/https://www.treehugger.com/sustainable-product-design/get-rid-your-wifi-lovely-lifi-lamp.html

Alternatively, you could make a "poor-man's Li-Fi" using a Raspberry
Pi Zero.  It will be slow, but it will work and be much cheaper.
