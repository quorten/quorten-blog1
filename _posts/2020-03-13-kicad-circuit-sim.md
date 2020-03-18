---
layout: post
title: "KiCad circuit simulation, unfortunately analog-only"
date: 2020-03-13 20:19 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

KiCad has circuit simulation via ngspice.  Does it simulate 7400
series integrated circuits?  Unfortunately, no, because digital
circuit simulation is not done well by an analog simulator.  For that,
you have to look toward a different digital or mixed-signal simulator.

20200313/DuckDuckGo 7400 series spice models  
20200313/https://hackaday.com/2008/12/18/7400-series-logic-simulator/  
20200313/https://forum.allaboutcircuits.com/threads/ltspice-74hc-library-from-yahoo-ltspice-group.46915/  
20200313/https://www.reddit.com/r/AskElectronics/comments/yhi5j/74xx_lt_spice_library/
