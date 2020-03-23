---
layout: post
title: Inductors explained
date: 2020-03-19 15:35 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

TODO FIXME: Work in progress blog article.

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
therefore, inductors.  The key caution of channeling the _back-emf_
through protective diodes when controlling motors using modern CMOS
semiconductor microcontrollers is because of this propety of
inductors: when you switch off the power to a motor to deliberately
cause high resistance to it to prevent continued motor motion, you are
in effect trying to increase the resistance to an inductor.
Therefore, the inductor will respond by boosting the voltage to try to
keep the current flow the same.  Therefore, rather than trying to
completely resist this current flow and loose when the voltage spikes
so high it destroys your CMOS semiconductor microcontroller, you
instead provide a more desirable path for this high voltage current to
dissipate through instead, until there is no more current that must be
dissipated.

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

LINK!

An inductor resists changes in current as defined by the following
differential equation.

```
emf = -H * dI/dt
```

Electromotive force, i.e. voltage, is proportional to the inductance
times the change in current over the change in time.  A negative sign
is used to indicate that this is an opposite, opposing voltage
compared to the supply voltage and current.  For a linear inductor
with a load that linearly changes in current over time, simple delta
computations can be used to determine the voltage over the given time
period.  Inductance is measured in a unit called "Henry": One Henry of
inductance means that a change in one Ampere of current over one
second supplies one volt.

But, more typically, you'd have a constant resistance load and you
want to know how long it will be powered above a certain voltage after
a nominal supply voltage and current has been removed.  To determine
this, you have to solve a differential equation using Ohm's law as the
function being integrated.

No... okay, this is how we do it.  We compute the beginning and end
current at the desired voltage and resistance.

```
I = V / R
```

Resistance is constant, so substitute the beginning and end voltage to
get the beginning and end current.

```
I_1 = V_1 / R
I_2 = V_2 / R
```

Using the beginning and end currents, we can then proceed to take the
linear equation of an inductor to determine the beginning and end
times.

```
emf = -H * dI/dt
I = H * t
t = I / H
```

Convert our linear increasing induction equation to the decaying form.

```
-t = I / H
-t = (I - I_1) / H
t = (I_1 - I) / H
```

Now we can solve for delta_t.

```
t_1 = (I_1 - I_1) / H
t_2 = (I_1 - I_2) / H
delta_t = t_2 - t_1
```

```
t_1 = 
delta_t = 
```

```
delta_I = I2
```

```
y = x
dy/dx

x dy/dx
x d/dx

emf = -H * delta_I/delta_t

R = y/x
So... it's a rate of change, it's the derivative.
R = 1 y/x
We need to integrate to get the function in terms of time directly.
integrate R
y = x
Now when we have the function in terms of time, we can solve for x
when y = 0.  How?  Substitute 0 for y, then solve for x.
0 = x
x = 0
Just like that.

Okay, back to business.

emf = -H * dI/dt
-emf / H = dI/dt
-emf / H = F'(t)
F(t) = I = t
I = V / R
```

Okay, that's a lot of nonsense.  Let's regress to capacitors.

```
C = Q / V
```

That defines the charge in a capacitor.  How do we know how long it
takes to charge a capacitor?

```
I = -C * dV/dt
```

What the heck does all this mean?  First of all, we want to know how
long it takes to charge up a capacitor to a voltage.  That,
ultimately, depends on the capacitance.  Larger capacitance, longer
time.

But capacitors, like I said, are kind of like batteries, so we can
take it all together to make it simpler.

```
C = Q / V
V = Q / C
V = IR
I = -C * dV/dt
I = V / R

I = Q / (C * R)
Q / (C * R) = -C * dV/dt
Q / R = -C^2 * dV/dt
Q = -R*C^2 * dV/dt
```

Okay, let's back up.  What is charge?  It is a measure of current
transported over time.

http://en.wikipedia.org/wiki/Coulomb

----------

Watt-hours = voltage x current x time
charge = current x time

Here's the key to remember.  A battery can only be specified
in Watt-hours at a particular voltage.  So to determine the runtime
at a different voltage draw, you must first convert to amp-hours.

85 Wh @ 85 W = 1 hr
85 Wh @ 40 W = 2.125 hr

