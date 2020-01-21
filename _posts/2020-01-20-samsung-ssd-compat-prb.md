---
layout: post
title: Samsung 860 EVO V-NAND SSD compatibility issues
date: 2020-01-20 14:53 -0600
author: quorten
categories: [misc]
tags: [misc]
---

So... I bought a Samsung 860 EVO 500 GB V-DAND SSD, installed it in a
desktop PC via a mounting bracket, started using it, and it appeared
to be doing fine.  But, upon further inspection, I found out that it
was having problems.  First of all, they appeared to be performance
problems.  But, upon closer inspection, I saw the drive was having
trouble with SATA communication errors.  What gives?  Searching around
on the Internet, I found insight.  The Samsung 860 EVO's SATA
controller is not compatible with my particular AMD SATA controller.
Samsung has been blaming AMD for having a buggy controller and
refusing to make a firmware upgrade on their side to work around the
bugs.

So, for many folks, this means returning the Samsung SSD to the
retailer they purchased from and replacing it with a different brand
name SSD, and this solved the problem.  Well, that's really a bummer.
In my case, the choice is between returning and replacing with a
different brand or swapping with a Crucial brand SSD I have in a
different system that is about the same capacity.

20200120/DuckDuckGo linux ata log page reported inactive tag  
20200120/https://eu.community.samsung.com/t5/Cameras-IT-Everything-Else/860-EVO-250GB-causing-freezes-on-AMD-system/td-p/575813

Indeed, my `lspci` output show the following:

```
00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode]
```

<!-- more -->

So I very likely do have one of the problematic AMD 9xx chipset SATA
controllers.

And... my final choice?  I decided to do a swap with my existing
Crucial drive.  This was a real bummer because the newer drive was a
few gigabytes smaller than the older one, and that meant I needed to
shrink my biggest partition, my XFS partition.  Alas, the XFS
filesystem doesn't have good offcially supported tools for shrinking,
which meant that I had to create a new XFS filesystem and copy all my
files over, via rsync.  Bummer... but hey, it worked okay, and all is
well.  The AMD-based PC is not complaining with the Crucial SSD, and
the Intel-based laptop is working fine with the Samsung 860 EVO SSD.
