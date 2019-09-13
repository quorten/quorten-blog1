---
layout: post
title: Best way to bootstrap a classic Macintosh
date: 2019-05-27 00:17 -0500
author: quorten
categories: [mac-classic]
tags: [mac-classic]
---

So, you have a bare metal classic Macintosh, but no software for it?
How do you get software over to it?  How do you get it to even boot?
Here, I will unravel my advice that I have developed over the years of
working with and researching classic Macintosh software.

1. You need a system disk to boot.  To get a system disk for your
   Macintosh, you must ascertain the particular hardware vintage of it
   to determine compatibility.  There are a few main lines of
   Macintosh compatibility here.

   * "Old world" Macintoshes:
       * 400K floppy disk drive Macintoshes
       * 800K floppy disk drive Macintoshes
       * 1.44 MB floppy disk Macintoshes
       * Macintosh Classic includes system disk image in ROM
       * Macintoshes equipped with bootable CD-ROM drives
   * "New world" Macs:
       * OpenFirmware PowerPC Macs.
       * EFI PowerPC Macs.
       * EFI Intel Macs.

<!-- more -->

   Suffice it to say, booting new world Macintoshes is easy: just
   build a Macintosh bootable CD-R disc and insert that into the
   CD-ROM drive.  Likewise with the last of the old world Macintoshes
   that included CD-ROM drives, and also the Macintosh Classic.  For
   Macintoshes equipped with a 1.44 MB floppy disk drive, you can
   write the raw disk image on a standard PC internal or USB floppy
   disk drive.  It is the _old old world_ Macintoshes that are
   difficult to boot, due to the difficulty of building the
   non-standard floppy disks.

   So, how do you build such a floppy disk?  There are a few main
   ways.

   1. Conventional "brand loyal" Mac user: Get a Macintosh that is new
      enough to be able to access moderm media such as bootable
      CD-ROMs but old enough to support 800K floppy disk drives.  Boot
      the new Macintosh and use DiskCopy to write out the 400K or 800K
      system disk images.

   2. Clever PC user and early home computer enthusiast: Get an Apple
      II computer with a serial port and an Apple II 3.5 inch floppy
      disk drive.  You'll be able to use Apple Disk Transfer ProDOS to
      (1) bootstrap the Apple II from bare metal and (2) write out
      Macintosh 400K and 800K disk images.

   3. Old fashioned hardware maven: Get yourself a CatWeasel and
      attach it to a PC.  This is a custom floppy disk controller that
      will allow you to write out 400K and 800K style Macintosh floppy
      disks from a PC.

   4. Modern hardware maven: Get yourself a SCSI2SD adapter.  With
      this clever trick, you will be able to construct, via a
      Macintosh emulator, a bootable hard disk image that can be
      written out to the SD card.  The SCSI2SD adapter can then be
      attached to SCSI-enabled Macintoshes either externally or
      internally.

2. If you have a Macintosh hard drive, you're going to want to make
   sure you build a floppy disk image containing Apple HD SC Setup so
   that you can initialize your hard drive.

3. In addition to the system disk needed to boot your Macintosh, from
   a practical standpoint, you also want some useful communications
   and networking software so that you can send additional software
   directly to your Macintosh.  My recommendation for old world
   Macintoshes is to make serial communications your #1 priority.

   * Get either ZTerm or Macintosh Kermit onto either your boot disk
     or another floppy disk.

   * You need a bare, minimalistic way to unpack the data and resource
     forks of Macintosh application files downloaded via a serial
     connection.  If your serial communications program does not do
     this automatically for you (I haven't tested any yet), put
     binunpk on a floppy disk too.

4. With the previously specified bare minimums in place, you can
   easily copy over more generally useful software through the serial
   connection.  Here is a top priority list.

   * Stuffit Expander 4.0.1
   * DiskCopy 4.2
   * MacTCP, MacPPP, ConfigPPP
   * Fetch (FTP client)
   * NCSA Telnet
   * Some web browser (???)

If you're operating a classic Macintosh with at least 1 MB of RAM and
a hard drive, you should now have a full-fledged Internet connected
Macintosh.  Regarding the setup of the PPP connection required for
TCP/IP communications, I have detailed that in a previous article that
effectively allows you to use a Raspberry Pi as a "modern modem" in
place of your traditional modem.

New world Macs with a CD-ROM drive?  Heck, don't bother me about there
being any particular challenge, you can practically load as much core
operating system software as you want onto a single CD-ROM.