Okay, that makes sense.  Of course, half voltage draw means
half power draw.

Now, what about amp-hours?  Divide by voltage to get amp-hours
from Watt-hours.

85 Wh / 11.3 V = 7.522 amp hours = 7522 milli-amp hours

Now of course a battery is typically rated to provide power only
at a specific voltage.  And, in fact, you can only draw power at
that voltage directly from the battery, a switched-mode power
supply is required if you want less.  So if you want a runtime
at a different voltage, you need to convert to watt-hours first.
But amp-hours is the most elementary measure of charge.

ah, wow... laptop batteries

But this brings up the point.  You wanted to know how much charge is
in a capacitor?  Just like a battery, given the charge number, it is
the current times the time, that is how much charge has flowed out.

And why do we observe a non-linear response in circuits?  Because as
the charge drops, so does the voltage, given capacitance is constant.
So, this means that resistive loads will consume less current as the
capacitor runs low, so it will last longer.  And, hence, the
long-tailed curve.

Okay, so that means we know how to define Ohm's Law when the voltage
source is a capacitor rather than a constant voltage source... sort
of.

```
C = Q / V
V = I * R
```

The key relation here is the current draw.  What we need to solve for
is the current draw over time, that defines how much charge is left
inside the capacitor.  And for purely resistive loads, current draw is
proportional to voltage.  Which, for the capacitor, is proportional to
charge.

```
I = V / R
V = Q / C
```

So, the equation which defines the current draw of the purely
resistive load based off of the charge inside the capacitor.

```
I = Q / (C * R)
```

Charge itself is defined as current times time.

```
I = I * t / (C * R)
```

Does this make sense?

```
t = C * R
```

As resistance increases, so does time to zero charge.  As capacitance
increases, so does time to zero charge.  Yes, that does make sense.

But, that's not fully accurate, so to speak.  We've got to use the
tools of Calculus to correctly understand this.

```
I = Q / (C * R)
```

What we can understand, we can take a tiny slice of time and compute
how much current flows during that time by computing the equation at a
single instant.

```
delta_Q = I * delta_t = Q * delta_t / (C * R)
```

Now we want to define a series that will compute the remaining charge
after a number of time steps.  The initial charge is a precomputed
constant.

```
Q_1 = Q_0 - Q_0 * delta_t / (C * R)
Q_1 = Q_0 * (1 - delta_t / (C * R))
```

So it should become clear that this is a geometric series where the
stepping term is equal to `1 - delta_t / (C * R)`.  So we can
represent that in an equation.

```
Q_n = Q_0 * (1 - delta_t / (C * R))^n
```

Now let's convert from an "n" integer stepping term to a quantized
time value.

```
Q_t = Q_0 * (1 - delta_t / (C * R))^(t/delta_t)
```

Now we want to take the limit as `delta_t` approaches zero to get an
equation in terms of time and charge.

```
Q_t = Q_0 * (1 - delta_t / (C * R))^(1/delta_t)^t
```

Okay, how about this.  Try an example.  You have a 220 uF capacitor
charged up to 5 volts supplying current to a 220 ohm LED.  How long
can the LED be powered above 0.5 volts?

Starting conditions.

```
C = Q / V
Q = C * V

R = 220 ohm
C = 220 uF = 0.000220 F
V_0 = 5 v
Q_0 = C * V_0 = 0.000220 F * 5 v = 0.001100 C
V_e = 0.5 v
Q_e = C * V_e = 0.000220 F * 0.5 v = 0.000110 C
```

Now, let's verify initial condition calculations.

```
C = Q / V
Q = C * V

R = 220 ohm
C = 220 uF = 0.000220 F
V_0 = 5 v
Q_0 = C * V_0 = 0.000220 F * 5 v = 0.001100 C


I_0 = Q_0 / (C * R)
I_0 = 0.001100 / (0.000220 * 220)
I_0 = 0.023 A = 22.727 mA
I_0 = V_0 / R
I_0 = 5 / 220 = 0.023 A = 22.727 mA
```

Okay, that looks good, initial conditions calculations check out both
ways.  At that rate of current draw, the charge would have been
consumed in 0.048 seconds.  But we know there is a slumping current
draw curve due to a slumping supply voltage and a purely resistive
load, so the actual runtime from the full capacitor equation should be
longer than that.

