---
layout: post
title: Reflection and summary of motor control protective circuits
date: 2019-11-11 21:46 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Building a fully proper motor control circuit on Raspberry Pi is
literally an introductory course in power engineering.  The protective
circuitry literally is a low-voltage AC power adapter between your
motor and your computer.  The first part that piques my interest: upon
a careful analysis of the diode protective circuits in the L293D, I
found out it was actually a diode bridge rectifier between the motor
and its power source.

So if you turn the motor on its own, it is a generator that supplies
power to your computer.  Of course you can't control your motor at the
same time it is being used as a generator.

Kids, don't try this on commercial consumer electronics at home.  I
did, and the electronic in question almost turned into a brick.
That's because in the interest of cutting costs, they eschew on proper
electrical isolation in both their motors AND AC power supplies.
Lucky for me, the particular electronic did have some alternate design
wherein there was effectively a polyfuse that would not let too much
current flow from the motor into the rest of the circuit, when tripped
it would refuse to provide any power to the entire device circuit.

But, you should still be forewarned, in college classes on
electrical/power engineering, professors do note to students that
popular consumer electronic gadgets omit some protective circuitry
from the AC power adapters in the chargers in the interest of saving
cost/bulk/weight and reasoning that such power fault events are rare.
"Let the buyer beware," but especially for home use, the buyer is but
one of the many people who use it.

<!-- more -->

Key components of protective circuits in power systems: (1) diode
bridge rectifier, (2) flyback diodes, (3) decoupling capacitors, (4)
voltage regulators, (5) polyfuses, (6) large grounding plane, (7)
isolated protective ground.

Commercial electronics cut costs by omitting components #2 and #4
as they apply on the high-voltage side, since these are also
larger and add more bulk and weight to your mobile device's
charger.
