---
layout: post
title: "Digi-Key KiCad library, and generate a Digi-Key Bill of
        Materials in KiCad"
date: 2020-03-10 20:32 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Digi-Key has created a KiCad library of their own, listing many
Digi-Key parts.  This is a great way to get started creating your
schematics, you'll get all the Digi-Key part numbers on your items and
it will be really easy to generate a Bill of Materials.

20200310/https://www.digikey.com/en/resources/design-tools/kicad  
20200310/https://github.com/Digi-Key/digikey-kicad-library

Digi-Key Bill of Materials.  Yeah, you can roll your own, but if you
are working out a design in KiCad, wouldn't it be nice to generate one
from your KiCad design?  Indeed you can, here's how.  Just make sure
you either use the Digi-Key KiCad library or annotate all your parts
with Digi-Key part numbers, and the rest should be a breeze.
Unless...  for some reason you're using an old KiCad version that
doesn't have the group by quantity BOM plugin.  In that case, you can
use the KiBOM exporter after a simple `git clone`.  It also allows you
to generate nice HTML BOM listings.

20200310/DuckDuckGo digikey kicad bill of materials plugin  
20200310/https://forum.digikey.com/t/kicad-kibom-and-digi-key-streamlines-ordering/857  
20200310/https://github.com/SchrodingersGat/KiBoM