Now let's solve for `t` using a `delta_t` of 1/1000 second.

```
Q_t = Q_0 * (1 - delta_t / (C * R))^(1/delta_t)^t
0.000110 = 0.001100 * (1 - 0.001 / (0.000220 * 220))^(1/0.001)^t
0.000110 = 0.001100 * (1 - 0.001 / 0.048400)^(1/0.001)^t
0.000110 = 0.001100 * (1 - 0.020661)^(1/0.001)^t
0.000110 = 0.001100 * 0.979339^(1/0.001)^t
0.000110 = 0.001100 * 8.571e-10^t
0.1 = 8.571e-10^t
log 0.1 = log 8.571e-10^t
log 0.1 = t * log 8.571e-10
t = log 0.1 / log 8.571e-10
t = 0.11
```

Okay, that looks pretty good!  Indeed we get a time longer than our
initial prediction, and does this converge if we use delta_t =
1/10000?  Yes, the result is now 0.111.  Great job!

Now what if I doubled resistance, and used 1/1000 time steps?

```
Q_t = Q_0 * (1 - delta_t / (C * R))^(1/delta_t)^t
0.000110 = 0.001100 * (1 - 0.001 / (0.000220 * 440))^(1/0.001)^t
0.000110 = 0.001100 * (1 - 0.001 / 0.096800)^(1/0.001)^t
0.000110 = 0.001100 * (1 - 0.010331)^(1/0.001)^t
0.000110 = 0.001100 * 0.989669^(1/0.001)^t
0.000110 = 0.001100 * 3.091e-05^t
0.1 = 3.091e-05^t
log 0.1 = log 3.091e-05^t
log 0.1 = t * log 3.091e-05
t = log 0.1 / log 3.091e-05
t = 0.222
```

Okay, so we know that despite our equations going to weird limits,
they are in fact correct, as doubling the resistance doubles the run
time.

Now we just have to compute the final limit on this equation, when
`delta_t` approaches zero.  What do we get?  Indeed, we should get
some sort of exponential decay equation.

```
Q_t = Q_0 * (1 - delta_t / (C * R))^(1/delta_t)^t
```

Okay, so here's the deal.  So far, we can see that this is indeed an
exponential decay equation.  Suffice to say, the constant terms can be
simplified as follows:

```
Let D = (1 - delta_t / (C * R))^(1/delta_t)
Q_t = Q_0 * D^t
```

And now this can be converted to a base-e exponential equation using
the logarithm and exponent laws.

```
ln Q_t = ln (Q_0 * D^t)
ln Q_t = ln Q_0 + t * ln D
Q_t = Q_0 * e^(t * ln D)
```

Let's try to understand the convergent trickery in D:

```
D = (1 - delta_t / (C * R))^(1/delta_t)
D = ((C * R - delta_t) / (C * R))^(1/delta_t)
Let idelta_t = 1 / delta_t
D = (1 - 1 / (idelta_t * C * R))^(idelta_t)

(1 - 1 / (N * x))^x

D^delta_t = 1 - delta_t / (C * R)
D^delta_t + delta_t / (C * R) = 1
(C * R) * D^delta_t + delta_t = C * R
delta_t = C * R - (C * R) * D^delta_t
```

KEY POINTS TO UNDERSTAND:

Exponential growth differential equation:

dy/dt = ky

The only solutions to these exponential growth differential equations:

y(t) = y(0) * e^(k*t)

BAD WORK:

```
Let F = (1 - delta_t / (C * R))^(1/delta_t)
Q_t = Q_0 * F^t
F = ((C * R - delta_t) / (C * R))^(1/delta_t)
F = (C * R - delta_t)^(1/delta_t) / (C * R)^(1/delta_t)
Let G = (C * R - delta_t)^(1/delta_t)
Let H = (C * R)^(1/delta_t)
F = G / H

y = x^(1/x)
log y = log x^(1/x)
log y = 1/x * log x
x * log y = log x
```

----------

JJJ TODO!

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

JJJ TODO:

Ideas for next blog articles:

* Please explain inductors, back-emf is voltage, and this induced
  voltage is what allows current to flow through the other side of
  transformers.
