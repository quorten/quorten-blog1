---
layout: post
title: "Macintosh hardware projects, RaSCSI, hw. info, X68000
        computer, VIA datasheet"
date: 2020-09-06 01:17 -0500
author: quorten
categories: [mac-classic]
tags: [mac-classic]
---

SCSI2SD?  You said it's not Open Hardware?  Okay, well that may be
true that it isn't Open Hardware, but all the firmware is open-source
software.  Take a look at the GitHub repository over here.

20200906/http://www.codesrc.com/gitweb/index.cgi?p=SCSI2SD.git;a=summary

DuckDuckGo RaSCSI board kits are now available on Tindie!

20200905/https://www.tindie.com/products/landogriffin/rascsi-macintosh-version/

Also interestingly, the original Japanese author behind RaSCSI now has
his site brought back online.  Take a look over here.  And, this is
his Twitter.  Best part about it, he is also well-aware of the 68kMLA
version of RaSCSI, so he's keeping tabs on this new development too,
as we are keeping tabs in his recent new developments.

20200905/http://retropc.net/gimons/rascsi/  
20200905/https://twitter.com/kugimoto0715

X68000 is the name of the game for the original target machine of
RaSCSI.  Is the machine covered on the English Wikipedia?  Indeed it
is!

20200905/https://en.wikipedia.org/wiki/X68000

<!-- more -->

This is cheesestraw's GitHub, from 68kMLA.  Yes, go around here to
find the networking code he's developed.

20200905/https://github.com/cheesestraws

----------

As part of development of a replacement RTC chip based off of
Arduino-compatible AVR ATTiny85, where is the Macintosh Family
Hardware Reference?  I've seen it mentioned in a code comment and I
want to see for myself what it says.  Well, I couldn't find it, but I
could find a close sibling version of it called Guide to the Macintosh
Family Hardware.  Still, it has pretty good information on how the
Macintosh Toolbox and operating system software accesses the SCSI.
Basically, it bit-bangs out the serial interface exposed through the
VIA registers.

20200905/DuckDuckGo macintosh family hardware reference  
20200905/https://archive.org/details/apple-guide-macintosh-family-hardware

VIA datasheet:

20200906/DuckDuckGo via versatile interface adapter  
20200906/https://www.westerndesigncenter.com/wdc/w65c22-chip.cfm  
20200906/https://www.westerndesigncenter.com/wdc/documentation/w65c22.pdf
