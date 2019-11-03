---
layout: post
title: How to 3D print a plastic magnifying lens
author: quorten
date: 2018-11-17 18:07 -0600
categories: [pentax-k-1-camera, 3d-printing, raspberry-pi]
tags: [pentax-k-1-camera, 3d-printing, raspberry-pi]
---

So, now I'm wondering.  Really, can you 3D print a magnifying glass?
Yes you can.  A real working, crystal clear smooth one at that.

So, how do you do it?  There are multiple ways.  I'll point out the
first and perhaps most expensive way.

First of all, use a SLA 3D printer to 3D print your object out of
clear resin.  Once you're done with that standard job, you need to
finish off the surface smooth by one of several means.  Yes, you can
do traditional pellet pounding, acid bath, and sanding with sandpaper.
Another nifty method you can do is to spray it with a clear resin
coating spray.

So, now you're wondering.  Can you also do this with a FDM printer
like the Prusa i3?  Well, in order to do that, you'd first need to be
able to 3D print with a transparent plastic like polycarbonate.  So
can you do that on the Prusa i3?  Indeed you can.  Now, there's a
really nifty trick to do that, though.  You know how you've been told
that 3D printing with polycarbonate requires higher temperatures than
typical consumer, DIY, and hobbyist 3D printers can supply?  Well, not
an entirely complete description of what's going on here.  The
plastic's ability to be shaped depends on both the temperature and
pressure applied to it.  So if you keep the temperature the same, but
increase the pressure, will that work?  Indeed, it does work quite
well.

So, there you go.  Now you can 3D print with polycarbonate on a FDM 3D
printer too.

<!-- more -->

Also note that these other plastic materials can be used in a
transparent manner too: polyethylene terephthalate, polystyrene, high
density polyethylene, polypropyline.  Basically, all of those
materials can also be printed with in the Prusa i3 too, with the right
settings selected.

So, now that you really have a lot of options for 3D printing your own
magnifying glass, you therefore have a lot of options for building
your own cheap optical camera viewfinder for Raspberry Pi projects.
You just need to apply some original thinking, get the right
materials, and, well, do a lot of experimenting.

20181117/DuckDuckGo 3d print magnifying glass  
20181117/http://www.instructables.com:80/id/3D-Printed-Magnifying-Glass/  
20181117/https://www.thingiverse.com/thing:1006913

NOT what I'm looking for, but interesting idea.  If you want to build
one of those armed magnifying glass systems for working on
electronics, but entirely by the means of 3D printing, take a look at
this article.

20181117/https://theccontinuum.com/2016/07/08/hobby-creek-arm-mod-3d-printed-illuminated-magnifying-glass/

20181117/https://www.reddit.com/r/3Dprinting/comments/799moi/i_3d_printed_a_magnifying_glass/  
20181117/https://www.thingiverse.com/thing:2999188

Here are details on how to print polycarbonate with the Prusa i3.

20181117/DuckDuckGo prusa i3 polycarbonate  
broken/20181117/https://shop.prusa3d.com/forum/print-tips-archive--f86/polycarbonate-here-s-how-to-print-it-without-warpi-t6919.html  
20191103/https://forum.prusaprinters.org/forum/original-prusa-i3-mk3s-mk3-print-tips-archive/polycarbonate-here-s-how-to-print-it-without-warping-delamination-or-an-enclosure-with-better-than-abs-results./  
20181117/DuckDuckGo prusa i3 transparent hdpe  
20181117/DuckDuckGo prusa i3 transparent polypropylene  
20181117/https://hackaday.com/2012/11/27/prusas-nozzle-prints-polycarbonate-peek-nylon/  

This is an interesting article on threaded rods, i.e. lead screws and
ball screws.  Yes, the things that may often be necessary for some 3D
printer designs.  The alternative that I see more often in consumer
printers and scanners is belt drives.

20181117/https://hackaday.com/2018/11/13/mechanisms-lead-screws-and-ball-screws/
