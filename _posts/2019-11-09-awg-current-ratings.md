---
layout: post
title: Current ratings of AWG wire gauges
date: 2019-11-09 21:36 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

How much current can different AWG wire gauges handle?  26 AWG is
fairly common in basic electronics, and it is rated for about 2.5 A of
current.  This means that that you should limit your circuit design to
put a maximum of 1 A of current through 26 AWG wire, i.e. at least
half the current rating of the wire.  And this nicely coincides with
the 1 A power consumption limit of the Raspberry Pi Zero computer
board.

This also means you should make sure your modular connectors you use
are rated for 2 A of current if you are using them for the main power
connector to the Raspberry Pi Zero.  All other lower power connectors,
e.g. for connected peripherals, can go just fine with 1 A modular
connectors, i.e. Molex PicoBlade.

20191109/DuckDuckGo 26 awg wire current  
20191109/https://www.engineeringtoolbox.com/wire-gauges-d_419.html

UPDATE 2020-03-07: That's only the current rating for single core or
"solid" wire.  Stranded wire will have a lesser current rating.
Typical AWG wires that you work with in electronics will be stranded
wires with at least 5 strands... so 26 AWG wire may only be rated for
1 A of current, which limits you to putting 500 mA through the wire.

20200307/https://electronics.stackexchange.com/questions/361321/awg-for-connecting-a-usb

Please see [my next article on the subject]({{ site.baseurl
}}/blog/2020/03/07/usb-awg-info) for important further discussion.
