---
layout: post
title: "The PIC microcontroller understood in context"
date: 2020-09-06 01:27 -0500
author: quorten
categories: [raspberry-pi, mac-classic]
tags: [raspberry-pi, mac-classic]
---

So, whwt is the PIC microcontroller anyways?  It is used in particular
to implement Apple Desktop Bus (ADB) on the Macintosh SE and Apple
IIgs.  Here are some important datasheets for the particular version
used for ADB, the PIC16CR54.  Also, very important, there is a
separate datasheet dedicated to describing the programming and
verification interface to the PIC16CR54.  If code protect is enabled,
then you can't dump out the program contents, otherwise you can using
this interface, and can then duplicate an PIC chip.

20200905/DuckDuckGo PIC16CR54 datasheet  
20200905/https://www.datasheetarchive.com/PIC16CR54-datasheet.html  
20200905/https://www.microchip.com/wwwproducts/en/PIC16C54  
20200905/http://ww1.microchip.com/downloads/en/DeviceDoc/30453E.pdf  
20200905/DuckDuckGo PIC16C5X Programming Specification  
20200905/http://ww1.microchip.com/downloads/en/DeviceDoc/30190h.pdf

But, I digress.  To answer my first question, what is PIC exactly?
Well, as it turns out, both PIC and AVR are made by the same company,
and they have a huge overlap in the overall microcontroller
architecture.  I would reckon that PIC is an earlier version of AVR.
As for AVR, there is a later version of it .
