---
layout: post
title: Lots of useful information for my classic Macintosh SE
date: 2016-01-09 21:00 -0600
author: quorten
categories: [mac-classic]
tags: [mac-classic]
---

Broken link!  NOT available in the Internet Archive Wayback Machine!

20160109/https://68kmla.org/forums/index.php?showtopic=6267

20160109/https://en.wikipedia.org/wiki/MacsBug  
20160109/https://en.wikipedia.org/wiki/Programmer's_key  
20160109/https://en.wikipedia.org/wiki/Macintosh_startup#Sad_Mac

Stolen from Apple!  The second web site contains the instructions to
access the "Stolen from Apple!" icon on the Macintosh SE.

20160109/http://www.folklore.org/StoryView.py?project=Macintosh&story=Stolen_From_Apple.txt  
20160109/http://www.mackido.com/EasterEggs/HW-Stolen.html

A site full of many other Apple Computer-product Easter Eggs.

20160109/http://www.reocities.com/SiliconValley/7933/mac.html

More Macintosh special keys information:

20160109/http://davespicks.com/writing/programming/mackeys.html

Can you bootstrap the original Macintosh from bare metal?  Nope, it
can't be done.  Early generation Macintoshes must have boot disks to
be functional.  If they do not have a boot disk, they will fail to
boot.  You need at least a Macintosh Classic to be able to boot from
ROM.

<!-- more -->

NOTE!  The Amiga.  Similar to a Macintosh, relied on a boot disk, but
in a more explicit way.  The Amiga didn't have _any_ ROM code at all,
instead relying on loading the code from disk to function.

Interesting, though not useful link.  All it contains is a comment
referencing the Macintosh.  It doesn't contain any actually useful
information on the Macintosh, just on the Raspberry Pi.

20160109/https://www.raspberrypi.org/forums/viewtopic.php?f=72&t=59697

How to use the interenal Macintosh debugger?  It goes by the name
MicroBug.  MacsBug is a related but much more powerful alternative.

20160109/http://www.digplanet.com/wiki/MacsBug

This is the link to the actual documentation on MicroBug.  This link
is not working for me at this time!  No problem, I was able to
successfully get the information from the Wayback Machine.  I've saved
the document locally just for safe keeping.  JJJ TODO Sort everything
out!

20160109/http://www.fenestrated.net/~macman/mirrors/Apple%20Technotes%20%28As%20of%202002%29/tn/pdf/tn1136.pdf  
20160109/http://web.archive.org/web/20141113174222/http://www.fenestrated.net/~macman/mirrors/Apple%20Technotes%20%28As%20of%202002%29/tn/pdf/tn1136.pdf

Sad Mac error codes?  What is this error code that I get when I press
the programmer key during bootup?  This is just an indication that a
non-maskable interrupt was received, which is considered normal
functioning.  Bummer, I was really hoping I could get to the ROM
debugger as a ways to bootstrap a Macintosh from bare metal.

20160109/http://www.mac512.com/macwebpages/sadmac.htm  
20160109/http://myoldmac.net/FAQ/SADerror-portable.htm  
20160109/http://myoldmac.net/FAQ/SADerror.htm  
20160109/http://www.midiguy.com/MGuy/MacQs/SadMac.html

Hey, the Wikipedia website must have been updated.  It contains much
of the information that I thought was available only on other websites
until recently.

20160109/https://en.wikipedia.org/wiki/Macintosh_SE  
20160109/http://www.mac512.com/macwebpages/se.htm

So, what are those strange extra connectors on the back of my
Macintosh SE?  They are ports on an expansion card in the PDS slot.
Note the photograph of the back and the caption in the link above.
They note that that cover on the left of the back panel (where ours
has the extra ports) covers up the expansion slot.  Ah, now I have
something to search for.  PDS slot expansion cards for the Macintosh
SE.  Once I find one that has a coaxial port and DE-9 port on the back
of it, I'll know what that thing is.  Either that, or I have to open
up the Macintosh SE to find out.

20160109/https://en.wikipedia.org/wiki/Processor_Direct_Slot  
20160109/http://www.applefritter.com/image/tid/122  
20160109/http://www.applefritter.com/node/20403

Nope, no matches so far, but the last link was an interesting diagram.

More information?  No, not quite enough for me.

20160109/http://www.lowendmac.com/tech/pds.shtml

JJJ TODO Sort this out!

* NOTE: Sometimes, a list of links need not be sorted out.  Sometimes,
  all that needs be said is that this is a list of useful links to
  additional information, some more useful than others.  Well, I guess
  that's enough to warrent sorting it out in some sort of way.
  Anyways, sometimes you just have a whole bunch of miscellaneous
  information that is all at the same rank.  When such is the case,
  there really is no practical way to sort the information out.

20160109/http://www.lowendmac.com/about.shtml  
20160109/http://lowendmac.com/1999/power-mac-g4-yikes/  
20160109/http://www.lowendmac.com/video/pds/index.html  
20160109/http://lowendmac.com/video/68k/index.html  
20160109/http://lowendmac.com/lowendpc/home.html  
20160109/http://lowendmac.com/lowendpc/articles.html  
20160109/http://lowendmac.com/lowendpc/idea/2002/1127.html  
20160109/http://lowendmac.com/2014/personal-computer-history-the-first-25-years/  
20160109/http://lowendmac.com/category/tech-history/page/3/  
20160109/http://lowendmac.com/2014/cgi-story-the-development-of-computer-generated-imaging/  
20160109/http://lowendmac.com/2014/history-of-the-compact-disc/  
20160109/http://lowendmac.com/2013/the-rise-of-google-beating-yahoo-at-its-own-game/  
20160109/http://lowendmac.com/2013/pixar-story-steve-jobs-disney-toy-story/  
20160109/http://lowendmac.com/2006/andy-hertzfeld-software-wizard-from-apple-to-google/  
20160109/http://lowendmac.com/2006/origin-of-the-ibm-pc/

20160109/http://lowendmac.com/2012/keep-your-pc-cool-by-replacing-its-thermal-compound/  
20160109/http://lowendmac.com/lowendpc/dk/2003/0116.html  
20160109/http://lowendmac.com/lowendpc/dk/2003/0102.html

## Important MicroBug Commands

For the Macintosh SE with a bootable disk inserted.

Exit to Finder: SM 0 A9F4
                G 0

Display "Stolen from Apple!" message: G 4188A4

Show photo slide show of the developers: G 41D89A
