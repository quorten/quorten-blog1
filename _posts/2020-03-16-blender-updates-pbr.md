---
layout: post
title: Blender updates and PBR
date: 2020-03-16 12:19 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

Blender has been quite the actively developed project over the years.
It's gone through several updates and changes, some of which I wasn't
fully aware of.  So, for my own sake, I'll highlight some of the main
changes that I have experienced since the first time Blender got
updated to version 2.5.

* The Cycles GPGPU accelerated internal raytracing rendering engine
  got replaced by Eevee, a "PBR" renderer.  What's that?  Basically,
  an evolutation on top of raytracing rendering engines to be more
  stringingly physically accurate, hence the acronym "Physically Based
  Renderer" (PBR).

* The internal Blender Game Engine has been removed.  It is considered
  deprecated and a more powerful external game engine such "like
  Godot" should be used instead.

20200316/https://en.wikipedia.org/wiki/Physically_based_rendering  
20200316/https://en.wikipedia.org/wiki/Godot_(game_engine)

Ah, I remember Crystal Space was the old recommendation for an
external game engine, but looks like they've been dethroned.  Yep...
looks like development froze over and the website is now partially
broken.  The page content is there, but the Content-Type reported by
the server is no longer correct.

20200316/https://en.wikipedia.org/wiki/Crystal_Space
