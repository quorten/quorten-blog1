---
layout: post
title: "Great open-source 3D scanners, including advanced Raspberry Pi
        use, filesystem information and tools"
date: 2016-06-01 21:00 -0600
author: quorten
categories: [raspberry-pi, 3d-scanner, unix, important]
tags: [raspberry-pi, 3d-scanner, unix, important]
---

Important!  3D scanner notes.

So, if a super sleuth kit was already implemented by integrating lots
of discrete open-source software, are Internet resources really that
great?  Search engines may be lousy, but in theory I could have found
that sleuthkit on my own were I to peruse every single search engine
result really carefully.  Is it possible that a hybrid
reflective-diode and laser 3D scanner implementation that I am
planning on building is already on the Internet?  Well, let's see.
Let's start with the search query.

20160601/DuckDuckGo open source hybrid 3d scanner cheap laser

What do I find?  Well, I refound one that I've already encountered
before but decided was not good enough: MakerScanner.  However, the
technical details of the software implementation may prove
inspirational.

20160601/http://www.makerscanner.com/

Wait, what?  Fabscan?  Somehow, that sounds more like what I'm looking
for.  I don't know what it is about the name, it just sounds more on
target.

20160601/DuckDuckGo fabscan 3d scanner

<!-- more -->

Wow!  Head on.  It uses a Raspberry Pi and a laser line generator.
However, it also uses a pre-built turntable setup, which is not quite
like my idea of 3D scanner.  One major disadvantage of this design is
that it requires storage space for the armature and rigging.  Also,
although the rigging can be bulit cheaply with paper mache, most
people likely do not have an ample supply of scratch paper that they
can go to for their paper mache, nor are they familiar in advanced
paper mache construction skills.

20160601/http://hci.rwth-aachen.de/FabScan

But, all of these resources are a start for looking at in order to
obtain better standardization in the superficial software aspects of
my 3D scanner design.  That is, the file format of the output data,
and any APIs that need to be used to integrate with other software
that accepts the input of 3D scanners.

And, that gets me thinking.  What about my whole idea to design my own
experimental filesystem?  Is that really a good idea?  Could I perhaps
instead combine a well-known filesystem that has good robustness
properties with the sleuthkit to equate to the kind of tools that I
want available for my filesystem data?  Let's see.

DuckDuckGo robust file system recoverable event of errors archival
backup

Let's check Wikipedia.

20160601/https://en.wikipedia.org/wiki/List_of_file_systems

Aww, there are still a lot of caveats with some of the robust
filesystems.  Not quite ideal.

20160601/https://en.wikipedia.org/wiki/HAMMER

Renote, the alternative for installing GNU/Linux side-by-side with
MS-DOS on a FAT filesystem.

20160601/https://en.wikipedia.org/wiki/UMSDOS

"CDFS," other interesting expansions to different meanings.  NOT High
Sierra or ISO 9660.

20160601/https://en.wikipedia.org/wiki/CDfs  
20160601/https://en.wikipedia.org/wiki/Compact_Disc_File_System

20160601/DuckDuckGo open source automatic filesystem recovery
  partition table boot sector

20160601/Google open source automatic filesystem recovery partition
  table boot sector

Sure enough, TestDisk still comes up on the top from this search
query.  However, if you look hard enough, you will indeed find
sleuthkit.  Google pushes the result I am looking for closer to the
top of the search results, but it is still discoverable via
DuckDuckGo.

What's this?  This could be an interesting directory site.

20160601/http://forensicswiki.org/wiki/Tools:Data_Recovery

"Tools that work"?  Well, unfortunately, their website does _not_
work.  You know, one thing that I am thinking about open-source
software, the people behind it tend to be more reliable and they make
sure their sites are kept up for at least a couple of years.  Er, I
mean decades.  This is really interesting, because sometimes people
tout proprietary software as "more professional," but in fact many of
the small companies that develop proprietary software are far less
reliable than the hobbyists who develop open-source software.  This
has led to many professional software developers regularly relying on
the work of hobbyist developed software solutions in order to do their
professional jobs.  This is in stark contrast to the image and
reputation of "the professional media" that tends to deride amateurs
as "unprofessional."

20160601/http://www.toolsthatwork.com/bringback.htm

Is there a Wikipedia article on sleuthkit?  Yes, but it appears to be
significantly outdated compared to the amount of progress that has
been made on sleuthkit.  sleuthkit appears to be much more featureful
now than the Wikipedia article would seem to suggest.

20160601/https://en.wikipedia.org/wiki/Sleuthkit  
20160601/https://en.wikipedia.org/wiki/The_Coroner%27s_Toolkit
