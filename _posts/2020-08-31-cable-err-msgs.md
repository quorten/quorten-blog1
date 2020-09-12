---
layout: post
title: Info cable modem communications error messages
date: 2020-08-31 13:36 -0500
author: quorten
categories: [home-network]
tags: [home-network]
---

Getting more into the log information on my DOCSIS 3.0 cable modem for
which my home Internet is currently connected through, I've found
these interesting pages.  Main point, if you see "T3 time-out" or "T4
time-out", then you are having communication failures that are causing
high packet losses.  SYNC failure and MDD message timeout are more
critical errors that means proper channel communication cannot be
established.

20200831/DuckDuckGo t3 timeout  
20200831/https://www.pickmymodem.com/cable-modem-t3-and-t4-timeouts-error-messages-and-how-to-fix-them/
20200831/DuckDuckGo mdd message timeout  
20200831/DuckDuckGo docsis mdd message  
20200831/https://volpefirm.com/top-10-docsis-terms/

Also, during my previous searching, I've found some information on a
defective Intel modem chipset named Puma 6.  This has given both Intel
and Arris a bad name as Arris has been doing a lot of business with
Intel chipsets.  Now, the whole "Intel Inside" marketing, now that
really backfired in this case, "don't buy any modem with Intel on the
packaging" is now the adage.

<!-- more -->

20200831/https://www.reddit.com/r/Comcast_Xfinity/comments/ffnys6/slow_internet_speed_due_and_lost_mdd_timeout/  
20200831/DuckDuckGo puma chipset issues  
20200831/https://approvedmodemlist.com/intel-puma-6-modem-list-chipset-defects/  
20200831/https://www.reddit.com/r/HomeNetworking/comments/c9v3wq/2019_are_the_puma_6_modems_fixed_yet/

The class actuion lawsuit law firm also notes tech info from The
Register, the underlying cause is too much reliance on the x86 CPU for
packet processing, when realtime tasks tick, they cause a spike of
latency.
20200831/https://www.classactionlawyers.com/puma6/

My current modem, an Arris SB6183, is not affected, though.

20200831/DuckDuckGo arris sb6183 puma  
20200831/https://www.bestbuy.com/site/questions/arris-surfboard-16-x-4-docsis-3-0-cable-modem-white/9082019/question/08592dff-4ffc-3a77-bff3-b459c8350f67
