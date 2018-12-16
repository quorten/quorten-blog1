---
layout: post
title: Raspberry Pi 3 B+ on-board power supply tech in detail
author: quorten
date: 2018-08-21 17:24 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

First I start by trying to look for the most energy-efficient
USB power supply for a Raspberry Pi Model B+.

20180821/DuckDuckGo raspberry pi b+ smallest energy efficient power
  supply

Oh, then I find this is a very article about the development of the
Raspberry Pi 3 B+ on-board power supply.  So much has changed about
the Raspberry Pi 3 B+ and so much engineering went into it that they
could have called it the Raspberry Pi 4.  Now, in the case of the
on-board power supply, in the past they have been putting together a
collection of discrete devices to get the desired because all the
Power Management Integrated Circuits (PMIC) available on the market
were too featureful and too expensive for the Raspberry Pi.  But,
nowadays, with the Raspberry Pi's awesome economy of scale, they could
get a Power Management Integrated Circuit (PMIC) custom engineered
just for the Raspberry Pi, that met the feature and cost requirements.
Also, now this is cruical.  The custom engineered PMIC allowed more
power to be supplied on-board, which they could then use to feed to a
CPU with a higher clock speed.  Yep, that's the reason why your
Raspberry Pi 3 B+ consumes so much energy.

Lots of other detailed electrical engineering information is also on
this page.

<!-- more -->

lolo wrote:

> With such articles, the educational purpose of the raspberry pi
> fundation goes over traditional classrooms.
>
> Thanks for this very instructive content and keep going on.

20180821/https://www.raspberrypi.org/blog/pi-power-supply-chip/

The PMIC is available for use in other devices too.

20180821/https://www.exar.com/product/power-management/universal-pmics/universal-pmics/mxl7704
