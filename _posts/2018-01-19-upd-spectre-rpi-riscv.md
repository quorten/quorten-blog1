---
layout: post
title: "Updates on Spectre and Meltdown, Raspberry Pi not vulnerable, RISC-V, and updates on EOMA 68"
date: 2018-01-19 21:00 -0600
author: quorten
categories: [security, raspberry-pi]
tags: [security, raspberry-pi]
---

Updates on Spectre and Meltdown?

20180119/https://newsroom.intel.com/news/intel-security-issue-update-addressing-reboot-issues/  
20180119/DuckDuckGo spectre meltdown  
20180119/http://www.zdnet.com/article/spectre-and-meltdown-insecurity-at-the-heart-of-modern-cpu-design/

Good news.  Raspberry Pi isn't vulnerable to Spectre and Meltdown.
Here's why.  They don't use out-of-order execution, speculative
execution, and branch prediction.

20180119/https://www.raspberrypi.org/blog/why-raspberry-pi-isnt-vulnerable-to-spectre-or-meltdown/

20180119/https://www.crowdsupply.com/eoma68/micro-desktop/updates

Oh, this is really interesting.  The commentary about the popularity
of the 3D printer at the Shenzen Maker Faire, the awards, and the
demographics of those attending.  More than 50% women, totally not the
situation of the West.  Also. makerspaces are well-attended over
there.

20180119/https://www.crowdsupply.com/eoma68/micro-desktop/updates/a-tale-of-two-tools

Oh, this is really interesting.  RISC-V can easily make it possible to
get 64-bit on an embedded chip.  However, there are a few missing
things that need to be figured out first.

<!-- more -->

20180119/https://www.crowdsupply.com/eoma68/micro-desktop/updates/keeping-100-ohms-hdmi-impedance-risc-v-64-bit-libre-soc-anyone  
20180119/https://www.crowdsupply.com/eoma68/micro-desktop/updates/hdmi-review-and-thank-you

Lots of interesting news going on here.  Mainly, that the HDMI review
is complete and the design is being sent off of the factory for
manufacturing.  Second, the next Apple iPhone is causing price spikes
in 0.01, 0.1, 1.0, 10 and 100 µF capacitors, probably because these
are the components used within the iPhone which are being hoarded by
iPhone manufacturers.  The price spike is somewhere between a factor
of 5 and 10.  Also, DDR3 RAM is also experiencing a price spike.

20180119/https://www.crowdsupply.com/eoma68/micro-desktop/updates/eoma68-a20-2-7-5-gerbers-off-to-factory-thank-you-to-everyone-for-the-sponsorship

So, are the EOMA Earth-friendly computing devices affected by this
issue?  Nope, because they use the ARM Cortex A7 core which is also
not affected, as noted on the Raspbery Pi website.

20180119/https://www.crowdsupply.com/eoma68/micro-desktop

Ah, yes, there is a branded website for this branded bug.

20180119/https://meltdownattack.com/

RISC-V has some very interesting things to say here.  First of all,
RISC-V is not affected.  Second, by RISC-V being open hardware and
peer-reviewed, it has quite the chance to learn from the lessons and
mistakes of the older processors of times past.

20180119/https://riscv.org/2018/01/more-secure-world-risc-v-isa/  
20180119/https://access.redhat.com/security/vulnerabilities/speculativeexecution

Intel has a very PR-like response to the questions on the Meltdown and
Spectre issues.

20180119/https://www.intel.com/content/www/us/en/architecture-and-technology/facts-about-side-channel-analysis-and-intel-products.html

Wikipedia already has an article on Spectre.  Indeed, it says that
most ARM cores are in fact not affected.

20180122/https://en.wikipedia.org/wiki/Spectre_(security_vulnerability)
