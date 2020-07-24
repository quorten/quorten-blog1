---
layout: post
title: "KiCad rectangular drill holes, and CrtYd layer"
date: 2020-07-16 23:39 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

How do you specify rectangular drill holes in KiCad?  It's a lot
uglier than plain old circular or elliptical drill holes... you need
to specify a CNC milling layer and get your board manufactured with
CNC milling support, and that is "wicked expensive" for the hobbyist.
For hobby projects, just use a plain old circular (or elliptical hole
if supported) that is big enough for the maximum diagonal distance.

20200716/DuckDuckGo kicad rectangular drill holes  
20200716/https://www.eevblog.com/forum/kicad/rectangular-pad-drill/

What is the F.CrtYd layer?  It's an abbreviation for "courtyard", this
indicates the clearance needed by robotic pick-and-place equipment
around the perimeter of a component.  Or, alternatively, the clearance
needed around a component for hand assembly.

20200716/DuckDuckGo kicad f.crtyd  
20200716/https://forum.kicad.info/t/layer-confusion-crtyd-and-fab/5030
