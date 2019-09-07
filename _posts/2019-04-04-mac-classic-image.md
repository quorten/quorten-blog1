---
layout: post
title: Copy a Macintosh Classic hard disk image over the network
date: 2019-04-04 15:44 -0500
author: quorten
categories: [vintage-computing, mac-classic]
tags: [vintage-computing, mac-classic]
---

How do you copy a Macintosh Classic hard disk image over the network?
Well, that's a mighty question to be asking.  How old of a Macintosh
Classic are you talking about?

For the oldest of Macintosh Classic computers, "copying over the
network" means copying over a serial connection.  If you haven't
played around with the serial connection on your Macintosh yet, I'd
recommend starting out with Macintosh Kermit.  This will work on most
older classic Macintoshes, except for the very oldest 128K Macintosh.
However, let's remember that very old Macintosh does not have internal
hard disk drives!  So, if you do happen to be the odd-ball that has an
external hard disk drive connected to that very old Macintosh,
consider yourself very lucky.

20190404/DuckDuckGo kermit macintosh serial  
20190404/http://www.columbia.edu/kermit/mac.html  
20190404/http://www.columbia.edu/kermit/usingmackermit.pdf  
20190404/http://www.kermitproject.org/mac.html

Unfortunately, this far, Mac Kermit will only allow you to copy files
across the serial connection.  I have to keep looking for methods for
copying a hard disk drive image over a serial connection.  Of course
you can't store hard disk drive image of itself locally in a file or
on an external floppy disk.  Or, maybe I should simply roll up my
sleeves and prepare to develop my own Macintosh Classic software to go
do this.

<!-- more -->

For newer "Classic" Macintoshes, you'll find that they have Ethernet
capabilities.  For these, there are a number of more modern programs
to assist you in copying hard disk images over TCP/IP.  Check out
these links for some good information.

20190404/http://www.savagetaylor.com/2018/09/10/setting-up-your-vintage-classic-68k-macintosh-using-softmac/  
20190404/http://www.savagetaylor.com/2018/05/28/setting-up-your-vintage-classic-68k-macintosh-creating-your-own-boot-able-disk-image/  
20190404/http://www.savagetaylor.com/2018/01/19/setting-up-your-vintage-classic-68k-macintosh-using-basilisk-ii/

Also, if you're into doing vintage computing on physical hardware, but
with some nifty shortcuts, check out SCSI2SD adapter that allows you
to use an SD card in place of a true vintage SCSI hard drive.

20190404/http://www.savagetaylor.com/2018/01/05/setting-up-your-vintage-classic-68k-macintosh-using-a-scsi2sd-adapter/
