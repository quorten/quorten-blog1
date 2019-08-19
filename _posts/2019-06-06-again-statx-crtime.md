---
layout: post
title: Again, statx on Linux to get crtime
date: 2019-06-06 22:25 -0500
author: quorten
categories: [unix, reiterate]
tags: [unix, reiterate]
---

Again, I reiterate, because this is important!  Where again is the
information on getting the `crtime` of files on Linux?  It is the
`statx()` system call, the `xstat()` implementation was the one that
went nowhere.

Now, although the system call is found inside modern Linux kernels, it
still has yet to work its way into `glibc`.

20190606/DuckDuckGo linux file creation time statx  
20190606/https://unix.stackexchange.com/questions/2464/timestamp-modification-time-and-created-time-of-a-file  
20190606/https://lwn.net/Articles/397442/  
20190606/DuckDuckGo glibc linux statx  
20190606/https://www.phoronix.com/scan.php?page=news_item&px=Glibc-Statx-Support
