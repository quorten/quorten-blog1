---
layout: post
title: Details on how to develop a Macintosh dd
date: 2019-09-15 16:08 -0500
author: quorten
categories: [mac-classic]
tags: [mac-classic]
---

After a few months of delay, I've finally come back to picking up on
the project of sending Macintosh disk images over the network.  What
am I going to do?  I am going to keep it really simple.  I will follow
in the footsteps of my simplicit "early PC" disk imaging program:
send/receive a disk image over a serial communications connection,
using an extremely simple protocol involving only a 32-bit size header
and literal data.  This is easy enough and compatible enough to work
on the Macintosh 128K.  Similar to the PC case, the practical limit
comes at the high end: once your computer is too new, your disk is too
big, and serial communications too slow, you've got to switch to an
Ethernet-based disk image transfer program.  But, lucky for us, the
new computers with big disks (both PC and Mac) have no trouble running
Linux, so we're covered with a classic `dd` and `netcat` on that one.

So, for my own sake of being able to develop the Macintosh disk image
software, I will summarize my findings here.  Essentially, all of my
findings come from research sources previously reverenced, especially
the original _Inside Macintosh_ printed book, Volumes I, II, and III.

<!-- more -->

UPDATE 2019-09-21: Please note that my terminology of "drive" here is
a misnomer, it is technically a "volume" or "partition."  In order to
get a full hard disk image, including the partition table, you need to
use the SCSI Manager.  See [my newer blog article]({{ site.baseurl
}}/blog/2019/09/22/mac-dc-128k-io-speed) for details.

* First, start by iterating all available disk drives.  Use the
  `GetDrvQHdr()` macro to get a pointer to the _drive queue_ header.
  The `QHdr` data structure is described in Chapter 13 of Volume II
  from _Inside Macintosh_.  The location of the drive queue header is
  actually a constant memory address.  You can then iterate this
  linked list to get the key information needed to read raw data off
  of a Macintosh disk drive: the _drive number_ and the _driver
  reference number_.  Luckily, the drive queue also includes the size
  of the drive in logical blocks (512-byte blocks), which you can use
  to display in your user interface to help the operator identify
  which drive they are working with.  The information on the _drive
  queue_ is found in one of the last sections of "The File Manager"
  chapter of Volume II of _Inside Macintosh_.

    * Please note: There are some variations in the size header
      specifications in the drive queue element data structures.  The
      original value of `qType` value was always equal to `drvQType`,
      which is 3.  Newer systems that support large disks will have a
      value of zero for small disks, 1 for large disks.  In large
      disks, a second 16-bit word is specified after the first that
      contains the high-order size data.

      20190916/https://web.archive.org/web/20001214111300/http://developer.apple.com/techpubs/mac/Files/Files-112.html

* Next, the user configures the software to select the source and
  destination of their copy.  They can copy between two disk drives,
  or between a disk drive and the serial connection, in both
  directions.

* Thankfully, low-level disk access is easy on the Macintosh.  There
  is an abstract interface defined for device I/O, and you simply use
  these abstract routines with the respective drive number and driver
  reference number to read and write data from a disk drive.  See "The
  Device Manager" and "The Disk Driver" chapters from Volume II of
  _Inside Macintosh_ for details on how to do this.

  One particular note for correct copies to and from large disks.
  Always use absolute positioning rather than relative positioning,
  because the relative positioning offset is not large enough to
  handle the complete displacement within large disks.

  The previously referenced _Monster Disk Driver_ Technote is
  particularly useful for showing some example code written in C
  rather than Pascal.  _Inside Macintosh_ only shows example code in
  Pascal.  But, here's the main key point you need to know.  The C
  function names are almost identical to the Pascal routine names,
  i.e. `PBRead`.  However, for the mode specifier, the mode may be
  specified as a special function name, such as `PBReadSync()`.

  Also, one thing that is unique about Macintosh disks, mentioned in
  _Inside Macintosh_, is that each 512-byte sector of a Macintosh disk
  has an additional 12 bytes of data called the _file tags_.  This is
  a metadata structure that contains information on how to reconstruct
  files in the event that the filesystem gets destroyed.  Under normal
  conditions, this information will be redundant, but if it's there,
  why not read it and archive it?  The main disadvantage, so it seems,
  is that you must only read one sector at a time in order to reliably
  retrieve and archive the file tags for all sectors.

  UPDATE 2019-09-26: Please note that file tags have been deprecated
  from newer Macintoshes, but they are still a feature of older
  Macintoshes.  See [my blog article on file tags]({{ site.baseurl
  }}/blog/2019/09/26/dc42-file-tags-format/blog/2019/09/26/dc42-file-tags-format)
  for more information.

* Thankfully, the serial communications interface is quite simple too,
  again using the Device Manager for reads and writes.  The additional
  information for using the serial communications interface is
  specified in "The Serial Drivers" chapter from Volume II of _Inside
  Macintosh_.

* The Device Manager API has been fairly stable across all generations
  of Macintoshes.  Despite tremendous innovation that needed to happen
  in newer Macintoshes, the overall field layout in the `IOParam` data
  stsructure is identical at the beginning.  Pretty much the only
  extension made in newer Macintoshes was the `XIOParam` interface to
  support disks larger than 4 GB.

That's all there is to it!  Enjoy, and write away a great Macintosh
disk imaging software for early Macintoshes!
