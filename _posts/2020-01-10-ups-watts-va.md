---
layout: post
title: UPS sizing, Watts versus Volt-Amps
date: 2020-01-10 11:53 -0600
author: quorten
categories: [home-network, battery-backup]
tags: [home-network, battery-backup]
---

How long will a 40 watt light bulb run on a UPS?  This requires a bit
of understanding of the proper measures of a UPS capacity.

First of all, Watts and Volt-Amps are **not** the same!  Volt-Amps is
a measure of the "apparent load" of a system.  The "power factor" is
the ratio of actual power consumption to apparent load, which is
typically less than one (60% to 85%) for small computers like desktop
PCs due to them behaving like "capacitive loads."  Purely resistive
loads such as incandescent light bulbs and electric heaters will have
a power factor of 1.

So, when a UPS specifies its power capacity in terms of Volt-Amps, you
should generally multiply that by 1 / 60% = 1.67 to obtain the actual
power rating in Watts that is guaranteed to be available.

To be on the safe side, you can always assume your connected equipment
has a power factor of 1 and your UPS power rating in Watts is 60% of
the Volt-Amp rating.  This will result in an oversized UPS that runs
for longer than calculated.

20200110/DuckDuckGo ups how long will a 40 watt light bulb run  
20200110/https://www.power-solutions.com/watts-va
