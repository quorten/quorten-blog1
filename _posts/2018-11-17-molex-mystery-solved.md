---
layout: post
title: The connector mystery solved, Molex PicoBlade
author: quorten
date: 2018-11-17 21:41 -0600
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, so I've figured out the solution to the mystery connector on my
IR cut filter, I think.  I took a good careful look at the connector.
I measured the distance between the pins to be about 1 mm, but alas, I
concede that I couldn't do a highly accurate measurement and they
could be just as well 1.25.  Finally, I took a good careful look at
the RC Groups JST connector confusion page, and after careful analysis
of minute features of the various connectors, I've determined that my
connector must be a Molex PicoBlade, not a JST.  Using the metrics on
the site of the outside dimensions, I measured the outside dimensions
of mine to confirm that they are the same.  The distinguishing
features of Molex PicoBlade are blade-like receptacles and the lip
protrusion details.  It's important not to draw conclusions about the
micro-scale connector designs based off of pictures of the larger
scale connectors.

20181117/https://en.wikipedia.org/wiki/Molex_connector  
20181117/https://en.wikipedia.org/wiki/JST_connector

20181117/https://www.rcgroups.com/forums/showthread.php?1493712-JST-connector-confusion-the-real-story  
20181117/https://static.rcgroups.net/forums/attachments/6/9/1/2/6/a4299114-113-4%20JST%20%20Plugs.jpg  
20181117/http://www.micronwings.com/HintsAndTips/RCConnecorTypes/index.shtml  
20181117/http://www.micronwings.com/HintsAndTips/RCConnecorTypes/Molex3P/index.shtml  
20181117/http://www.micronwings.com/HintsAndTips/RCConnecorTypes/Molex2P/index.shtml

----------

Now, what about other small modular electrical connectors that I'm
going to use in my Raspberry Pi 3D scanner project?  Am I going to use
Molex PicoBlade or micro JST?  Well, my goal was to use practically
the same small white plastic modular connectors are used inside my
XMODS RC car to connect with the extra lighting doodads.  So, I
checked those connectors in detail, and indeed, they are Molex
PicoBlade because they have the distinctive blade-like receptacles.
