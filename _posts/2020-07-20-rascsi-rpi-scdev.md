---
layout: post
title: "RaSCSI, the solution to using your Raspberry Pi as a SCSI device"
date: 2020-07-20 20:59 -0500
author: quorten
categories: [vintage-computing, raspberry-pi]
tags: [vintage-computing, raspberry-pi]
---

Finally, at long last, the solution I was looking for.  Want to use
your Raspberry Pi as a SCSI device?  Use RaSCSI, the solution to
exposing your Raspberry Pi GPIO pins to control a SCSI connection.
With this, you can emulate a SCSI hard disk drive and use that to boot
any classic Macintosh that is equal to or newer than the Macintosh
Plus.  So, now you have two clear paths to creating the necessary boot
disk to boot an older Macintosh.

1. Boot a newer Macintosh, either with the assistance of a modern
   device emulating a SCSI hard drive, or using a bootable optical
   disc (CD-R).

2. Now that your Macintosh is booted, write out the 400K/800K style
   floppy disk.

3. Boot your vintage Macintosh using it.

Alternatively, if you are really lucky, there is still one more final
conversion path.  Use a magnetic flux imager drive, such as
Applesauce, to directly write out a Macintosh floppy disk from a
modern computer.

With Raspberry Pi serial communications, and Raspberry Pi parallel
port via `pi-parport`, you're pretty much all set to tackling anything
problem a vintage system may throw at you.

<!-- more -->

PLEASE NOTE: The original author of RaSCSI wrote the site in Japanese,
and they didn't use a GitHub account.  The original site is long gone
now, but luckily, it was picked up by the community and has numerous
mirrors, some notable ones on GitHub.

20200720/DuckDuckGo rascsi  
20200720/https://github.com/akuker/RASCSI  
20200720/https://github.com/XReyRobert/RASCSI

This is also an important thread where folks from 68kMLA are
discussing their own efforts at building from this design.

20200720/https://68kmla.org/forums/index.php?app=forums&module=forums&controller=topic&id=30399
