---
layout: post
title: Mystery parallel port interface pins solved
date: 2020-10-28 13:27 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

That Texas Instruments SN74LVC161284DL parallel port transceiver chip?
It has two mystery signals that are not well explained, HOST LOGIC and
PERI LOGIC.  What are these for?  Well, this took a lot of searching
around to find out what they're for, but they are designed for
detecting whether the device on the other side of the link is powered
on.  Essentially, its a Vcc power source of a sort.  However, these
pins are not exposed in the standard DB25 connector, they are only
available on those stupid nonstandard 36-pin micro Centronics
connectors that nobody uses.  But, the most interesting thing about
this?  I found an online source that said the micro Centronics
connectors are recommended for new applications!  Ha!  They never
showed up on PC back panels before the parallel port became obsolete,
who would ever use them?

20201028/DuckDuckGo ieee 1284 device power pin  
20201028/http://www.interfacebus.com/Design_ieee1284c_Connector_PinOuts.html  
20201028/DuckDuckGo ieee 1284 host logic high  
20201028/http://www.efplus.com/techref/io/parallel/1284/1284conn.htm

I think a lot of things about the IEEE 1284 were a "wannabe" standard.
This standards committee got together and thought they could create
this new high-speed communications standard that would then take the
market by force, but that simply never happened.  So, in the latest
versions of IEEE 1284, we ended up with all kinds of bespoke
functional specifications that were never used in practice.
