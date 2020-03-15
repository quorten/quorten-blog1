---
layout: post
title: "Lots of lessons learned on switched-mode power supplies, and
        effective series resistance of capacitors"
date: 2020-03-08 14:35 -0500
author: quorten
categories: [raspberry-pi, reiterate]
tags: [raspberry-pi, reiterate]
---

First of all, I have to make reference to a great datasheet I've found
on a particular Maxim switched-mode power supply that was extremely
informative for an computer-grade electronics design novice like me.

20200308/https://datasheets.maximintegrated.com/en/ds/MAX1771.pdf

Again, I reiterate, because this is important!  Second, I have to draw
attention to the key realizations that got me unstuck on the decisions
that had to be made for a suitable switched-mode power supply for my
Raspberry Pi projects.

There are two classes of integrated circuits for switched-mode power
supplies: switching regulators and switching controllers.  Switching
regulators have the main switching MOSFET builtin, whereas switching
controllers use an external MOSFET.  This allows switching controllers
to supply more current than switching regulators, but it comes at the
expense of requiring more complex circuit design.

<!-- more -->

So, armed with that knowledge, I went searching for a switching
controller rather than a switching regulator.  And indeed, I found a
chip that could supply the 1+ amp of power I needed for my Raspberry
Pi projects, in through hole form factor to boot.  Yeah, it sure would
be nicer if I could use those surface-mount components, I would have a
much greater selection of components at my disposal, but for now, I
must stick with the more limited selections in through-hole mounting.
But, nonetheless, the point is this: if you only need 500 mA or less
of current, you have a pretty wide selection of switching regulators
available, but if you need more than 500 mA of current, you'll find
there to be a wider selection of switching controllers to be available
for that particular purpose.

Now, reading into the Maxim datasheet, I learned something new to keep
in mind when selecting resistors: equivalent series resistance (ESR).
What is that?  Unlike the ideal mathematical model of capacitors, real
capacitors are not exclusively capacitive.  Rather, they can be
modeled as if there is a resistor in series with the capacitor.  But
please note, this isn't merely an ordinary resistor, it is one that
has an "AC" resistance.  That is, it is only resistant at certain
frequencies.  If no other frequency is specified, it is the
self-resonant frequency of the capacitor.  At that point is where the
resistance is strongest, and it fades away above and below that point.

Cheap aluminum electrolytic capacitors (the kind you get in
electronics kits for novices) have a relatively high equivalent series
resistance.  To get a lower ESR, use a aluminum polymer capacitor or a
tantalum capacitor.

Specifically, in the case of switched-mode power supplies, you need a
capacitor with a low ESR because it will be subject to high ripple
currents.  The ESR is responsible for all the energy that gets
dissipated as heat from the capacitors.

20200308/https://en.wikipedia.org/wiki/Equivalent_series_resistance

Another word about heat.  Switched-mode power supplies are never 100%
efficient... they're at least 80% efficient if not better.  At 80%
efficient, 5 volts, 1 amp, 5 watts... that means 1 watt of heat.
Yeah, now that's a significant amount of heat to waste for a hobby
project board since it's enough to feel warm to he touch.

So, the BIG LESSON learned... with switched-mode power supplies, when
the power draw is low, its really easy to integrate the whole module
on the same board as the rest of your electronics, and of course it's
easier to integrate the MOSFET switch in the PMIC IC itself.  But, for
high power draw, you need to use an external MOSFET.  And not only
that, you're going to have more waste heat that you need to dissipate
away.  This means its more likely that the switched-mode power supply
itself will be located on a different board away from your main logic
circuits, where it is easier to dissipate the heat, and a cable will
connect the two together.

Matter of fact, that's a good reason behind the design of wall warts
in small electronic boxes like network switches, home routers, set-top
boxes, and so on.  It allows you to easily have a smaller box without
active cooling, the extra surface area of the wall wart provides
adequate passive cooling of the switched-mode power supply.
Otherwise, you'd need a larger box to provide all needed passive
cooling, or use active cooling and that would generate more noise.
