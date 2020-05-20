---
layout: post
title: "Repair an LCD screen with dead segments/pixels on hand-held
        electronics, and notes on multiplexing schemes for displays"
date: 2020-05-19 03:54 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Having trouble with an LCD screen in a hand-held electronic that
appears to have dead segments or pixels?  Almost always, these kind of
problems come from loose electrical connections.  Particularly, in
hand-held electronics, the LCD screen is connected to the printed
circuit board using a flat ribbon cable that is bonded using hot glue,
and this glue-down connection can come loose over time.  Fortunately,
it is fairly easy to fix this using simple tools like a hot air gun to
soften the glue and a pencil eraser to push the ribbon back down
closer to the board to make electrical connection.

20200519/DuckDuckGo multiplexed 7-segment lcd display internal wires loose  
20200519/https://hackaday.com/2009/06/20/repair-a-malfunctioning-lcd/  
20200519/https://www.instructables.com/id/Repair-a-Malfunctioning-LCD/

However, the if this does not work to fix the problem, it might be
more nuanced.  LCD displays with a large number of segments or pixels
are always multiplexed, and multiplexed LCD displays have an internal
interconnect grid to connect individual segments to the ribbon cable
wires.  It's possible that connections can come loose in here.  If
that's the case, yeah, then attempting to repair the ribbon cable
won't maky any difference.  I'd like to assume that is less likely
than the other case, but if all else fails, sure, that's something to
suspect too.  I mean, if this is the case, you can still use the LCD
screen if you find a way to repair those internal connections in a
non-invasive manner.

<!-- more -->

Also related, how exactly are the digits multiplexed in your display?
Interleaving digits when refreshing reduces apparent flicker, and
advanced displays multiplex some segments of a digit but not all
segments of one digit at the same time.  So, keep this in mind if you
see part of one digit's segment disappear but not the other.

20200519/https://electronics.stackexchange.com/questions/32675/why-do-7-segment-led-displays-break-apart-when-i-brush-my-teeth

My particular display's ribbon has about 33 conductors.  The display
itself has 10 7-segment digits and a decimal point for each, plus
about 11 other supplemental "indicator" display items.  So, about 91
segments total.  A 10x10 matrix (20 conductors) can drive that, plus a
few more wires for LCD grid voltage and convenience.  Yeah, I guess it
does sound plausible that the external theory holds, the bonding
adhesive came loose.  Say each of those digits used one "common
cathode" (or grid voltage) connection, but it was setup to cover half
of each adjacent digit.  That's 10 more wires.  Sounds plausible.
