---
layout: post
title: "Learning about the watchdog timer on my TPE-R1100 wireless
        access points"
date: 2020-05-26 15:59 -0500
author: quorten
categories: [home-network, raspberry-pi]
tags: [home-network, raspberry-pi]
---

I'm having trouble with my Think Penguin TPE-R1100 wireless access
points hanging after heavy Wi-Fi activity or the like.  But, here's
the thing.  I saw the hardware has support for a watchdog timer, and
presumably LibreCMC/OpenWRT uses that to prevent device hanging.  So,
maybe I should check if something is wrong in that stack.  But in the
end, I found nothing, everything is swell.

Anyways, the tech learning sure was nice, though, so I'll summarize
what I've learned here.

The watchdog timer for this device is implemented here.  Looking
through the code, all is swell and nice, support for "magic close" is
in there, so if the software crashes without a graceful close, the
watchdog timer will still keep ticking and reset the system
accordingly.

```
linux-VERSION/drivers/watchdog/ath79_wdt.c
-> ath79_wdt_keepalive
```

<!-- more -->

So, where is the code implementation in LibreCMC/OpenWRT?  Until 2013,
OpenWRT previously used the watchdog daemon tool from Busybox.  After
that, they merged the functionality into `procd`.  However, although
`procd` opened and ticked the watchdog timer properly, it did not
implement magic close, so any time you stopped it, the watchdog timer
would keep ticking and reset the system since the driver required
magic close.  Not until 2017 did we get a patch to implement the magic
close feature in `procd`, so then you could gracefully disable the
watchdog timer in `procd` with ease, for use and control with your own
software.

20200526/DuckDuckGo openwrt watchdog  
20200526/http://kernelreloaded.com/manually-controlling-openwrt-hardware-watchdog/

Here is some great information on checking the status of the watchdog
daemon on OpenWRT/LibreCMC.

20200526/https://openwrt.org/docs/guide-user/hardware/watchdog

Good point here.  Having trouble with your device watchdog-reset?
There are USB watchdog devices you can use, basically a
microcontroller that controls relays on a pin header.  You can then
use that to control the reset pin on your board, the power, or both.

Now I imagine an extended watchdog serial protocol, send debug
information to the watchdog device to save, which can then be
retrieved and sent out over the network on successful reboot.
