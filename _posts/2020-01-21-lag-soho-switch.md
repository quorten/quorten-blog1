---
layout: post
title: "Link Aggregation Groups (LAGs) on an unmanaged (SOHO) switch?
        Maybe."
date: 2020-01-21 19:40 -0600
author: quorten
categories: [home-network]
tags: [home-network]
---

Okay, so now here's a trick question.  Can you do Link Aggregation
Groups (LAGs) on an unmanaged/SOHO switch?  In general, no.  However,
there is one notable exception.  If you are connecting a computer
**directly** to the switch that supports Link Aggregation Groups in
the operating system, then you can effec link aggregation, but only to
that particular computer.  You _cannot_ use link aggregation in, say,
a trunk connection between two switches.

So wait... actually, that means I _can_ do it.  Here's the trick.  If
you've got a smart managed switch on one end and an unmanaged switch
on the other end, you can configure a link aggregation group in the
smart managed switch, and just connect up the unmanaged switch as-is.
The smart switch will work everything out.  Assuming... assuming that
the unmanaged switch is smart enough to update its MAC tables to allow
a packet to be forwarded down any of the applicable ports, rather than
constraining MAC address forwarding to a single port.

20200121/DuckDuckGo link aggregation group unmanaged switch  
20200121/https://www.reddit.com/r/HomeNetworking/comments/do6zjd/link_aggregation_possible_on_unmanaged_switch/  
20200121/https://serverfault.com/questions/840700/does-freenas-link-aggregation-work-with-an-unmanaged-switch  
20200121/https://www.dslreports.com/forum/r32557662-Home-Network-Link-aggregation-with-unmanaged-switch

You must not simply connect multiple cables between switches without
any LAG configuration, else that will create a switch loop.

<!-- more -->

20200121/DuckDuckGo can an unmanaged switch forward same mac to multiple ports  
20200121/https://networkengineering.stackexchange.com/questions/33831/how-to-detect-loops-created-by-unmanaged-switches  
20200121/DuckDuckGo connect multiple cables between unmanaged switches  
20200121/https://serverfault.com/questions/506098/connecting-two-desktop-switches-with-more-than-one-cable  
20200121/https://serverfault.com/questions/720964/lag-managed-to-unmanaged-switch

Alas, upon further research, looks like even if you do have a smart
managed switch on one side and the unmanaged switch on the other, you
will still get problems with switch loops .

Ha, but wait!  If you get the right smart managed switch... it may
have a "dumb learning mode" that can make LAGs work even with
unmanaged switches?

20200121/https://forums.anandtech.com/threads/can-unmanaged-switches-do-passive-lacp-is-that-possible.2558836/

Ah, here's a lead.  Fake LAG (FLAG).  It does have its limitations
compared to real LAG, namely that it intermittently collapses down to
a single link every time there is an ARP request broadcast, but hey,
after that settles down, it works well for the time in beween by
rewriting ARP addresses to balance across two interfaces/ports.  That
being said, the two ports do need separate MAC addresses, so this
won't work with a simple smart managed switch that only has one MAC
address for the whole switch.  By another source, transmit can use
both links, but receive can only use one link.

20200121/DuckDuckGo fake link aggregation  
20200121/https://datacenteroverlords.com/2013/09/02/link-aggregation/
