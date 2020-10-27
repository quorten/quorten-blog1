---
layout: post
title: "Raspberry Pi 4 Compute Model, looking for info on PiZero 3.3 V
        short circuit"
date: 2020-10-21 14:21 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Is there any info online for Raspberry Pi Zero short between 3.3 V and
ground?  No, but we're seeing similar reports for Raspberry Pi 3, the
custom PMIC for it fails to have sufficient robustness in this
respect.  This unfortunately happened to me due to a soldering error
on a Raspberry Pi Zero, that board is now toast.

20201021/raspberry pi zero short between 3.3 and ground  
20201021/https://hackaday.com/2019/06/12/shorting-pins-on-a-raspberry-pi-is-a-bad-idea-pmic-failures-under-investigation/

Wow, Raspberry Pi 4 Compute Module?  Now that is really interesting!
It allows you to get PCIe onto your own connector!  Although, you can
hack a Raspberry Pi 4 to get the PCIe connector by forfeiting USB 3.

20201021/https://hackaday.com/2020/10/19/new-raspberry-pi-4-compute-module-so-long-so-dimm-hello-pcie/  
20201021/https://hackaday.com/2019/07/10/giving-the-pi-4-pci-express/

Wow, these are some interesting Hackaday articles.  Hand-soldering a
BGA package using tombstone resistors, another way hand-soldering
directly to the solder balls, and an old PDP-11 on a chip!  How did
the PDP-11 make its way to chips?  It was one of the last failed
products that came out of DEC in attempts to gain a modern market
presence, that's how.

<!-- more -->

20201021/https://hackaday.com/2019/07/08/bga-hand-soldering-uses-tombstone-resistor-technique-demands-surgical-precision/  
20201021/https://hackaday.com/2018/01/28/the-tiniest-working-68k-system/  
20201021/https://hackaday.com/2016/08/22/a-pdp-11-on-a-chip/
