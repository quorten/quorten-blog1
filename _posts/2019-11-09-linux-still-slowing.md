---
layout: post
title: Linux kernel performance still on the decline
date: 2019-11-09 15:03 -0600
author: quorten
categories: [unix, reiterate]
tags: [unix, reiterate]
---

Again, I reiterate, because this is important!  Previously I've linked
to an article about Linus Torvalds agreeing that Linux is bloated, but
that was a few years ago.  Well, we're still at the progressive
slowing down of the Linux kernel.  Here is yet another newer article
on the same subject.  But, some of the specifics rae different.  In
light of the Meltdown and Spectre bugs, some of the mitigations have
resulted in notable slowdowns, but these are not the result of the
largest slowdowns.  The largest slowdowns were due to configuration
errors, some introduced by newer changes, others introduced simply by
inability to auto-configure with newer hardware.

Companies like Red Hat and Google spend 6-12 months tuning the kernel,
but Linux kernel releases come out every 2-3 months.  Google uses a
team of 100 engineers to do this.

20191109/https://blog.acolyer.org/2019/11/04/an-analysis-of-performance-evolution-of-linuxs-core-operations/
