---
layout: post
title: "Some good cheap segmented LCD displays, and info on driving an
        LCD display"
date: 2019-12-04 00:12 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

From my first Digi-Key searches on segmented LCD displays, I couldn't
really find LCD displays less than $10 with as many segments as I
wanted, i.e. around 10 segments.  Likewise, I found out that LED
displays ran around similar costs, $5 for 4 digits.  But, now I search
again, and the magic is in opening up the search criteria.  Sure, I
can't find a **?-segment** LCD display with as many digits as I like
at the price point I want, but I found a 14-segment display with 8
digits and about $4 for one unit.

20191203/https://www.digikey.com/product-detail/en/lumex-opto-components-inc/LCD-S401C39TR/67-1792-ND/469781

And, circling back to modifying my previous expectations, I also found
a good 4-digit, 7-segment LCD display, about $4 for one unit.

20191203/https://www.digikey.com/product-detail/en/varitronix/VIM-878-DP-RC-S-LV/153-1115-ND/1118605

<!-- more -->

The good news is that both of these display modules come in
through-hole mounting.  The bad news?  Well, again, LCD displays are
more complicated to drive than LED displays, but why exactly is that?
It's not just a question of multiplexed or individual segment drive.
It's also that LCD displays require an "alternating current"
oscillating square waveform to drive, and if a DC voltage is applied,
that will cause irreversible damage to the display.  That means you
can't miss a beat if you are driving an LCD display directly via a
Raspberry Pi.  For an Arduino microcontroller, although this is easier
to guarantee even if you are directly connecting to GPIO pins, one
wrong programming move and you've damaged your LCD display.

Here is some good information I've found on how to drive an LCD
display.  Of course these search results are all very old as nothing
has really changed in this field in decades.  As it turns out, the
reason why there is a preference for direct segment drive on simple
low segment count LCD displays is that multiplexed LCD display drive
is even more complicated than is the case with multiplexed LED
displays.

20191203/DuckDuckGo how to drive segmented lcd display  
20191203/https://forum.arduino.cc/index.php?topic=51464.0  
20191203/https://web.archive.org/web/20070317082006/http://ww1.microchip.com/downloads/en/AppNotes/00658a.pdf  
20191203/https://web.archive.org/web/20110914140715/http://www.atmel.com/dyn/resources/prod_documents/doc8103.pdf
