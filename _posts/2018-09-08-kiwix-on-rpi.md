---
layout: post
title: Dedicated Kiwix server on a Raspberry Pi
author: quorten
date: 2018-09-08 10:40 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, you're wondering about Kiwix on a dedicated server?  Yes, indeed
it's simple.  You just run a program called `kiwix-serve` and you've
got it setup.  You can route it through an Apache server front-end if
you like.

20180908/https://en.wikipedia.org/wiki/Kiwix  
20180908/https://en.wikipedia.org/wiki/Internet-in-a-Box

Unfortunately, the data storage requirements for an offline Wikipedia
plus my other cool stuff are still beyond me on only a 128 GB MicroSD
card.  Maybe a few years from now it will be feasible.  10 years,
100-fold improvement?  Oh, oops, that puts the capacity, beyond the
SDXC 2 TB limit, at 12 TB.  You need the next new standard, SDUC for
that.  We're going to have to wait and see on that.  If there's a new,
low-power Raspberry Pi out by then, compatibility with my existing
Raspberry Pi will be out of the question.

20180908/https://en.wikipedia.org/wiki/Secure_Digital  
20180908/https://petapixel.com/2018/06/27/sduc-express-memory-cards-to-allow-128tb-storage-and-985mb-s-speed/  
20180908/https://www.dpreview.com/news/7847794311/sd-express-sduc-memory-cards-association
