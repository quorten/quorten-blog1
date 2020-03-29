---
layout: post
title: Picking a MOSFET with proper support for gate voltage
date: 2020-03-28 23:20 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

MOSFETs... yes, they have so many gate voltage threshold parameters.
How do you navigate them if you, say, want to be able to control a
MOSFET with a 5 V signal?  Here's how.

* Look for "drive voltage" as this is indicative of how.

* "Gate threshold voltage" is the minimum voltage that you'll barely
  get any MOSFET switching behavior.

* Max gate voltage is, of course, the maximum voltage you can put on
  the gate.

MOSFETs are kind of like BJT transistors, they're not perfect binary
switches.  When there is less voltage, the source-drain path is more
restrictive to the flow of current than when there is more.  That's
what the range of gate threshold voltages is indicative of, and the
restrictiveness to current flow is indicated by the varying resistance
between the source and the drain.

20200328/DuckDuckGo mosfet drive voltage  
20200328/https://electronics.stackexchange.com/questions/367274/what-is-drive-voltage-for-a-mosfet
