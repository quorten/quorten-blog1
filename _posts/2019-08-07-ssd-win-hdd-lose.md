---
layout: post
title: SSDs are poised to render hard drives totally obsolete
date: 2019-08-07 08:31 -0500
author: quorten
categories: [raspberry-pi, pentax-k-1-camera]
tags: [raspberry-pi, pentax-k-1-camera]
---

So, out of curiosity when researching the Raspberry Pi 4, I decided to
take a look at what prices terabyte SSDs are at today.  Now they are
at about $100 per terabyte?  Wow.  The technology has come a long way.
I remember the days (early 2010s era) when SSDs like that would cost
over a thousand dollars.  Meanwhile, hard disk drives have been
stagnant for too long, awaiting the maturization of technology in
research such as HAMR and MAMR.  Until then, you're seeing market list
prices around $200 per 6/8 terabytes.  That is no longer a compelling
differentiator from solid-state drives.  Seriously, the
capacity-to-price factor is only a difference of a factor of 3, 4, or
maybe 5.  No longer do hard disk drives have the factor of 12
advantage in storage economy.

You know what that means?  As far as the near-term market projections
are concerned, hard drives have _failed_.  With the current momentum
behind SSDs, everyone is prepared to see SSDs pass up hard drives in
storage economy, and when that happens, despite the disadvantage of
lower rewrite durability than hard drives, the vast majority of the
market is going to quickly switch over to using SSDs exclusively, and
suddenly there will be a crash in revenue available for research and
development of hard disk drive technology.  You can argue that it's
already happened today, that because there is so much more money going
into the SSD market, they could fund more research, move faster, and
pass up hard disk drives.  Soon enough, we may end up viewing hard
disk drives just as we view CRT monitors: a bygone legacy of computing
times past.

<!-- more -->

Please note that there is a method to solve the problem of limited
rewrite durability in solid-state drives, often called "self-healing."
The technique uses heat to assist in the process of erasure, which not
only eliminates the wearing of the drive due to erasures, but also
speeds up performance.  So remember, it's definitely possible to
eliminate this disadvantage of solid-state drives, but no companies
are currently pursuing putting this function in commercial drives at
the moment.  It's just a matter of time until it works its way into
commercial drives.

The prime innovation that you may be seeing in commercial drives, of
course, is to use multi-level cells (MLC) and 3D NAND to increase
storage density.  Hindsight is 20/20, but you can see the obvious
advantage of increasing storage density as a means to improve storage
economy to the point that write-once-read-many (WORM) use is more
economic for SSDs than for HDDs.  The limited rewrite durability only
concerns as small set of rewrite-intensive applications such as swap
drives and caches.

What about long-term archival in cold storage?  That is a quickly
waning application area, especially thanks to cheap live servers like
Raspberry Pi.  Ultimately, that's a shrinking market that hard drives
once served well for the low-budget niches.  But without hard drives,
magnetic tape and tape drives still serve that market well.

I've discussed this with other folks who had useful insight questions
to ask.  "Who's making it?"  "South Korea.  Samsung, SanDisk, and
Micron are some of the big companies.  Yeah, pretty much."  "They're
just a tiny little country, but they sure have a lot in electronics
coming out of them."
