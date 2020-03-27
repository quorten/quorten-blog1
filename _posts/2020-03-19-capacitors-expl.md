---
layout: post
title: Capacitors explained
date: 2020-03-19 15:25 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

In the midst of trying to explain inductors, I realized that to be
able to have a really good understanding of inductors, you need to
have a really good understanding of capacitors.  And, well, capacitors
are quite tricky to properly understand, but they are somewhat easier
to understand due to their similarity to batteries.  But, the point
is, amidst my attempt to explain inductors, I needed to have a clear
explanation of capacitors.  So here I am.

First of all, a very brief explanation of batteries as they relate to
capacitors.  Often times, a battery is modeled in a circuit simply as
a fixed voltage source.  The current in the circuit can then be
computed using Ohm's Law:

```
I = V / R
```

20200319/https://en.wikipedia.org/wiki/Ohm%27s_law

However, true batteries don't last forever.  Their lifetime is based
off of how much electricity is consumed from them.  Which is what?
Intuitively, this is energy.  For electricity, these are the pertinent
equations:

```
E = P * t
P = V * I
```

<!-- more -->

A battery, of course, supplies a "fixed voltage," though when it runs
low, the voltage sags.  But first, let's assume the voltage is fixed.
That means that the only unknown left to computing the energy
consumption is the current draw.

For purely resistive loads such as an incandescent light bulb, the
current draw is proportional to voltage.  By extension, an LED, by
virtue of using a resistor in series with the LED, can also be treated
as a purely resistive load.  So, now it should be obvious that it is
straightforward to compute the current draw from a battery with a
purely resistive load attached: just use Ohm's Law.

Okay, so let's do an example.  How much power does an LED in series
with a 220 Ohm resistor consume when attached to a 5 V battery?

```
I = V / R
I = 5 V / 220 = 0.022727 A = 23 mA
```

If the resistance of the LED on its own is assumed to be near zero,
that means we consume 23 mA of current.  Otherwise, we might actually
consume something closer to 10 mA or so.  Let's work with a 20 mA
figure for simplicity in the subsequent calculations.

```
P = V * I
P = 5 V * 0.020 A = 0.1 W
```

If our LED can run for 200 hours (8.3 days) on the battery, how much
energy does the battery store?

```
E = P * t
E = 0.1 W * 200 * 3600 s
E = 72000 J = 72 kJ
```

So our battery stores 72 kJ of energy.

Now, as it turns out, since we assumed that the battery supplies a
constant voltage, we really have no need for carrying the voltage
number through our energy calculations.  So we can eliminate that
variable and still get a number indicative of the battery's energy
storage and run time.  Of course, we still use voltage in the
calculation of current draw.

```
Q = I * t
Q = E / V
Q = 72000 J / 5 V = 14400 C = 14.4 kC
```

The unit of electric charge is Coulombs, whose base units are amperes
times seconds.  It's a measure of how much current is transported over
time.  The primary unit for measuring how much energy is stored inside
a battery is milliamp-hours (mAh).  You can see this is also a measure
of electric charge, since it is current times time.

20200319/http://en.wikipedia.org/wiki/Coulomb

Due to the fact that real batteries have a voltage sag as they run
low, they do in fact behave somewhat similar to capacitors.  The
equation of capacitance is as follows:

```
C = Q / V
```

This means that a capacitor's output voltage will sag as the available
charge runs low, due to the following:

```
V = Q / C
```

Here's another key to remember.  A battery's energy storage can only
be specified in milliamp-hours at a particular voltage... or an
effective capacitance which is determined by its voltage sag profile.
And, a battery can only have power drawn from it at a voltage
different than its nominal supply voltage via a switched-mode power
supply.  So to determine the runtime at a different voltage draw, you
must first convert milliamp-hours to watt-hours, then you can compute
the power draw of the connected device and compute the subsequent
runtime.  For example:

```
7083 mAh @ 12 V = 7083 mAh * 1 A / 1000 mA * 12 V = 85 Wh
Device power = 5 V @ 1 A = 5 W
85 Wh / 5 W = 17 h
Device power = 12 V @ 1.25 A = 15 W
85 Wh / 15 W = 5.67 h
```

Laptop battery calculations... you gotta love them.

----------

How do we know how long it takes to charge a capacitor?  The following
differential equation is given, based off of the information in the
two Wikipedia articles.

```
I = -C * dV/dt
```

20200325/https://en.wikipedia.org/wiki/Inductor
20200325/https://en.wikipedia.org/wiki/RC_circuit

What the heck does all this mean?  First of all, we want to know how
long it takes to charge up a capacitor to a voltage.  That,
ultimately, depends on the capacitance.  Larger capacitance, longer
time, assuming a resistor of known size is used when charging.

But capacitors, like I said, are kind of like batteries, so this is
the key to remember.  When charging a capacitor, it develops a
difference in potential, just like a battery.  Current only flows when
there is a difference in potential.  If you have a path wired between
two +3 V sources, no current will flow since the difference in
potential is zero.  Once you know the difference in potential, you can
compute the amount of current that will flow using Ohm's law with that
computed voltage.  This means that as a capacitor charges, the
difference in potential between the capacitor and the battery
decreases, so the current that flows into the capacitor also
decreases.  And, therefore, the rate at which it charges slows down as
it approaches the voltage of the battery.  Once it is equal to the
voltage of the battery, it cannot accept any more charge and develop
any higher of a voltage.

