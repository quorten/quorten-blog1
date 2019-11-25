---
layout: post
title: "Explaining single-wire earth return, and updates on \"magnetic
        resonance\" power distribution"
date: 2019-11-23 23:18 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Intuitively possible but mind-boggling as it is, I took another look
at single-wire earth return and nown I understand the operating
principles.  Intuitively, this would work better with AC than with DC
current, and indeed AC is quite practical for this for a number of
reasons I will explain.

First of all, single-wire earth return uses an isolation transformer
to keep the grid voltage loop out of the single-wire earth return
voltage loop.  There is also another such isolation transformer on the
customer premises to keep their local power out of the single-wire
earth return distribution current loop.  So, right off the bat, we can
say that isolation of current loops is important.

Some more intuition would lead you to believe that AC at a
sufficiently high frequency is needed to be able to pump the charge
out of the ground without having the signal want to short striaght to
ground.  Because if it did, you would have virtually no current flow
through your distribution wire, and thus your electricity would travel
nowhere.

<!-- more -->

Indeed, this is another important consideration.  If the resistance of
the ground soil is too high, you won't be able to get an efficient
distribution system.  And, surprise surprise, what happens with
single-wire earth return is that there is in fact technically a
current loop that travels through the earth, finding its way from the
distribution end-points right back to the source grounding steak.
Wow, now intuitively, if that is what is happening, then you also do
need high-voltage electricity to get any usable supply at all.
Actually, this is a practical example of what is called a "phantom
loop."

So, there you go, the key operating principle of single-wire earth
return has been disclosed and explained.  You technically do need a
full current loop, as is the case with any electrical transmission,
but the trickery here is that part of the current loop, the earth
return, runs through an implicit, undefined path in the ground.  For
this to work, your ground source must be sufficiently conductive of
electricity, and, ultimately, it must be contiguously connected
between the source and destination points.  This has the obvious
implication that you cannot supply electricity to "airborne" users who
have only one wire connected and no conductive path to ground.

Now, here's the important key point to myself.  This means that for
small electronics, like a key fob for public mass transit, cannot be
constructed using truly only one wire for 1-wire communications via
the "single-wire earth return" principle, because the voltage is too
low and the ground insulation between the user and the mounted device
is too high for there to be an "earth return" ground path.  For
current to flow in such a "suspended in the air" use, you need two
wires.  Otherwise, your only other alternative like "one-wire" is to
electromagnetic radiation of the power and data signals, just like
RFID.  Yes, you can guide radio frequency through a single-conductor
antenna, but the best radio frequency carrying cables always have two
conductors, or one conductor and one ground.  Yes, indeed, radio
frequency is modulating electrical power and signals at really high
frequency, so it is like ultra-high frequency AC.

20191123/https://en.wikipedia.org/wiki/Single-wire_earth_return

We've found practical ways to distribute data singles long distance
through electromagnetic radiation, but power, those have long only
been practical for short-distance transmission.  Magnetic resonance
was once long ago hyped as a solution for being able to send power
over a longer distance as electromagnetic radiation, but in the
intervening years, the technology has stagnated in research and
development progress, no useful products made it to market, and it is
pretty much all but forgotten from the public consciousness.

20191124/https://en.wikipedia.org/wiki/Resonant_inductive_coupling

Oh, okay, looks like the primary update in the research of this is as
follows.  People have successfully built commercialized realizations
of this technique that can reach up to 3 meters, but the concept of
reaching several kilometers with this technology has been shelved.  3
meters is good enough to wirelessly power a maglev train and to power
equipment inside of a mid-sized closet, but most typical "small rooms"
are going to be just a tad bit too big to power all electronics in the
room solely from a single magnetic resonance node inside the room's
one central lighting fixture.

Also, more importantly, you're not remotely going to get this
technology rolled out in the home residential market on a large scale,
that market moves too slowly and is relatively resistant to change.
