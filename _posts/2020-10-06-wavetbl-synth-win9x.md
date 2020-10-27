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
to the older VxD drivers.  However, upon my examination of the driver
files, I see no signs that the WDM audio framework is used.

So, rememvber that, you don't need AC97 to get the Microsoft GS
Wavetable Synth working on Windows 98, you just need WDM drivers of
any sort.

<!-- more -->

----------

UPDATE: So, the devil is in the details, as always.  Here's the
problem I'm running up against.  So, looks like I can't install the
Realtek WDM AC'97 drivers after all on Windows 98, after all my
trials.  Yeah, I know if might be possible if you have the right
service packs, but that is too much work for me.  And yeah, the
Windows 95 drivers are VxD only.  But, I heard, they do support MIDI?
Okay, maybe I just have to try that out...

20201006/DuckDuckGo windows 95 ac97 driver  
20201006/https://forums.virtualbox.org/viewtopic.php?t=86773  
20201006/DuckDuckGo windows 98se ac97 sound  
20201006/https://www.youtube.com/watch?v=zWMJ3T8c2Us
