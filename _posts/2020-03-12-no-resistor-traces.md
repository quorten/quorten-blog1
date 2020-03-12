---
layout: post
title: Do not route traces under resistors in PCB designs
date: 2020-03-12 02:50 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Good note here to keep in mind when designing printed circuit boards.
Traces under resistors is considered bad practice.  Yeah, this makes
sense when it is brought up, resistors generate heat, and heat
increases resistance in traces, which degrades their primary purpose
in the circuit.

20200312/https://github.com/worlickwerx/pi-parport/issues/29
