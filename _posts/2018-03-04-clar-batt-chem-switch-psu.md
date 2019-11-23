---
layout: post
title: "Clarification on rechargeable battery technology, switched
        mode power supplies"
date: 2018-03-04 21:00 -0600
author: quorten
categories: [battery-backup, raspberry-pi]
tags: [battery-backup, raspberry-pi]
---

So, to clarify some questions I had.

* NiCd and NiMh batteries _can_ be charged in series.  However, make
  sure you properly limit and regulate the voltage if you do this.

Lots of interesting search engine adventures in thrashing around
trying to rediscover one of my already logged links uncovered some new
and interesting articles from Instructables.  Yes, it turned out that
the article I was looking for was **not** from Instructables, it was
from an entirely different website.

20180304/DuckDuckGo instructables battery backup alarm clock  
20180304/DuckDuckGo instructables nimh battery charging alarm clock  
20180304/DuckDuckGo instructables dc battery charging alarm clock  
20180304/DuckDuckGo instructables dc battery charging alarm clock

This article is really interesting.  It covers how you can make your
own switched mode power supply of a sort from fundamental circuit
components.  Hey, wait, is it saying that you don't need motor control
ICs if you use MOSFETs as your interface units?  Maybe.  But yes, if
you're trying to save space, you should definitely go for the ICs.

20180304/http://www.instructables.com/id/Build-Your-Own-Battery-Power-Supply/  
20180304/DuckDuckGo dc battery charging alarm clock site:instructables.com  
20180311/DuckDuckGo line power battery charging backup site:instructables.com

<!-- more -->

SAVE your print, about saving 20-hour 3D prints from power outages
that effectively ruin them.

http://www.instructables.com/id/SAVE-Your-PRINT-When-the-Power-Goes-Out-Longterm-B/

20180310/DuckDuckGo line power nickel metal hydride battery charging backup site:instructables.com

* Important!  This article mentions that you can use a single
  state-of-the-art IC for both NiCd and NiMh battery charging.

20180310/http://www.instructables.com/id/How-to-Make-a-NiMH-NiCd-Battery-Charger-Circuit/  
20180310/DuckDuckGo line power rechargable battery switch site:instructables.com  
20180310/DuckDuckGo battery charging dc input jack site:instructables.com

----------

So, good news for the overall battery backup system design.  The
switched mode power supply?  You can buy a board with all the
integrated components on them.  The battery charging limiting design?
You can buy an IC to properly control that.  The power source
switching design?  You can buy an IC to control switching that too.
So, the remainder of the design comes down to creating a printed
circuit board with a few more diodes and resistors, and you should be
all set.  Plug in your 12 V DC wall power supply on one end, and route
the other end to your network equipment.  You should be all set.

Wait, don't you want to conformal coat your circuit boards?  Okay,
okay, now you're talking.  Yes, you do, since the Raspberry Pi itself
is conformal coated.
