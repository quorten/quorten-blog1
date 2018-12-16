---
layout: post
title: "Success opening old DSL router, now time to figure out JTAG
        wiring"
author: quorten
date: 2018-09-27 23:07 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Cracking open the case on the old DSL router is complete!  Thanks to
the use of the right JIS screwdriver set.  Wow, it really is amazing,
just like the videos online.  You use a Phillips, and you can't really
grasp the screw at all.  But, just by a few minor changes to the
Phillips screwdriver geometry to a JIS screwdriver, suddenly you can
really grip the screw and uncrank it with a lot of force, exactly what
was needed for me to open up that router box.

Now that I can finally see and get access to the bare board, I spied
two 6-pin headers, labeled JP603 and JP604.  What do those do?  One of
them, the JP603 header, is most likely a CMOS serial console.  Indeed,
one of those could be JTAG, using the bare minimum number of pins
required.  Here's is the bare minimum for JTAG pins:

1. GND: Ground
2. TCK: Test Clock
3. TMS: Test Mode Select Input
4. TDI: Test Data Input
5. TDO: Test Data Output
6. TRST: Test Reset

If you have a 14-pin JTAG header, nearly half of those pins just wire
up to ground.  So don't worry, 14 pins aren't actually needed for a
JTAG connector.

<!-- more -->

Determining the actual pin assignment is a tough one.  Generally, the
advice is to look at the circuit board traces to see which pins
connect to the JTAG pins on your processor.  The JTAG processor pins
are determined by searching for the specifications online.  Likewise,
you can probably use a similar technique for determining where the
CMOS serial console pins are.

Oh, and a word of warning for more modern devices than an old router:
high-end modern devices take a number of steps to prevent the use of
JTAG after the device is commercially sold.  Sometimes the
microcontroller requires a hard reset to clear a JTAG disable setting,
and the hard reset also erases all firmware.  Sometimes they use
permanent blow-out fuses to disable JTAG.  Sometimes they use password
lock-down, deliberate delays between failed password attempts, or
single-try logic for passwords that require a cold boot on failure.

Background info already existing in my notes.

20180927/https://www.routertech.org/viewtopic.php?f=3&t=3007&start=15  
20180927/https://www.routertech.org/viewtopic.php?f=3&t=3007&sid=05ce63030fe984d7d17d23ad8bd916c3  
20180927/https://en.wikipedia.org/wiki/Texas_Instruments_AR7  
20180927/https://en.wikipedia.org/wiki/File:ADSL_modem_router_internals_labeled.jpg

Now the new stuff.  First the pin descriptions for JTAG.

20180927/DuckDuckGo jtag port pin description  
20180927/http://www.interfacebus.com/Design_Connector_JTAG_Bus.html

Now searching for particular information on my type of old router.

20180927/DuckDuckGo JP603 JP604 pin headers  
20180927/https://www.routertech.org/viewtopic.php?t=5216  
20180927/DuckDuckGo reverse engineer jtag pin assignment  
20180927/https://reverseengineering.stackexchange.com/questions/1374/how-do-i-identify-and-use-jtag#1382

As it turns out, Wikipedia is still a great resource for information
on electronics.

20180927/https://en.wikipedia.org/wiki/JTAG  
20180927/https://en.wikipedia.org/wiki/In-circuit_test#Bed_of_nails_tester  
20180927/https://en.wikipedia.org/wiki/Pad_cratering  
20180927/https://en.wikipedia.org/wiki/Automated_X-ray_inspection  
20180927/https://en.wikipedia.org/wiki/Automated_optical_inspection
