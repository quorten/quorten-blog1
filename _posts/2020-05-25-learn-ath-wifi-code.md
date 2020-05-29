---
layout: post
title: "Follow the breadcrumb trail, try to find out inner workings of
        ThinkPenguin Wi-Fi devices"
date: 2020-05-25 21:33 -0500
author: quorten
categories: [home-network]
tags: [home-network]
---

ThinkPenguin Wi-Fi devices.  Great Respects-Your-Freedom devices until
they crash or lock up under heavy Wi-Fi activity, right?  Yeah, that's
the problem, I've upgraded my firmware many times to no avail on
fixing the problem, many times hoping an upgrade would fix it.  What
I've found out instead was that simply using more Wi-Fi access points
to spread the load further away from the central router was the main
way to move crashes off the central router... at the expense of them
happening on the edge routers instead.  Okay, so now I know the
crashes are definitely a Wi-Fi induced problem, wired networking and
routing causes no issues whatsoever.

So, although my first suspicion is that the culprit is `hostapd`
because the crashing problem consistently happens across two different
classes of device hardware, there are two main places where crashes
may be happening:

* The Linux Wi-Fi drivers, what interacts on the lowest level to
  provide the `wlan0` interface to user-mode.

* The user-mode Wi-Fi software stack, basically that's entirely just
  `hostapd`.

<!-- more -->

So, first question, do the devices actually use different Wi-Fi
hardware and drivers?  At the outset, looks like the answer is yes.  I
have one TP-Link WR841ND-v8 (rebranded to ThinkPenguin) that uses the
AR9341 Atheros SoC that includes Wi-Fi, and another ThinkPenguin
TPE-R1100 that uses the AR9330 Atheros SoC that includes Wi-Fi.  So,
there possibly could be different Wi-Fi drivers involved.  But how
different are they?  If they are similar enough, it could be that the
problem is happening at the driver level.  Because, after all, you can
be much more sure that won't be changing any time too soon, hardware
companies don't have a penchant for upgrading their hardware.

But, anyways, chasing down the source code to `hostapd`.  There are
actually three versions of `hostapd`, the one used in LibreCMC/OpenWRT
is "Jouni Malinen's hostapd."  Unfortunately it is quite a bit of a
challenge to get at the source code, it's not on GitHub, it's on a
self-hosted Git repository by the original developer.  And when you go
look in there, it really gives you the impression that this is not a
software project that many developers collaborate on to improve.

20200525/https://en.wikipedia.org/wiki/Hostapd  
20200525/http://w1.fi/hostapd/  
20200525/http://w1.fi/cvs.html  
20200525/http://w1.fi/cgit

Nevertheless, there are some signs of improvement on the field of
better testing and robustness of `hostapd`.

20200525/http://w1.fi/cgit/hostap/commit/?id=8ee0bc622a715366344e6669bc19c9bd40891aeb

So, it's going to be a challenge to chase down the bugs in this.  My
first thought, due to the fact that this is aggravated by a busy/noisy
Wi-Fi network, is to do a software fuzz test on `hostapd`.  The main
problem as I see it is interacting with it via the software interface,
as in its real operational mode it is interacting with hardware.  But,
the use of tests in the source code is good news, hopefully it will be
easy to operate the full software via a mock interface for fuzz
testing.

Now, for chasing down the drivers and hardware equation.  After prying
deeper, I found some interesting things.  It turns out that the
TPE-R1100 is based off of an older SoC than the TL-WR841ND.  However,
my device as manufactured is newer and is equipped with more RAM and
flash memory.  Nevertheless, I've found a very old TP-Link device that
looks quite similar to the ThinkPenguin device, and the AR9331 SoC
must be quite similar too.  Could it be that the ThinkPenguin device
is an aftermarket upgrade or custom manufacture just for ThinkPenguin?
I'm guessing so, it must have been something like that.  But in the
whole of things, the hardware is overall a design that is 9 years old.

https://openwrt.org/toh/tp-link/tl-wr841nd

20200525/DuckDuckGo tpe-r1100 librecmc  
20200525/https://gogs.librecmc.org/libreCMC/libreCMC/src/LTS/docs/TPE_R1100.md  
20200525/https://openwrt.org/toh/tp-link/tl-wr703n  
20200525/https://web.archive.org/web/20191002113745/http://wikidevi.com/wiki/Atheros_AR9331  
20200525/https://web.archive.org/web/20191002113002/https://wikidevi.com/wiki/Atheros#tab=SoC  
20200525/https://web.archive.org/web/20200523062239/https://www.openhacks.com/uploadsproductos/ar9331_datasheet.pdf

The AR9341 datasheet was released to the FCC, and they provide a
download link to it.

20200525/https://web.archive.org/web/20191002113002/https://fccid.io/pdf.php?id=2667110

Really, when you think about it, though, if the different SoC versions
were released only a few months apart, surely the drivers are almost
exactly the same, wouldn't you expect?

But come on, let's be honest.  I saw the poor performance behavior
back when we were running with only a single access point, it's
definitely a software problem in earnest.  When Wi-Fi gets noisy, the
CPU consumption gets busy, and of course that's all from `hostapd`,
would it not be?

Oh, and part of my failed search on trying to find more information
particularly on `hostapd` crashing.  This may be a good discussion on
this GitHub issue about possible debugging activities I may perform to
determine what the cause of the crashing is.

20200525/DuckDuckGo hostapd crashing wi-fi access point  
20200525/https://github.com/lwfinger/rtl8723au/issues/27

INDEX NOTE FCC ID does not have a direct link, they use web magic to
prevent bots from downloading the PDFs.
