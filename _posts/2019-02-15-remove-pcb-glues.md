---
layout: post
title: "How to remove various glues from circuit boards, and about
        chip-on-board modules"
date: 2019-02-15 22:54 -0600
author: quorten
categories: [raspberry-pi, mat-sci]
tags: [raspberry-pi, mat-sci]
---

So, you opened up an electronic device, and there are some fancy
components like 6-segment digital LCD screens taht you'd like to
salvage for use in hobby projects.  But alas, you see that your
desired component is glued onto the circuit board!  How do you get it
off?

Some background knowledge is very useful in devising a strategy for
removing pesky bonding materials.  There are three main methods of
removing bonding materials:

* Mechanical: These are strictly methods that involve cutting at the
  bond with a knife, rubbing at it with sandpaper, or going all out
  with a rotary cutter to really grind down that pesky bonding
  material!

* Thermal: Heat up the bonding material so that it melts or softens.

* Chemical: Use some sort of acids to dissolve your bonding chemical.

Typically, if you have no idea what you are working with, the easiest
and safest method is to go with a combination of mechanical and
thermal removal.  Heat up the joint in hopes that doing so will soften
the bonding material, as is the case with some types of epoxy.  A
hairdryer is the go-to DIY hobbyist tool to get started on this, but
if you are better equipped, you may go with a heat gun or a heated
knife instead.  Anyways, once you've got your joint heated, cut away
at the joint with a utility knife.

<!-- more -->

My understanding is that the chemical removal method is generally not
recommended because it has a greater propensity to damage your
electronic components, and in the case of epoxy, it's really not
effective at all.

Finally, have you been wondering about those calculator circuit
boards?  You open them up and look inside, and you can see that the
CPU is covered with something that either looks like a piece of
"leather" or is a drop of epoxy.  What is this?  This is "chip on
board" mounting: the unpackaged silicon dye is mounted directly onto
the circuit board, ahd epoxy is used to cover it to protect it from
moisture, fingerprint grease, corrosive gases, or other environmental
contaminants.  It is ostensibly the go-to choice for cheap,
mass-market electronics.  This is also called "blob top" or "glop
top."

20190215/DuckDuckGo how to dissolve unglue components from circuit board  
20190215/DuckDuckGo how to dissolve unglue lcd from circuit board  
20190215/DuckDuckGo how to dissolve unglue lcd from circuit board calculator  
20190215/DuckDuckGo remove glued components from circuit board  
20190215/https://electronics.stackexchange.com/questions/9377/how-to-remove-glue-block-from-pcb  
20190215/https://itstillworks.com/circuit-board-epoxy-removal-5799527.html  
20190215/https://en.wikipedia.org/wiki/Chip_on_board  
20190215/https://en.wikipedia.org/wiki/Electronic_packaging#Glop-top
