---
layout: post
title: "Great Digi-Key article on diodes, and searching for DC
        switching power supplies, and inductors revisited"
date: 2019-11-27 01:43 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Now, this is a great Digi-Key article on diodes, in particular I find
the coverage of Schottky diodes most interesting.  Schottky diodes
have a low forward voltage drop which makes them great for use in
power supplies, for protecting against reverse polarity, and
protective diodes in inductor/motor circuits.  Also included is a
great schenatic on how to use a voltage regulator chip, LM2595.  Alas,
that's only a buck switching power supply, it doesn't have boost
capability.  Nonetheless, it's a high frequency switching regulator,
which allows for smaller sized filter components.

20191127/https://www.digikey.com/en/articles/techzone/2019/nov/the-fundamentals-application-of-zener-pin-schottky-varactor-diodes  
20191127/https://www.digikey.com/product-detail/en/texas-instruments/LM2595SX-ADJ-NOPB/LM2595SX-ADJ-NOPBCT-ND/3440112

Okay, so I think I've found a few good candidates.  First of all,
though, some design considerations on the Raspberry Pi Zero power
supply.  Although you can run the Raspberry Pi Zero off of 3.3 V
power, keep in mind (at least to be safe) that the limit of 1 A of
power consumption still applies.  In other words, that means that you
can only distribute about 66% of the maximum power when running 3.3 V
power into the 5 V connector, effectively limiting the max power
consumption to "660 mA at 5 V" (3.3 Watts).  Yeah, that's good enough
to run the Raspberry Pi Zero at full CPU load plus Raspberry Pi camera
(500 mA at 5 V), a good handful of LEDs (max 242 mA at 3.3 V), but
basically nothing else.  But, of course, you can't run USB devices
anyways unless you give a full 5 V power supply.

<!-- more -->

Point in hand, if you plan to consume a lot of power from your
Raspberry Pi Zero board assembly, you've absolutely got to run off of
a full 5 V, not 3.3 V.

So, let's review some of the good PMICs I've found.  The point in hand
to keep in mind here when searching is that you generally want to
search for a boost converter.  If you need any buck functionality,
often times you can achieve that adequately with simple linear voltage
regulator circuits as you typically will not need to buck much voltage
off of the supply... yeah, but don't take my word, the Raspberry Pi
Foundation recommends you use a good switch-mode power supply without
linear waste heat style step-down conversion.  Yeah, looks like there
actually is some cleverness on how to do proper switched buck
conversion even with a boost converter IC, the Linear Technologies
specification sheet seems to show a good example.

So, here is for the best 3.3 V boost converter, surface mount package.
Also claims to be able to output 5 V.

20191127/https://www.digikey.com/product-detail/en/texas-instruments/TPS613221ADBVR/296-50502-1-ND/9685641

Here is a second pick for a 5 V boost converter.  Alas, it points
straight into the same data sheet!  Ah, I see, there are different
part numbers for different output voltages.

20191127/https://www.digikey.com/product-detail/en/texas-instruments/TPS613222ADBVR/296-50503-1-ND/9685642

Here is a first pick for a 5 V boost converter, max 600 mA output.
That's lower than ideal, but good enough for Raspberry Pi Zero +
Raspberry Pi Camera.  By comparison, all of the Texas Instruments
chips have pretty good current output capabilities.  A second version
of the chip is configurable to 3.3 V output.

20191127/https://www.digikey.com/product-detail/en/linear-technology-analog-devices/LT1302CN8-5-PBF/LT1302CN8-5-PBF-ND/889560

Regarding thermal shutdown, all of the PMICs referenced contain
thermal shutdown protection.  The LM2595SX-ADJ/NOPB additionally
contains overcurrent protection.

----------

Okay, so frm my recent search so far, some careful analysis, and
reviewing some of my older notes, I think I've learned a lot of
lessons thus far.

First of all, there is no need to shy away from configurable, variable
output voltage PMICs.  It is pretty easy to configure them to provide
a fixed output voltage by means of a voltage divider resistor network
using fixed resistors values.  And indeed, if you truly want to be
able to arbitrarily tweak the output voltage, you could connect a
variable resistor with voltage divider configuration in place of fixed
voltage divider resistors.  The most important consequence of properly
understanding this fact is that you can drastically widen your search
on Digi-Key and compare a much wider selection of available PMICs that
can suit your needs.

Second, it appears to be difficult to find PMICs that provide both
buck and boost functions, and when you do find such PMICs, they tend
to need to make compromises to be able to provide both functions.  Or,
they are new designs that only come in surface-mount packages.  If you
can think really carefully about your power supply approach, about
what you really need to optimize, then you can opt to prefer to buy
whichever of buck or boost provides better optimization for the common
case, and wire up simple but less efficient circuits to handle the
uncommon case.

UPDATE: Many early PMICs have three operating modes: buck, boost, and
inverting.  The inverting mode is a buck-boost converter, and by far
the simplest one at that.

Third, if you really want the best PMIC available, you might need to
concede with some surface-mount soldering.  But if it is only on one
part in your system, that's not too bad a price to pay.

Fourth, the toroidal inductor "donut rings" have not actually
disappeared from modern mobile devices!  Take a look at the photos of
this Adafruit "PowerBoost 1000 Basic - 5V USB Boost @ 1000mA from
1.8V+" board.  It uses a standard fair Texas Instruments PMIC, which
you may know typical such circuits require an inductor.  Beyond the
PMIC, there are many standard fair supporting resistors, tantalum
capacitors, one transistor, and two LEDs, all very recognizable as
such.  But, you'll notice that there is a large squat "tin can" on the
board.  Can you guess what that is?  What else could it be, other than
the required inductor, sneakily packaged into a "tin can"?

