---
layout: post
title: "You **can** buy a fully automatic SMT assembly prototype online!"
date: 2019-11-26 00:29 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

For quite a while, I despised the fact that surface-mount assembly
prototyping required you to do your own solder paste and pick and
place the components by band.  Alas, I was merely short-sighted.
Searching around on the Internet, I came upon this site,
JLCPCB(JiaLiChuang (HongKong) Co., Limited).  They do in fact provide
fully automated assembly of printed circuit boards, including pick and
place for surface-mount devices.  Ball-grid array assembly is not
supported, though.  Still, come on, that's pretty good!

20191125/https://jlcpcb.com/v  
20191125/https://support.jlcpcb.com/article/13-who-is-jlcpcb  
20191125/https://support.jlcpcb.com/category/78-smt-assembly  
20191125/https://support.jlcpcb.com/article/83-smt-assembly-faqs  
20191125/https://support.jlcpcb.com/article/79-pick-place-file-for-smt-assembly  
20191125/https://support.jlcpcb.com/article/80-bill-of-materialsbom-file-for-smt-assembly

Interesting that they've only been around for 12 years.  "Only" 12
years?  Come on, that's a long time!  In the tech world in general,
yeah, **but** they are relatively young compared to other companies in
their area of electronics prototyping/manufacturing support companies
such as Digi-Key, Mouser, etc.  Then again, PCB manufacturing service
companies seem to be rather young... many of the old big electronics
businesses did the whole process in-house.  So in that respect, they
are old for a PCB manufacturing services company.

<!-- more -->

And looking more into this, now I realize that `dirtypcbs.com` may
provide the same through their "dirty BOM" site feature.  Oh yeah, and
the custom cables?  That is mainly about getting a service to crimp
standard cables onto standard connectors for you, with minor tweaking.
No need to suffer the pain of crimping your own cables.

Yeah, unfortunately, OSH Park offers nothing along the lines of BOM.
If you want professional automation, you've got to take it to Hong
Kong, Shenzhen, and the like around Asia.

----------

Preface to this discovery:

What?  I saw mention of Digi-Key PCBs on Twitter?  Wait, can you
really have Digi-Key ship you PCBs too?  No, that's not what was
happening.  What was happening here, a Digi-Key employee created PCBs
with Digi-Key branding, had them packed up, and was going to use them
to help teach soldering.  There you go, not a Digi-Key provided
service.  Look elsewhere.

20191125/DuckDuckGo digikey pcb

Oh, now this is an interesting article discussing Bill of Materials
(BOM) integrated into a PCB CAD design software, namely that of the
site owner.

20191125/https://www.altium.com/solution/digikey

So, working with a manufacturer that also places components on your
printed circuit board, the key to that is the Bill of Materials (BOM)
specification, which apparently has become fairly standardized in the
industry.

Interestingly, I saw mention of this "PCB ruler" from Digi-Key,
basically a ruler made as a printed circuit board.

20191125/https://www.eevblog.com/forum/chat/ruler-from-digikey/
