---
layout: post
title: Physical placement of logical sectors on removable media
date: 2019-05-08 23:27 -0500
author: quorten
categories: [vintage-computing]
tags: [vintage-computing]
---

Removable digital storage media... ah, yes, it's something we no
longer use nowadays in modern desktop computing.  Only in the halls of
big datacenters might you find removable storage media nowadays.  But,
if you're really into 1980s and 1990s era vintage computing, removable
media is a major element of this genre.  Additionally, errors on
removable media were also a somewhat rare but occasional occurrence.
So, when you take out your physical media that is in error and look at
it, how do you know how to deal with the error?  First, you need to
know the geometry that the data is logically stored on the physical
media.

* Floppy disks and hard disks: Both floppy disks and hard disks are
  formatted via the cylinder, head, sector (CHS) methodology.
  Cylinders/tracks are concentric rings.  The logical first cylinder
  is always the outermost ring.  Each head is one side of a circular
  disk.  Side A of a floppy disk is the "top" side, as seen when you
  insert the disk into the drive, and side B is the "bottom" side.

  The cylinders/tracks on most floppy disks are divided up into the
  same number of sectors regardless of where the cylinder appears on
  hte disk surface.  For example, IBM-formatted disks have the same
  number of sectors per track on all tracks on a disk, but
  Apple-formatted disks, format more sectors on outermost tracks.

* CD-ROMs and other optical discs: The data is written on a spiral
  track that starts on the inner edge of the disc, spirals
  counterclockwise, and ends on the outer-edge of the disc.

<!-- more -->

* Phonograph records: I include this one here simply because it often
  times heleps cause confusion to people when they think about floppy
  disks, CD-ROMs, and phonograph records together.  I mean, come on,
  they're all discs, shouldn't they all be treated relatively the
  same?  Nope.  The spiral track on a phonograph records begins at the
  outer-edge of the disc, spirals counterclockwise, and ends on the
  inner edge of the disc.

20190508/https://en.wikipedia.org/wiki/Compact_disc  
20190508/https://en.wikipedia.org/wiki/Floppy_disk  
20190508/https://en.wikipedia.org/wiki/Phonograph_record  
20190508/DuckDuckGo floppy disk first sector outer edge inner edge  
20190508/https://superuser.com/questions/643013/are-partitions-to-the-inner-outer-edge-significantly-faster/643634

So, now you know where to look for errors in case you find them.  Have
you been flicking your wrist when handling a 3.5 inch floppy disk, and
now your computer claims it can't read the boot sector?  Ah, that
shaking around inside the plastic cartridge must have done it to the
outer-edge of the disk.  No worries, the rest of the inner tracks of
the disk should be readable.

Do you have an CD-ROM where you are getting read errors near the
beginning?  Check the inner-most ring of your optical disc for
scratches, discoloration (for CD-R), or other deformities.  Then, you
can figure out how to treat the disc from there.

Do you have a read-error near the end of your CD-ROM's logical data?
First of all, check what the total size of your ISO filesystem is.  If
you use less than 700 MB of data, then the logical "end" will be
proportionally closer to the interior of the disc.  Once you identify
the logical end of the disc, you can look around there for deformities
that might cause read errors and figure out how to treat the disc from
there.
