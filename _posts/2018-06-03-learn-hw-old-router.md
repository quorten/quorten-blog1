---
layout: post
title: Learning low-level hardware using an old ADSL modem-router
author: quorten
date: 2018-06-03 14:28 -0500
categories: [raspberry-pi, vintage-computing]
tags: [raspberry-pi, vintage-computing]
---

I've been wanting to get more involved with low-level hardware hacking
on single board computers so that I can work with the full range of
low-level hardware functions on my LibreCMC Atheros chipset, MIPS CPU,
router such as the CMOS serial console and JTAG flash programming.
However, I can't take out my current router in use since I don't have
a spare, after we've gotten rid of the ISP rented router.  Now,
conveniently, I happen to have an old ADSL router-modem.  What kind of
software does it run?  How do I program it?  Is it rather similar to
modern routers?

Indeed, it is.  I am in luck.  It is somewhat similar to modern
routers: it runs Linux + Busybox.  However, it uses a different
bootloader, adam2 rather than Das U-boot.  Here are the details that
I've mined out from the Internet and booting up and logging into the
router itself.

* Model: Actiontec GT701-WG
* Board/chipset: Texas Instruments AR7WRD
* CPU: MIPS32
* Bootloader: adam2
* Flash size: 4 MB
* RAM size: 14 MB (16 MB?)
* Linux kernel: 2.4.17
* Packages: Busybox, odhcpc
* Command-line login protocol: telnet
* Linux root username/password: admin, admin
* CMOS 3.3 V serial console
    * Baud?  Try "38400 8-N-1" according to HyperTerminal.  (38400
      baud, 8 data bits, no parity bits, 1 stop bit.)

Despite these modest specifications, the router sure does get hot
compared to more modern equipment.  For sure, that's because the
hardware is so old that the chipset uses a larger feature
semiconductor process and is less energy efficient.

<!-- more -->

Notes on the bootloader:

* Access the bootloader via `ftp` during first few seconds of boot, or
  via CMOS serial console.  Address is 192.168.0.1.  Username and
  password both "adam2".

* PSPBoot is the official successor to Adam2.

* A major disadvantage of the `adam2` bootloader is that its
  environment is prone to getting fragmented.  Hence, there are
  upgrade tools on the RouterTech website to "defragment the
  environment."

* Another disadvantage when using the `adam2` bootloader.  **DO NOT**
  type backspace or any other special characters, these will end up
  getting inserted in the environment variables and cannot be removed
  even with an unsetenv.  This issue is also due to the buggy poor
  quality of the `adam2` bootloader, which is why advanced users try
  replacing it with something better.

* RouterTech's "PC-tool" and "firmware tool" are basically just fancy
  front-ends to the FTP protocol access.  So, you don't need Windows
  or WINE emulation after all.

* Check to see if your router needs separate-image uploads for
  firmware.  Not all of the old ones support single-image uploads,
  depending on the organization of the MTD partitions of the flash
  memory.

Also, it looks like my router checks off on all the hardware criteria
for compatible ADSL routers:

ADSL Routers using the TI AR7*RD platform, compatible with the
RouterTech v2.1 firmware

AR7WRD (i.e., wireless) . Features required for full compatibility:

1. Texas Instruments AR7WRD platform (TNETD7300GDU . MIPS32 processor,
   DSP-based digital transceiver, ADSL analog)

2. Texas Instruments TNETW1130 wireless (TNETW1130 (ACX111) converged
   Single-Chip MAC and Baseband Processor)

3. Marvell 88E6060 switch

4. PSPBoot/Adam2 boot loader

5. 1/4 ethernet ports

6. USB port (optional)

20180503/DuckDuckGo GT701-WG

Purportedly, this router is no longer supported by CenturyLink.

broken/https://www.centurylink.com/internethelp/modems/gt701/index.html

Unfortunately, it turns out this CNET page isn't technical enough.

20180503/https://www.cnet.com/products/actiontec-wireless-dsl-gateway-gt701wg-wireless-router-dsl-802-11b-g-desktop-series/specs/

20180503/DuckDuckGo GT701-WG open up chipset
20180503/DuckDuckGo GT701-WG linux chipset

Yes!  Here we go.  Detailed information from someone whose been
hacking on my exact same model of router.  So, now we know that the
RouterTech firmware works on my router for sure.

20180503/https://www.routertech.org/viewtopic.php?f=3&t=3685

So, this RouterTech site is the place to go.  So, here's what I've
learned about my router so far.

Start here:

20180503/https://www.routertech.org/about/  
20180503/https://www.routertech.org/firmware-faq/

Looking for a how-to page directly on my router model?  Bingo!  I've
found not one, but two.  So, my recommendation?  Ultimately go with
the first one where you configure the MTD partitions so that you can
do a single firmware image upload, as that will make everything in the
future much easier.

20180503/https://www.routertech.org/viewtopic.php?f=16&t=4027&p=48592#p48592  
20180503/https://www.routertech.org/viewtopic.php?f=15&t=3185&hilit=tutorial&start=12

Latest binary and source release:

20180503/https://www.routertech.org/viewtopic.php?f=23&t=4183  
20180503/https://www.routertech.org/faq/firmware/compatible-routers/

Wow, this router types and classes references some really old hardware
in the earliest mentions.

20180503/https://www.routertech.org/faq/general-networking/router-typesclasses/

Core information to get from your router before doing things that
would brick it.  Log in to the router and save the output from these
commands:

    cat /proc/ticfg/env
    cat /proc/modules
    cat /proc/interrupts
    cat /proc/avalanche/avsar_ver

20180503/https://www.routertech.org/viewtopic.php?t=961

So, here you go.  Serial console is just as normal in the modern case,
CMOS 3.3 V.  Baud?  Try "38400 8-N-1" according to HyperTerminal.
This article details the serial console protocol.

20180503/https://www.routertech.org/viewtopic.php?t=242

This page describes the process to get to the bootloader via an
Ethernet connection and PC-tool.  Note that "PC-tool" is a binary
program created by the site authors that only works on Windows XP.
However, there are other options like performing the FTP bootloader
manipulation manually, and other tools that are more Unix-friendly.

20180503/https://www.routertech.org/viewtopic.php?t=335

This is the RouterTech "Firmware Tool" that can run on Linux via WINE.

20180503/https://www.routertech.org/viewtopic.php?t=3101

There is lots of great information on my hardware board class on
Wikipedia.

20180503/https://en.wikipedia.org/wiki/Texas_Instruments_AR7  
20180503/https://en.wikipedia.org/wiki/File:ADSL_modem_router_internals_labeled.jpg  
20180503/https://en.wikipedia.org/wiki/Custom_firmware

So, does OpenWRT support this board?

20180503/DuckDuckGo openwrt AR7WRD

OpenWRT only partially supports these boards, for a limited selection
and criteria.

20180503/https://wiki.openwrt.org/doc/hardware/soc/soc.ar7  
20180503/https://wiki.openwrt.org/doc/techref/bootloader/adam2  
20180503/https://wiki.openwrt.org/doc/techref/bootloader/pspboot

More useful information on the Adam2 and PSPBoot bootloaders.

20180503/http://wikibin.org/articles/adam2.html  
20180503/http://wikibin.org/articles/pspboot.html
