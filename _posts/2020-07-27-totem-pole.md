---
layout: post
title: "\"Totem-pole\" means buffered"
date: 2020-07-27 23:19 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

What are "totem-pole" outputs?  Those are simply "fully buffered"
outputs where an input signal is converted so that logic one is a path
to the positive voltage source, and logic zero is a path to ground.
As opposed to "open collector" or "open drain" logic where logic level
zero is simply left "floating."  And a buffer is also a "push-pull
amplifier."

20200727/https://en.wikipedia.org/wiki/Push%E2%80%93pull_output  
20200727/https://en.wikipedia.org/wiki/Open_collector
