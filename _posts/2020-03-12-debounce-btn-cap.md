---
layout: post
title: "Debounce a button using a capacitor, and RC filters explained"
date: 2020-03-12 23:36 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Can you debounce a tactile switch using a capacitor?  Well, let's
search around.  Now here are some stachoverflow folks who don't know
what they are talking about.

20200312/DuckDuckGo capacitor button debouncing  
20200312/https://electronics.stackexchange.com/questions/64770/is-it-possible-to-use-just-a-capacitor-to-debounce-a-button#64771

Okay, let's cut through that nonsense and I'll provide my own accurate
explanation.  Yes, you can debounce a tactile switch using a
capacitor, and you can also debounce a selector switch using two
capacitors.  Here's how.

A resistor together with a capacitor between your GPIO input and
power/ground acts as a low-pass filter.  It wil work with both pull-up
and pull-down circuits if wired correctly.  Here's how it works.
Either the capacitor is empty and it will need to be charged up, or it
is "full" (charged up to same voltage) and needs to be discharged.
Not until the capacitor charge and voltage changes will the voltage to
the GPIO input change.

For a pull-up input, wire the capacitor between the input and positive
voltage supply.  For a pull-down input, wire the capacitor between the
input and ground.  Although, if you are using ceramic capacitors, it
doesn't really matter which way you do it since the polarity is
invertable and actually both ways work.

<!-- more -->

----------

One problem with the Wikipedia articles on low-pass filters, high-pass
filters, and RC filters is that they don't really explain the
technical circuit aspects for having an operating RC filter very well.
Upon careful thought and closer examination of other circuits such as
the prominent RC filter circuits for Raspberry Pi audio, it occurred
to me that the common knowledge does not have a completely accurate
understanding of the implications of the design of RC filter circuits.

So, let me put forth my explanation about the operational circuit
requirements to have an actual functioning RC filter, starting with
explaining a low-pass filter since it is easier to explain.  (Refer to
the Wikipedia article for the diagram in the following discussion.)

20200325/https://en.wikipedia.org/wiki/Low-pass_filter

A low-pass filter, at the outset, seems easy to understand.  You have
your digital logic output, that's connected immediately to a resistor,
then you have a capacitor connected between that resistor's output and
ground.  The rate at which the capacitor charges and discharges is
controlled by the resistor and the capacitor's capacitance, and those
together determine the cut-off frequency.

However, there are several assumptions that must be fulfilled in order
for Wikipedia's simple calculation of the half-amplitude cut-off
frequency calculation of `1 / (2 * pi * R * C)` to hold.

* The digital logic output must be "fully buffered" and not an "open
  collector" design: a logic one is presented as the positive voltage
  source, a logic zero is represented as a path to ground.

* The digital logic output must be "low impedance," i.e. it is capable
  of supplying a large amount of current without a voltage sag.  At
  least relative to the subsequent analog input, that is.

  20200325/https://en.wikipedia.org/wiki/Line_level#Line_out

* The analog input must be "high impedance," i.e. it does not draw
  very much current, much like a load with a very high resistance
  would.

If these assumptions are not met, the low-pass RC filter DAC will not
function correctly.  Why not?

A capacitor only charges and discharges when there is a path for
current to flow.  If the output is an open collector output, charge
will flow into the capacitor at logic level one, but charge will not
flow out of the capacitor (at a reasonable pace) at logic level zero
because there is no path for the current to flow out of the capacitor.
What will happen is that the PWM signal with push the capacitor to a
higher and higher level until its voltage is nearly equal to that of
the positive supply voltage, and then it will be stuck at that logic
level one voltage.  Therefore, a fully buffered digital signal is
required for the capacitor to have a symmetric charging and
discharging profile.

The purpose of the resistor in the low-pass filter is to deliberately
take the low-impedance output and pin it to known impedance value.
Without a clearly known source impedance, you cannot calculate the
charging of the capacitor.  More importantly, if the source impedance
is too low, then the capacitor will have no effect on smoothing out
the waveform into an analog curve: since the source impedance is so
low, the voltage supplied to the analog input would be virtually equal
to the digital output.  The purpose of the resistor and capacitor
together is to deliberately cause a "voltage sag" condition when the
capacitor is empty of charge and is being charged with high current
draw, and not until the capacitor is "fully charged" does the analog
input receive the same voltage as the digital output.

You might have noted that some of the problems I've mentioned could be
solved if you had a low-impedance analog input.  So why, then, did I
specify a high-impedance analog input as a required assumption?  What
this comes down to is mainly the ability to calculate the specific
operation of the circuit, rather than the fundamental low-pass
filtering characteristics itself.  If you have additional
low-impedance current flow paths to discharge the capacitor, you must
take **all** of those together in your calculations in order to
properly calculate the cut-off frequency of your RC filter.  In the
case of a low-impedance analog input, this would require you to
calculate the resistance of resistors in parallel, which decreases the
resistance smaller than the smallest resistor in your circuit, and
that's generally not very intuitive when you are trying to target a
specific resistance in circuit design.  Adding the resistance of
resistors in series is much easier and more intuitive.

