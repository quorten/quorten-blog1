---
layout: post
title: Looking for causes of slow VNC performance
date: 2019-03-15 09:51 -0500
author: quorten
categories: [unix]
tags: [unix]
---

So, I was recently using VNC on some local computers, but suffering
from unusually slow performance not due to the network.  So, what was
the cause of this?  Looking around, it appears to be related to screen
graphics drivers, some drivers will result in slow fetching of the
screen to send to VNC.

Unfortunately, I haven't found a real solution to my problem, so for
now, I'll just leave some pointers to some useful information that
I've found.  Note that `vino`/`vinagre` were the particular VNC
software I was using.

20190315/DuckDuckGo vino vnc running slow  
20190315/DuckDuckGo vinagre running slow  
20190315/DuckDuckGo vinagre vnc running slow  
20190315/https://help.realvnc.com/hc/en-us/articles/360002450292-Slow-performance  
20190315/https://askubuntu.com/questions/673968/regarding-graphical-issues-and-performance-in-ubuntu-14-04-lts-server-with-gui/674656#674656  
20190315/DuckDuckGo vnc without monitor  
20190315/https://forums.opensuse.org/showthread.php/430465-VNC-without-monitor-connected  
20190315/DuckDuckGo vinagre slow performance  
20190315/DuckDuckGo ubuntu good vnc client  
20190315/https://help.ubuntu.com/community/VNC/Clients
