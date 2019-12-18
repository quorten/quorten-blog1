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
20191109/https://www.ecstuff4u.com/2018/05/difference-between-thyristor-and-mosfet.html

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
to that purpose.  On the other hand, when there are _several_
simultaneous outputs supported tied to one big central clock, that can
considerably increase the cost of the ADC.

Finally, an additional useful feature of an expensive ADC is to
provide not just a single PCM register per input, but an entire buffer
of consecutive PCM values, thus allowing high-frequency data to be
buffered up and read out in bulk by a non-realtime process.
Interrupts can be issued at particular fullness intervals, and also to
indicate if a "buffer overrun" occurs.  That is, a failure to read the
buffer fast enough resulted in old samples being overwritten by new
samples and therefore lost.  Sound hardware is one of the primary use
cases where the more advanced ADC and DAC features justifies the cost.

But, ultimately, there's more than one way to construct an full-system
ADC, some methods being more expensive than the others.  The Wikipedia
article on the subject provides a less-organized but more
comprehensive treatment.  The main issue with ADC quality is that
"cheap" ADCs are technically not "single-chip" designs, and therefore
they are more susceptible to any source of noise and error,
temperature dependence being but one of the sources.

20191116/https://en.wikipedia.org/wiki/Analog-to-digital_conversion

That being said, the full design of the most conventional analog to
digital conversion setups I've mentioned in this article can be
described in these main stages, with a variety of implementation
techniques for each stage.

1. Generation of an analog conversion clock signal
    * Local oscillator
    * Microcomputer-generated oscillating signal, PDM with low-pass
      filter
    * Microcomputer-generated trigger signal, capacitor discharge
      sawtooth
    * Microcomputer-generated successive approximation signal
2. Conversion from analog to PDM
    * Comparator-based PDM conversion
    * 555 one-shot timer pulse, comparator embedded
    * Comparator-based successive approximation
3. Conversion from PDM to PCM
    * Local counter-based converter
    * Software-based full period cumulative
    * Software-based trigger pulse timing
    * Software-based successive approximation, PCM value in
      approximation output register
4. PCM sample processing
    * Immediate, realtime sample processing
    * Hardware sample buffering, delayed processing in bulk
    * Software sample buffering, delayed processing in bulk

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

----------

Another notable discussion point is latency of ADCs.  Referring to the
steps mentioned above, the primary areas where latency are introduced
are in conversion from PDM to PCM, known as _quantization latency_,
and buffering of PCM samples.  Notably, conversion from analog to PDM
doesnn't technically need to introduce very much latency, the primary
source of latency is from the analog signal traveling through the
comparator gates.  Quantization latency is inevitable, but buffering
latency can be minimized by using the smallest possible buffers.  Of
course, the 555 timer technique and successive approximation technique
necessarily roll other steps together that do introduce more latency.

Another related problem is generating an analog conversion clock
signal using a microcomputer.  If you use a cheap low-pass filter as
your digital to analog converter, you are necessarily rather limited
in the frequency by which you can generate your analog conversion
clock, which necessarily limits your ADC input frequency to much less
than your DAC output frequency.  In the vein that generating a
sawtooth or triangle wave and feeding it to a comparator is
essentially a format of successive approximation, you might as well
just do that instead to get a faster response time.  Likewise, in this
vein, it turns out that the 555 timer approach is also a faster way to
generate the analog conversion clock: a one-shot sawtooth waveform is
generated via a capacitor discharge.  So, we can rank the cheap ADC
conversion techniques in terms of speed, from slowest to fastest.

1. Class-D amplifier style ADC, sawtooth/triangle signal is generated
   by microcomputer PDM with low-pass filter.
2. Successive approximation using low-pass filter for DAC.
3. 555 timer approach, capacitor as one-shot sawtooth wave generator,
   microcomputer drives leading edge of conversion clock.
4. Class-D amplifier style ADC, sawtooth/triangle signal is generated
   via a local oscillator.

If you have an expensive ADC connected almost directly to the address
bus, then embedded PCM conversion and buffering can also contribute to
speed.  Otherwise, serial communications with an ADC with PCM
conversion embedded doesn't buy you much time compared to compared to
microcomputer PDM conversion.

Notably, the 555 timer technique is pretty much the best technique
overall.  Like successive approximation, it also requires one
capacitor and one comparator, but it is faster and still pretty cheap.

On the other hand, the successive approximation technique does have an
advantage of a sort: it does not require a realtime software timing
loop to get accurate results.  That is, accurate to the limits of the
DAC and comparator.
