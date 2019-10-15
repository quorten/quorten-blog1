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

<~-- more -->

```
SCSI ID: 0
Direct access block device.
Peripheral device connected or unknown.
Reserved = 0x00
SCSI version = 0x02
Response data format = 0x01
VendorID: QUANTUM 
ProductID: CTS40S          
Revision: 4.07
lbasize = 82332, blksize = 512
```

Well, looking around, I was able to find more information on
Wikipedia.  Quantum Corporation once was a very formidable hard drive
vendor, but they ended up selling their hard drive business sector to
Maxtor in the early 2000s.  Ah, now that's a familiar name in the
modern hard drive business, they're still around.  Alas, as it turns
out, they exist in brand name only.  They too were bought by Seagate
in the late 2000s.

20190929/https://en.wikipedia.org/wiki/Quantum_Corporation  
20190930/https://en.wikipedia.org/wiki/Maxtor

Upon further analysis of the INQUIRY data, I was able to determine
more specific information about the drive model.  "Quantum ProDrive
ELS 40" is the full official name.  I even found the official manual
for the hard drive... well, actually only a very close analog.  Or
maybe there was just one manual for the whole family, but the meaning
of "ELS" is lost upon me.  Looks like the "hub" source of the online
manuals is `bitsavers.org`.  Ah yes, a venerable website for vintage
computing.

20191006/DuckDuckGo QUANTUM CTS40S 4.07  
20191006/http://www.textfiles.com/bitsavers/pdf/apple/scsi/apple_scsi_ident.txt  
20191006/https://www.manualslib.com/products/Quantum-Prodrive-40s-3735137.html  
20191006/DuckDuckGo quantum prodrive ELS 80  
20191006/https://archive.org/details/bitsavers_quantumQuaroductManualJun88_6537414

Wow, even through all the buyouts and mergers, Seagate has continued
the legacy by continuing to host relevant documentation.

20191006/https://www.seagate.com/files/staticfiles/maxtor/en_us/documentation/quantum_jumper_settings/prodrive_jumpers.pdf

And oh, wow, what risky extents some are willing to go through to
bring a stuck Quantum drive back to life.  Looks like that patented
AIRLOCK arm locking mechanism is prone to locking a bit too well, and
that such is fairly common with the older drives.

20191006/https://www.ebay.com.au/itm/Quantum-ProDrive-ELS-Repair-Insert-Fix-your-classic-Macintosh-hard-drive-/253950486931