This means that the equation that defines the rate of charging of a
capacitor is an exponential growth equation, because the rate at which
a capacitor accepts current and increases its charge/voltage is
proportional to its existing charge/voltage level.

As it turns out, charge and voltage are directly proportional to each
other for capacitors, but since it is often times more useful and
easier to calculate using voltage, the exponential growth and decay
equations for capacitors are all specified using voltage.  I tried my
own hand at calculating the exponential growth and decay equations
using charge and I got stymied at solving the limit for the rate of
proportionality as the delta-time slice approaches zero.  Alas,
Wikipedia has solved the differential equations in terms of voltage,
so we will present them here and use them in our discussions.

So, let's solve this differential equation.  An exponential growth
differential equation has this form:

```
dy/dt = ky
```

The only solutions to these exponential growth differential equations
are of the following form:

```
y(t) = y(0) * e^(k * t)
```

We can solve using the capacitor equations as follows:

```
I = V / R
I = -C * dV/dt
V / R = -C * dV/dt
V / (-R * C) = dV/dt
let k = 1 / (-R * C)
kV = dV/dt
V(t) = V(0) * e^(k * t)
V(t) = V(0) * e^(-t / (R * C))
```

This equation can then be substituted and solved to get an equation to
determine how long it will take to charge or discharge a capacitor to
a specific voltage with the given resistance.

```
V_e = V_0 * e^(-t / (R * C))
V_e / V_0 = e^(t / (-R * C))
ln (V_e / V_0) = t / (-R * C)
t = -R * C * ln (V_e / V_0)
```

This equation actually tells us the time it takes to discharge a
capacitor.  To get an equation that tells us the time to charge a
capacitor, simply remove the negative sign.

Does this make sense?  Indeed it does.  A simple test circuit for a
capacitor connects a capacitor in parallel to a purely resistive load
such as an incandescent light bulb or LED.  Once the capacitor is
charged, the battery voltage source is removed and the capacitor
discharge powers the light.  As the capacitor discharges, the light
intensity decreases, but there is an non-linear curve such that the
light lasts longer at the lower charge than it does at the higher
charge.  This is consistent with the underlying equations that state
there should be an exponential growth/decay curve with both capacitor
charge and discharge: as the capacitor nears the end of charging, its
charge rate slows down.  Likewise, as the capacitor nears the end of
its discharging, its discharge rate slows down.

----------

Yeah, that's nice and correct and all, but where did that exponential
growth differential equation come from out of the blue?  Can you prove
by solving for it using the base equations of capacitors?  Indeed we
can... the question is am I able to do it?  We'll see.

The primary equation of a capacitor:

```
C = Q / V
```

Now, we want to start by defining a step-wise approximation equation
explaining how the voltage of a capacitor decreases based off of how
much current has flowed out of it.  We are discharging this capacitor
using a constant-value resistor.  Previously, I defined the equations
in terms of charge and got stymied.

```
V = Q / C
Q = I * t
I = V / R

Q = V * t / R

V_0 = Q_0 / C
V_n = Q_n / C
delta_t = t_n - t_0
delta_Q = Q_n - Q_0
I_0 = V_0 / R
delta_Q ~= -I_0 * delta_t

delta_Q ~= -V_0 * delta_t / R
Q_n = Q_0 + delta_Q
Q_n = Q_0 - V_0 * delta_t / R
Q_n = V_0 * C - V_0 * delta_t / R
Q_n = V_0 * (C - delta_t / R)
V_n * C = V_0 * (C - delta_t / R)
V_n = V_0 / C * (C - delta_t / R)
V_n = V_0 * C / C - V_0 * delta_t / (R * C)
V_n = V_0 - V_0 * delta_t / (R * C)
```

Okay, now I'm playing my trick.  We can rephrase this as a
differential equation by describing how change in voltage and change
in time are related.  The factor in the relation is the constant of
proportionality, and we can then solve the differential equation using
our knowledge on the required form of the known solution.

```
V_n = V_0 - V_0 * delta_t / (R * C)
V_n - V_0 = -V_0 * delta_t / (R * C)
delta_V = -V_0 * delta_t / (R * C)
delta_V / delta_t = -V_0 / (R * C)
```

Alright, so now that we have the deltas of both quantities, we can
rephrase into the final differential equation.  By taking the limit as
the deltas approach zero, `V_0 = V_n`, thus we can substitute `V` for
`V_0`.  And with the limit as the deltas approach zero, `delta_V /
delta_t` is the instantaneous rate of change, thus we can replace it
with `dV/dt`.

```
dV/dt = -V / (R * C)
let k = -1 / (R * C)
kV = dV/dt
```

And then we're right back to the earlier presented equations that were
left unsolved.

And, alas, I must also note.  Using charge instead of voltage wasn't
the real reason I got stymied, I got stymied because I did not look at
the problem at hand and realize it would be better to rephrase it as a
differential equation.  The key to the solution was to break away from
trying to solve `V_n` or `Q_n` based off of `V_0` or `Q_0` and instead
also change those variables into a delta.

So, the final question.  How do we get the differential equation with
current instead of resistance?  Simply use Ohm's Law to replace
resistance with current.

```
I = V / R
R = V / I
dV/dt = -V / (R * C)
dV/dt = -V * I / (V * C)
dV/dt = -I / C
I = -C * dV/dt
```
