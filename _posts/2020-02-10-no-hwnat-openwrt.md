---
layout: post
title: Why hardware NAT is not in OpenWRT
date: 2020-02-10 20:52 -0600
author: quorten
categories: [home-network]
tags: [home-network]
---

Does OpenWRT support hardware NAT?  Unfortunately, as you may have
guessed, the answer is no.  Yep, so that's why the Linksys WRT AC3200
router that works well with OpenWRT must consume 12 volts at 2.5 amps.
That's the price you pay so that the NAT can all be done in software
at gigabit speeds.  So, don't even bother asking if you can have
gigabit routing speeds in LibreCMC.

Nevertheless, there were some pretty good attempts to get this project
moved forward into mainline OpenWRT.

20200110/DuckDuckGo openwrt hardware nat  
20200110/https://forum.openwrt.org/t/hardware-nat-for-lede/1094  
20200110/https://dev.archive.openwrt.org/ticket/11779  
20200110/https://openfastpath.org/  
20200110/https://openfastpath.org/index.php/service/technicaloverview/
