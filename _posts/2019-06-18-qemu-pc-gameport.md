---
layout: post
title: Looking for QEMU PC Gameport support
date: 2019-06-18 23:22 -0500
author: quorten
categories: [windows]
tags: [windows]
---

So, does QEMU support the PC Gameport?  How do you get the support
working?  Oh, bummer... a while back, there were some devs with a
work-in-progress branch to add support to QEMU, but it never got
through to completion.  Here is the trail of their last conversation
in the subject.

20190618/DuckDuckGo qemu gameport  
20190618/https://lists.gnu.org/archive/html/qemu-devel/2005-03/msg00258.html

So, I guess I'll have to start over implementing it from scratch.
It's not too hard to implement, it's just getting all the interfaces
matched up is tedious.
