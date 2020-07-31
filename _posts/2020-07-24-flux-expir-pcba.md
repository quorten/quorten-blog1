---
layout: post
title: "Does solder flux ever expire?  Not really.  And, another
        turnkey PCB assembler.  And, how to tell leaded solder boards
        apart from lead-free solder boards."
date: 2020-07-24 02:38 -0500
author: quorten
categories: [raspberry-pi, important]
tags: [raspberry-pi, important]
---

Solder flux, if you purchase it on its own, typically has aN
expiration date of 2 years.  But what about the flux cores inside
solder wire?  That os gemerally considered not to expire, what gives?
Okay, so it turns out that some manufacturers do list an expiration
date.  And actually, especially if solder wire is left exposed to open
air, the flux core will go bad near the tip.  But, kept in a sealed
bag, many folks have reported the solder working just fine several
decades later.  As for solder flux, it can be restored by putting a
few drops of alcohol in it if it thickens.  But solder paste, due to
the solder powder and flux being mixed together, it doesn't fare so
well when it expires.

A flux wetting test is useful to determine if flux is good or bad.
What is that?  Basically, if you drip it on to a metal surface to be
cleaned and fluxed, does the flux spread evenly across the surface?
Or does it tend to stick together?  Proper wetting means it will
spread as much as possible evenly across the surface, for a
considerable surface distance.

20200723/DuckDuckGo how long does flux in solder last  
20200723/https://www.evilmadscientist.com/2013/solder-expire/  
20200723/http://www.circuitinsight.com/programs/54448.html  
20200723/DuckDuckGo flux wetting test  
20200723/https://superiorflux.com/role-of-flux/

<!-- more -->

Now, all that discussion about using flux.  My rationale, I need it so
that I can properly clean connections already applied to the circuit
board that have developed an oxide layer, but I want to rework them.
Is using flux really the answer?  Well, yes, looks like so, according
to this source on proper soldering.  Alas, looking in here, I also
learned that I was not doing a bunch of my solder joints correctly.  A
proper solder joint should have a concave fillet, if you see a convex
fillet, you used too much solder.  Why?  This is mainly in regard to
inspection to check if both the lead and the pad were both properly
wetted.  A ball-like convex solder fillet may be hiding defects
beneath the surface, a lesser amount of solder for a concave fillet
cannot so easily hide defects under the surface.  Indeed, this article
is in reference to NASA's electronics workmanship guide.

20200723/DuckDuckGo oxide layer on board solder  
20200723/https://www.seeedstudio.com/blog/2019/08/07/13-common-pcb-soldering-problems-to-avoid/

Also, another important note, Seeed Fusion is another turnkey PCB
assembler, they do the complete process of not just printing your
printed circuit board, but they can also pick-and-place the discrete
components onto it.  Another Chinese one, that is.  So, now that
brings our total number of PCB Assembler choices to three.

* JLC PCB (Hong Kong)
* NextPCB (China)
* Seeed Fusion (China)

One thing I didn't really figure out, how many of these allow you to
order assembled PCBs in quantity of one?  Seeed Fusion does PCB
printing in quantity of one, not sure about PCB assembly.

----------

Important!  The Seeed Fusion article mentioned how to tell leaded
solder joints apart from lead-free solder joints, and now thinking it
through carefully, I can attest that I did see the difference and am
personally able to tell them apart visually.  Leaded solder joins,
when done ideally, will look _very smooth and shiny_, whereas
lead-free solder joints, even when done ideally, will have a _duller
and more matte_ look to them.

Yes, now I think back.  Have you bought a Raspberry Pi with the pin
header already soldered on?  Take a good look at the solder around the
pin header, since there is ample amount over there.  You will notice
that the solder looks rather dull and matte.  Why is that?  Shouldn't
it look clean, smooth, and shiny?  No, it should not.  That is
precisely because Raspberry Pi boards are RoHS and therefore
manufactured with _lead-free_ solder.  On the other hand, if you look
at any vintage-style electronics with through-hole components, the
underside of the board with the solder joints will look very clean,
smooth, and shiny.

That being said, it is much harder to tell what kind of solder has
been used on a board by looking at surface-mount components than it is
by looking at through-hole components, simply because less solder is
used and most of it is visibly occluded by its nature of being between
the pads and the leads, or maybe even totally hidden underneath a
no-leads component such as Quad-Flat No Leads (QFNL) or Ball Grid
Array (BGA).
