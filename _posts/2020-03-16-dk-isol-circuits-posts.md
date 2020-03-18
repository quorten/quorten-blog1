---
layout: post
title: "Digi-Key blog articles: isolation circuits, Raspberry Pi solar
        cells, and respect for power engineering"
date: 2020-03-16 16:34 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Here are some useful and interesting blog articles from Digi-Key.

First, a good review and summary of power isolation circuits, I've got
to keep this in mind:

1. Inductive isolation via transformer coils, this is useful for
   transferring power but keeping the current loops separate.

2. Opto-isolators.  This is a fairly common traditional electrical
   isolation mechanism for data cables to prevent ground loops.

3. Capacitive isolation.  This is a somewhat newer method geared up
   for electrically isolating data connections, but it can be smaller
   and more tightly integrated than opto-isolation.  Still, it can
   provide resistance for very high voltages.

Do keep in mind: The simplest way to transfer a digital signal across
an electrically isolated gap is to use a modulated frequency for a
one, and no current for a zero.

20200316/https://www.digikey.com/en/blog/engineering-and-isolation-its-not-what-you-think

<!-- more -->

This is a great article that shows one possible design for using solar
cells to power a Raspberry Pi 3 with a rechargable battery.  One note
they make in the article, including the Wi-Fi on-board saves power
compared to an off-board USB device.  Okay, okay... so maybe I really
would want to use Raspberry Pi Zero W for Wi-Fi devices, it's just
that I have to cope with finding a way to setup good Wi-Fi antennas on
Raspberry Pi Zero W.

20200316/https://www.digikey.com/en/articles/techzone/2016/jul/how-to-use-solar-cells-to-power-a-raspberry-pi-3-single-board-computer

This is an interesting article that expresses a somewhat personal
viewpoint: When will Power Engineering finally get some respect?

20200316/https://www.digikey.com/en/blog/when-will-power-engineering-finally-get-some-respect
