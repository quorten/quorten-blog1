---
layout: post
title: Causes and solutions to technical chaos
author: quorten
date: 2018-05-17 11:26:00 -0500
categories: [blogging, reiterate]
tags: [tour-de-force, blogging, reiterate]
---

Again, I reiterate, because this is important!

As I've mentioned earlier, all technology is part of a stack that has
a top and a bottom: there are base technologies that are built off of,
and there is a derived product technology as a result.  And unfortunately,
the way technology works is that there is always going to be duplicated
work in this story of technological progress.

But, as I've also mentioned, not all duplicated work is effectively
waste... just that most duplicated work is mostly waste.  So, when
exactly is the problem of duplicated work worse or better?

I will provide my personal judgement here.

* When two technologies perform the same task, but each expose an
  incompatible symbolic interface to achieve that task, the problem of
  duplicated work is one of the worst.

    * Every derived technology needs to, in fact, "invent" a symbolic
      format, symbolic language, or symbolic interface upon which
      higher level technologies can build off of.

* By constrast, when the symbolic interface exposed by duplicate
  technologies is identical or otherwise completely backwards/forwards
  compatible, the duplicated works are among the best.

* When the base technologies are the same or very similar, and the
  derived technology is essentially the same, the problem of
  duplication is going to be one of the worse ones.

<!-- more -->

* When the base technologies are very different, and the derived
  technology is essentially the same, the duplication is going to be a
  more veritable goal.  Especially, when the derived technology uses a
  _plug-compatible_ symbolic interface with existing similar
  technologies, the duplicated work will be among the best.

So, the interesting conclusion that you may be drawn to is this:
although it is acceptable for lower levels of technology to be
radically different, the higher levels of technology better have good
compatibility, and the highest levels of technology essentially cannot
be changed: compatible interfaces must continue to be used.
