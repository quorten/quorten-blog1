---
layout: post
title: Inductors explained
date: 2020-03-19 15:35 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, okay, so these ideas were coming from a larger documentation
project I was working, but for the sake of timeliness and succinct
containment, I thought I'd write a separate blog article on the
subject.

What is an inductor?  Basically, it's kind of like a capacitor but the
opposite in a few key ways.  Both capacitors and inductors store
energy.  A capacitor stores energy in electric charge.  An inductor
stores energy in a magnetic field.  As you know from the basic laws of
electromagnetism, electric fields and magnetic fields go hand-in-hand
with electromagnetic radiation.  A changing electric field causes a
changing magnetic field, and vice versa.

Okay, that all makes sense in concept, but what does this mean an
inductor does in an electronic circuit?  First of all, let's review
what a capacitor does in an electronic circuit.  When a voltage source
(i.e. battery) and a capacitor are connected, the capacitor will start
charging up.  Current will flow through the capacitor until it is
charged up to the same voltage as the voltage source, at which point
it will block the flow of current, i.e. it will _resist_ the flow of
current.  Then, when the voltage source is disconnected, the capacitor
will act like its own voltage source and supply current until it is
fully discharged.  Just like a battery, the voltage a capacitor
supplies will gradually decay until it has no more charge left.

<!-- more -->

That being said, an inductor acts in the opposite fashion of a
capacitor.  An inductor, when fully discharged, will _resist_ the flow
of current.  When an inductor is charged up in accordance with the
supplied power, it will allow current to flow with low resistance,
pretty much just like a wire.  Then, when the voltage source is
removed, an inductor will discharge.  But, here's the key difference
to understand.  Rather than acting as a voltage source, an inductor
will act as a _current source_.  In the typical case of electronics,
you'd use Ohm's Law to solve for the unknown current that would flow
through a circuit using the known voltage and resistance.  In the case
of inductors, the current and resistance are known, but the voltage is
unknown.

Of course, in the simple case of a test circuit that sets up inductor
charging and discharging to power an light just like a capacitor, not
much changes here.  Once you switch off the voltage source, you have a
constant resistance load such as a light and the known current that
the inductor was charged up to.  Immediately at the point the power
was switched off, you can compute the inductor's supply voltage based
off of the current and resistance, and this will work out to be the
same as the voltage source.  Then, as the circuit runs, the current
and voltage will decay in tandem as the inductor's stored energy runs
out, just like a capacitor.  And, therefore, the light intensity will
also decay.

Beyond the inverted behavior of how an inductor passes or blocks
current compared to a capacitor, the other difference can only be
observed in circuits with variable resistance loads.  First, an
inductor is charged up and the voltage source is removed so that the
inductor will be powering a load.  When the load's resistance
increases, an inductor will also _boost_ its supply voltage in order
to keep current flow the same.  Likewise, when resistance decreases,
an inductor will _buck_ its supply voltage to keep current flow the
same.

Solenoids and motors have coils in them to deliberately generate a
magnetic field that will result in the physical motion of another
magnetic device.  However, because they have coils, they are also,
therefore, inductors.  The key caution of channeling the _back-EMF_
(Electro-Motive Force, i.e. voltage) through protective diodes when
controlling motors using modern CMOS semiconductor microcontrollers is
because of this propety of inductors: when you switch off the power to
a motor to deliberately cause high resistance to it to prevent
continued motor motion, you are in effect trying to increase the
resistance to an inductor.  Therefore, the inductor will respond by
boosting the voltage to try to keep the current flow the same.
Therefore, rather than trying to completely resist this current flow
and loose when the voltage spikes so high it destroys your CMOS
semiconductor microcontroller, you instead provide a more desirable
path for this high voltage current to dissipate through instead, until
there is no more current that must be dissipated.

On the other hand, the ability of inductors to boost their supply
voltage is key to the implementation of boost switched-mode power
supplies.  A buck switched-mode power supply can be implemented with
ease using only capacitors: just switch off the voltage source to a
capacitor when its voltage gets too high, and switch it back on when
its voltage gets too low.  But for a boost switched-mode power supply,
a capacitor is never going to give you a higher voltage than you
supply to it.  Nevertheless, even for implementing buck switched-mode
power supplies, inductors simplify the implementation because it is
easier to sense their voltage when being charged and determine what
their supply voltage at a particular current draw is going to be once
the voltage source is removed.

And those are the conceptual keys that you need to know about an
inductor.  Now we can get into basically the beginning of what the
Wikipedia article says about inductors, now that you have a concrete
conceptual understanding.

20200325/https://en.wikipedia.org/wiki/Inductor

An inductor resists changes in current as defined by the following
differential equation.

```
emf = -H * dI/dt
```

