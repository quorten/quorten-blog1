---
layout: post
title: "Searching for Open Hardware designs in vintage computing,
        history of Floppy Emu, and the crux of mass production and
        Open Hardware"
date: 2020-08-01 23:15 -0500
author: quorten
categories: [vintage-computing, apple-ii, mac-classic]
tags: [vintage-computing, apple-ii, mac-classic]
---

It's coming!  I'm going to have clean, clear, and precise models of my
vintage Macintosh hardware that I own, maybe even sharp enough to
manufacture a replica of the hardware.  Now, wouldn't that be swell?

More importantly, for my own personal interest, wouldn't it be swell
if I could have a full physical model of my original hardware in
virtual space, and only ever need to interact with the virtual model
forever more?  It would provide _everything_ that the physical model
would, without any shortages due to computation speed limits on
computers or limits on the features implemented by the emulator that
strives for speed by sacrificing accuracy.

So, here we go.  For classic Macintoshes.  First stop, ROM
replacements.

Macintosh 128K, 512K, 512Ke: ROM-inator, Open Hardware, design files
available.  Check it out.  Designed in Eagle because it's rather old.
But, wait... where's the source?  Okay, maybe not totally Open
Hardware, but at least there is a refrence design available for you to
look at.

20200801/https://www.bigmessowires.com/mac-rom-inator/

<!-- more -->

Macintosh SE/30, IIx, IIcx, IIci, IIfx, IIsi: ROM-inator II, Open
Hardware project name `mac-rom-simm-programmer`.  Also designed in
Eagle because it too is old.

20200801/https://www.bigmessowires.com/mac-rom-inator-ii/  
20200801/https://www.downtowndougbrown.com/programmable-mac-rom-simms/  
20200801/https://code.google.com/archive/p/mac-rom-simm-programmer/

Virtually all Apple II and Macintosh computers: Floppy Emu, Apple
Floppy disk emulator, almost Open Hardware but not quite.  This
started out as a small hobby project but quickly had a turn to go very
commercial.  Now, do-it-yourself prototype builds appear to be
discouraged.  Some of this may be unintentional, or maybe it really is
that the author's viewpoints/opinions changed over time.

20200801/http://www.bigmessowires.com/floppy-emu-tech-design/

There is a tech blog with a lot of the development story here, but not
all of it.  Some of the articles were deleted by the author.

20200801/http://www.bigmessowires.com/category/macintosh-floppy-emu/

And who is the author?  Steve Chamberlin.  Indeed, his site
introduction claims the reason why he really liked the Apple II
hardware was because you could peek and poke around the memory like it
was no one's business, it was all out there in the open, unfettered.
And, alas, the author himself, he gradually went from this all out in
the open spirit to a more proprietary one, once manufacturing and
sales of his hobby scaled up.

20200801/https://www.bigmessowires.com/about/

Check out the Internet Archive Wayback Machine for a link to the
deletd article about making your own Floppy Emu.

20200801/https://web.archive.org/web/20160110203450/http://www.bigmessowires.com/floppy-emu-tech-design  
20200801/https://web.archive.org/web/20160306174320/http://www.bigmessowires.com/2012/12/15/build-your-own-floppy-emu/

You'll also find the source code referenced from that article copied
to other modern GitHub sites and elsewhere on the Internet.

20200801/DuckDuckGo floppy emu github  
20200801/https://github.com/una1veritas/mac-floppy-emu

Yes, about that transition from being open to being proprietary.

Is it really that he transitioned from being open to being
proprietary?  Or did he just delete that article because the parts on
the board as-designed were getting too rare?  That he didn't want to
be inundated by E-mails from folks asking him for a spare PCB?
Especially, the DB-19 connector, when he made a statement that he made
a considerable personal investment to bring about modern manufacturing
of the connector.  And, hoping to pay back that expense through his
own sales, why wouldn't he want to make things a bit more proprietary?

So, what I'm saying.  'Tis the price you pay for scaling up to mass
production manufacturing, that such centralized control and the
sacrifices that need to be made to make it work tend to make people go
more proprietary.

So, more articles from the tech blog on Floppy Emu are insightful
here.  Here, ordering more DB-19 connectors, and the history to get it
newly manufactured.

20200801/https://www.bigmessowires.com/2018/05/10/10000-more-db-19-connectors/  
20200801/https://www.bigmessowires.com/2016/06/04/db-19-resurrecting-an-obsolete-connector/

Here, on the subject of DB-19, "angering" the Internet, and as a
response, the author decided to delete the original post that provoked
that conversation.

20200801/https://www.bigmessowires.com/2015/03/20/finding-a-db-19-angering-the-internet/

Here, the Yellowstone disk controller hardware for Apple II computers
to be able to use a UniDisk 3.5 style disk drive and HD20, languishing
in a proprietary storage location for years before being released to
the public.  Important!  This contains an FPGA that implements the IWM
disk controller.  Very important if you need a replacement for that
chip on a logic board!

20200801/https://www.bigmessowires.com/category/yellowstone/  
20200801/https://github.com/quorten/fpga-disk-controller

Here, discussion on the issue with parts on Floppy Emu getting rarer,
and a redesign to use more abundant and cheaper parts in the current
mass production manufacturing environment.

20200801/https://www.bigmessowires.com/2018/04/06/thoughts-on-floppy-emu-redesign/

Here, relating to development, an interesting article noting the
author's personal deficiencies with maintaining supply chain stock
being a personal challenge.

20200801/https://www.bigmessowires.com/2017/06/02/floppy-emu-back-in-stock-3/

And, finally, here, some of the very earliest articles posted in the
early stages of Floppy Emu hardware development.  The challenges of
finding a board manufacturer, the sobering fact that packing a box
must take 10 minutes, details on the first circuit board layout, and
so on.  The challenge of a 30-year-old ROM bug in the original
Macintosh.  Finally, ending with the very first blog post.

20200801/https://www.bigmessowires.com/2014/03/12/how-to-manufacture-a-widget/
20200801/https://www.bigmessowires.com/2014/01/06/selling-the-floppy-emu/  
20200801/https://www.bigmessowires.com/2013/11/09/getting-ready-to-sell/  
20200801/https://www.bigmessowires.com/2013/10/17/fixing-30-year-old-apple-rom-bugs/  
20200801/https://www.bigmessowires.com/2011/12/18/floppy-emu-board-layout/  
20200801/https://www.bigmessowires.com/2011/09/02/an-sd-card-floppy-emulator-for-classic-compact-macs/

And, just a few more fun things.  Circuit protection and signal
conditioning appears to consistently be the author's weak point.
Take, for example, not being able to get Yellowstone to work fully
faithfully.  So, here is one article he wrote on the subject.

20200801/https://www.bigmessowires.com/2015/04/19/circuit-protection-economics-and-electronics/

Apple Pippin, an ill-fated video game console made by Apple?  Ha, that
one is a new surprise to me.  So even Apple tried to do the Microsoft
Xbox trick, but they tried earlier, and it failed in the market place.
Also, the article mentions a curious trick on how to get floppy drive
support on the Bondi Blue iMac, which came without any floppy drive
support since it touted itself as _legacy-free hardware_.

20200801/https://www.bigmessowires.com/2017/08/18/floppy-emu-and-the-apple-pippin/
