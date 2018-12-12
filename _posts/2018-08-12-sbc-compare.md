---
layout: post
title: "Comparisons and plans for getting my next-up better
        single-board computer"
author: quorten
date: 2018-08-12 11:29 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Single board computer notes.

So, after some thought, I'm planning on getting the Libre Computer
Board latest version in preference to the Banana Pi that supports NAS.
I think it will be more important to have the best performance out of
my intended single board computer form factor than having a
potentially useful feature that I might want to use.

20180812/https://en.wikipedia.org/wiki/Libre_Computer_Project

So the EOMA 68 Earth Friendly Computing Devices?  Where are those?
They're in good shape!  Shipping is planned for late October of this
year!  However, that's primarily 1000 units for the 800 pre-orders
thus far.  If you're like me and going to jump on the bandwagon after
the fact, you better be prepared for a bottleneck.

20180812/https://www.crowdsupply.com/eoma68/micro-desktop/updates/2-7-5-samples-received-dram-is-ok-micro-hdmi-to-confirm

Now that I'm here to look, I also see that there are some libre NAS
devices that look quite interesting.  But the final verdict?  Their
form factor and power consumption is too large for my desires.  Sure,
I like the performance, but I've been telling myself to go for the
form factor that you want, and let technological scaling over time
handle the performance after several upgrade cycles.

20180812/https://www.crowdsupply.com/gnubee/personal-cloud-1  
20180812/https://www.crowdsupply.com/gnubee/personal-cloud-2

And, finally, this is ever further justification that I do not need to
go for Banana Pi.  If I want a NAS, this device will do a much more
excellent job than the Banana Pi will do.

But now, I'm looking further into what Amazon has in store for the
Libre Computer board.  And what am I seeing?

* The latest Libre Computer Board, Tritium, is not available on
  Amazon.

* The next latest Libre Computer Board on Amazon, Le Potato, has some
  reviews claiming it is good... but their is this other board that is
  better named the ODROID-C2.

<!-- more -->

Okay, so now let's get the lowdown on the ODROID.  My verdict: there
are multiple versions of the ODROID available, one of the latest of
which is the C2.  Sure some of the other later versions are more
powerful from a computational standpoint than the C2, but they also
consume more power.  Also, ODROID-C2 has Gigabit Ethernet, whereas
Libre Computer Board Le Potato does not.  Finally, Libre Computer
Board may require some proprietary binary blobs to boot.  So my
verdict?  Given all the limitations at hand, I'll go with ODROID-C2.

All of that said, one thing that people say compares well on the side
of the Libre Computer Board Le Potato as a home theater PC is that it
supports high dynamic range video output, whereas ODROID-C2 does not.
However, this still doesn't work so well given the 100 Mbps Ethernet
on the Libre Computer Board Le Potato.

Still more comments.  The fact that Le Potato has trouble running
Armbian?  Well, wait, Wikipedia claims it does support Arbian.  But
all in all, ODROID-C2 has better software support, which is one of the
reasons why it ranked better on Amazon than Libre Computer Board Le
Potato.

20180812/https://www.amazon.com/Libre-Computer-AML-S905X-CC-Potato-64-bit/dp/B074P6BNGZ/ref=sr_1_3?ie=UTF8&qid=1534092245&sr=8-3&keywords=libre+computer+board  
20180812/https://en.wikipedia.org/wiki/ODROID  
20180812/https://www.amazon.com/ODROID-ODROID-C2/dp/B01LDLBBY8/ref=sr_1_2?ie=UTF8&qid=1534094083&sr=8-2&keywords=ODROID-C2
