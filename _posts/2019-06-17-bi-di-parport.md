---
layout: post
title: Bi-directional communication on a parallel port
date: 2019-06-17 22:34 -0500
author: quorten
categories: [dos, windows, unlipic]
tags: [dos, windows, unlipic]
---

The Art of Assembly Language book, Borland C/C++ compilers, and the
DJGPP compiler provide ample documentation and functions for parallel
port output.  But what about parallel port input?  Here I go
a-searching the Internet to find the pertinent information.

20190617/DuckDuckGo dos read input from parallel port  
20190617/http://electrosofts.com/parallel/  
20190617/https://en.wikipedia.org/wiki/Parallel_port

Well, as it turns out, input is easy to do, just make sure to set bit
5 of the control register, then you can read and write the port both
ways from the data register, as indicated in the following table.

|  Register   	   	     	|	LPT1 |	LPT2 |
| ---------			|	---- |	---- |
| Data register (Base Address + 0) |	0x378 |	0x278 |
| Status register (Base Address + 1) |	0x379 |	0x279 |
| Control register (Base Address + 2) |	0x37a |	0x27a |

Well, apparently Borland C/C++ does include functions for parallel
port input.  Look toward the outportb() inportb(), outport(), and
inport() functions.
