---
layout: post
title: More memory allocation algorithms
author: quorten
date: 2018-06-23 9:44 -0500
categories: [misc, unlipic]
tags: [misc, unlipic]
---

More memory allocation algorithms.  So, FreeBSD says they have a
memory allocation algorithm that bests `dlmalloc`.  So, what are the
key things it improves upon?

* Multiple arenas for multi-threaded use.
* Classifying page runs by their fullness and using that as a
  selection criteria.

20180623/http://g.oswego.edu/dl/html/malloc.html  
20180623/https://en.wikipedia.org/wiki/Buddy_memory_allocation  
20180623/http://people.freebsd.org/~jasone/jemalloc/bsdcan2006/jemalloc.pdf
