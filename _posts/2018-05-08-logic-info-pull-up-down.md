---
layout: post
title: "Wire-OR gate, DTL, RTL, etymology of pull up/down in GPIO"
date: 2018-05-08 21:00 -0600
author: quorten
categories: [raspberry-pi, important]
tags: [raspberry-pi, important]
---

Important!  LINK.

This is what a wire-OR gate is.  No, it's not just wire together, the
official circuit uses diodes to prevent signal back-flow, and a pull-down
resistor to keep the voltage/current regulated.

JJJ TODO LINK with DTL and RTL articles.

20180508/DuckDuckGo wire-OR  
20180508/https://en.wikipedia.org/wiki/Wired_logic_connection

Important!  For GPIO on the Raspberry Pi.  Wondering where the names
pull-up and pull-down for the GPIO state configuration are derived?
Look here, this is the reason why.

20180508/https://en.wikipedia.org/wiki/Pull-up_resistor

* Of course, as many commentators have stated on this, modern users
  are far displaced from the concept of pull-up and pull-down.
