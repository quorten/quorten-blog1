---
layout: post
title: "KiCad rounded traces, interactive graphical HTML BOM"
date: 2020-07-20 05:09 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

How do you create rounded traces in KiCad?  This is the ideal form for
high-frequency circuits.  Unfortunately, there's no easy way to do
this directly at the moment, but the microwave/RF extensions do
provide a workaround that amounts to creating a custom footprint for
the rounded portions.

20200720/DuckDuckGo kicad rounded tracks  
20200720/https://blog.oshpark.com/2019/12/31/kicad-round-tracks/  
20200720/https://hackaday.com/2019/11/19/kicad-action-plugins/

Indeed, looks like it will be some time until rounded tracks are
treated as a first-class object in KiCad.

20200720/https://hackaday.io/project/167914-kicad-rf-tools

Wow, this is sure interesting, an HTML BOM generator that includes a
graphical map of your PCB, allows you to easily find where you should
place your components.

20200720/https://hackaday.com/2018/09/04/interactive-kicad-boms-make-hand-assembly-a-breeze/

<!-- more -->

This is interesting, if you create an Open Hardware design and it
becomes sufficiently popular, you might get copied by a cheap Chinese
mass production manufacturer, and now suddenly your designs are
available for the cheap.  The catch, of course, is that this pretty
much always happens without offering any payment back to the original
designer.

20200720/https://hackaday.com/2020/07/18/the-sincerest-form-of-flattery/
