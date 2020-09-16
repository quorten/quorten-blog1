---
layout: post
title: Determine capacitor values to use with crystal oscillator
date: 2020-09-14 15:24 -0500
author: quorten
categories: [raspberry-pi, mac-classic]
tags: [raspberry-pi, mac-classic]
---

Quartz crystal oscillators, one of the finest and cheapest ways to
keep track of time in a stable manner without a network connection.
The typical circuit connects a crystal and two capacitors to an
integrated circuit.  As explained in a [previous blog article]({{
site.baseurl }}/blog/2020/09/10/avr-xtal-dedicated), inside the
integrated circuit is a "clock generator" circuit which is basically
an inverting amplifier connected to the two pins of the crystal
oscillator circuit.

But, how do you determine the capacitor values that you need to use
for your crystal oscillator?  Here's how.  Look for the "load
capacitance" specification in your crystal's datasheet.  You must pick
two capacitor values that satisfy the following formula:

```
C_L = load capacitance of crystal
C_p = parasitic capacitance
C_1 = first capacitor
C_2 = second capacitor
C_L = 1/(1/C_1 + 1/C_2) + C_p
```

But, what is the parasitic capacitance?  It is the capacitance caused
due to fat traces, long traces, pins, leads, etc.  Generally, using a
value around 3-5 pF works well, obviously if you have less ideal wire
connections, you should use correspondingly larger values.

<!-- more -->

20200914/DuckDuckGo determine capacitor values to use with crystal
  oscillator  
20200914/https://electronics.stackexchange.com/questions/121659/how-to-select-capacitor-for-a-crystal-oscillator

Now, for the selection of the two capacitors.  Ideally, you would use
identical capacitor values, in this case you simply use twice the
value of `C_L - C_p`.  But in the real world, that might land you
needing to use rare capacitance values, so that will cost you more to
manufacture.  In that case, using different values will allow you to
reduce the overall cost of the system.

For example, suppose you want to use a 32.768 kHz crystal oscillator
with a load capacitance of 12.5 pF.  The symmetric capacitor value
calculation gives you the following:

```
(12.5 - 4.5) * 2 = 16 pF
```

Those capacitors are hard to come by so they cost more.  On the other
hand, you can choose a 10 pF and a 33 pF capacitor and the equation
will still be well satisfied.

```
1/(1/C_1 + 1/C_2) + C_p ?= C_L
1/(1/10 + 1/33) + 5 ?= 12.5
7.7 + 5 ?= 12.5
12.7 ?= 12.5
```

32.768kHz crystals are one of the most stable crystal oscillator
frequencies that are excellent to use in watches and other
applications that need a real-time clock (RTC), or "wall clock" time.
In fact, these are the all the actual values use for the RTC circuit
inside the black-and-white, compact Apple Macintosh computers.
