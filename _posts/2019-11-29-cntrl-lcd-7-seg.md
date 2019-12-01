---
layout: post
title: "More info on 7-segment LCD display control, flat zebra cables,
        and beware of PWM LED brightness control"
date: 2019-11-29 14:28 -0600
author: quorten
categories: [raspberry-pi, 3d-scanning, 3d-scanner]
tags: [raspberry-pi, 3d-scanning, 3d-scanner]
---

So, I was looking into more detail on 7-segment LCD displays on
Digi-Key.  I've already looked here before to shop for a 7-segment LCD
display to use with my Raspberry Pi Zero 3D scanner, but I was
dismayed by the prices of the gear.  Now that I've been through
Digi-Key's selection of LED displays and have also seen high prices on
those, well I guess I am no longer as dismayed as I once aws.  The
trick that the Raspberry Pi Foundation uses to get the Raspberry Pi
Zero's price so low is manufacturing on an absolutely massive scale.
Nonetheless, for the sake of larger system building, it is a relief
that the Raspberry Pi Zero itself is only a $5 component in your
larger system.

But, anwyas, on the subject of 7-segment LCD display control.  Upon
closer analysis of the 7-segment LCD displays on Digi-Key, these are
**not** multiplexed displays like the LED displays are.  Rather, there
are two control pins for every LCD segment on the display, plus a few
more pins for common ground and voltage.  So if you do want to drive
an LCD display the same way you'd drive a multiplexed LED display, you
need to buy an LCD display controller chip and insert that into your
system, or build your own out of a collection of chips.

Also looking on Wikipedia, it confirmed this knowledge, albeit only in
a very minor side note on the liquid crystal display article.  Most of
the article was about compute monitor LCDs.

20191129/https://en.wikipedia.org/wiki/Liquid-crystal_display

<!-- more -->

Also, along the way, I found the Wikipedia articles on those flat
printed flexible black-and-white striped ribbon cables you sometimes
see internal to electronics.  The name of the game is "anisotropic
conductive film" and "elastomeric connector."  "Zebra" is also a
fitting word to describe these.

20191129/https://en.wikipedia.org/wiki/Anisotropic_conductive_film  
20191129/https://en.wikipedia.org/wiki/Elastomeric_connector

The Wikipedia article also notes that PWM brightness control in
LED-backlit displays can cause motion sickness and eye strain to some
users.  That is, the LED light output is flicked directly via the PWM
control signal, rather than feeding that into a low-pass filter and
using software compensation for the non-linear brightness curve of
LEDs.  The rationale, of course is it's an easy way to get a good
linear response control on the LED brightness.  But, be careful when
you use multiplexed LED display and PWM brightness modulation in your
electronics projects, they may cause a lot of grief to some users
later down the line if your project becomes more popular.

20191129/https://discussions.apple.com/thread/1677617  
20191129/https://superuser.com/questions/149362/is-an-led-monitor-better-for-eyes-than-an-lcd-monitor
