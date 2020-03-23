---
layout: post
title: "Temperature resistant insulation materials in pin headers,
        wave versus reflow soldering, and DNP"
date: 2020-03-11 20:52 -0500
author: quorten
categories: [raspberry-pi, mat-sci]
tags: [raspberry-pi, mat-sci]
---

Previously I've bought some pin headers and soldered with them, but
with my bad novice soldering skills, I've had trouble with the
insulation material melting.  On male pin headers in particular, this
would be problematic because then the pins would sag over and ruin the
usability when the pins would be sticking out at the wrong angle.  On
the other hand, I had some female sockets that I charred a number of
times, but they didn't end up so bad from my extra soldering ironing
heating.

So, what can I do in the future when buying new pin headers to get
more temperature-resistant ones?  Avoid plain
Polybutylene_terephthalate (PBT) headers.  Glass-fibre reinforced
ones, however, are more temperature resistant.  Polyester headers are
also more temperature resistant, and weird-sounding materials like
liquid-crystal polymer (LCP) and polycyclohexylenedimethylene
terephthalate (PCT) are pretty temperature resistant.  The higher
temperature ones can be placed in a reflow soldering oven, while plain
PBT may be unsuitable for such treatment.

Please also see my [hot temperatures article]({{ site.baseurl
}}/blog/2019/11/02/hot-temps-list) for reference.

<!-- more -->

20200311/https://en.wikipedia.org/wiki/Polybutylene_terephthalate  
20200311/https://en.wikipedia.org/wiki/Polyethylene_terephthalate  
20200311/https://en.wikipedia.org/wiki/Polyamide  
20200311/https://en.wikipedia.org/wiki/Nylon_6  
20200311/https://en.wikipedia.org/wiki/Nylon_66  
20200311/https://en.wikipedia.org/wiki/Liquid-crystal_polymer  
20200311/https://en.wikipedia.org/wiki/Polycyclohexylenedimethylene_terephthalate

UPDATE 2020-03-16: Although Nylon can withstand higher temperatures,
it is not suitable for reflow soldering due to its high moisture
absorption rate.  This means its dimensional accuracy is highly
dependent on the environmental moisture and temperature level.

20200316/DuckDuckGo nylon reflow soldering  
20200316/https://sullinscorp.com/wp-content/uploads/2015/04/Nylon-6t-and-Reflow-Soldering.pdf  
20200316/DuckDuckGo nylon moisture absorption rate  
20200316/https://www.toray.jp/plastics/en/amilan/technical/tec_003.html

Likewise, according to this source, glass-filled polyester is also not
suitable for reflow soldering.  The stated plastics that work well
with reflow soldering are "Liquid Crystal Polymers (LCP),
Polyphenylene Sulfides (PPS) and Polycyclohexylene Terephthalates
(PCT)."

20200316/DuckDuckGo glass filled polyester reflow soldering  
20200316/http://suddendocs.samtec.com/processing/smthb/plastics.html

Noteworthy is that Nylon does not have as high a heat deflection
temperature as polyethylene terephthalate.

20200316/https://en.wikipedia.org/wiki/Heat_deflection_temperature  
20200316/DuckDuckGo nylon heat deflection temperature  
20200316/https://www.creativemechanisms.com/blog/3d-printing-injection-molding-cnc-nylon-plastic-pa

----------

Merely discussing temperature resistant plastics, I am somewhat
missing the point of _why_ you need temperature resistant plastics,
the implications of those choices, and how people were able to get by
without temperature resistant plastics.  So, I will be more punctual
in that explanation here.

Reflow soldering requires that you have your entire board subject to
high temperatures.  This means that every single component on your
board must be capable of tolerating the temperature range of reflow
soldering, typically 220 to 260 degrees Celsius.  Your main point of
concern is plastic since most plastics melt below the reflow soldering
temperature.  "Plastic" IC packages are in fact made of
high-temperature epoxy and are therefore safe for reflow soldering.

This is why selection of pin headers on circuit boards can be
problematic.  Often times, the insulation material is some sort of
fairly typical plastic, which can't tolerate reflow soldering
temperatures.  Only specially formulated plastics can tolerate reflow
soldering temperatures.  Of course, this doesn't come without a price.

So, how did people ever get these low temperature plastics onto boards
in a commercial mass manufacturing process?  They used wave soldering.
Wave soldering, unfortunately, pretty much requires that you only use
a single-sided circuit board since a wave of molten solder must pass
over one surface of your circuit board in its entirety.  But, its
advantage over reflow soldering is that the board as a whole can be
subject to lower temperatures so that your plastics will not melt.

Finally, for small prototyping or custom manufacturing runs,
hand-soldering with a soldering iron is also a viable method to avoid
subjecting plastics to temperatures above their melting
point... provided that you are reasonably skilled with using a
soldering iron.

----------

What does DNP mean in a schematic?  DNP = Do Not Place.  It is used to
indicate an empty footprint on a board where components can be placed
ad-hoc by the end user after the standard assembly process.

20200311/DuckDuckGo resistor DNP  
20200311/https://electronics.stackexchange.com/questions/255555/dnp-means-to-short-or-keep-circuit-line-open
