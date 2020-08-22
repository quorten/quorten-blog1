---
layout: post
title: Great technique on hand-soldering fine pitch integrated circuits
date: 2020-08-15 22:36 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, I was having quite a bit of trouble figuring out how to
hand-apply solder paste to SSOP pads without stencils, but I got some
very good insight here.  One method of soldering fine pitch pads is
the "pool of solder" method, whereby you flood the pads and pins with
solder, then you use solder wick to remove the excess.  You'll have
nice, cleanly separated pads.

So, that's really great to hear!  The technique can be extended to
using solder paste too.  You apply the solder paste such that the pads
are bridged together, but then you can use solder wick to remove the
excess.  But, the good things don't stop there.  Thanks to surface
tension magic, most bridges across pads will break apart on their own
because the molten, liquid solder wants to stick to the metal pad
surfaces more so than the insulative solder mask surface.  That leaves
less work for solder wick cleanup, not to mention less likelihood of
failure to properly clean up the overflow.

That being said, this technique of course doesn't work with
Quad-Flat-No-Leads (QFNL) or Ball Grid Array (BGA) components due to
the lack of exposed leads where you can do cleanup with solder wick.

20200815/DuckDuckGo hand apply solder paste tssop pads  
20200815/http://skywired.net/blog/tutorials/how-to-solder-qfp-tssop-soic-surface-mount/

20200815/https://electronics.stackexchange.com/questions/145271/whats-the-easiest-way-to-solder-tssop-parts

<!-- more -->

So, I put my hypothesis to the test.  The result?  I am quite
impressed!  Re-positioning a fine-pitch chip is very easy when you
have solder paste smeared across the pads because you do not worry
about accidentally creating bridges when doing so, they'll be broken
away anways after your rework.  And then, after I've done the reflow,
indeed there were only a few fine-pitch pads bridged together, and I
was able to clean these up with solder wick without much issue.

My main concerns were that I either (1) may have not cleaned up enough
solder, somehow hiding deep on the pads may be a bridge I just cannot
reach, or (2) I may have damaged the chip from too much heat from the
soldering iron from solder wick cleanup.  Reflow ovens are nice
because you don't use as high of a point temperature as soldering
irons, so heat damage is less likely.  That being said, I was of
course trying to be very careful to avoid overheating when using the
soldering iron, and my hope was that the thermal mass of the solder
wick also helped for softer and gentler treatment to the chip itself.

Finally, the question of testing for bridges?  Basically, the only
reliable way to do this with integrated circuits is optical
inspection.  Often times the internal circuits may use buffers or
default ground termination of some sort that render basic electrical
continuity testing pretty much useless in informing you of solder
bridges.