20191127/https://www.adafruit.com/products/2030

Likewise, take a real careful look at the Raspberry Pi Zero
schematics.  You'll see that there are indeed two inductors wired up
to the switch-mode power supply PAM2306AYPKE, labeled L1 and L2.  Now,
look around real carefully at some photos of the Raspberry Pi Zero.
You'll see the corresponding labeled components as what looks like
rectangular "tin cans."  Yep, those are inductors packed away inside a
metal can of shielding, the large toroidal inductors, which were
already small compared to what came before them, have been further
miniaturized an packed away in a metal shield.  Now you could easily
miss that they even exist on the circuit board.

20191127/https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/Raspberry-Pi-Zero-V1.3-Schematics.pdf  
20191127/https://en.wikipedia.org/wiki/File:Raspberry-Pi-Zero-FL.jpg

Fifth, revisiting my previous notes on Adafruit switch-mode power
supply boards for easy battery power off of AA batteries, etc.  Most
of the boards aren't all that great because they can't supply the full
1 A of power ot the limit of the Raspberry Pi's power supply.  Second,
only the best one that can supply to the full 1 A limit, the
PowerBoost 1000 Basic, can also boost up to 5 V from a battery voltage
down to 1.8 V.  But when you think about it, this isn't actually that
much better than wiring directly to your AA batteries.  Why?  Some
simple voltage comparison equations can explain this easily.

The Raspberry Pi Zero can run down to a voltage supply of 2.9 V on the
5 V power input, or 58% of a nominal 5 V power supply.  PowerBoost
buys you the ability to run down to 1.8 V, or 36%.  Yeah, although
that is an improvement, to be honest, assuming voltage varries
linearly with remaining battery charge (it doesn't), PowerBoost only
buys you 1.5x running time over wiring directly to your AA batteries.
That's not even better by a factor of two.  And you've got to shell
out about $15 to get that board.  You're better off wiring directly to
either 3 AA Alkaline batteries or 4 AA Nickel Metal-Hydride batteries.
4 AA batteries would be more ideal for getting more run-time and
better run-down of the full battery capacity.  If you really want to
use 4 AA Alkaline batteries, a buck PMIC is not a bad investment, or
even just a linear voltage regulator that wastes the extra voltage for
the period of time that it lasts, if you want to fly in the face of
the Raspberry Pi Foundation's recommendations.

Is there any justification for the PowerBoost?  Yes, if you want to
power a USB device that is finicky and will not run unless it gets a
full 5 V power supply, then you really do need the PowerBoost.

----------

Okay, so armed with that knowledge, let's try again on the search for
my ideal PMIC.  Oh, wow, this one is pretty good.  Well, I mean... at
first glance, if I primarily want a buck converter, but with some
ability to also boost for the sake of 5 V USB devices via the
"inverting" configuration, this works great.  In terms of pure
Raspberry Pi Zero use, it breaks even with powering straight from
batteries.  This also supports current limiting, so a polyfuse can be
obviated.

20191127/https://www.digikey.com/product-detail/en/linear-technology-analog-devices/LT1172CN8-PBF/LT1172CN8-PBF-ND/891731

Let's go searching for more information.  Surely, Digi-Key has one of
those blog articles to better explain buck-boost power supplies, don't
they?  Yes, indeed they do.

20191127/DuckDuckGo digikey buck boost power supply design  
20191127/https://www.digikey.com/en/articles/techzone/2012/apr/buck-boost-design-solutions

Alas, the nice H-bridge buck-boost design in the newer devices is
pretty much only available in surface-mount packages.  Luckily, the
simplest inverting buck-boost design can also be made to work quite
well with the older series PMICs.

20191127/DuckDuckGo digikey inverting buck-boost  
20191127/https://www.digikey.com/en/articles/techzone/2015/aug/using-an-inverting-regulator-for-buck-boost-dc-to-dc-voltage-conversion

Such as this one, for example.  Yes, an almost great find.  This one
runs down to 2 V and can supply 750 mA of **switch** current... which
means that the load can be 375 mA.  Okay, bummer, but almost great.
Lots of great documentation on how to set it up in the inverting
design too, and plenty good stocking.  Yes, it is a bit expensive, as
are all the PMICs.  It has built-in current limiting, which may
obviate the need for a polyfuse.

20191127/https://www.digikey.com/product-detail/en/texas-instruments/LM3578AN-NOPB/LM3578AN-NOPB-ND/32487

----------

Okay, so there's another lesson I learned that you must beware about,
looking further into the data sheets for the switch-mode power
supplies.  If you do use higher frequency switching, you must also be
more careful about the length of your wires connecting your PMIC to
its external inductor and capacitor components.  Keep the length of
the wires as short as possible, and use wide traces.  Especially,
we're talking small components and short distances if we're using a
surface-mount PMIC.  That means that the highest switching frequencies
are basically off limits when doing basic novice electronics work.
For this reason, there is a benefit to lower frequency switching power
supplies: they can be built on a breadboard, though this comes at the
expense of larger components, possibly incurring more noise and less
efficiency.

This is where if you do want to use a high frequency switch-mode power
supply, it may be beneficial to buy one of those pre-built Adafruit
boards, even though it does come at a higher price.  But that's the
price you pay for buying lower-volume manufactured boards.

----------

Do you really need a PMIC for a switch-mode power supply?  Yes, you
do, if you are powering integrated circuits or the like.  Take a look
at the Wikipedia article on "Joule thief."  The Joule thief is a very
simple circuit for a switch-mode power supply, but it results in
flickering of the output.  The various techniques to improve the
output quality ultimately result in a lot of complexity that is better
expressed in an integrated circuit package than with discrete
circuits.

20191127/https://en.wikipedia.org/wiki/Joule_thief
