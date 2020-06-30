---
layout: post
title: Finally, ribbon cables to connect LCDs understood
date: 2020-06-25 16:13 -0500
author: quorten
categories: [raspberry-pi, mat-sci]
tags: [raspberry-pi, mat-sci]
---

How do those ribbon cables that connect LCDs work?  Sure, if you're
having trouble with missing pixels on a character or numeric style
LCD, you know the ribbon cable to the circuit board is connected with
hot glue, so it's merely a matter of reheating with a hot air gun and
pressing down with a pencil eraser (be careful with the abrasive!) to
seal it back down to a nice connection.  But what exactly are all the
materials?

The Wikipedia articles are only vaugely informative, they lack any
photos that look consistent with what I've been looking at.

20200625/https://en.wikipedia.org/wiki/Liquid-crystal_display  
20200625/https://en.wikipedia.org/wiki/Tape-automated_bonding  
20200625/https://en.wikipedia.org/wiki/Elastomeric_connector  
20200625/https://en.wikipedia.org/wiki/Anisotropic_conductive_film

After searching on Digi-Key, I got some hints.  What I'm looking for
is called a "heat seal."  Going back to the Wikipedia articles,
indeed, I found a word-drop of "heat seal connector," so I search for
that, and tada!  I found lots of great technical information.
Unfortunately, Digi-Key appears not to sell the bare LCD modules where
you must attach the heat seal connectors yourself.

<!-- more -->

20200625/https://www.digikey.com/product-detail/en/lumex-opto-components-inc/LCM-S01602DTR-M/67-1781-ND/469805  
20200625/https://www.lumex.com/spec/LCM-S01602DTR-M.pdf  
20200625/DuckDuckGo heat seal connectors  
20200625/http://elform.com/  
20200625/http://elform.com/bond_parameters.html  
20200625/http://elform.com/peel_strength_spec.html  
20200625/http://elform.com/designguide.html  
20200625/http://www.lcd-factory.com/html_products/Heat-Seal-Connector-161.html

Oh yeah, and about attaching the heat seal connectors.  LCD modules
come from the manufacturer without any ribbon cable attached to them
at all.  The electrical traces are drawn directly on the glass
substrate using a transparent conductor, typically indium tin oxide.
That's why if you look carefully at the LCD modules, you see the
ribbon cable ends on the glass surface and you can't see any traces
continuing any further.  Of course you can't see any, because they
used a transparent conductor.  So, first of all, you want to be
careful with the LCD end of the attachment not to scratch or rub away
the transparent conductive traces on the surface.

20200625/https://en.wikipedia.org/wiki/Indium_tin_oxide

Don't worry about this material's melting point, it's 1526 to 1926
degrees Celsius.

But, the point is, the heat seal connector is indeed heat sealed on
both the LCD itself and the printed circuit board.  If you hoped you
could get away with only needing to reseal on the printed circuit
board side, well maybe you're right, that's probably where most
problems develop.  But you might also need to reseal on the LCD glass
side too.

But, for the technical parameters, this is what you need to know.  You
need at least 140 degrees Celsius of heat.  Now, here's where
Wikipedia dropped in to be useful.  Older ribbon connectors needed
higher temperatures, 178 to 180 degrees Celsius... so if you're
wondering why you may have an older calculator manufactured in the
1990s that still works just fine, but a newer calculator manufactured
in the 2000s that has got trouble, that would be it.  Also, be careful
not to exceed 180 degrees Celsius because then air bubbles can break
out of the bonding material and make it unstable.  The old-style
bondings may have been thermoset, but newer bondings are all
thermoplastic so they can be reheated for repairs.

The plastic part of the ribbon itself is made out of polyethylene
terephthalate plastic (PET) and the conductive traces are usually
carbon-based such as graphite.  The actual adhesive, well that's not
actually just hot glue, that is electrically anisotropic adhesive,
essentially hot glue with conductive particles suspended.

20200625/http://elform.com/ANISO.jpg

All of this being said, a final important point is worth reiterating.
If the bonding material epoxy, hopefully it is more temperature
resistant and you won't have problems.  But if you do, reheating will
not solve your problems because thermoset plastics cannot be melted
and reused as such.  So, chances are if you do have problems that
occurred not from any particularly harsh handling, it is due to the
thermoplastic properties causing the material to get soft in high
temperatures, to the point you no longer have a good electrical
connection.  But, the good news here is that you can fix it somewhat
easily.

A very important note in the elform page!  "HSCs [Heat Seal
Connectors] can be tacked into place before final bonding by touching
them with a soldering iron set at 160°C."  Yep, you've seen it said
right there.  Alternative connection mechanisms do have their merits.
Well, if a soldering iron is okay for tacking into place, so is a hot
glue gun, I'm convinced.  If you want alternative heat up and
press-down methdos, you can try a hot glue gun or soldering iron with
aluminum foil, this will give you both heat and a semblance of padding
push-down.

----------

Still wondering about the hot glue temperature equation?  Oh, sure I
am.  Okay, so this was something really interesting to find.  You can
soften some kinds of low-temperature hot glues below 100 degrees
Celsius.  Wow, the glass transition temperature can be even lower than
it is generally touted to be.

20200625/DuckDuckGo does low temperature hot glue soften below 120 celsius  
20200625/https://charlesarcheryblog.wordpress.com/tag/what-temperature-hot-melt-glue-soften/

Also, on the other side of affairs, what temperature does a hot glue
gun actually operate at?  120 degrees Celsius is the rated melting
point of the _low-temperature hot glue_, not the temperature of the
hot glue gun itself.  Conceivably, for good performance and easy
workability, the low-temperature hot glue gun itself is a little bit
higher temperature than this.  All the better for using to reheat the
bonding material.
