---
layout: post
title: Simplistic gate array simulation discussion
date: 2019-06-27 19:23 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

So, I have my simplistic gate array simulator that I designed mainly
with one goal in mind... simplicity, and some semblance of being an
accurate yet simplified hardware simulator.  Okay, initially, my goal
was to only simulate a single type of gate, and then build everything
else up from that.  That idea was short-sighted because it made it
impossible to adjust a simple square wave timer loop.  Why?  The goal
is to start the timer loop by creating a nominal delay in a ring
oscillator, then using frequency divider, i.e. counter, circuits to
slow it down to the desired frequency.  Unfortunately, if you build
your timer's inner loop out of only NAND or NOR logic gates, then it
is not possible to create a slower clock signal using a ring
oscillator: _every_ stage of your design results in an inversion of
the signal at the highest possible frequency.

This issue was rather crippling for my earliest of design iterations
and testing.  I spent quite a bit of time debugging why my counter
circuits were not performing as expected.  The problem, of course, was
that they were being fed much too fast of a signal to be able to
compute the correct values deterministically.

So, we need some non-inverting logic too, solely for the purpose of
being able to create correct timing loops.  NAND + OR logic is my
choice, for the following reasons.

<!-- more -->

First of all, there is another possible alternative implementation of
the simulator that is pretty nice from a conceptual standpoint, but
impractical from a CPU-based simulation standpoint.  Rather than using
two input, one output gates, you can use one input, one output gates.
This makes for a more beautiful and symmetric design.  Your gates take
a signal from a source, and either copy it (diode) or invert it (NOT
gate) at its destination.  If you have more than one output routed to
a single wire, you simply compute the value as follows.  At the start
of a simulation cycle, you zero all the initial wire values.  Then as
you compute each output, you OR-accumulate it to the wire value.

Unfortunately, as it turns out, there is higher computational overhead
in simulating this kind of design on a CPU compared to my original
design option.  When you have two input, one output gates, the nominal
simulation of this rather common logic gate is faster, of course.
And, with the simulation rule that there can only be one output to
every single wire, you eliminate the need to zero all wires.

Finally, there still is a sense of elegance in NAND + OR simulation.
A NAND gate can be implemented by wire-ORing two NOT gates together.
An OR gate can be implemented by wire-ORing two diodes together.
Matter of fact, you could use a compiler to convert one design to the
other before simulating it.

Finally, there's a question of how to specify the data format of this,
now that we've got two types of gates.  My recommendation is to
specify the data as two separate "masks".  So, this means either two
separate files or a container format that contains two separate
objects.  Again, this is the fastest way to simulate, rather than
storing gate types and decoding that in a loop.

And that's about as good as you can get for a gate array simulator on
a CPU.  If you want to go any faster than that, then you need to go
FPGA-style or use higher-level register-width primitives in your
simulation.
