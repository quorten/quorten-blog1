---
layout: post
title: Mystery of the lost hard drive company
date: 2019-09-29 16:35 -0500
author: quorten
categories: [mac-classic, computer-history]
tags: [mac-classic, computer-history]
---

When I was exporting a full disk image from my Macintosh SE, I noticed
something very interesting about the 40 MiB internal hard disk drive.
It wasn't as I was expecting it to be.  First, some background
information on hard disks for classic Macintoshes.  To access a hard
drive on the block-level, a classic Macintosh doesn't really provide
any layer of abstraction; rather, it merely provides a set of
convenience routines called the _SCSI Manager_.  Essentially, you have
to build up your own SCSI requests and parse out the SCSI responses,
and the SCSI Manager's sole role is to provide helper functions for
sending requests and receiving responses.

So, as I previously stated, I had to learn the SCSI protocol to make
my Macintosh hard disk image.  As part of this process, I was sending
the SCSI `INQUIRY` command to get basic information on the disk
drives.  Here I saw that (1) the hard drive wasn't actually an Apple
40 MB Internal Hard Disk because it had more blocks than the official
specification, and (2) the third party hard drive vendor was Quantum.
Wow, now that's a hard drive company that I've never heard of before
because they no longer exist in the modern era.

Well, looking around, I was able to find more information on
Wikipedia.  Quantum Corporation once was a very formidable hard drive
vendor, but they ended up selling their hard drive business sector to
Maxtor in the early 2000s.  Ah, now that's a familiar name in the
modern hard drive business, they're still around.  Alas, as it turns
out, they exist in brand name only.  They too were bought by Seagate
in the late 2000s.

20190929/https://en.wikipedia.org/wiki/Quantum_Corporation  
20190930/https://en.wikipedia.org/wiki/Maxtor
