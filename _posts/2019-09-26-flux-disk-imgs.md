---
layout: post
title: What's this?  Magnetic flux disk images?
date: 2019-09-26 02:53 -0500
author: quorten
categories: [vintage-computing]
tags: [vintage-computing]
---

While I was reading the source code and commit history on the PCE
emulator, I found there was some rather recent development in an
interesting area.  `mac-gcr`?  Whoah, what's this, the capability to
handle disk images at the lowest level?  Applesauce disk images, PRI
disk images?  Whoah, what's that?  It's the specially built hardware
to read those disk images?  Yep, and wow, it's with modern
manufacturing.  You know the long dead Catweasel and KryoFlux?  Well,
about Kryoflux... they're still alive and well, but yeah, they have
those weird licensing terms.

All of this in the midst of Linus Torvalds killing off the floppy disk
driver from Linux.  Well, yeah, I guess it is sadly fitting...  all of
these modern hardwares are using their own highly advanced drivers.
Floppy disks are still alive and well, but the software world moves
on.

Important!  See my older blog articles on the same subject.

* [Macintosh Classic disk interface]({{ site.baseurl }}/blog/2019/05/25/mac-classic-disk-io)
* [Linus kills the floppy disk driver from Linux]({{ site.baseurl }}/blog/2019/07/31/no-linux-floppy)

So, the next in line high tech flux disk imagers.  The SuperCard Pro
is a rather old one, it's been around since 2013 with an emphasis on
Amiga and Commodore systems.  cmbstuff.com is the name of the website.

<!-- more -->

20190926/DuckDuckGo pro flux image floppy  
20190926/http://www.cbmstuff.com/forum/showthread.php?tid=16  
20190926/http://eab.abime.net/showthread.php?t=71853  
20190926/http://www.cbmstuff.com/  
20190926/http://www.cbmstuff.com/about.htm

Next in line is the Applesauce disk imager, designed specifically for
use with Apple II systems, and also capable of supporting Macintosh
disk images by extension.  So, my old trick on reading/writing
Macintosh disk images with an Apple II has been revealed to the
masses.

20190926/DuckDuckGo applesauce flux image  
20190926/https://archive.org/details/ApplesauceFlux4  
20190926/https://archive.org/details/flux_capacity  
20190926/https://archive.org/details/flux_capacity?tab=about  
20190926/DuckDuckGo internet archive flux image  
20190926/DuckDuckGo applesauce flux image floppy disk  
20190926/https://applesaucefdc.com/a2r/  
20190926/https://applesaucefdc.com/

All of these flux disk imagers are, by definition, custom floppy disk
controllers.

----------

I have to say... these developments being much more out in the open,
wow that is really handy!  By doing so, and by doing so in mass
numbers, we are finally building true open industry standards for
representing low-level disk image data.  Sure, I understand the
original motivation is for precisely copying copy-protected games, as
it must be, since almost all vintage computing is gaming and
entertainment-motivated, but think about the possibilities of
extending this technology further.  It is merely a matter of scaling
the technology and principles to reach the level of libre hard disk
imagers for do-it-yourself low-level hard drive data recovery.

Although there were various reasons why I pulled out of the vintage
computing community and was dormant for quite a while, namely that I
felt I did not have sufficient resources to do a whole lot interesting
in there, now I am back to taking a look at what they're off to, and
wow, they don't slow down.