----------

So, let's return to our discussion of debouncing a tactile switch
using a capacitor.  At the outset, something sounds wrong about this.
A tactile switch conducts when it is pressed, and does not conduct
when it is released.  How, then, can you use a capacitor as a low-pass
filter with a tactile switch?

The answer here, is a rather tricky one.  You cannot get an ideal,
symmetric low-pass filter using a capacitor with a tactile switch, but
you _can_ get an asymmetric filter.  And, as it turns out, an
asymmetric low-pass filter is all you need to eliminate key bounce.
Key bounce is caused when there are both high-frequency _presses_
**and** _releases_.  If you have high-frequency presses, but
low-frequency releases, you've still eliminated key bounce, provided
that your low frequency releases are not so low that the capacitor
does not discharge fast enough.

The trick, here, comes down to the use of pull-up or pull-down
resistors.  Let's consider the case of a pull-down resistor.  When the
button is pressed, the capacitor charges at an non-deterministically
fast rate.  But, when the button is released, the pull-down resistor's
path to ground provides the other required leg of an RC filter.  The
rate at which the capacitor discharges can be calculated using the RC
filter equations.  Essentially, what you're doing is your taking a
square waveform and converting it into a sawtooth waveform.

Of course, the implications of this particular circuit presents a
little bit of a dilemma.  With a pull-down resistor, you want the
resistance value to be as high as possible to minimize the leakage
current consumption.  However, with an RC filter, you want to use a
relatively low value resistor so that your filtered output still has a
low impedance relative to your input.  How do you know what resistance
value to pick?

The ideal solution involves inserting a buffer IC chip between your
tactile switch output and your RC filter input.  This allows you to
use two separate resistors, each with ideal resistance values for the
primary purpose of the particular circuit.  Of course, that circuit
design costs more money, and the reason why you're asking this
question was probably quite deliberately because you were trying to
create a cheaper circuit that does not require a microcontroller for
debouncing.

So, I'll make my calls on this point about a good compromise.  For
pull-down resistors, 4.7K ohm is a good starting point, and 50K is
more ideal.  For RC filters, 100 ohm is ideal, but 220 ohm works
alright too.  So, if you make a compromise between those two ends, you
can end up trying out the use of a 1K resistor.  This should still
provide a low enough output impedance for most digital logic inputs,
while still minimizing leakage current as much as possible.

----------

Now, high-pass filters, that's a little bit trickier to explain, but
when you build an explanation based off of the previous knowledge I
covered in explaining low-pass filters, then it is fairly easy to
understand.  Again, the same assumptions must be withheld:

* The digital logic output must be "fully buffered" and not an "open
  collector" design: a logic one is presented as the positive voltage
  source, a logic zero is represented as a path to ground.

* The digital logic output must be "low impedance," i.e. it is capable
  of supplying a large amount of current without a voltage sag.  At
  least relative to the subsequent analog input, that is.

* The analog input must be "high impedance," i.e. it does not draw
  very much current, much like a load with a very high resistance
  would.

So, with those assumptions in place, we can present the circuit
design.  The capacitor blocks the path from digital output to analog
input, and on the output side of the capacitor, the resitor provides a
path to ground.  (Refer to the Wikipedia article for the diagram in
the following discussion.)

20200325/https://en.wikipedia.org/wiki/High-pass_filter

So, let's explain how this works.  Of course because we do have a
capacitor on the path between output and input, a steady voltage will
not allow current to flow for long: the capacitor will get charged and
prevent any more current from flowing.  The resistor to ground
provides a current path with a clearly known resistance which (1)
controls the rate of charging/discharging of the capacitor and (2) is
selected such that only a negligible amount of current is consumed by
the analog input compared to the operation of the RC filter circuit.
Again, the fully buffered input is the key to deterministic operation
of the low-pass filter RC circuit: without the ability of the digital
input to provide a path to ground, the capacitor would never be able
to discharge properly.  When a path to ground is provided, current can
discharge by looping through ground and through the resistor.

----------

Now, the real challenges and pitfalls come into explaining the
combination of both a high-pass filter and a low-pass filter.  This is
a stumbling point for many, simply because you cannot compute the
values for the two separate modules and plug them together.  Rather,
the modules are, in essence, intertwined.

Take for example this misguided explanation of the Raspberry Pi's
audio on Hackaday.  (Please also refer to the article for the diagrams
in the following discussion.)

20200325/https://hackaday.com/2018/07/13/behind-the-pin-how-the-raspberry-pi-gets-its-audio/

The numbers derived for the low-pass filter... they are almost
accurate, only off by a factor of two when discharging.  But the
high-pass filter numbers, they are way off.

So, how do you properly understand this circuit?  Start with the
low-pass filter.  Take a good careful look at _all_ current paths you
can trace from one side of the capacitor to the other.  You'll notice
that there are in effect two parallel resistor paths... so for the
path of discharing that resistor, you must compute the effective
resistor value from those resistors in parallel.  Then you'll know the
roll-off freqeuncy for the _discharge_ side of the waveform.  What
about the charging side of the waveform?

