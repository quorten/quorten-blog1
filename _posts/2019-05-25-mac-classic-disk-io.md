---
layout: post
title: Macintosh Classic disk interface
date: 2019-05-25 18:32 -0500
author: quorten
categories: [mac-classic]
tags: [mac-classic]
---

So, you want to create a hard disk image of a really old Macintosh,
but you are having trouble finding the software?  Well, from the looks
of it, maybe you simply will never find some already written software
for this particular use case.  Back in the day, the vast majority of
Macintosh users transferred data by copying files between floppy
disks.  The more Unix-like methodology of doing a `dd` and sending the
result over the network is a foreign one to Macintosh users,
especially among _old world_ Macintosh computers.

So, on we go with the search.  Surprise surprise, if you know where to
look, you can find a treasure trove of documentation on the disk
interface.

20190525/DuckDuckGo inside macintosh scsi disk driver  
20190525/http://www.fenestrated.net/mirrors/Apple%20Technotes%20%28As%20of%202002%29/tn/tn1189.html

Inside Macintosh was purportedly all on the Internet, but you're going
to need the Internet Archive Wayback Machine in order to see it.  As
was typically the case in recent years, Apple has been deleting all
Macintosh Classic information from their website.

20190525/https://web.archive.org/web/20000306231850/http://developer.apple.com/techpubs/mac/Devices/Devices-122.html  
20190525/https://web.archive.org/web/20000229231834/http://developer.apple.com/techpubs/macos8/mac8.html  
20190525/https://web.archive.org/web/20000414113920/http://developer.apple.com/techpubs/mac/Devices/Devices-2.html

<!-- more -->

My old versions of Inside Macintosh are also pretty helpful too.
Basically, once you've got the driver number figured out to access a
SCSI disk, you just call this really simple and easy Toolbox routine
where you specify the address of the block you want to read, and it
will be placed inside a buffer.  Then you can easily complete the rest
of the job just by using the documented serial interface in the old
Inside Macintosh books.

Now, here's another surprise.  Once upon a time, there has a physical
hardware device named _Catweasel_ that allowed you to read
Macintosh-style floppy disks from a PC.  Unfortunately, it appears to
no longer be on the market.  If you had it, then there was this fancy
Windows software that allowed you to easily access the files within
those floppy disks images too.

20190525/DuckDuckGo macintosh device manager scsi disk driver read
  write sector  
20190525/DuckDuckGo macintosh send scsi disk image over network  
20190525/https://www.macdisk.com/disksen.php  
20190525/https://www.macdisk.com/macimgen.php  
20190525/https://www.macdisk.com/mden.php  
20190525/DuckDuckGo Catweasel board  
20190525/https://en.wikipedia.org/wiki/Individual_Computers_Catweasel
