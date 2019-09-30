---
layout: post
title: Clever tricks with electronics and EOMA68
date: 2019-09-29 13:29 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Yes, yes, it's been a while, does EOMA68 have any updates?  Oh, yes it
does, and very interesting ones that that.  First of all, there is
still evidence of people "complaining" about the slow progress of
EOMA68.  By all means, this is due to the thin budget that the project
is operating on.  But, because of this, the project does publish some
useful tips and tricks for working with advanced, modern electronics
on a low budget.

The first trick, dealing with cheap printed circuit boards.  The edges
of a cheap printed circuit board are not precisely machined.  There
are tiny burrs on the edges that will inhibit proper insertion of
edge-mounted components, such as an edge-mounted mini/micro HDMI
connector.  But, luckily there is a simple and cheap remedy for this
issue.  Take an Xacto knife and rub away on the edges where precise
fitting is needed.  This will cut away the burs that are 0.01 mm in
size, and tada!  Your micro HDMI connector will fit.

20190929/https://www.crowdsupply.com/eoma68/micro-desktop/updates/report-back-from-factory-on-hdmi

<!-- more -->

The second trick.  Well, this is not so much a trick, but something to
watch out for.  Some tiny integrated circuit components such as power
regulators need a blob of solder underneath the component.  Also,
interestingly, with modern integrated circuit packages that are so
tiny, they package may have no labeling on it simply due to the
impracticality of putting labels on the package at a low cost.  So,
when you buy and work with such components, you better be pretty sure
you are working with the right stuff, otherwise you just have to throw
away the components and buy new ones, due to lack of labeling.

20190929/https://www.crowdsupply.com/eoma68/micro-desktop/updates/faulty-power-regulators
