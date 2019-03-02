---
layout: post
title: Updates on board support in LibreCMC
date: 2019-01-25 22:31 -0600
author: quorten
categories: [home-network, raspberry-pi, important]
tags: [home-network, raspberry-pi, important]
---

Important!  What's going on with the latest versions of
LibreCMC/OpenWRT?  What's this talk about ar71xx versus ath79 targets?
Here's what's happening.  As you may have known, for quite some years,
the Linux kernel was going through a transition, an improvement, as to
how it handles embedded systems.  This was, and still is, very
important as the embedded Linux market is booming in 2019.  Namely,
the main transition that must be taken is to migrate the board support
package configuration method from the old C header file method of
machine description to the new, standardized, Device Tree (DTS)
configuration method.  So, this is the main hurdle that must be
undertaken to get your old Linux router running on the new kernel.
Naturally, to distinguish the old and new methods unambiguously, the
new method uses the board target name `ath79` in place of `ar71xx`.
Luckily, most of the old `ar71xx` devices are supported by the new
kernel.

20190125/https://librecmc.org/news.html  
20190125/https://gogs.librecmc.org/libreCMC/libreCMC/issues/79  
broken/https://openwrt.org/docs/techref/targets/ar71xx-ath79  
20190125/https://web.archive.org/web/20190104011616/https://openwrt.org/docs/techref/targets/ar71xx-ath79  
20190125/https://lists.openwrt.org/pipermail/openwrt-devel/2018-February/011312.html  
20190125/https://forum.openwrt.org/t/porting-guide-ar71xx-to-ath79/13013/79
