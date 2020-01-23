---
layout: post
title: Last calls on LibreCMC gigabit routers
date: 2020-01-23 01:54 -0600
author: quorten
categories: [home-network]
tags: [home-network]
---

Okay... this is not going nicely, the progress that has happened with
the libre network routers.  Where can I find a _gigabit_ router that
works well with libre software?  Think Penguin does not sell any.  So
it looks like I am going to have to resort to buying the hardware and
flashing myself.  Sure, there is good hardware I can buy from Ubiquiti
Networks and PFsense, but it is unknown whether they will work with
LibreCMC.

So, let's give this one last shot... does LibreCMC have any
respectable gigabit routers, other than the Netgear WNDR3800?  Indeed,
it does.  Preciesly two.  There is one (or more) Buffalo devices, and
there is one TP-Link device.

<!-- more -->

20200123/https://gogs.librecmc.org/libreCMC/libreCMC/src/v1.4/docs/Supported_Hardware.md  
20200123/https://gogs.librecmc.org/libreCMC/libreCMC/src/v1.4/docs/WNDR3800.md  
20200123/https://gogs.librecmc.org/libreCMC/libreCMC/src/v1.4/docs/WZR_HP_G300NH.md
20200123/https://gogs.librecmc.org/libreCMC/libreCMC/src/v1.4/docs/TL_WR1043ND.md  
20200123/DuckDuckGo WZR-HP-G300NH  
20200123/http://cdn.cloudfiles.mosso.com/c85091/WZR-HP-G300NH_Manual_web.pdf  
20200123/https://www.newegg.com/buffalo-wzr-hp-g300nh-ieee-802-11b-g-n-ieee-802-3-3u-3ab/p/N82E16833162031  
20200123/https://www.cnet.com/products/buffalo-technology-wzr-hp-g300nh-nfiniti-wireless-router/  
20200123/DuckDuckGo WZR-600DHP  
20200123/https://www.buffalotech.com/products/airstation-highpower-n600-gigabit-dual-band-open-source-dd-wrt-wireless-rou  
20200123/DuckDuckGo TL-WR1043ND  
20200123/https://www.tp-link.com/us/home-networking/wifi-router/tl-wr1043nd/#overview

So, now the question comes down to, what is the power consumption?
The WNDR3800 device consumes 30 W of power, judging by the AC adapter.
The Buffalo device, it can consume just over 12 W of power at peak
load.  The TP-Link device, it can purportedly consume up to 18 W of
power, judging by the AC adapter.  Well, at least it's better than the
Linksys WRT AC3200 that can consume up to 30 W of power... judging by
the AC adapter.

One thing you wonder is how can these devices route gigabit at a low
power consumption?  The answer, in the case of the TP-Link device, is
hardware NAT.  Without hardware NAT, either the routing would be too
slow or the CPU would have to consume more energy and emit more waste
heat.

Both of these devices are 802.11n Wi-Fi, but that is already outdated
as 802.11ac is quite old now, and now some wireless routers are even
supporting 802.11ad.  Alas, the primary limitation in getting 802.11ac
on a fully libre system is the complexity of the protocol invites a
host of hardware that is dependent on proprietary firmware blobs to
function.

So, again, it looks like I am repeating the compromise that I've
already made years ago, when I bought the 100 Mbps Think Penguin
router even though I knew it would become obsolete rather quickly when
gigabit became mainstream in the future.  However, to be honest, this
device will be stationed in the basement, and we don't really use many
Wi-Fi devices in the basement, they're mostly located in the living
room, dining room, kitchen, and bedrooms, so it may not be all that
bad after all.

But, with this compromise in place, looks like I am down to buying
ether the Buffalo device or the TP-Link device.  I don't really like
the vertical standing design of the Buffalo device, it's antennas are
a bit ugly, that's the same reason why I didn't like the Netgear
WNDR3800 when I say it years in advance, so I might as well go with
the TP-Link device.  Plus, I'm already using many TP-Link devices and
I know that they manufacture good hardware.  Poor hardware quality has
plagued me on one old Netgear GS108Tv2 switch that I bought.  Their
later production runs must have fixed the hardware defect, but hey, it
costed me $100 dollars, it works most of the time, so why get rid of
it?  Also, perhaps most importantly, they seem to have generally more
detailed specifications on their product.

The only question is, will I be able to take advantage of the hardware
NAT when I am running LibreCMC?
