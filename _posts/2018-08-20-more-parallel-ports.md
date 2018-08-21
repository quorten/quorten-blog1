---
layout: post
title: "Parallel port discussion continued, and some analysis on
        the history of computer size, capabilities, and market share"
author: quorten
date: 2018-08-20 12:30 -0500
categories: [raspberry-pi, tour-de-force, reiterate]
tags: [raspberry-pi, tour-de-force, reiterate]
---

So, about the parallel port emulation problem.  With all the
complexity for full parallel port support on PCs requiring a PCI card,
surely you could do full parallel port support on Raspberry Pi by the
use of the GPIO, I2C, or SPI, correct?  Indeed, you can, and I found
one such project, but you have to do a bit of searching before you get
there.

20180820/DuckDuckGo ecp port on raspberry pi  
20180820/https://www.reddit.com/r/raspberry_pi/comments/4f5ltd/gpio_to_lpt_is_it_possible/

Here is an interface for Arduino control over CNC mills,
etc. connected via a parallel port.

20180820/http://www.coreforge.com/blog/2014/08/grbl-tb6560-interface/  
20180820/DuckDuckGo raspberry pi parallel port

Ah ha!  Here it is.  Full support for ECP in version 2, i.e. IEEE 1284
bi-directional.

20180820/https://github.com/garlick/pi-parport  
20180820/https://en.wikipedia.org/wiki/Parallel_port

<!-- more -->

So, let me summarize the whole parallel port ordeal this way.  In the
early days of computers, if you wanted a cheap, low-level electrical
control interface, you would head straight toward writing a program on
your MS-DOS PC that manipulated the parallel port by a custom pattern.
For a short period of time, you could also do likewise even on a more
powerful computer running a multitasking operating system like Windows
95/98/95SE.  But, nowadays, parallel ports are all but obsolete for
modern applications.  By far and large, specialized hardware is
connected to modern powerful computers only through a "serial port"
discipline.  If, by contrast, you want to be able have some semblance
of lower-level hardware control from a powerful computer in the modern
era, you would head straight toward a Raspberry Pi and program the
GPIO pins, which will give you an experience similar to Windows 9x.
If you want really low-level control on a real-time system similar to
MS-DOS, you would head straight toward programming an Arduino
microcontroller.

----------

Wow, that is really interesting, when you think about it.  The older
PCs?  We never really retired the hardware, but rather we assigned new
names for feature-equivalent computers.  For the new computers that
were the same physical size as the old ones, they took on the same
name as the old ones.  At the same time, the desired applications on
those computers changed to adapt to the new applications available.
Old-fashioned MS-DOS computers became microcontrollers.  Old-fashioned
Windows 9x computers became single-board computers.

But now, and this is where things get really interesting.  What about
the latest PCs, you ask?  Well, those kind of fell off an edge of a
cliff of a sort.  What happened was that yes, those machines continued
to gain new features and functions.  But consumer mass market computer
users were no longer interested to keep using the new computers!  The
new features and functions simply just weren't interesting compared to
what older computers could already do.  The line stopped at laptops
running Windows XP Media Center Edition: right in the midst of 2005,
when laptops were on their upwards trajectory of replacing PCs in
terms of mass market share, and laptops have also long but ditched
some of the low-level hardware fancies from PCs of times past such as
parallel ports and floppy disk drives.  Also, these laptops added new
Wi-Fi wireless communications network support, which proved to be
massively popular.  The result?  The consumer mass market polarized
itself around smartphones, tablet computers, and laptops.  Docking
stations are available for these smaller computers should you want to
have a larger monitor, better keyboard, and mouse for your computer,
but most people were no longer interested in connecting those
peripherals to a full-sized desktop PC.  The smaller computers
provided enough features and functions for most people, so why pay for
the larger one?

Desktop PCs, nowadays, are only used for computationally intensive,
real-time interactive computing such as the latest video games,
three-dimensional design, and real-time simulations.  Nowadays,
non-realtime computationally intensive computing is outsourced to
cloud computing and accessed via a mobile device: laptop, tablet, or
smartphone.

Again, I reiterate, because this is important!  Why are the biggest
most expensive computers "required" for video games?  They are
"required" because the commercial video game market, where people are
willing to pay a considerable amount of money for their video games,
is by far and large inhabited only by people who already paid a
considerable amount of money for their computers.  Now, this shouldn't
be surprising, but if someone starts out on on foot by buying a cheap
computer, chances are likely that they're going to want to keep the
price of complementary products down too.  Yet this means that one
cannot fund an expensive video game with even a million of these such
customers: chances are likely that people are willing to pay even less
for their software than they paid for their computer hardware.
