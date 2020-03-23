---
layout: post
title: Explaining n-channel and p-channel MOSFETs
date: 2020-03-22 17:02 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

MOSFETs... n-channel MOSFET, p-channel MOSFET, how do you use them?
What do they mean?  An n-channel MOSFET is turned on when you supply a
positive voltage to the gate, this allows positive voltage current to
flow from drain to source.  (The source provides a source of
electrons.)  A p-channel MOSFET is turned on when you supply a path to
ground to the gate, this allows positive voltage current to flow from
source to drain.  (The source provides a source of holes.)

Yes, so in essence, control of MOSFETs is very much like PNP versus
NPN BJT transistors: an n-channel MOSFET is like an NPN transistor, a
p-channel MOSFET is like a PNP transistor.  And, therefore, what I
have previously written about current paths for BJT transistors is
also somewhat applicable for MOSFETs too... just that not nearly as
much current needs to flow through the gate of a MOSFET for it to
operate.

It's hard to fish that information out of Wikipedia, and there are
definitely easier ways to explain for electronic circuit designers.
You don't need to know the full theory in this purpose.

20200322/https://en.wikipedia.org/wiki/MOSFET  
20200322/https://en.wikipedia.org/wiki/NMOS  
20200322/https://en.wikipedia.org/wiki/Field-effect_transistor#n-channel_FET

<!-- more -->

But, there is one theoretical point that is worthy of note when making
purchasing decisions for MOSFETs.  In general, when you are using a
MOSFET to control power switching, you want to verify that the MOSFET
you are buying is an _enhancement mode_ MOSFET.  This means that when
there is no voltage applied, the MOSFET will not conduct, just like a
BJT transistor.  You can identify this clearly by looking at the
schematic diagram for a MOSFET and verifying that there is a broken
bar around the central arrow.  A _depletion-mode_ MOSFET, by contrast,
will conduct when no voltage is applied, and an inverse voltage must
be applied in order to turn it off.  The schematic symbol will not
have a broken bar around the arrow, the line will be connected to the
rest of the edges.
