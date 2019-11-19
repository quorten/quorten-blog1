---
layout: post
title: Summary of computer I/O connector voltages
date: 2019-11-16 17:46 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

I have notes in various scattered places about the voltages that are
used in various I/O connectors, but no convenient summary all in once
place.  So, here I go.  When there is an "absolute maximum" voltage
that is rated higher than the maximum signal voltage, I note it in the
following list.

Vpp = volts peak to peak

* "Consumer line-out/in" audio, RCA jack and 3.5mm jack: 0.8 Vpp,
  absolute max 2 Vpp.  Please note that line-out outputs can only
  drive high-impedance loads, such as a computer or amplifier, and
  therefore cannot drive speakers or headphones directly.
* Microphone audio input: 0.002828 Vpp or greater
* Composite video: 0.7 Vpp without blanking/sync signals, 1 Vpp with
  blanking/sync signals
* VGA video: 0.7 Vpp (i.e. differential signaling)
* Parallel port: 5 V
* PC Gameport: 5 V
* MIDI: 5 V
* PS/2 connector: 5 V
* USB: 5 V
* Ethernet: +/- 1 V (100BASE-TX), +/- 2 V (1000BASE-T)
* RS-232: At least +/- 5 V, +/- 10 V, +/- 12 V, +/- 15 V, absolute max
  +/- 25 V
* RJ11 Telephone: 48 V voice, 90 V ring

<!-- more -->

20191116/https://en.wikipedia.org/wiki/Line_level  
20191116/https://en.wikipedia.org/wiki/Nominal_level  
20191116/https://en.wikipedia.org/wiki/Decibel#Voltage  
20191116/https://en.wikipedia.org/wiki/Output_impedance  
20191116/https://en.wikipedia.org/wiki/MIDI  
20191117/https://en.wikipedia.org/wiki/Ethernet_over_twisted_pair  
20191117/https://en.wikipedia.org/wiki/Gigabit_Ethernet
