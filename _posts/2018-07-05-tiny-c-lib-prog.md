---
layout: post
title: Tiny C libraries and programs
author: quorten
date: 2018-07-05 18:30 -0500
categories: [unlipic]
tags: [unlipic]
---

So you're writing your own tiny C library, wondering if someone else
already has one written?  Well, let's not count on finding what you
are looking for.  It looks like when people want to go small, they go
all out and write in assembly language and binary byte codes.

20180705/DuckDuckGo smallest tiny linux libc  
20180705/https://stackoverflow.com/questions/14407832/build-static-elf-without-libc-using-unistd-h-from-linux-headers  
20180705/http://www.muppetlabs.com/~breadbox/software/tiny/teensy.html

Well, anyways, for the sake of containers, I've found a better
solution than `myinit.py`: `dumb-init`.  This time through, it is
written in C and statically linked.  musl libc gets to 20 kB.  Can we
do better than that?  Not really, unless we store sections to disk
without padding.

But, that being said, this is another important program that my tiny
libc implementation should support.

20180705/https://packages.debian.org/sid/dumb-init  
20180705/https://github.com/Yelp/dumb-init  
20180705/https://github.com/Yelp/dumb-init/blob/master/dumb-init.c
