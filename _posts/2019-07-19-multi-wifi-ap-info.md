---
layout: post
title: "Good guidance on setting up multiple Wi-Fi access points on
        the same network"
date: 2019-07-19 20:26 -0500
author: quorten
categories: [home-network]
tags: [home-network]
---

So, I was wondering.  Is it feasible to setup multiple Wi-Fi access
points on the same channel when they are far apart, but can still hear
each other?  Will they be able to reliably cooperate with each other
in sharing the same channel, or will the interference just be
horrendous?  It appears that with Wi-Fi, things are destined toward
the later.

On the other hand, I found a great article with a lot of information
and design considerations for setting up multiple access Wi-Fi points
on the same network.  I'll summarize some of the noteworthy design
considerations:

* Water is a strong attenuator of Wi-Fi signals.  Therefore, humans
  are a strong attenuator of Wi-Fi signals because they are water
  rich.  Also, wood is a significant attenuator of Wi-Fi signals
  because it absorbs water vapor from the air, -6db, -20db, or more
  depending on the thickness of the wood.  Notably, this also means
  that when the humidity is higher, like in the summer, the Wi-Fi
  signal attenuation is stronger, but when the humidity is lower like
  in the winter, the Wi-Fi signal attenuation is less.

* Glass is actually also a fairly significant attenuator of Wi-Fi
  signals, -4db per pane.  Double-paned and triple-paned glass
  respectively result in double and triple the attenuation.  Likewise,
  fiberglass insulation is a significant attenuator of Wi-Fi signals.

<!-- more -->

* Sheetrock drywall is not a very significant attenuator of Wi-Fi
  signals, -2db.

* Brick walls basically totally block off Wi-Fi signals, of course.
  -28db!

* Metal and steel likewise basically totally block off Wi-Fi signals,
  -50db!  Concrete is a likewise strong attenuator of Wi-Fi signals.

* If you need more than 3 or 4 Wi-Fi access points within proximity of
  sharing essentially the same collision domain, it will not bee
  possible to have them all on separate channels with 802.11n.
  802.11ac will be required since it has many more channels, and
  because of this, it is the Wi-Fi technology of choice for
  high-density installations.  Go for equipment capable of 802.11ac
  Wave 2.

* Outside neighbor Wi-Fi interference can degrade performance on your
  network too, of course.

* Use specific outdoor Wi-fi access points for outdoor use, if
  applicable.  Because of many of the reasons listed previously, the
  exterior walls of a building will be strong attenuators of Wi-Fi
  signals.

So, armed with this knowledge, is it really necessary to have one
Wi-Fi access point per floor in a house, even if the straight line
distance is not all that great?  In the old days, the answer was "no"
simply because the air was relatively clean of Wi-Fi signals when very
few people had Wi-Fi.  But nowadays, in a neighborhood where almost
everyone has Wi-Fi, and the average person has more than one Wi-Fi
device, the signal noise from the neighbors and from inside the same
residence is going to be too great for that to work well anymore.  So
you need smaller cells to boost Wi-Fi signal strength, and because of
the thickness of wood, concrete, or steel in the floors of buildings,
the floor itself is a pretty good attenuator of Wi-Fi signals, which
means you do generally need one access point per floor, even when the
straight line distance is short.

20190719/DuckDuckGo wi-fi access points on same channel  
20190719/https://www.madebywifi.com/blog/multiple-wifi-aps-on-the-same-network/
