---
layout: post
title: Linus kills the floppy disk driver from Linux
date: 2019-07-31 18:31 -0500
author: quorten
categories: [misc]
tags: [misc]
---

Oh my, when searching about for what comes after DevOps, I found this
on the Register.  The floppy disk driver in Linux is being marked as
Orphaned.

20190731/https://www.theregister.co.uk/2019/07/30/torvalds_floppy/

The main problem with USB floppy disk drives is that they are
basically only practical for reading 1.44 MB floppy disks.  If you
want to read floppy disks of **any** format, you're going to need some
more tools, tips, and tricks.  Here are a few that were mentioned in
the comments of the article.

One of the old methods was to use the Catweasel custom floppy disk
controller that could read a multitude of different floppy disk
formats in the same 3.5 inch floppy disk drive.  Unfortunately, it is
discontinued and really only works with pretty old PCs.  A more modern
solution that is similar in design is KryoFlux, but it has some
questionable licensing terms.

20190731/https://en.wikipedia.org/wiki/KryoFlux

Here's a a pretty nifty trick you can do for reading Amiga floppy
disks:

<!-- more -->

> That's not entirely true; Disk2FDI can do it on a standard PC with
> two floppy drives.

> The magic trick? Drive selection is external to the FDC and data is
> transferred prior to checking for CRC errors, so reformat the floppy
> in one drive to have really long sectors, start reading one of those
> really long sectors, change the selected drive behind the
> controller's back, drink in the Amiga data. Subject to possibly
> having to try a few times to get a serendipitously-timed switch re:
> clock versus data bits.

Wow, now that's quite a trick.  I must admit, it's a pity that we are
slowly loosing the older generation who were more versed in those
kinds of hardware tricks.  Nowadays, software is pretty much the only
thing that modern developers understand, and the inner workings of
hardware is unbenowest to them.
