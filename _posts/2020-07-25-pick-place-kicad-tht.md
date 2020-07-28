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
