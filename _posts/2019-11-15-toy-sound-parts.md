---
layout: post
title: Minimal components to build a cheap sound toy
date: 2019-11-15 20:01 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Minimal components to build a cheapo sound toy, based off of vague
observations looking inside a real sound toy.

* 1 x Super-cheap chip-on-board (COB) microcontroller (MCU)
* 1 x Ceramic capacitor for MCU power delocalized coupling
* 1 x Zener diode for MCU power
* 2 x Resistors for MCU power and low-pass filter
* 1 x Electrolytic capacitor for low-pass filter
* 1 x BJT transistor for speaker amplifier
* Possibly a few more resistors depending on specifics

And that's all there is to it!

No need for low-pass filter circuits... since this is a toy, it can be
designed so that all stored sounds are low-pass filtered before
manufacturing, thereby eliminating the need for such circuitry.  Not
to mention, when the toy is designed only to drive a built-in speaker
and not an external speaker, the only speaker at risk of being damaged
by low-frequency sounds is the cheap internal toy's speaker itself.
