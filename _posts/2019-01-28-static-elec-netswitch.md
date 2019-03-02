---
layout: post
title: Static electricity IS causing the hanging on my smart switch
date: 2019-01-28 20:12 -0600
author: quorten
categories: [home-network, raspberry-pi]
tags: [home-network, raspberry-pi]
---

So, for quite some time, I was wondering about what the causes of my
NETGEAR GS108Tv2 smart switch hanging could be.  For a long time, I
knew that the hanging tended to happen more when people were plugging
in and unplugging cables.  After thinking about this and studying a
bit about CMOS logic more, I came to a few conclusions:

* The smart switch does not like "floating" connections on ports.
  Ideally, all 8 conductors should be wired to a cable.  Using a cable
  with less than 8 conductors is likely to cause trouble due to the
  "floating" connections.

* Indeed, it is static electricity that can cause the smart switch to
  hang.  Furthermore, some laptops don't have good grounding.

* The DC power jack lacking a ground connection is indeed part of the
  problem.  For some people who have been having trouble with similar
  NETGEAR switches out in the field, attaching a ground point to the
  case solved the problem.  Good thing the smart switch comes with a
  metal case.

* Some cheap PHY Ethernet ICs lack adequate electrostatic discharge
  protections.  It's likely that cheaper models may forgo proper ESD
  as a cost saving measure.

* You might be able to add ESD protection on the outside of your smart
  switch by placing a "tranzorb" style device right at the jack input.

<!-- more -->

20190128/DuckDuckGo network switch sensitive to electrostatic discharge  
20190128/DuckDuckGo netgear network switch sensitive to electrostatic discharge  
20190128/DuckDuckGo netgear network switch ethernet sensitive to electrostatic discharge  
20190128/DuckDuckGo netgear network switch ethernet sensitive to static electricity

Confirmed, here on Reddit that sensitivity to electrostatic discharge
is indeed a problem out in the field on NETGEAR switches that use a DC
input power jack without a ground.

20190128/https://www.reddit.com/r/networking/comments/27vq6i/does_you_use_the_grounding_points_on_your/

This StackExchange was a great resource for details on some internal
switch components on the market that are not well designed for static
electricity.

20190128/https://electronics.stackexchange.com/questions/9722/what-is-the-most-common-way-ethernet-ports-experience-harware-failure
20190128/
