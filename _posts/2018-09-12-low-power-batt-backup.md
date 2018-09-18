---
layout: post
title: Low-power cable modem and battery backup
author: quorten
date: 2018-09-12 18:32 -0500
categories: [home-network, battery-backup]
tags: [home-network, battery-backup]
---

Looking for a low-power cable modem?  Ah, there's this technique of
turning off channels to save power.  Alas, the power savings are
dismal: 0.5 W in the best case.  So, lesson learned, the bottom line
of a low power cable modem is go for one.

20180912/DuckDuckGo low power consumption cable modem  
20180912/https://www.excentis.com/blog/can-you-really-reduce-cable-modem-power-usage-using-energy-management-feature

Now you're wondering about lead-acid battery capacity, size, weight,
and cost?  You're in good luck.  For being an uninterruptible power
supply for small low-power network equipment, their capacity is pretty
good: 12 volts, 7 amps, 20 hours.  Size and weight are acceptable: 5.9
x 2.5 x 3.7 inches, 5 pounds.  Cost is acceptable: $20.  Safety is
acceptable: lead-acid batteries don't catch fire easily, don't require
charge control circuitry, and can't overcharge.

20180912/DuckDuckGo 12 volt uninterruptible power supply lead acid battery  
20180912/https://www.amazon.com/ExpertPower-EXP1270-Rechargeable-Lead-Battery/dp/B003S1RQ2S

This is a helpful article on building an uninterruptable power supply,
for HAM radio.

20180912/http://www.westmountainradio.com/pdf/BuildYourOwnUPS.pdf

Make sure to use sealed lead-acid batteries, otherwise they can
generate dangerous fumes when charging.  "Two types of sealed lead
acid batteries are Absorbed Glass Mat (AGM) and Gel."

However, further investigation makes this obvious.  How long will the
battery last?  Will the cost still be worth it adjusted for the
longevity of the battery?  Expect the battery to last between 6 months
and 48 months, though if you're lucky the battery may last you a few
more years.  Also note that having a smarter battery charge controller
can help prevent over-discharge to your battery, though this is not
strictly required with lead-acid batteries connecting wholly to
switched-mode power supply circuits.
