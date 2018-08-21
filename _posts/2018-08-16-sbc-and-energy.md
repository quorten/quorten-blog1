---
layout: post
title: Single board computer energy consumption
author: quorten
date: 2018-08-16 6:21 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Upon looking around at various Raspberry Pi models and competitors,
one thing that I realized was running short was not compute features
per se, but energy consumption metrics.  What was the various energy
consumption of the boards in relation to the features that they
provided?  Which single-board computers were most energy-efficient for
the tasks that they do?

Unfortunately, when you think about it, you realize energy consumption
is something that consumers really don't care about, which is why
government regulation is so important toward increasing energy
efficiency.  Yeah, sure the new technology comes out that can be more
energy efficient, but how do you convince all manufacturers to use it?
This needs to be done so that when a consumer buys any technology at
random, it will keep progressively using the more energy efficient
technology.

Anyways, although I love the features of the Raspberry Pi 3 B+, upon
looking at the energy consumption, and taking into consideration my
intended use, I instead decided to go with the Raspberry Pi 1 B+.  The
extra 100mA idle power consumption from the Gigabit Ethernet
interface, which can't even put out a full gigabit, the 2.5A
recommended power supply, and the fact that I strongly wanted to
optimize idle power consumption meant that the Raspberry Pi 1 B+ was a
far better choice than the 3 B+, not to mention that by this year of
2018 the models are selling a few dollars cheaper than their original
list price.
