---
layout: post
title: Poor man's JTAG programmer
author: quorten
date: 2018-06-04 19:02 -0500
categories: [unlipic]
tags: [unlipic]
---

Okay, so this is interesting.  Need a JTAG programmer?  With special
software (standard JTAG software won't work), a parallel port, and a
few resistors, you can easily build your own "poor man's" JTAG
programmer, i.e. Xilinx cable.  Wow, that sounds really great.  Now I
just need to make the decision between buying a dedicated USB JTAG
programmer versus buying a parallel port and building a "poor man's"
Xilinx cable JTAG programmer alternative.

Oh, and the final thing.  Will this work with my old AR7WRD router?
Indeed, it looks like it will, as this forum poster was working on
essentially the same chipset, although not the same board.

So, that being said,

20180604/DuckDuckGo jtag router adam2 u-boot bootloader  
20180604/https://www.routertech.org/viewtopic.php?f=3&t=3007&start=15  
20180604/https://www.routertech.org/viewtopic.php?f=3&t=3007&sid=05ce63030fe984d7d17d23ad8bd916c3  
20180604/https://www.routertech.org/viewtopic.php?f=3&t=3007&sid=05ce63030fe984d7d17d23ad8bd916c3&start=30

This is the cable design.

20180604/http://ciclamab.altervista.org/hard_corpo_jtag.htm#Xilinx

And this is the name of the software that it works with: "CICLaMaB."

20180604/http://ciclamab.altervista.org/index_en.php

Yeah, other sites are recommending the more expensive variants.

The so-colled "Wiggler" is the circuit used by the more expensive
variants.

20180604/DuckDuckGo xilinx cable parallel port  
20180604/https://startingelectronics.org/projects/xilinx-parallel-programmer/

Ah, so there's some more tools for JTAG that are being used on the
OpenWRT side of the community.  "JTAG Tools" is the name of the tool.

  bertollo, in your case works , jtag-waldeck with unbufered
  cable(very poor man jtag xilinx)?? what is your linux version?
  debian? slackware?

20180604/DuckDuckGo poor man's Xilinx cable parallel port  
20180604/https://web.archive.org/web/20080410104038/http://forum.openwrt.org:80/viewtopic.php?id=6357&p=10

----------

This is an interesting random find.

20180604/https://electronics.stackexchange.com/questions/189649/why-are-fpgas-used-so-often-for-hdmi-video-projects  
20180604/http://www.ze.em-net.ne.jp/~kenken/en/videogame.html