Well, this is a bit tricky to understand, you must take into
consideration all of the ways in which the circuit setup could be
interpreted.

* The two resistors form a _voltage divider_ across the capacitor.
  The capacitor, therefore, can only be charged to a fraction of the
  digital output.

* The parallel resistor with the capacitor is a type of _bleeder
  resistor_.  It causes the capacitor to discharge more quickly than
  it otherwise would if left on its own.

* The parallel resistor and capacitor together is a type of low-pass
  filter.  However, this type of low-pass filter does not affect the
  output voltage, it only has a low-pass filter effect if fed by a
  _current source_.  This is explained in the RC circuit Wikipedia
  article:

  20200325/https://en.wikipedia.org/wiki/RC_circuit

Altogether, this is tough stuff to understand.  With so many potential
interpretations at play, how does the final charging frequency
filtering behavior look like?  I'll make my call.  The parallel
resistor causes no interaction in changing the charging frequency
filtering.  It does, of course, act as a voltage divider that limits
the maximum voltage the capacitor can get charged to, but because RC
filters are defined independent of voltage (and we are using a voltage
source rather than a current source), this does not affect the cut-off
frequency when charging.  The statement of the parallel resistor
behaving as a "bleeder resistor" is indeed correct with our previous
analysis noting that it causes an effective lower resistance during
discharge.

Now, let's analyze the touted "high-pass filter" section of the
circuit.  Now, this is where the explanation about what's really going
on can get really convoluted.  Particularly it's the most convoluted
with the original Raspberry Pi, so let's start there.

The first problem you see here... there's no resistor on the
"back-end" of the high-pass filter capacitor.  How then does the
high-pass filter capacitor charge and discharge?  The answer lies in
one of the assumptions I've warned not to make... the assumed
impedance of the audio input connection provides a path for the
current to flow.  Typically this will be 10K ohms, but you can never
be sure that this resistance will be the same across all kinds of
different audio devices that the user may plug in, it could get as low
as 600 ohms.  So, the high-pass filter does not have a clear filter
frequency, but rather an approximate range of filter frequencies.

What then does the other resistor do that is between the low-pass
filter and high-pass filter capacitors?  That has somewhat of the same
effect on the high-pass filter as it does on the low-pass filter... it
increases the discharge rate but it doesn't affect the charge rate.
For discharging the high-pass filter capacitor, there are two parallel
resistor paths to take, the 150 ohm path to ground and the 270 ohm
path to the digital output.  Now, we can assume the digital output
will only be a path to ground say 50% of the time, so effectively as
far as current draw is concerned, we can double that resistance value
to 540 ohms.  So, what is the parallel resistance in front of that
capacitor?

```
R = 1 / (1 / 540 + 1 / 150) = 117.391
```

Okay, 117 ohms, not too far off from the Hackaday article on that
resistance leg.  But, the larger resistance leg they failed to account
for was the current path through the audio output.  This is
effectively a resistor in series, so you must add this resistance,
117 + 10000 = 10117.  Worst case impedance, 600 + 117 = 717.  In any
case, the resistance along that current path is dominated by the
output impedance.

So, what is the cut-off frequency range of the high-pass filter?

```
min = 1 / (2 * pi * 0.000010 * 10117) = 1.573 Hz
max = 1 / (2 * pi * 0.000010 * 717) = 22.197 Hz
```

Not too bad... it's just the uncertainty of not knowing for sure what
the cut-off frequency of the high-pass filter may be.

Now, the Raspberry Pi 3 improves upon the old circuit design by adding
a 1.8K ohm resistor to ground on the output side of the high-pass
filter capacitor and in parallel with the analog output.  This allows
us to pull the minimum cut-off frequency up higher to a known value in
the case of a high-impedance output, but in the low-impedance output
case, the minimum cut-off frequency is pretty much the same.

```
front resistance = 1 / (1 / 440 + 1 / 100) = 81.481
min rear resistance = 1 / (1 / 1800 + 1 / 600) = 450
max rear resistance = 1 / (1 / 1800 + 1 / 10000) = 1525.424
min cut-off = 1 / (2 * pi * 0.000047 * 1606) = 2.109 Hz
max cut-off = 1 / (2 * pi * 0.000047 * 531) = 6.377 Hz
```

Now, that's much better.  I mean, the difference between the minimum
and maximum frequency cut-offs is much smaller.  That means the
high-pass filter's behavior is much more deterministic and independent
of the specific impedance of the connected audio device, especially
compared to the old design.

So, that pretty much concludes are discussion and analysis about
combined low-pass + high-pass filters.  As you can see, it is quite
complicated to analyze and understand the operation of low-pass +
high-pass filters.  One more key that must be understood: the low-pass
filter section must **always** be in front of the high-pass filter
section, otherwise your circuit will not work as intended.
