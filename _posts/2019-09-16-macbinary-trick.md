---
layout: post
title: The trick to understanding MacBinary
date: 2019-09-16 20:00 -0500
author: quorten
categories: [mac-software]
tags: [mac-software]
---

On one hand, it is a great convenience that ZTerm includes support for
encode/decode to MacBinary within it by default.  On the other hand,
it is a real crux that Mini vMac does not support serial port
emulation.  Instead, I am confined to using this non-standard
emulation extension of ImportFl and ExportFl.  So, that means I still
need external software to perform the encode and decode of MacBinary.

Okay, so where do I go looking for this MacBinary software?  The
Gryphel project is a good place to start.  Unfortunately, I've found
only MacBinary II over there, which states that it is designed for
System 7 and up.  I need an older version for the older computers.
But where is it to be found?  After some careful reading up on
Wikipedia, I found out that "BinHex 5.0" encodes and decodes
MacBinary.  Oh wow, now that's a real know to throw.  Use BinHex 4.0
if you want to encode in "BinHex."

20190916/http://www.gryphel.org/c/sw/archive/macbinii/index.html  
20190916/https://en.wikipedia.org/wiki/BinHex  
20190916/https://en.wikipedia.org/wiki/MacBinary  
20190916/http://www.gryphel.org/c/sw/archive/binhex/index.html

So, now that I've given it a test drive, I have to say.  Why didn't I
just start out with BinHex 5.0 instead of Mini vMac binunpk?
Advertising.  Yeah, that definitely has everything to do with it.
