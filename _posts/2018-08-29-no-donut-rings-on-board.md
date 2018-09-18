---
layout: post
title: "\"Donut rings\" no longer on modern motherboards, and other
        interesting hardware notes"
author: quorten
date: 2018-08-29 15:05 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Modern motherboards don't contain very many "donut rings" on them
anymore, but if you look inside the Ethernet port of the Raspberry Pi
3 B+, you'll find that there are indeed some "donut rings" inside
there.  Yeah, these are called "toroids" in more formal terms.  What
does Wikipedi have to say about these?  Basically, these are more
efficient inductors.  They're more compact, lighter weight, and
generate less electromagnetic interference, which is why they became
so popular on 1990s PC motherboards.

20180829/https://en.wikipedia.org/wiki/Toroidal_inductors_and_transformers

But, the fact is that modern ultra-compact smartphone chargers do not
use any "donut rings" inside them, they only use solid-state voltage
converters, I believe.  So, how exactly do those work?

Failed search.

20180829/DuckDuckGo how do modern ultra-compact power supplies work

On the other hand, I found some pretty interesting information on how
to convert a PC power supply into a "desktop workbench" power supply.
So, about not opening those boxes.  Where are the warnings in this
guide about high voltage if you touch a stray charge storage device
inside there?  Ah, that's something this guide seems to gloss over.
Maybe it's not quite as high of a risk when the device is unplugged
and powered off?  I thought the risk was the same either way.

20180829/http://web2.murraystate.edu/andy.batts/ps/POWERSUPPLY.HTM

Again, I reiterate, because this is important!  Remember heatshrink.

Why do LEDs need resistors?  Because they are current-driven devices,
so the resistor is necessary to set and regulate the current,
irrespective of the voltage.

But, I am still convinced to try to find more information on this.

Failed search.

20180829/DuckDuckGo how do smartphone chargers work
20180829/https://www.digitaltrends.com/mobile/how-does-fast-charging-work/

On the other hand, I found an interesting article on so-called "Turing
structures," Alan Turing's attempt to explain natural structures like
the spots on a leopard or the stripes on a zebra chemically.  This
inspiration was used to develop a more effective reverse osmosis
desalination plant by using a better membrane structure.

20180829/https://www.digitaltrends.com/cool-tech/alan-turing-water-purification/
