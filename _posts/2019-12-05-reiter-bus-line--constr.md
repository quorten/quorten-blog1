---
layout: post
title: Reiterate transmission line bus construction
date: 2019-12-05 22:01 -0600
author: quorten
categories: [raspberry-pi, reiterate]
tags: [raspberry-pi, reiterate]
---

After some thought analysis about what I've learned about transmission
line reflections theory, I can re-affirm my explanation of
transmission line bus construction.  Changes in current flow are the
primary cause of reflections.  So, when the question comes down to how
to tap out a T connection to your device connected to your bus wire,
the solution is simple.  You simply want your device on the T
connection to be a "high impedance" connection, i.e. it does not draw
much current from the line.  This way, you are minimizing your
interruptions to the line current when connecting.

But on second thoughts, there may be other considerations.  You can
have multiple receivers on the connection simultaneously, but only one
sender can send at a time.  So, although you can have a high-impedance
receive, you must have a low-impedance send.  And ultimately, you want
to be able to electrically remove a device from the transmission line
when it is not sending so that it does not provide a current flow path
that would interfere with other senders.  Ah, yes, looking at the
Wikipedia article for "three-state logic" in more detail, this is
precisely what it is: in addition to an output being able to assert
two states, it can also assert itself to be electrically removed from
the connection, creating a high-impedance state.

20191209/https://en.wikipedia.org/wiki/Three-state_logic

<!-- more -->

So, that's the magic on control of the sender side.  So, finally, your
primary current path is pretty much just the "bus" line connection
itself, and you finish that off by terminating the ends of the bus
line with resistors equal to the characteristic impedance of the line.
These resistors, of course, have lower resistance than the high
impedance receive connections, which are designed to have a higher
impedance so as to not interfere with the line.

So, another consideration.  What kind of cable should you use for your
own IoT network where you plan on connecting devices via RS-485?  In a
large scale construction, sure, you could use cheaper cable, but my
recommendation would to be to simply use the same standard Cat6A cable
that you are using for building out the Ethernet network, and likewise
strive to wire it up in a star topology.  This provides for easy
upgrade to a high-speed Ethernet network should the need arise in the
future.  "Design for the future, because it will be here sooner than
you think."  And especially for construction at the building scale,
often times there are sources of delay and procrastination with making
any changes at all that more than tilt the cards to building
future-resistant structures that can still provide value even under
procrastination and deferred maintenance.

Now, what if you want to put a single RS-485 receiver at the hub of a
star topology with point-to-point connections?  How can you do this
that provides for proper termination at the characteristic impedance?
Simply use line drivers for termination, this will provide for
electrical isolation of the current loops of different wires.  Then,
you can wire-OR everything together on the board-side of your circuit,
without worrying about creating interference in the lines.
