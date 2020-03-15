---
layout: post
title: Understanding capacitor voltage limits
date: 2020-03-08 14:25 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Capacitors, capacitors... seemingly simple components, but tough to
fully understand.  If you have a decoupling/bypass capacitor wired up
to the main power supply, it will get charged up by the power supply
and stay there.  But, what if you have some other voltage source that
you want to absorb by a capacitor like a motor that may cause
inductive voltage spikes?  Can the capacitor still accept more charge
and absorb this?  Yes... the key is to have a proper understanding of
capacitance.

The capacitance equation is C = Q / V.  Capacitance is equal to charge
divided by voltage.  What does this mean?  It means that capacitance
is a function of how much charge a capacitor has stored compared to
what voltage it supplies in circuit.  If two capacitors are charged up
to 5 volts, but one capacitor can discharge a specific resistance load
for a longer period of time than the other, then the longer lasting
capacitor has a greater capacitance.  What is also means is that any
capacitor can be charged to a higher voltage, but it won't last as
long at supplying a higher voltage than would a capacitor with a
greater capacitance.  Furthermore, this means that a capacitor is
never "fully charged" within a circuit.  Rather, it is merely charged
up to the point where its voltage is equal to the supply voltage, but
it is still capable of accepting more charge if pumped with a higher
voltage.  That is the key to understand.

<!-- more -->

And also, because of this property of capacitors to not reach 100%
charge when a lower voltage is applied, capacitors **do** have the
ability to absorb voltage spikes.  The voltage spike will simply start
charging the capacitor closer to its limit, and with a large
capacitance value, this will cause negligible increase in the output
voltage.  So capacitors do work in this functionality as being a means
to filter transient spikes on a power supply.  The capacitor itself
will be the path of least resistance for the current to travel.

Of course, capacitors are also rated with a voltage limit... the true
maximum charge a capacitor can hold, before the ultimate limit is
reached and the extra energy is just dissipated as heat (the
high-voltage signal jumps across the capacitor and it acts like a
resistor instead) and causes the capacitor to burn up.

20200308/https://en.wikipedia.org/wiki/Series_and_parallel_circuits#Cseries  
20200308/https://en.wikipedia.org/wiki/Capacitor#Overview  
