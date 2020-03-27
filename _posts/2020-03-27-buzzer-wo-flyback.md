---
layout: post
title: "The trick to directly connecting a magnetic buzzer without
        flyback diodes"
date: 2020-03-27 12:16 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Quite some time ago, I bought an Inland electronics parts pack from
Micro Center, and in the instructions for using the included buzzer,
it simply said to connect it directly to your microcontroller.  Sure,
that makes sense, it could be a piezoelectric buzzer so it wouldn't
generate inductive back EMF, hence it wouldn't need a flyback diode.
Well, anyways, I did just that, directly connected it to my Raspberry
Pi Zero, and it worked fine... but upon closer inspection, it seemed
to clearly be a magnetic device, not a piezoelectric device.  Weird,
how did this work just fine without damaging my Raspberry Pi?  Was it
because it was sufficiently low current that the back EMF if generated
could have caused no damage?

Sort of, that's not quite it.  After some careful thought, the real
reason why this works okay becomes clear.  The magic is in the fully
buffered termination in the pull-up GPIO output.  When you switch the
GPIO output off, the Raspberry Pi provides a path to ground on the
GPIO output, rather than leaving the output "floating" as an "open
collector" design would.  Now, the magnetic coil inside the buzzer
wants to keep the current flowing, and that is absolutely no problem
in this case.  Since both ends of the coil are connected to ground, a
current can keep flowing in the coil any way it pleases, and since
there is no additional resistance on the coil, it will do so at its
desired current, which will actually end up generating a back EMF
voltage equal to the original supply voltage.

<!-- more -->

See?  There is no need for a protective flyback diode.  Nevertheless,
you can add one into your circuit for safety if you so please.  Of
coruse, the key requirement here is that the inductor on its own must
be a low-current draw device, otherwise you'll definitely have
problems whether it is switched on or off.  Suffice it to say, this
kind of device presents somewhat of a limited exception to the general
rules of driving an inductive device directly using CMOS logic.

When is a flyback diode required?  If you are controlling the current
to the buzzer with a single BJT transistor (or a single MOSFET for
that matter), then when you switch the transistor **off**, you are
leaving the circuit in an "open collector" mode.  This is where you
must definitely provide a flyback diode for the back EMF to flow,
otherwise it will force its way through your BJT transistor via high
voltage and destroy it.
