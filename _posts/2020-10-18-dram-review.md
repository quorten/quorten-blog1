---
layout: post
title: Review on early generation DRAM usage
date: 2020-10-18 08:29 -0500
author: quorten
categories: [vintage-computing, raspberry-pi]
tags: [vintage-computing, raspberry-pi]
---

I might have learned a bit about this in my computer architecture
class, but just to be sure that I wasn't learning about the too new
stuff, I'll do a web search on the subject.  How do you use the row
accwess strobe and column access strobe on an old school DRAM?  Easy.

1. Send row access strobe first with the row address.
2. Send column access strobe second with the column address.
3. You can now read/write the memory.
4. You must periodically refresh the DRAM by reading every single row
   of DRAM.

What about write-enable?  Well, I'm guessing just start driving that
value before you send the row access strobe and after you've finished
writing.  Once you release the write-enable, the newly written value
will get propagated to the DRAM, or at least the row buffer.

20201018/DuckDuckGo dram row access strobe column access strobe  
20201018/https://my.eng.utah.edu/~cs6810/pres/12-6810-15c.pdf
