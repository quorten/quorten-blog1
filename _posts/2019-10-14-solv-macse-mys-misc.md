---
layout: post
title: "Mystery MacSE expansion card identity solved, still figuring
        out how to use it, misc. information on vintage computing"
date: 2019-10-14 23:30 -0500
author: quorten
categories: [vintage-computing, mac-classic, mat-sci]
tags: [vintage-computing, mac-classic, mat-sci]
---

So, the identity of the mystery card in the PDS slot of my Macintosh
SE has been solved: it is the Micrographic Images Megascreen 3,
Copyright 1987, designed by Gary Landis.  So, the question that still
remains, and some progress along the way.  How do I use it?  Where are
the drivers for it?  Also, I have some general notes on a lot of other
useful miscellaneous information on vintage computing.

Here is another photo of the Megascreen 3 expansion card, though the
board touts the same model number, it must be from a different
manufacturing run, as the board finish, wire colors, and a jumper are
all slightly different.

20191014/DuckDuckGo micrographic images megascreen 3  
20191014/https://68kmla.org/forums/index.php?/topic/56378-micrographic-megascreen-3-se-pds-video/

Here is some information about Micrographic images, namely one of
their MacWorld full page ads.

20191014/DuckDuckGo 68kmla megascreen  
20191014/https://68kmla.org/forums/index.php?/topic/28653-ebay-finds-thread/&page=134&tab=comments#comment-593985

Here is a repository of classic Macintosh drivers, including video
drivers.  Presumably I could find the drivers for my particular card
in there... alas, no!

<!-- more -->

20191014/DuckDuckGo macintosh pds drivers  
20191014/https://vintageapple.org/macdrivers/network.shtml  
20191014/https://vintageapple.org/macdrivers/  
20191014/https://vintageapple.org/macdrivers/video.shtml

Here is some good advice on treating keyboards keys that don't quite
work.  You can clean off corrosion via a treatment of vinegar,
distilled water, and baking soda.  But don't forget, sometimes with
old Apple II keyboards, you just get ghost keys if you type too fast.

20191014/https://68kmla.org/forums/index.php?/topic/57361-512k-disappointment/

Macintosh SE has SIMM slots for the ROM?  Oh goodie, that means I
could put my own flash memory chips in there and program up a custom
ROM.  Look here for the needed hardware device, the ROM-inator II.

20191014/https://68kmla.org/forums/index.php?/topic/56932-best-rom-disk-for-rominator-gglabs/  
20191014/DuckDuckGo rominator ii  
20191014/https://www.bigmessowires.com/mac-rom-inator-ii/

However, you won't find the software, which is only provided for SE/30
and newer.  For supported modules, there is also support for building
a custom ROM disk for diskless booting.  Great to have a hard,
always-bootable Macintosh!  Well, that's as long as you don't erase
the flash memory... yeah, in the end, it's not real hard bootable
unless you have it burnt into ROM.

What is TTL video?  After closer looks, well if you're talking
monochrome, it's simply what it sounds, 5V for on, 0V for off.  Then
you have an analog raster signal scan and without sync signals, you
have to calibrate the video size on your receiving equipment.  For
analog video, the voltage ranges from 0V to 5V.  For color, you simply
have more components.  There are commercial signal converters you can
get to convert to a more common format.  TTL video is actually very
similar to LVDS video/

20191014/DuckDuckGo ttl video signal  
20191014/https://www.youtube.com/watch?v=LTl31UNhJz0  
20191014/https://www.vintage-radio.net/forum/showthread.php?t=93775

In addition to the retrobright technique for whitening yellowed
plastics, there is also a similarly named "evaporust" technique for
lifting corrosion off the surfaces of metal.

20191014/https://68kmla.org/forums/index.php?/topic/57430-se-fdhd-estate-sale/

Wow, a floppy changing jukebox for the Macintosh?  Very interesting.
A YouTube video is forthcoming.

20191014/https://68kmla.org/forums/index.php?/topic/58092-5th-generations-jukebox-five-floppy-disk-mechanized-hopper/
