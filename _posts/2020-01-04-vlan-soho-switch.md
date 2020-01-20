---
layout: post
title: Using an unmanaged (SOHO) network switch with VLANs
date: 2020-01-04 20:18 -0600
author: quorten
categories: [home-network]
tags: [home-network]
---

When buying a PoE switch, I decided to make a compromise: I bought a
switch _without_ smart managed support features, hence that means no
VLANs.  Nevertheless, I persist to ask the question.  Can you use
VLANs with an unmanaged switch?  The answer is yes!  Sometimes.  How
does this work?  Basically, forwarding and switching Ethernet packets
depends only the source and destination addresses.  The switch can use
broadcast testing followed by storing into a MAC address table to
determine this without any VLAN knowledge.  Only the end devices need
to have VLAN capabilities, and so long as tagging is used for all VLAN
packets, it will all work out just like so.

When might this not work?  Some ASIC chipsets are unnecessarily strict
in checking packet CRCs and will thus fail on any VLAN tagged packet.
Suffice it to say, generally speaking newer ASIC chips will be
gracefully designed to handle VLAN tagged packets, but older ones will
be unnecessarily stringent.

20200105/DuckDuckGo can an unmanaged switch forward vlan tagged packets  
20200105/https://community.netgear.com/t5/Unmanaged-Switches/ingress-tagged-traffic-on-unmanaged-switch/td-p/1122243  
20200105/https://serverfault.com/questions/333859/what-happens-when-a-consumer-switch-receives-a-vlan-tagged-ethernet-frame
