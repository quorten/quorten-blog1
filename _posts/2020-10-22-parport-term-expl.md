---
layout: post
title: Parallel port termination explained
date: 2020-10-22 14:11 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

If you want high-speed communications on a parallel port, you need
proper termination.  But what is the circuit anyways?  Searching
around, I found a device with a datasheet, or at least I thought I
did...

So, the essentials of proper termination?  Provide pull-up resistors
for proper open collector signaling.  Besides that, you can also
provide EF protection diodes and an RF filter (resistor and capacitor
to filter out radio frequencies).  That's all the info I could find,
nothing about using resistors to terminate the lines at their
characteristic impedance.

20201022/DuckDuckGo parallel port bus termination resistors  
20201022/https://resources.pcb.cadence.com/blog/termination-resistors-in-pcb-design  
20201022/DuckDuckGo ieee 1284 termination impedance  
20201022/https://www.vishay.com/docs/60089/vssx1284.pdf

Otherwise, there's always just the random guess, a resistor around 100
ohms.  120 ohms, 90 ohms, 70 ohms, oh something like that.

OKAY, fine, the final verdict answer.  Because IEEE 1284 cables are
single-ended with ground wires in between, rather than differential
cables, the characteristic impedance is 90 ohms, not 120 ohms or
greater as is the case with differential cables.  Yeah, it's not
really good data and insight, but that's the best I can fathom.  In
addition, the fact that many parallel port devices are not connected
with precisely impedance-matched cables.

<!-- more -->

20201022/DuckDuckGo characteristic impedance db25 cable  
20201022/http://laserfx.com/Backstage.LaserFX.com/Standards/ISP-DB25.html  
20201022/DuckDuckGo printer cable impedance  
20201022/DuckDuckGo what is the impedance of db25 printer cable 1284  
20201022/DuckDuckGo what is the impedance of ribbon cable  
20201022/http://www.signalintegrity.com/Pubs/news/3_10.htm  
20201022/https://electronics.stackexchange.com/questions/487186/what-is-1-27mm-ribbon-cable-impedance-for-the-ground-signal-ground-signal

Oh, wait, I got it.  Revisiting one of my links and search results.
For twisted pair DB25 cables, 62 ohms, that is the name of the game
for single-ended impedance.  Differential impedance, that is 100 ohms.
But, yes, by all means, target your resistors to lower values, not
higher ones.

20201022/DuckDuckGo ieee 1284 ohms  
20201022/https://www.hca.hitachi-cable.com/products/hca/products/round/ieee1284/pdfs/bulk-IEEE-1284-cables.pdf

Parallel SCSI Wikipedia article to the rescue!

"Active termination provides a better impedance match than passive
termination because most flat ribbon cables have a characteristic
impedance of approximately 110 Ω."

20201022/https://en.wikipedia.org/wiki/Parallel_SCSI#Termination

To remind myself, for single-ended signaling, you terminate both ends
by running a resistor between the signal and ground.  Inputt and
output on both ends, however, should connect directly to the signal
wire, not behind the termination resistors.

Yes, 110 ohms is the single-ended impedance, not the differential
impedance, no confusion here.

20201022/DuckDuckGo characteristic impedance flat ribbon cable  
20201022/https://www.ewh.ieee.org/r5/denver/rockymountainemc/archive/2001/2001symposium/flatcablezo.pdf

Also, finally, yes, anecdotal evidence.  My printer says that only
shielded, twisted pair cable should be used, but it is connected with
a flat ribbon cable and it seems to work just fine.  Apparently the
difference in impedance-matching by 50 ohms and 100 ohms isn't too
bad, but 50 ohms and 1 ohm?  That's terrible.
