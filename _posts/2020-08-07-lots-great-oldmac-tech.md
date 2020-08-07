---
layout: post
title: "Lots of great tech: RaSCSI, Scuznet, MacOS cross compile, and
        more"
date: 2020-08-07 06:28 -0500
author: quorten
categories: [vintage-computing, mac-classic]
tags: [vintage-computing, mac-classic]
---

The user Uniserver on 68kMLA?  Here is his website.  Apparently he has
made a number of his own schematics, but he requires payment before
you can download it.

20200805/http://www.maccaps.com/MacCaps/Schematics.html

The available schematics mostly focus on newer classic Macintosh
models, pretty much the oldest one on the list is the Macintosh SE/30.
And that one, well nowadays that has a more openly available
schematic.

Good news, RaSCSI has plans of adding support for SCSI network
adapters!  In the meantime, there is Scuznet, available as a
standalone board project.

https://68kmla.org/forums/index.php?app=forums&module=forums&controller=topic&id=30399&page=6&app=forums&module=forums&id=30399  
https://68kmla.org/forums/index.php?app=forums&module=forums&controller=topic&id=59044&page=2&app=forums&module=forums&id=59044

Here is the GitHub for the 68kMLA version of RaSCSI.

20200805/https://github.com/akuker/RASCSI/wiki/OLED-Status-Display-(Optional)  
20200805/https://github.com/akuker/RASCSI/wiki/Setup-Web-Control  
20200805/https://github.com/akuker/RASCSI

<!-- more -->

Here is the GitHub for Scuznet.  It uses, and provdes good
documentation on, the protocol used by an existing historic Macintosh
SCSI device, so the same drivers can be used.  Namely, the Nuvolink
SC.

20200805/https://github.com/saybur/scuznet  
20200805/https://github.com/saybur/scuznet/blob/master/PROTOCOL.md

This 68kMLA forum thread has some good advice on working with floppy
disk drive repairs.

20200805/https://68kmla.org/forums/index.php?app=forums&module=forums&controller=topic&id=60268

Wow, this is interesting.  Discussion about issues setting dates after
the year 2020, due to a bug in the system 6/7 control panel.  There is
a handy open-source SetDate utility you can use to work around this.

Nevertheless, there is still the year 2041 problem.  But, a very
interesting plan of attack has been discussed, you can just patch the
Macintosh toolbox date/time conversion routines to gracefully handle
dates after the year 2041.

Interesting, as early as Macintosh System 6.  Way back in the 1980s,
and ona 32-bit CPU at that!  Not even 32-bit, to be punctually
technical.

20200805/https://68kmla.org/forums/index.php?app=forums&module=forums&controller=topic&id=60343  
20200805/http://www.synack.net/~bbraun/macapps.html  
20200805/http://mirror.informatimago.com/next/developer.apple.com/documentation/mac/OSUtilities/OSUtilities-99.html#MARKER-9-89

Also interesting, from the `synack.net` website.  Seiko RC-1000, a
smart watch from the 1984?  Yes, 2K of user programmable memory.

20200805/http://www.synack.net/~bbraun/rc1000/

Notes on classic Macintosh programming?  Here is one good site,
written in the modern context, for sample programs.

20200805/https://mu0n.github.io/ForayInto68k/index.html

Finally!  It's what I've been looking for, a modern GCC toolchain
compiler to cross compile vintage Macintosh software.  Even better,
there is now an open-source Mac OS Classic API library called
Multiversal Interfaces.  Wow, that's great, that means I don't have to
write it all from scratch on my own.

20200805/https://github.com/autc04/Retro68
