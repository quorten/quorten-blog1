---
layout: post
title: MacBinary and BinHex are reasonably easy to process
date: 2019-09-19 22:23 -0500
author: quorten
categories: [mac-classic]
tags: [mac-classic]
---

In the process of writing a serial communications program for
Macintosh Classic, I've thought it would be nice to include built-in
support for MacBinary and BinHex, rather than relying on the user
going to a separate program.  So, how I do go about doing this?  Let's
see if I can find more information on these file formats online.

I found the specifications for MacBinary, MacBinary II, and BinHex,
the main challenge is computing some CRC checksums.  But, as I cover
in the next blog article, those are also reasonably easy to computer.

20190919/https://en.wikipedia.org/wiki/MacBinary  
20190919/http://files.stairways.com/other/macbinaryii-standard-info.txt  
20190919/https://en.wikipedia.org/wiki/BinHex  
20190919/http://files.stairways.com/other/binhex-40-specs-info.txt
