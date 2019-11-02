---
layout: post
title: Capacitor repair info on vintage Macintoshes
date: 2019-10-23 23:33 -0500
author: quorten
categories: [vintage-computing, mac-classic, raspberry-pi]
tags: [vintage-computing, mac-classic, raspberry-pi]
---

Some interesting notes on capacitor repair on vintage Macintoshes.
Checkerboard pattern on CRT screen?  Flickering lines on CRT screen?
These are signs that the capacitors are in need of replacement.  Sure,
you might say taht after running the system for a while and the
capacitors warm up, the problem appears to "self-heal," but don't
count on that.  Capacitors don't get any better once they start to
fail.  Also, if you are replacing capacitors and accidentally remove a
pad, no worries, you can scrape off a bit of the solder mask of the
connecting adjacent wire and with magnifying optics, you can resolder
to the wire.  This is a bit more clever than the technique of tracing
the wire on the board to find a different pad to solder to via an
extension wire.

20191023/https://68kmla.org/forums/index.php?/topic/58144-recapping-accident-on-macintosh-classic/  
20191023/https://68kmla.org/forums/index.php?/topic/58139-macintosh-se-flicker-and-interference/

A good point in hand to state here for working with hobby
electronics...  through-hole components are easier to service
long-term than surface mount components.  Maybe only in regard to
capacitors, I guess.  Many other components do not require all that
much servicing and maintenance.

<!-- more -->

What is the RIFA safety capacitor?  RIFA is the brand name, the safety
capacitor design is such that it is connected directly to AC line
voltage and has corresponding failure mode safeguards built-in.  So,
be careful about the aging of these capacitors, and that's also why
the failure mode can be so dramatic with an explosion, loud popping
sound, and thick gray smoke clouds.

20191023/DuckDuckGo RIFA safety capacitor  
20191023/https://www.allaboutcircuits.com/technical-articles/safety-capacitor-class-x-and-class-y-capacitors/  
20191023/https://cpc.farnell.com/evox-rifa/pmr209mb5470m100/capacitor-class-x2-0-047uf-100r/dp/CA06049?st=rifa%20capacitors

This is some good Macintosh SE knowledge.  Trouble with jumpy picture?
Check the red, green, blue, yellow wire connector to the analog board,
near the top of the Macintosh.  If you see the connector browned or
blackened, it will only get worse.  Check the solder joints here too.
Replace the connector if necessary.

20191023/https://68kmla.org/forums/index.php?/topic/58027-macintosh-se-screen-flickeringchanging-shape/
20191023/
20191023/
