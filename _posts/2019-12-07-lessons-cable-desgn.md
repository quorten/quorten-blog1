---
layout: post
title: Lessons learned with cable design
date: 2019-12-07 22:24 -0600
author: quorten
categories: [raspberry-pi, vintage-computing, mac-classic]
tags: [raspberry-pi, vintage-computing, mac-classic]
---

Recently, I built a cable with pin 0.1 inch header connectors so that
I could modify my Macintosh SE to locate the clock battery off the
motherboard, and to provide adaptability in what kind of battery I
have connected.  Cool.  Unfortunately, there were a few obvious design
oversights that made the cable a bit more difficult to build.

I bought standard pin headers and sockets that are designed to be
soldered on to circuit boards.  I just take these and solder them onto
the wire, easy, right?  Not so fast.  Before getting too far along,
the potential problem I've observed was that this method provided for
no strain relief mechanism.  Any stress when pulling the wire, whether
accidental or intentional, would transfer all strain to the solder
joints, which runs the risk of breaking them.  And once your solder
joints are broken, all heck is out.  Not only does your primary cable
connection not work anymore, but the exposed wires may violate your
power wiring conventions of always having a power source connected
through sockets, never pins or plugs.  Once you've got a power source
with stray pins sticking out, that could cause a short through other
components and damage them, effectively ruining your vintage computer.
That is definitely a no-go.

<!-- more -->

Typically, insulation displacement and crimp-on connectors provide
strain relief by default.  That is, after all, how they are designed
to work.  At the wire to connector connection, much of the insulation
is left on the wire and the connector physically grips onto the
insulation.  This essentially gives you a degree of strain relief for
free.  Solder-on connectors such as DE-9 connectors, by contrast, must
provide an additional separate mechanism for strain relief.  You will
note this by the outer shell of such connectors having a gripping end
at the entrance/exit of the main cable bundle.  Likewise, some
punch-down connectors like RJ45 Ethernet will also have such a similar
additional clamp at the cable entrance/exit for strain relief.

On Digi-Key, "Rectangular Connectors - Free Hanging, Panel Mount" is
where you should look for these kind of connectors.  Insulation
displacement connector (IDC).  **Not** "pin headers" as those are what
go on boards.  Wire to board, panel mount is what you are looking for.

20191207/https://en.wikipedia.org/wiki/Insulation-displacement_connector

Another issue with soldering pin headers to wires is that, well, they
are not designed for that kind of soldering.  In the case of solder-on
DE-9 connectors, there is a concave connector protruding from the
D-shell connector where you can place wire leads in and get plenty a
good solder connection secured.  But pin headers on their own come
without such a structure.  The intent is that they are to be soldered
into the holes of a circuit board, and that will provide the adequate
structure.  Also, a circuit board provides insulation between the
separate pins, which direct soldering will not provide for you, giving
you the risk of a short.

Therefore, to resolve both of the problems of my soldered-on
connectors, (1) lack of strain relief and (2) risk of shorts between
soldered connections, I cut out a small strip of paper, inserted it
between the soldered pin connections, and wrapped it around the
outside.  This isolates the soldered connections from shorting with
each other or any external components.  Finally, I taped down outside
of the paper to both the plastic part of the pin header and the wire
insulation itself.  This completes the design of a strain-relief
connector by distributing force between the plastic edge of the pin
header and wire insulation.  The solder joints, by virtue of the paper
being wrapped around them, are held in a steady location where they
will not be subject to unnecessary stress, thereby reducing the risk
of breaking a solder joint.  And even if a solder connection does
break, it is much less likely for it to come loose in a way that
causes a short due to the strength and closure of the strain relief
structure.

The final problem that was left with my pin header design was lack of
polarized connectors.  Although I had Molex PicoBlade connectors that
were polarized, and some of which were also crimp-on connectors, I
wanted to use the pin header connectors instead because theye seemed
to be more consistent with the vintage technology of the Macintosh SE.
But, this is where I fell short.  Almost every single pin header
connector inside the Macintosh SE was a polarized design.  Had I
thought a few steps ahead and bought the right parts, I could have
also used polarized two position pin headers similar to the sound
connector on the main logic board.  And that also would have provided
me with strain relief on the connectors.

Because I am doing a retrofit modification, chances are that reversed
polarity will be very unforgiving, possibly causing damage to the
circuit.  Make no mistakes when inserting the pin headers.  The safest
way is to disconnect all batteries, insert the pin headers,
double-check for correct polarity, and insert the battery last.
Likewise, it is safest to remove the clock battery first thing when
opening the computer for servicing, but this comes at the expense of
loosing all your PRAM.

But, alas, these are all shortcoming that I've made, and regardless, I
am fortunate that the whole system works nicely!
