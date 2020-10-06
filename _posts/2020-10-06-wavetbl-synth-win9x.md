---
layout: post
title: The secret to Microsoft GS Wavetable Synth on Windows 9x
date: 2020-10-06 13:06 -0500
author: quorten
categories: [vintage-computing, windows]
tags: [vintage-computing, windows]
---

So you're bummed that you can't get Microsoft GS Wavetable Synth
working on Windows 9x?  Never fear, the solution is a rather simple
one.

Just look here, the answer is plain and simple: It only works with WDM
drivers, with VxD drivers it is totally unavailable.

20201005/DuckDuckGo windows 98 install microsoft wavetable synthesizer  
20201005/https://officialblackmidi.fandom.com/wiki/Microsoft_GS_Wavetable_Synth

Because AC97 drivers are generally newer, this is why it is
recommended to use them to get MIDI since they are also more likely to
be WDM for that reason.  Besides, also if you are trying to emulate a
later Windows 98 PC, you should probably pick AC97 sound as many of
the later models were AC97 compatible.  ES1371 does apparently have
WDM drivers available, though many web search results will bring you
to the older VxD drivers.

So, rememvber that, you don't need AC97 to get the Microsoft GS
Wavetable Synth working on Windows 98, you just need WDM drivers of
any sort.
