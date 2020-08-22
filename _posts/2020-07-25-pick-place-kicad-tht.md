---
layout: post
title: "Pick-and-place files in KiCad, notes on through-hole automated
        assembly"
date: 2020-07-25 06:02 -0500
author: quorten
categories: [raspberry-pi, reiterate]
tags: [raspberry-pi, reiterate]
---

How do you generate pick-and-place files for through hole components
in KiCad?  The default exporter omits through-hole components.  Well,
here's the rationale for doing so.  Through-hole pick-and-place is a
lot more expensive than surface-mount pick-and-place because all the
pins need to be properly aligned before insertion.  Surface-mount is
more forgiving, and therefore cheaper.

Also, wondering why KiCad's mounting holes are plated rather than
non-plated?  Two reasons.  First of all, it's typically cheaper for
the manufacturer.  Second, the plating helps protect the hole against
wear and tear from the screw.

20200724/DuckDuckGo kicad pick and place through hole  
20200724/https://electronics.stackexchange.com/questions/456671/kicad-no-footprint-for-automated-placement  
20200724/https://forum.kicad.info/t/create-a-mounting-hole/6737

Again, I reiterate, because this is important!  Through-hole automated
assembly is fully possible.  With the correct machines, through-hole
components can be placed on the board.  Provided that the components
can handle the temperature range, solder paste and reflow soldering is
also fully possible with through-hole components, by stuffing the
holes with solder paste before stuffing the components onto the board.
For temperature-sensitive components, wave soldering will need to be
used instead.

<!-- more -->

----------

So, that being said, how does through-hole reflow handle in practice
when I do it?  It actually handles pretty well!  The main notes I have
to take into consideration from my experience.  In the digrams, the
thickness of solder paste above and below the through hole is about
the same as in the case of surface-mount components.  I've found out
from some first-hand working experience, this is not enough.  You want
to make sure the amount of solder paste above/below the the hole is a
little bit rounded off, thicker than only of that of surface-mount
solder paste pads.  Otherwise, there won't be enough solder to form a
nice fillet join after reflow, instead the solder will be only between
the pin and the ring on the inside of the hole.

Finally, of course, sometimes it is difficult to fully fill up a hole
with solder paste.  It may be that you cannot see through the hole
because there is solder paste covering the top and the bottom of the
hole, but how full is the hole itself?  Try really hard to make sure
that the hole is absolutely full, otherwise you're not going to get
good results, of course.  In particular, although the pin and the ring
may be electrically connected by solder, there may be some holes where
you can see light shine through, the through-hole not being completely
covered on the inner surface.
