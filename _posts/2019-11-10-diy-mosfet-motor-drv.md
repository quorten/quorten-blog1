---
layout: post
title: Build your own low voltage motor controller out of  MOSFETs
date: 2019-11-10 18:26 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, okay, so I've had a hard enough problem and trouble finding a
motor controller IC that would work well with 3 V motor power supply.
So, now that I think about it, surely I can build my own such
controller by buying MOSFET transistors and wiring them up in an
H-bridge, right?  Indeed I can.  I've found two good sources.

**Please note** that the `circuitdigest` website's MOSFET motor
controller schematics are lacking the "flyback diodes" (i.e. diode
bridge rectifier), so these will also need to be added.

20191110/DuckDuckGo mosfet motor comtroller ic  
20191110/http://www.instructables.com/id/DIY-MOSFET-Motor-Controller/  
20191110/https://circuitdigest.com/electronic-circuits/simple-h-bridge-motor-driver-circuit-using-mosfet

The `circuitdigest` site makes reference at the end that **proper
delocalized coupling** is a must, even with low-voltage motors if you
want them to run without glitches.  What do they mean by this?
Basically, they mean that output buffers must be used at the proper
locations... since they do not use a microcontroller, and of course
you need proper "flyback diode" isolation via a diode bridge
rectifier, and maybe even the low-pass filter across power to protect
against transient high voltage spikes.  They do mention using a large
ground plane to also isolate from the high currents which is good.

<!-- more -->

20191111/DuckDuckGo localized decoupling  
20191111/https://en.wikipedia.org/wiki/Decoupling_%28electronics%29  
20191111/https://en.wikipedia.org/wiki/Coupling_%28electronics%29  
20191111/https://en.wikipedia.org/wiki/Ground_plane

And now you know why circuit boards tend to have additional ceramic
capacitors next to a network of fully digital integrated circuits that
would otherwise not need any analog components.

Likewise, another protection you can put in place is the use of a
voltage regulator.  A voltage regulator can prevent minor
overvoltages, but it too has an operating limit.  For more extreme
over-voltage conditions that are not transients, a polyfuse can do the
trick.  The trick here is that mid-range frequency overvoltages will
run through the circuit rather than the bypass capacitor, and that
will result in higher current and heat dissipation at the voltage
regulator.  But before too much of that current runs through the
voltage regulator and destroys it, the polyfuse will trip.

For reference, my search for motor control ICs ended up with this
Toshiba page where there are a lot of good selections but pretty much
everything is surface-mount.

20191110/DuckDuckGo digikey mosfet motor comtroller  
20191110/https://www.digikey.com/en/product-highlight/t/toshiba-semi-and-storage/motor-controller-and-driver-ics
