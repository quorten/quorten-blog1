---
layout: post
title: Comparing new Gigabit routers and Wi-Fi access points
date: 2019-06-21 23:51 -0500
author: quorten
categories: [home-network]
tags: [home-network]
---

So, as part of my home network expansion, I need to upgrade my router
to a Gigabit Ethernet capable model.  Also, I'm libre software
compatible wireless access points.  For my purposes, they need to be
libre, and part of that is so that I can centrally manage then.

So, first of all, my first acquaintance, the Think Penguin mini Wi-Fi
router.  This is definitely a fun toy to play with, but it may not fit
the bill for some of the other users who don't care so much learning
about, tinkering with, and generally playing with technology.

20190621/https://www.thinkpenguin.com/gnu-linux/free-software-wireless-n-mini-vpn-router-tpe-r1100

So, if we must compromise between libre software friendliness and raw
performance features, where will we go next?  Looks like a Linksys
WRT3200ACM router may be a good compromise pick.  To be honest, this
is a bit bittersweet, as I know, ultimately, my pick will likely only
last 5 years before it becomes obsolete and reverts back to the status
of a tech geek's toy.  By all means, don't try to future-proof your
network equipment unless you are really sure that (1) the new
standards and features in your router are compatible with existig
equipment and (2) you are pretty sure that standard will become the
way of the future, such as was the case for Gigabit Ethernet.

20190621/DuckDuckGo gigabit router  
20190621/https://heavy.com/tech/2018/03/top-10-best-gigabit-routers-of-2018/

<!-- more -->

OpenWRT is okay, but I would much rather prefer something that works
with LibreCMC.  So my picks?  Linksys WRT AC3200, supporting MU-MIMO
again tops the list... with a few caveats.  ZyXEL Armor Z2 AC2600 also
supports MU-MIMO, but is only supported by LEDE.  Linksys WRT AC1200
does not support MU-MIMO, so I would not pick it unless it is set up
to be used by only a single person.  But, if that is the case, surely
you would want to pick a router without protruding antennas, as you
will not need that much gain.

By the way, this is a pretty well-written article.  Unfortunately, we
must undoubtedly agree that there is quite a far and wide gap between
the small minority of geeks and the unlimited ranks of consumers.

20190621/DuckDuckGo gigabit router librecmc  
20190621/https://hobgear.com/best-openwrt-lede-routers/

Well, with all those previous mentions, they may still not necessarily
work with LibreCMC.  So, we keep searching.  Vikings, ah yes, they are
always a good brand.  So the NETGEAR WNDR3800 appears to be a good
pick if you want support by LibreCMC.  Vikings sells a rebranded
version.  The price is right... but this is, of course, a relatively
old model of wireless router.  In the meantime, some of the
expectations as to how the average non-technical computer users uses
their computers have changed in that time.

20190621/https://store.vikings.net/wndrrouter
