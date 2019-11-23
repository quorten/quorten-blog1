---
layout: post
title: Debian versions and Ubuntu package sources
date: 2016-03-26 21:00 -0600
author: quorten
categories: [unix]
tags: [unix]
---

No, really, really, what Debian versions and releases do Ubuntu
packages come from?  I have to know this because all Trisquel packages
come from Ubuntu.  Basically, all Ubuntu packages are continuously
pulled from Debian unstable, regardless of the Debian release version,
then Ubuntu-specific modifications are merged in.  Oh, wow, that would
certainly explain why GNUStep worked so poorly in my version of
Trisquel.  It actually came from Debian unstable, so it wasn't even
supposed to be working correctly.  Yet, Ubuntu indiscriminately
merging in Debian unstable, followed by Trisquel cloning Ubuntu, has
brought this problem upon me that I have no idea what degree of
quality the packages in the Trisquel package repository are of.

20160326/https://en.wikipedia.org/wiki/Ubuntu_%28operating_system%29

Well, anyways, I better get working on that super-meta-distribution
system where I can grab packages from all GNU/Linux and *BSD
distributions, then store them based only off of their differences,
and reproduce the exact original source packages.  What about binary
packages?  That will be a tough one.  I'll try to do some reproducible
binary package from source system where I do a compile then a patch
apply to mitigate the differences, or I might customize everything
completely to try to share unlinked object files across distributions
when possible, then link to create the final binaries.  Yeah, the
point here is, things will be tough.  Things will be tough when I have
to work with very many different distributions simultaneously.
