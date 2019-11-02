---
layout: post
title: Very interesting modern 8-bit computer design
date: 2019-10-19 20:51 -0500
author: quorten
categories: [vintage-computing, raspberry-pi, unlipic]
tags: [vintage-computing, raspberry-pi, unlipic]
---

Looking for a modern 8-bit vintage computer design?  Look here at the
Gigatron.  Definitely it's modern, and the design files are libre
open-source under the two-clause BSD license.

There's also a lot of design knowledge combined together in the design
of this computer, check out the FAQ for some of the explanations.

Some notable design considerations.

* There are no shift instructions because lookup tables are adequate
  and they don't consume "much" memory for 8-bit operands... 1.25 KB
  is still quite a bit in my opinion, though, but they use a giant
  ROM.
* There are no interrupts.
* There is not status register, not even a carry flag, because the
  carry value is not too hard to compute in software.  Also, RISC-V
  does likewise.

20191019/https://gigatron.io/  
20191019/https://gigatron.io/?page_id=160
