---
layout: post
title: More info on selecting decoupling capacitors
date: 2020-03-01 13:51 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

The Wikipedia article on decoupling capacitors specifies a 100 nF
ceramic capacitor per every logic chip, with more for complex logic
chips.  But can you get away with less if you are using simple logic
and low frequencies?  Yes.  10 nF ceramic capacitors per every cluster
of quad NAND integrated circuits appears to work well.  You could also
use 22 nF.  100 nF per chip is primarily needed for faster circuits.

But one important key, when you pick a decoupling capacitor value, try
to stick with the same capacitor values consistently throughout the
circuit.  Otherwise, you can get other problems.

And, remember, the power supply source typically has a decoupling
capacitor of a few hundred uF.

20200301/https://en.wikipedia.org/wiki/Decoupling_capacitor  
20200301/DuckDuckGo decoupling capacitor quad nand ic  
20200301/https://www.cypress.com/file/135716/download  
20200301/https://www.reddit.com/r/electronics/comments/870wj0/8bit_alu_made_using_only_quadnand_ics/
