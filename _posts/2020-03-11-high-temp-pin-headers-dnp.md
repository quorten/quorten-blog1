---
layout: post
title: "Temperature resistant insulation materials in pin headers, and DNP"
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

What does DNP mean in a schematic?  DNP = Do Not Place.  It is used to
indicate an empty footprint on a board where components can be placed
ad-hoc by the end user after the standard assembly process.

20200311/DuckDuckGo resistor DNP  
20200311/https://electronics.stackexchange.com/questions/255555/dnp-means-to-short-or-keep-circuit-line-open