Electromotive force, i.e. voltage, is proportional to the inductance
times the change in current over the change in time.  A negative sign
is used to indicate that this is an opposite, opposing voltage
compared to the supply voltage and current.  As we have previously
explained the derivation of the capacitor equation, you should see how
the two are intuitively related based off of the previous conceptual
discussion.

```
V = -H * dI/dt
I = -C * dV/dt
```

Once again, just like the case with capacitors, you must use the
exponential growth and decay equations to compute how long it will
take to charge and discharge an inductor.  So let's derive the
corresponding exponential growth/decay equations.

```
V = -H * dI/dt
-V / H = dI/dt
V = I * R
-I * R / H = dI/dt
let k = -R / H
kI = dI/dt
I(t) = I(0) * e^(k * t)
I(t) = I(0) * e^(-R * t / H)
```

So, now let's consider the simple test circuit for an inductor
powering a purely resistive load.  Using the exponential decay
equation, you can easily find out how long the light will be lit at a
sufficient intensity by solving for a minimum acceptable current draw,
determined using Ohm's Law with the minimum acceptable supply voltage.

```
I_e = I_0 * e^(-R * t / H)
I_e / I_0 = e^(-R * t / H)
ln (I_e / I_0) = -R * t / H
t = -H / R * ln (I_e / I_0)
```

Now, as mysterious as inductors are, let's try a concrete example with
some familiar values to make this more intuitive.  Suppose you have a
5 V battery and a 220 Ohm resistor to charge up a 22 uH inductor.
There is an LED in series with a 220 Ohm resistor that wired in
parallel to the inductor.  When you switch off the battery power
source, how long will the LED remain lit?  The LED must have a supply
voltage above 1 V to stay lit.

```
I = V / R
t = -H / R * * ln (I_e / I_0)
H = 22 uH = 0.000022 H

V_0 = 5 V
V_e = 1 V
I_0 = 5 V / 220 Ohms ~= 20 mA = 0.000020 A
I_e = 1 V / 220 Ohms ~=  5 mA = 0.000005 A

t = -0.000022 H / 220 Ohms * ln (0.000005 A / 0.000020 A)
t =  0.0000001386e sec. = 0.139 us
```

Okay, that is a really short time for an LED to remain lit, like you'd
never even know you have an energy storage device at all.  Let's try
our "super-inductor" made by winding a single layer of 30 AWG magnet
wire around a toroidal ferrite core 22.6 mm in outside diameter.

```
H = 617758.919 uH = 0.617758919 H
t = -0.617759 H / 220 Ohms * ln (0.000005 A / 0.000020 A)
t = 0.003893 sec. = 3.893 ms
```

That barely makes for a nicer energy storage reservoir.  Now, if you
put that in an oscillator, that would result in an audible 257 Hz
frequency, that's like a C3 "middle C."

Now, take a good careful look at these equations.  One thing to
realize is that the effect of a resistor in discharging an inductor is
_opposite_ compared to using a resistor to discharge a capacitor.
Using a larger resistor when discharging a capacitor will increase the
time your capacitor can run before it is empty.  By contrast, using a
larger resistor when discharging an inductor will increase the supply
voltage until the current draw is the same, and by the equations, the
time to discharge the inductor will also decrease.  This is to be
expected since drawing a higher voltage at the same current draw
consumes more power, so the stored energy inside an inductor will run
out faster.  But, when you use a low-value resistor that allows lots
of current to run with ease, then the _same_ amount of current will be
supplied, but at a much lower voltage, which means the power draw will
be less and the inductor will run for longer.  This is also the reason
why using resistors in the flyback diodes of a motor driver circuit
allows the motor to slow down faster: the back EMF discharges faster
at the expense of experiencing higher voltages.

Suffice it to say, small inductors are not very useful for energy
storage per se.  Rather, their main uses are, of course, due to the
"special effects" of an inductor: boosting voltage, bucking voltage,
filtering radio frequencies, and generating magnetic fields.  Magnetic
fields, in particular, have many energy transfer applications:
solenoids and motors convert magnetic fields to kinetic energy, and
special "half transformers" can be used to "wirelessly" transfer
electrical energy over short distances without direct electrical
contact.

----------

Finally, with that knowledge in hand, we can explain how a transformer
works.  Why does power only flow through a transformer when it is
given an alternating current?  Because electromotive force,
i.e. voltage, is only induced in an inductor when there is a change in
current.  So, in order for power to keep flowing through to the other
side of a transformer, the current must keep changing.  Finally, we
know that the minimum frequency that current must keep changing at for
power to keep flowing is based off of the inductance of the coils:
larger inductance coils will take longer to charge up and discharge,
so electromotive force will continue to be induced for a longer period
of time, even when the current is not changing very quickly.
Therefore, larger coils are needed for low-frequency alternating
currents than for high-frequency alternating currents.
