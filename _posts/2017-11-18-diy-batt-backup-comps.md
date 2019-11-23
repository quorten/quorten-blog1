---
layout: post
title: Do-it-yourself battery backup system summary and components
date: 2017-11-18 21:00 -0600
author: quorten
categories: [battery-backup, raspberry-pi]
tags: [battery-backup, raspberry-pi]
---

Okay, to summarize.  AA battery backup power for network equipment.

* AA batteries can deliver 2500 mAh per cell.
    * Thus, 8 AA batteries can deliver 20 A.  Plenty good power for
      backing up network equipment.
* The best choices on battery chemistry are alkaline and Nickel
  Metal-Hydride.
    * Rechargeable alkaline does not have good capacity and life.
* You can use the LTC4412 IC from linear tech for gracefully switching
  to backup power.

20171118/DuckDuckGo electronics switch between aa power and dc input
  outage  
20171118/DuckDuckGo electronics switch between AA battery power and dc
  input outage  
20171118/DuckDuckGo AA battery 12 volt power supply

Somewhat on track, but it doesn't provide a DC pass-through for line
power.

<!-- more -->

20171118/https://www.superbrightleds.com/moreinfo/battery-and-cps-compact-power-supplies/12v-dc-battery-power-supply-8-cell-aa-battery-holder/934/  
20171118/DuckDuckGo electronics switch to backup power supply when main supply goes out  
20171118/http://www.electronicdesign.com/power/fet-or-circuit-switches-between-main-and-backup-supplies  
20171118/https://electronics.stackexchange.com/questions/113233/switching-between-backup-battery-and-main-power-supply  
20171118/http://www.edaboard.com/thread183013.html  
20171118/DuckDuckGo LTC4412 IC  
20171118/http://www.linear.com/docs/en/datasheet/4412hvfs.pdf  
20171118/DuckDuckGo FDN306P  
20171118/http://morrow.ece.wisc.edu/IEEE/2010/Datasheets/Fairchild/FDN306P.pdf  
20171118/https://www.mouser.com/ProductDetail/ON-Semiconductor-Fairchild/FDN306P/?qs=GeD7q9OHBPy9Kkc110idSQ%3d%3d

You're in luck.  This handy IC will do it all for you for circuits
that require 300 mA of current or less.

20171118/DuckDuckGo LTC1579  
20171118/http://www.linear.com/product/LT1579

"1579f.pdf":

20171118/http://www.linear.com/docs/3544

Ah, I see.  But 300 mA is a bit low on the current side for the
devices I plan on powering.  700 mA would work better.  By contrast,
the separate TI switch circuit can handle current up to 2.6 A.  I'm
going to have to carefully look at the power supplies and inputs of my
devices to be sure.

* But, remember this: 20 Ah / 1 A = 20 hours

Okay, more details.  Make sure you select that MOSFET carefully to
handle the voltage and current.  Generally, you have to over-specify
the limits to get what you want.  Look at those specification graphs
very carefully to make sure you're in range.

20171118/https://en.wikipedia.org/wiki/Schottky_diode  
20171118/DuckDuckGo battery power management switch mosfet 12 v

This is useful general information on using MOSFETs.

20171118/http://www.onsemi.com/pub/Collateral/AND9093-D.PDF  
20171118/DuckDuckGo load switch mosfet 12 v

This is it for the MOSFET, i.e. load switch.

20171118/https://www.electronicspoint.com/threads/using-mosfets-to-switch-a-12-volt-2-amp-load.263531/  
20171118/http://www.digikey.com/product-detail/en/FQP13N06L/FQP13N06L-ND/1053954  
20171118/DuckDuckGo FQP13N06L  
20171118/http://www.mouser.com/ds/2/149/FQP13N06L-244291.pdf

Be careful with the capacitor selection and configuration, in order to
get proper damping, avoid overshoot voltage and current, and keep the
power transition smooth.

20171118/DuckDuckGo application note 88 linear electronics  
20171118/http://cds.linear.com/docs/en/application-note/an88f.pdf

20171118/DuckDuckGo 8 AA battery backup power supply for router

Yeah, it sure looks like it is popular for people to use conventional
AC plug-in UPS for "everything."

20171118/https://batterybackuppower.com/2016/07/25/8-hour-and-24-hour-battery-backup-kit-for-home-modems-routers-and-voip-devices-released/  
20171118/http://www.practicallynetworked.com/networking/082307ups.htm

20171118/https://raspberrypi.stackexchange.com/questions/1360/how-do-i-build-a-ups-like-battery-backup-system

Too expensive ($120), and it doesn't meet my needs.

20171118/DuckDuckGo mini ups and power sensor  
20171118/https://avtech.com/Products/Sensors/MUPS.htm  
20171118/DuckDuckGo how long can 12 v router run off of AA batteries  
20171118/DuckDuckGo how long can 12 v router run off of 8 AA batteries

Yes, you do want 7 Ah, 10 Ah, or 26 Ah for powering network equipment,
otherwise your run time will be too short to be interesting.

20171118/http://www.instructables.com/id/Running-a-DSL-Router-from-12v-Battery-Anti-Loadshe/  
20171118/https://en.wikipedia.org/wiki/Nickel%E2%80%93metal_hydride_battery  
20171118/https://en.wikipedia.org/wiki/AA_battery  
20171118/https://en.wikipedia.org/wiki/Alkaline_battery  
20171118/https://en.wikipedia.org/wiki/Rechargeable_alkaline_battery

Interesting.

20171118/http://www.instructables.com/id/Convert-Battery-Powered-Electronics-to-Run-on-AC/
