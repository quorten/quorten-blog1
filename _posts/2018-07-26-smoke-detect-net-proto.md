---
layout: post
title: Smoke detector network communication protocols
author: quorten
date: 2018-07-26 21:52 -0500
categories: [home-network]
tags: [home-network]
---

Now you're wondering about smoke detector electrical signaling and
communications system.  Indeed, the picture is quite a complicated
one.  Is there a standard?  Sort of, BACnet may be the lowest common
denominator standard.  It is mainly a _protocol_, with many different
choices for the physical media and electrical signaling standard:
RS-232, coaxial cable (ARCNET), RS-485, Ethernet, LonTalk (twisted
pair, fiber optic, powerlines, etc.), and so on.  Still, there are
many proprietary protocols in use too, and other semi-standard
protocols and wiring styles.

Note that BACnet is also widely used for HVAC control.

20180726/DuckDuckGo smoke detector control panel signaling standard  
20180726/https://en.wikipedia.org/wiki/Fire_alarm_control_panel

Ah, great design here!  You can also apply a graphical display system
into your fire control panel, no need to rely on weird codes only.
The LEDs can be built into the graphics diagram.

20180726/https://en.wikipedia.org/wiki/File:Potomac_hall_facp.jpg  
20180726/https://upload.wikimedia.org/wikipedia/commons/4/45/Potomac_hall_facp.jpg  
20180726/https://en.wikipedia.org/wiki/BACnet  

Interesting, so RS-485 is like RS-422 but with amendments to switch
off receivers, which enables two-wire straight line shared bus
topology.

20180726/https://en.wikipedia.org/wiki/RS-485  
20180726/https://en.wikipedia.org/wiki/Arcnet  
20180726/https://en.wikipedia.org/wiki/LonTalk
