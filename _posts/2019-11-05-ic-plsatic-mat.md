---
layout: post
title: IC "plastic" packaging material and melting
date: 2019-11-05 01:50 -0600
author: quorten
categories: [raspberry-pi, mat-sci]
tags: [raspberry-pi, mat-sci]
---

All electronic parts on a printed circuit board are designed to be
able to withstand the temperatures of a reflow soldering oven.  Wait,
what about the black plastic integrated circuit packaging?  Most
plastics have a lower melting point than solder.  The "plastic" IC
packages clearly can't be plastic since they would melt when exposed
to the heat of reflow soldering.

So, what material are they actually made out of?  It is epoxy, a
thermoset plastic, rather than a thermoplastic.  Therefore, it will
not melt when it is overheated.  More specifically, it is formulated
so that high temperatures decomposition will result in charring.

20191105/DuckDuckGo what kind of plastic is used for ic packages  
20191105/https://electronics.stackexchange.com/questions/217423/ics-chips-are-typically-packaged-in-what-material  
broken/http://www.ti.com/en/download/qlty/SEMICONDUCTOR_PACKAGING_ASSEMBLY_TECHNOLOGY-MISC.pdf
20191105/DuckDuckGo semiconductor packaging technology misc  
20191105/http://educypedia.karadimov.info/library/SEMICONDUCTOR_PACKAGING_ASSEMBLY_TECHNOLOGY-MISC.pdf

Here is some more great information on the plastic packaging and
considerations for reflow soldering.

20191105/DuckDuckGo temperature range of plastic ic packaging  
20191105/DuckDuckGo plastic ic package max temperature  
20191105/https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/an/an113.pdf

<!-- more -->

So what is the temperature limit of the epoxy?  It depends on the
formulation.  Carbon-fiber reinforced epoxy composites can withstand
temperatures up to 1500 degrees Celsius.  If I had to guess, I would
assume that double the reflow temperature (\> 500 degrees Celsius)
would run the risk of destroying the epoxy packaging on your printed
circuit boards.

20191105/DuckDuckGo maximum temperature epoxy  
20191105/https://sciencing.com/effects-high-temperature-epoxy-8590977.html
