---
layout: post
title: "Information on DC barrel connectors and and tricks on how to
        measure DC barrel connectors"
date: 2019-11-28 23:30 -0600
author: quorten
categories: [raspberry-pi, important]
tags: [raspberry-pi, important]
---

How do you know what size of DC barrel connector to use for a
particular voltage power supply?  Unfortunately, in general, there are
no well-established standards for DC barrel connectors and intended
supply voltage.  However, there are a few very common sizes for
particular uses.

* 12 V: 5.5 mm outer diameter, either 2.1 mm inner diameter or 2.5 mm
  inner diameter.
* 5 V: 3.5 mm outer diameter, 1.3(5) mm inner diameter.
* Both standards use 9.5 mm length barrels.
* Japanese standard 5 V: "EIAJ-02 for 3.15–6.3 V 4.2 mm OD, 1.7 mm ID."
* Japanese standard 3 V: "EIAJ-01 for 0–3.15 V 2.5 mm OD, 0.7 mm ID."

Beyond that, you've got to really do guess and check.  Digi-Key made a
good recommendation on some helpful common gear tools you may have for
performing the measurement.

* A toothpick is gemerally manufactured from 2.1 mm to 2.2 mm in
  diameter, so you can use this to help disambiguate between 2.1 mm
  and 2.5 mm.  Likewise, the tip of a ball-point pen can similarly be
  used.

* A multimeter test lead is manufactured to 2.0 mm in diameter, so you
  can also use this with visual analysis to compare diameters.

<!-- more -->

20181128/https://en.wikipedia.org/wiki/Coaxial_power_connector  
20181128/https://en.wikipedia.org/wiki/DC_connector  
20181128/https://forum.digikey.com/t/measuring-power-supply-barrel-plug-id-2-1mm-vs-2-5mm/401

Important!  What's the difference between a coaxial power connector
and a barrel connector?  A coaxial power connector is, of course, like
a coaxial cable.  There's a round outer ground shield, and an inner
pin to connect the positive DC voltage.  A barrel connector, by
contrast, does **not** have an inner pin.  Rather, the outer shield is
coated with two separate conductors on each side, an outer conductor
and an inner conductor.  The middle, therefore, is either completely
hollow (on the plug/pin side) or filled completely solid (on the
socket side).
