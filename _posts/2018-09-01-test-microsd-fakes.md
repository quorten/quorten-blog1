---
layout: post
title: Testing my new MicroSD card for fakes
author: quorten
date: 2018-09-01 20:00 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, so I got my new 128 GB MicroSD card for only $30.  Sure, I made
sure to go with a MicroSD card from the official vendor on Amazon, and
I went with Samsung rather than SanDisk to evade the worst of the
counterfeit fakers, but I still have reason to be suspicious that even
this card is a fake, given recent reports from the year 2018.

So, I decided to go about testing for fakes like this.  Rather than
using a program that writes pseudo-random data to the card, I decided
to copy from some real, photographic data sets to fill up the card.
Then I used a binary `diff` command to compare that files on disk were
identical to the known good data.  But... ut oh.  I got disk I/O
errors?  Fake?  FAKE???  FAKERS???  FAKE, FAKE, FAKE!!!

Wait, hold on here.  Upon a closer analysis, it appears that the
problem wasn't quite as bad as I thought it was.  Doing a more
rigorous analysis, it turned out that actually most of the card was
readable and had identical digital data to the known good copy.
However, at the very start of my copy, I had a few bad blocks written.
Unfortunately this also meant that the root directory entry of my
filesystem got corrupted, which meant that when I unmounted and
remounted my disk, none of my files but the first directory showed up,
and the disk capacity still showed as nearly full.  Ut
oh... filesystem corruption.  How to fix this?

<!-- more -->

A cursory examination led me to believe that the Linux ExFAT FUSE
utilities weren't too great at fixing filesystems.  Luckily, I had a
Windows 7 operating system on hand that I believed would have a better
ExFAT filesystem repair utility.  Indeed, the repair utility on
Windows 7 was excellent, but with caveats: the graphical user
interface method by going to disk properties crashed, but running
`chkdisk /F` from the command lined worked excellently.

Some important final closing words about ExFAT.  ExFAT, unlike FAT32,
doesn't have a redundant copy of the file allocation table.  Also,
ExFAT, like FAT32 but unlike NTFS, isn't a journaling filesystem.
This collectively means that ExFAT is more prone to data loss and
filesystem corruption than either FAT32 or NTFS.  The moral of the
story is to try to avoid using ExFAT when possible.

Also, keep in mind that it looks like `testdisk` doesn't have
particularly special or smart support for recovering files from ExFAT
filesystems, so you'd end up having to drop down to a less
contextually aware method like `photorec` if you really had impending
data loss and only libre tools on hand.

20180901/DuckDuckGo linux repair exfat file system missing directory entries  
20180901/DuckDuckGo repair exfat file system missing directory entries  
20180901/https://apple.stackexchange.com/questions/197866/exfat-formatted-external-drive-loses-folders  
20180901/https://forums.macrumors.com/threads/exfat-partition-got-corrupted-but-was-easily-fixed-how-did-this-  
20180901/https://bbs.archlinux.org/viewtopic.php?id=192378  
20180901/https://www.cgsecurity.org/wiki/TestDisk_Step_By_Step

----------

Finally, after the trials and errors of bad block writes and corrupt
blocks on my MicroSD card, I tried rewriting the corrupted data twice,
as the first trial to fix the errors didn't quite work successfully.
Then, doing a final binary `diff` between the known good data and the
new MicroSD card.  The result?
