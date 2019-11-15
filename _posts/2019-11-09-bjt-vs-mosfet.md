---
layout: post
title: "BJT, MOSFET, and thyristors compared, discussion on ADCs"
date: 2019-11-09 21:21 -0600
author: quorten
categories: [raspberry-pi, reiterate]
tags: [raspberry-pi, reiterate]
---

What's the difference between a BJT and a MOSFET transistor?
Wikipedia has lots of information on the individual devices per se,
but not much in the way of how they differ.  So I go searching the
larger Internet for an answer, and indeed a good answer I have found.

* BJT transistors are _current-controlled_ devices, but MOSFET
  transistors are _voltage-controlled_ devices.  Thus a MOSFET only
  consumes gate power during switching, but a BJT transistor base
  power continuously.

  Thus, if you have a circuit that requires current to flow freely
  through the base of a BJT transistor, say in the cases of capacitor
  timers/oscillators and low-pass filters, a swap-out to a MOSFET
  transistor will not fully work as intended.  This is also the reason
  why MOSFETs are used primarily in digital switching circuits for
  power or logic rather than as amplifiers per se.

  However, if you convert your analog signal into a digital signal for
  the MOSFET amplification stage and keep the low-pass
  resistor-capacitor network outside of the MOSFET stage, then you can
  construct an amplifier using MOSFETs.  The Class-D amplifier is an
  excellent example.

  BJT transistors are sometimes useful when your primary goal is to
  minimize the cost of a circuit.  An audio DAC and amplifier can be
  built more cheaply using a BJT transistor as it allows you to use a
  smaller capacitor on the input-side of the amplifier rather than on
  the output-side as with a Class-D amplifier.

<!-- more -->

* MOSFETs can switch higher-power loads than BJT.  BJT is mostly
  confined to low-current circuits.

* MOSFETs work more efficiently at lower voltages than BJT
  transistors.

* MOSFETs can work at higher frequencies than BJT transistors.

20191109/DuckDuckGo mosfet versus bjt transistor  
20191109/https://www.elprocus.com/difference-between-bjt-and-mosfet/  
20191111/https://en.wikipedia.org/wiki/Power_MOSFET  
20191111/https://en.wikipedia.org/wiki/Class-D_amplifier  
20191111/https://en.wikipedia.org/wiki/Comparator  
20191111/https://en.wikipedia.org/wiki/Differential_amplifier  
20191111/https://en.wikipedia.org/wiki/Operational_amplifier

Note that an op-amp is also useful for converting differential
signaling serial communications to ground-based logic levels, for
input into your microprocessor.  Please note that the more specific
name of such dedicated chips is _line drivers_.

Now, what about thyristors?  A thyristors is only usable as a
two-state switch, not as an amplifier.  Also, thyristors are better
for higher-power applications than MOSFETs.  Thyristors are also less
sensitive to temperature than MOSFETs.

20191109/DuckDuckGo thyristor versus mosfet  
https://www.ecstuff4u.com/2018/05/difference-between-thyristor-and-mosfet.html

----------

Okay, so what about this whole slew of "cost-saving" techniques for
analog to digital signal conversion for microcomputers?  I have now
accumulated a list of no less than four major techniques.

1. Use a purpose-built ADC chip.

2. Apple II and IBM PC game port trick: Use a 555 timer chip to
   convert an analog signal into a proportional pulse duration.

3. Intel 4004 documentation trick: Use a comparator and a DAC with a
   successive approximation technique.  Again, I reiterate, a cheap
   DAC can be constructed via a simple resistor-capacitor low-pass
   filter.

4. Class-D amplifier trick: Use a comparator with a triangle (or even
   sawtooth) wave generator to generate a digital PDM signal.

20191111/https://en.wikipedia.org/wiki/555_timer_IC

So what makes the 555 timer chip cheaper than the alternatives?  The
555 timer chip also uses a comparator circuit inside (so there are no
cost savings from eliminating this component), and technically it
requires a repetitive trigger signal to be sent that is not dissimilar
to the triangle wave required in the Class-D amplifier approach.  My
understanding is that the main cost savings were highly situational.
_At the time_, the 555 timer chip was pretty popular and in production
for quite a long time, so those chips were cheaper than some other
very similar chip designs.  Also, the specific implementation also
makes the microcomputer ADC programming arguably simpler: only a
single counter variable is required to measure the pulse width from
the start of the trigger signal.  A PDM conversion technique, by
contrast, would require two counter variables: one to measure the
period, a second to measure the duty cycle.

Okay, so what about the criticism of the PC gameport having terrible
analog to digital conversion fidelity and being highly temperature
dependent?

20191111/https://lists.gnu.org/archive/html/qemu-devel/2005-03/msg00266.html

Okay, so first of all, maybe my assertion about those claiming
temperature dependence issues was a myth for this particular instance.
But, as I see it, the only part that makes it temperature dependent is
the capacitor for the timing circuit, everything else is precisely
identical to using any of the other ADC techniques.  I think the main
criticism against the PC gameport style ADC is that it requires a
realtime software timing loop in order to get accurate measurements.
But so do all the PDM-style conversion techniques.

So, what makes an ADC more expensive?  I think it must mainly be the
idea that an ADC can hand digital integers straight to you, rather
than requiring you to build your own from PDM data.  For that, an ADC
requires a built-in counter circuit and buffer to separate the
previous value and the computation-in-progress value.  Essentially,
this can be described as conversion from PDM to PCM.

The other, less significant, thing that makes an ADC more expensive is
the local oscillator required for the comparator circuit to convert
from analog to PDM.  This cost can be amortized when a single chip
provides for multiple ADC inputs, since the local oscillator signal
can be shared across all the ADC input comparators.  Conversely, in
the event that you use your microcomputer to generate the analog
conversion clock signal, you must sacrifice one GPIO pin to dedicate
to that purpose.

So, the full design of any analog to digital conversion setup can be
described in these main stages, with a variety of implementation
techniques for each stage.

1. Generation of an analog conversion clock signal
    * Local oscillator
    * Microcomputer-generated oscillating signal
    * Microcomputer-generated trigger signal
    * Microcomputer-generated successive approximation signal
2. Conversion from analog to PDM
    * Comparator-based PDM conversion
    * 555 one-shot timer pulse, comparator embedded
    * Comparator-based successive approximation
2. Conversion from PDM to PCM
    * Local counter-based converter
    * Software-based full period cumulative
    * Software-based trigger pulse timing
    * Software-based successive approximation, PCM value in
      approximation output register

Notably, all conversion techniques require a comparator, that's the
one electronic circuit component that you cannot get around.

The Wikipedia articles contain the equations on how to calculate the
cut-off frequencies of low-pass filters and high-pass filters.

```
R = resistance in ohms
C = capacitance in farads
Cut-off frequency: 1 / (2*pi*R*C)
```

Also note that the "cut-off frequency" is better understood as a
"roll-off" frequency.

20191111/https://en.wikipedia.org/wiki/Low-pass_filter  
20191111/https://en.wikipedia.org/wiki/High-pass_filter
