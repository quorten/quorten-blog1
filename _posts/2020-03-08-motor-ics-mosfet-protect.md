---
layout: post
title: "More discussion on motor control ICs, decoupling capacitors,
        MOSFETs, MOSFET protection circuits"
date: 2020-03-08 14:45 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Recently, I have stated that in switched-mode power supplies, you
should use capacitors with a low equivalent series resistance due to a
switched-mode power supply causing high ripple currents to such
capacitors.  Now, what about motor controllers?  The decoupling
capacitors to motor controllers are rather similar to those used in
power supplies.  I'll put in my recommendation: you should also use
low equivalent series resistance decoupling capacitors for a motor
controller, especially if you are using PWM motor speed control.  That
will for sure cause high ripple currents, and you don't want to have
decoupling capacitors that heat up and wear down if you don't have to.

So yes, that I'm updating my L293D schematics with the corresponding
changes.

Previously I've discussed the possibility of using a discrete
components MOSFET motor controller circuit.  It's actually not a bad
idea considering the switching controllers with external MOSFETs.  If
you want to drive higher current loads, the external components are
required.  So, simply for the sake of operating with through-hole
components at lower voltages, it's justifiable.

Of course, another option is still yet to use adapters and modern
surface-mount MOSFET motor controllers.  Saves you board space, for
sure.

<!-- more -->

Okay, but the main thing to beware of when using your own discrete
MOSFET controllers.  Thermal shutdown... it's built-in to many motor
control ICs.  Under voltage... that can damage the MOSFETs.
Under-voltage protection is pretty easy to build.  Thermal shutdown,
that may be a bit more challenging to do right when building your own.
One thing to note, though, is that discrete MOSFETs have pretty good
heat dissipation built-in to them, they have those metal heat sinks
sticking out of their tops and that makes it real easy to get a fairly
good heat dissipation in place.  It could be that your design may not
ever need thermal shutdown.

There are also classes of motor control ICs designed along same
principles of switched-mode power supplies, terminology is
key... "controller" is the keyword for when the MOSFETs or BJT
transistors that control the power directly to the motor are external.
If the word "driver" is used that means these are integrated into the
same package.

Here is some great information how protection circuits while using
discrete MOSFETs.  You can put temperature fuses on MOSFETs to protect
from overheating, and there are also some other nifty tricks of
resistor, diode, and capacitor placement.

20200309/DuckDuckGo mosfet under voltage protection  
20200309/https://www.homemade-circuits.com/mosfet-protection-basics-explained-is/
