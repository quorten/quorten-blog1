---
layout: post
title: Disk imaging software info
date: 2019-10-22 01:53 -0500
author: quorten
categories: [vintage-computing, mac-classic]
tags: [vintage-computing, mac-classic]
---

This thread on 68kMLA contains some great information about Macintosh
disk imaging and disk imaging in general.  Disk Copy 4.2 preserves
file tags, Disk Copy 6 does not.

20191022/https://68kmla.org/forums/index.php?/topic/56922-best-way-to-archive-vintage-mac-floppies-cds-to-images/&page=3&tab=comments#comment-607588

Here is the official Tech Support note stating that file tags are
deprecated from Apple.

20191022/https://macgui.com/usenet/?group=14&id=169

Wondering about copying CD-ROMs with both data and audio tracks?
To refresh my memory CUE/BIN is the name of the game for the file
format.

20191022/https://en.wikipedia.org/wiki/Cue_sheet_(computing)

What about the software to generate such a disk image?  Use `cdrdao`,
that is the recommendation of the 68kMLA veterans.

20191022/https://en.wikipedia.org/wiki/Cdrdao

JJJ TODO: Questions to ask:

* How does DiskCopy 4.2 gather the format byte from the GCR format
  nybble?
