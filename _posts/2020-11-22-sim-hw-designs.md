---
layout: post
title: Simulate your digital logic designs before building
date: 2020-11-22 09:31 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

I decided that for my first electronics project, I wanted to use
"standard logic" chips for all the needed glue logic rather than using
programmable logic like a GAL or FPGA because that was one less skill
needed for hardware prep, and one less thing to go wrong in the field.

But, the biggest problem I've ran into for this: How do I simulate my
glue logic to verify it?  I have the schematic design, but I was at
loss on how to simulate it.  KiCad has an internal circuit simulation
tool, but it is only for simple dsicrete logic, nothing like digital
integrated circuits.

So really, I got thinking, circling back to FPGA land, really.  I
wrote and simulated Verilog before as part of a college class without
any actual hardware programming, would Verilog be a good grounds for
simulation of this?  And, now that I've got involved in this vintage
Macintosh hardware recreation project, I can attest that it is in fact
a good idea for the sake of glue logic.

Okay, so time for web searching.  I cursory search found a few
candidates, though some of this stuff is pretty recent.

20201122/DuckDuckGo standard logic 7400 verilog  
20201122/https://github.com/TimRudy/ice-chips-verilog

Ice Studio you mention?  Oh, interesting, trying to make FPGA
development as easy as possible, all using open-source tools.  And
this FPGA Wars site, well that's a pretty interesting name.  Attack on
the proprietary FPGA platforms.

<!-- more -->

20201122/https://fpgawars.github.io/

The biggest lesson to be learned with standard logic chips is that
only the most basic and essential ones will stick around long into the
future.  But still, point in hand, that means old designs tend to be
wrought with the problem of using chips that are no longer in
production.

20201122/https://hackaday.io/project/10658-7400logichdl
