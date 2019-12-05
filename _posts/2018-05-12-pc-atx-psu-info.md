---
layout: post
title: "Info on PC ATX power supplies and \"lab bench supply\"
        conversion"
date: 2018-05-12 19:46 -0500
author: quorten
categories: [battery-backup, raspberry-pi]
tags: [battery-backup, raspberry-pi]
---

Okay, so for some reason, when I was searching for information on 12 V
power supplies that you can connect multiple 12 V devices to a single
power supply, I found these really great and useful sources, but
because they were all about PC power supplies and not the more general
topic, I scrapped them and failed to save them the first time through.
So, now I go backwards in time to search for what I've found
previously and note this article down again.

So, the question, can you connect multiple 12 V devices to a single 12
V power supply?  In general, yes, so long as your power supply can
provide adequate current.  PC power supplies in particular may have
relatively high current requirements and will use multiple power
supply rails with separate current limiters in order to comply with
the safety standard IED 60950.  Sometimes there may even be separate
switching regulators to help with noise isolation.  This website also
has lots of great information about PC power supplies in general.  A
PC power supply has 12 V, 5 V, and 3.3 V outputs.

20180512/http://www.playtool.com/pages/psumultirail/multirails.html  
20180512/http://www.playtool.com/pages/psurailhistory/rails.html

So, yes, in general, for low current, you can connect multiple 12 V
devices to a single 12 V power supply.

<!-- more -->

Additionally, along the way, I found out that there are many people
who convert a PC ATX power supply into a cheap "lab bench" power
supply.  Originally I found an Instructables article, but in fact
this is so popular that there are so many such Instructables articles
that I couldn't find the original.

The original Instructables article can be summarized like this.  Lab
bench power supplies can be rather expensive, but surely you have
loads of old PC ATX power supplies lying around, so why not convert
one to get a cheap lab bench power supply?  Then the Instructable went
into opening up the power supply, making some internal modifications
so that multiple voltage outputs could be provided, adding a neon
light since switched-mode power supplies cannot operate without a load
across the output and can get damaged if such a condition occurs, and
provided a variable resistor dial at the front to adjust the output
voltage.

But, for the sake of completeness, I link somewhat similar articles
here.  Alas, it is still a far cry from the original source that I
found.

20191204/https://www.instructables.com/id/Hack-an-Old-Pc-Power-Supply-Into-a-Lab-Bench-Power/  
20191204/https://www.electronics-tutorials.ws/blog/convert-atx-psu-to-bench-supply.html  
20191204/https://www.instructables.com/id/Encyclopedia-of-ATX-to-Bench-Power-Supply-Conversi/
