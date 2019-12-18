---
layout: post
title: Disk Copy 4.2 file format and file tags
date: 2019-09-26 18:53 -0500
author: quorten
categories: [mac-classic]
tags: [mac-classic]
---

Disk Copy 4.2... ah yes, the venerable Macintosh floppy disk copying
software.  What if you can't run it since you are operating on a
different operating system, but you want to get at the data contained?
Or what if you are writing your own disk copy software and you also
want to be able to write out data in that file format?  No problem,
I've found some pretty great references on the Disk Copy 4.2 file
format right here.

20190926/https://en.wikipedia.org/wiki/Disk_Copy  
20190926/https://wiki.68kmla.org/DiskCopy_4.2_format_specification

Also, good news, for I had not been fully aware of this, but Mini vMac
also supports direct emulation on the Disk Copy 4.2 file format.  The
main benefit of this, beyond convenience, is that the Disk Copy 4.2
file format has provisions for storing file tags, so you get a more
accurate emulation of Macintosh floppy disks in that respect.

<!-- more -->

----------

The Disk Copy 4.2 format specification is also informative about the
functioning and operation of the underlying hardware.  In particular,
Apple 400K/800K floppy disks have a _GCR format nybble_ in the header
of every sector.  This indicates information about the particular
sector formatting, which can vary from one sector to the next.  The
most important information encoded in the GCR format nybble is whether
or not this particular sector has _file tags_.  In Apple ProDOS
formatted sectors, there will not be file tags available, but in
Macintosh formatted sectors, there will be file tags available.
Please note, however, that the GCR format nybble is primarily
specified to indicate whether a disk has 2:1 interleave (Macintosh) or
4:1 interleave (ProDOS).

Nevertheless, I do mention this because it is consistent with my
experimental observations.  When I use Apple II Disk Transfer ProDOS
to copy a Macintosh disk image, then read out the Macintosh disk image
on a Macintosh, I notice that all the file tag data is
undefined/invalid.  But, after I write one Macintosh file to that disk
from the Macintosh computer, then I read the disk image from the
Macintosh again, I notice that there are some valid file tags on the
disk, but only for the newly written data.  Everything else still has
invalid file tags.

Please see [my newer blog article]({{ site.baseurl
}}/blog/2019/10/22/disk-img-sf-info) on the same subject for important
additional info regarding Apple's official deprecation of file tags in
newer Macintosh systems.

----------

Regarding file tags, the key to remember is that a disk must be
specially formatted so that it can store more than 512 bytes per
sector.  In the case of Apple 400K/800K floppy disks, this is easy
since the custom IWM chip (Integrated Woz Machine) is used for the
floppy disk controller (FDC).  But, PC standard MFM 720 KB or 1.44 MB
floppy disks do not have the space to spare for more than 512 bytes
per sector, so by definition, Macintosh filesystems on such disks will
never feature file tags.

The general understanding is that with the earliest of Macintosh
technology, the means to the end of implementing file tags support was
relatively easy, but as newer Macintosh computers increasingly needed
to use more mass market solutions shared in common with the PC world,
the ability to maintain the file tags system became impractical, so
Apple deprecated them altogether.

You can easily see this in the evolution of Apple's hard disk drives.
Apple's early Hard Disk 20SC uses 532-byte sectors, reserving 20 bytes
for system use.  Out of these 20 bytes, 12 bytes are certainly
available for use to store the file tags.  It's not until you get to
the next generation, that of the Internal Hard Disk 20SC and Internal
Hard Disk 40SC, where things get modernized.  Zone bit recording and
512-byte sectors, no longer any space for the file tags, and the later
Monster Disk Driver Technote officially marks them as obsolete.  When
you read blocks on these devices, the disk driver simply doesn't write
to the file tags buffers, so whatever stale or garbage data was in
there previously is left unchanged as you read blocks.

Does the original Hard Disk 20 that connected through the floppy disk
connector have file tags?  I would guess it does due to the use of a
custom controller, and chances are that the disk technology of it is
rather similar to the Hard Disk 20SC.  Well, the "original" Hard Disk
20SC, that is.  Maybe there was more than one version of the Hard Disk
20SC, and the newer versions did not feature 532-byte sectors with
room for file tags.

#### 20SC Hard Drive Info
* 532 bytes per sector (20 used by system)
* 32 sectors per track
* 305 cylinders
* 4 heads (technically 4 surfaces and 1 head per surface)

20,769,280 formatted byte capacity

#### Internal Hard Disk 40SC Specification

##### Capacity
* Data capacity: 40MB (formatted)
* Data surfaces: 3 and 4
* Heads/Surface: 1
* Block size: 512 bytes
* Total disk blocks: 82,020
* Blocks/Track: 28, 33, and 35

Note: Drive uses zone recording, so the usual sector size/sectors/
cylinders/heads volume specification will not work.

2010 era webpages:

20190924/https://web.archive.org/web/20110516051041/http://docs.info.apple.com/article.html?artnum=1931  
broken/http://docs.info.apple.com/article.html?artnum=6976&coll=ap

Unfortunately, the Internal Hard Disk 40SC Specification page was lost
to time, never captured by the Wayback Machine.  Fortunately, I took
some steps as a forward thinker to copy out the pertinent information
to my simple text-based notes, although I should have also thought in
advance to save this page to the Internet Archive Wayback Machine.

AND, unfortunately, even the Wayback Machine's archive of the page
does not match the original text that copied off of an earlier version
of the page.  It really doesn't look anything like the original page
that I remember seeing.
