---
layout: post
title: "What happened to the KiCad autorouter in version 5?"
date: 2020-03-12 17:00 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Recently, I started using KiCad to play around and start learning.
But then, when I really started using KiCad to collaborate on others
on GitHub, I had to update to the latest version, version 5.  I
actually ended up starting to learn on version 4, and boy that was a
mess in usability.  Version 5 came with some significant usability
improvements...  except for perhaps one.  Where is the built-in
autorouter in KiCad version 5?  I see it in the documentation, but I
don't see it in the user interface.

So, on I must go to searching the Internet and digging up community
discussion to answer this.  Unfortunately, as news has it, it was
removed.  If you want autorouting when using version 5, you have to
export and import to the external Freerouter autorouter.  Yeah, now
that's a nuisance and inconvenience for novices just getting started.
You have to draw all the traces yourself?  What a bunch of extra
unnecessary effort when you are just getting started and not to a full
final design yet!

Yeah, but that's the way it has to be.  On the flip side, you get much
better features overall in version 5.  Unlike in Blender, though, this
all comes at the expense of file format incompatibility with version
4.  I mean, you can still partially read version 5 data in version 4,
but some things will get broken that you'd think shouldn't have to get
broken.

In any case, if by accident I discovered this, it's a good idea to
have both version 4 and version 5 of KiCad around on hand for
immediate use.

<!-- more -->

20200312/DuckDuckGo kicad 5 autorouter  
20200312/https://forum.kicad.info/t/how-to-use-built-in-autorouter-in-version-5/12847/5
