---
layout: post
title: Review of some different Macintosh Classic emulators
date: 2019-05-17 23:28 -0500
author: quorten
categories: [mac-classic]
tags: [mac-classic]
---

* Executor -- if you simply want to run Macintosh Classic software and
  are okay doing so without a "genuine" ROM.

* Mini vMac -- my old preferred choice for emulating a Macintosh SE.
  The software and instructions for getting started are pretty nice,
  just as is the case for Apple Disk Transfer ProDOS.  Also, genuine
  SCSI hard disk drives are not supported, so I can't setup the
  virtual Macintosh SE just like I have the real one.

* MESSS + MAME -- MESS is now merged into the MAME project, MESS
  provides a more genuine emulation experience of Macintosh SE than
  Mini vMac when I last checked, but there was one bug on the timer
  and processor speed clocking that makes software run unusually slow.
  Genuine SCSI hard disk drives are supported, but not the kind of
  internal hard disk drive on SCSI0 that my real Macintosh SE has.

* PCE and PCE.js -- this may be more of a newer kid on the block in
  Macintosh emulation, but it has clearly grown much more popular by
  its inclusion in the Internet Archive.  Also, it supports genuine
  SCSI hard disk drives.

And there were also a few other Macintosh emulators that I've
mentioned in previous articles, but won't revisit those for now.

<!-- more -->

In any case, the main state of affairs here is that I need to revisit
the PCE emulator in more detail.  Yeah, the software documentation
appears to really not make it easy to get started on genuine
emulation, but in terms of software popularity, it appears to be the
future of Macintosh Classic emulation.

Also, some other news notes on Mini vMac, PROM handling support has
been improved in the official later versions.  Now there is a tool,
GetPRAM, that allows you to get custom PRAM settings and bake them
into a Mini vMac variations build.

In the middle of this topic, I was searching for a more
Macintosh-specific solution than Kermit for serial terminal emulation
and ZMODEM file transfer that also works on System 6, but no dice.

20190517/https://www.gryphel.com/c/news/index.html  
20190517/https://www.gryphel.com/c/minivmac/extras/getpram/index.html  
20190517/DuckDuckGo macintosh classic system 6 serial terminal emulator  
20190517/https://archive.org/details/mac_MacOS_6.0.8  
20190517/https://discussions.apple.com/thread/8546900  
20190517/DuckDuckGo pce emulator  
20190517/http://www.hampa.ch/pce/  
20190517/http://www.hampa.ch/pce/about.html  
20190517/http://www.hampa.ch/pce/pce-macplus.html  
20190517/https://jamesfriend.com.au/pce-js/
