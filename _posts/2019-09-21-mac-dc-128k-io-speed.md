---
layout: post
title: Important info updates on Macintosh hard drive imaging
date: 2019-09-21 21:12 -0600
author: quorten
categories: [mac-classic]
tags: [mac-classic]
---

My previous article on [Details on how to develop a Macintosh dd]({{
site.baseurl }}/blog/2019/09/15/detail-mac-image) made a few
mis-statements in the details.  Here, here I must clear them up.

The "Disk Driver" from the Device Manager API is a misnomer.  The
"Disk Driver" accesses logical blocks from a _volume_, i.e. a
partition, not a full disk.  Likewise, `GetDrvQHdr()` gets a list of
_volumes_, not drives.  This name oversight was perfectly fine in the
era of floppy disks since a volume and a disk were one-in-the-same,
but it did not extend well once partitioned hard disk drives were
introduced.  Additionally, please note that only Macintosh file
systems will be listed by the Disk Driver.  Volumes/partitions with
foreign file systems must be read using Apple File Exchange to get a
block-by-block copy.

Therefore, if you want to take a full disk image of a hard disk drive,
including the "partition map," you must use one of the newly
introduced low-level APIs.  In the case of the Macintosh Plus and
newer compact Macintoshes, this will be the SCSI Manager:

20190921/https://web.archive.org/web/19991116003046/http://developer.apple.com/techpubs/mac/Devices/Devices-119.html

However, please note that the Monster Disk Driver Technote states that
the Macintosh 128K and 512K do not support _partition-based drivers_.
That means that early hard disk drives like the Macintosh Hard Disk 20
do not have a such thing as a partition map hiding away outside the
volume visible to the Macintosh Device Manager.  So, if your goal is
to make a hard disk image of a really old hard disk drive like Hard
Disk 20, you're all set with the Disk Driver from the Device Manager
API.

<!-- more -->

(Yeah sure, they only boot through floppy, but can't you load a
partition-based driver from a floppy?  Well, not if the version of Mac
OS that supports partition-based drivers does not support your
machine.)

So, regarding the SCSI Manager, a brief overview of its operation for
my particular use case is helpful.  Basically, the SCSI Manager is a
thin wrapper on top of the SCSI protocol, so proper documentation on
the SCSI protocol is a must-have.  Using the SCSI Manager can be
described in the following high-level steps.

1. Arbitrate the bus.

2. Select the device.  How to enumerate?  Well, I guess simply try to
   select every available device, from zero to 6.  Device 7 is the
   Macintosh computer.

3. Command(s) followed by SCSI Manager read result data.  Namely,
   INQUIRY, READ CAPACITY, and finally a series of READs.

4. Free the bus.

You might want to program the loop so that you don't hold the bus the
whole time, but periodically free it after a burst of operations.
Well, that's probably what you want to do, and it's what I'll do.

### References

Important!  SCSI commands reference online, available for direct
download without registration, payment, or any of that for the
standard.

20190921/https://en.wikipedia.org/wiki/SCSI_command  
20190921/https://www.seagate.com/files/staticfiles/support/docs/manual/Interface%20manuals/100293068j.pdf  
20190921/https://en.wikipedia.org/wiki/SCSI_CDB

SCSI status codes:

20190922/https://en.wikipedia.org/wiki/SCSI_Status_Code

Contingent allegiance is the name for the SCSI error condition where
the error status is being held ready for a READ SENSE command.

20190921/DuckDuckGo scsi naca  
20190921/DuckDuckGo auto contingent allegiance  
20190921/https://en.wikipedia.org/wiki/SCSI_contingent_allegiance_condition

This article is really helpful for understanding SCSI contingent
allegiance condition and error handling.

20200602/https://www.pdl.cmu.edu/mailinglists/ips/mail/msg03427.html

Some possibly useful information on auto contingency allegiance (ACA).

20190921/http://www.t10.org/ftp/t10/document.97/97-225r0.pdf

Suffice it to say, appearances in the documentation of NACA and auto
contingency allegiance are new features that were not present in the
version of SCSI implemented in classic Macintoshes, so we just set
these bits to zero wherever we see them specified.

----------

My reflection of the Mac OS boot info?  It already is like a GUID
partition table, decades in advance!  And PCs were still using dumb
MBR partitioning.  Macintoshes leaping ahead with OpenFirmware, just
like the high end Sun workstations, then EFI.
