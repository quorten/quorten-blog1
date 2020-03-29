---
layout: post
title: Discussion on soldering surface-mount devices
date: 2019-01-01 17:35 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

TSOP, TSSOP, VMFP.  All kinds of quite cryptic acronyms that I am told
refer to some sort of surface-mount device packaging.  So, considering
that I am going to need to work with these to do what I want, what
does Wikipedia have to say to enlight me on the subject?  There is one
article on Small Outline Integrated Circuit (SOIC).  Unfortunately,
that Wikipedia article contains a dearth of information on the full
variety of surface-mount device packaging types.  For example, VMFP is
nowhere to be seen.

20190101/https://en.wikipedia.org/wiki/Small_Outline_Integrated_Circuit  
20190101/https://en.wikipedia.org/wiki/File:SEG_DVD_430_-_Hynix_HY29LV800BT-70-4279.jpg

Nevertheless, it still is a useful introduction to the variety of
packaging types in the subject, and the difference between narrow SOIC
(1.27 mm pin spacing) and small outline package (SOP, 0.65 mm pin
spacing).  Add a "T" in front for "thin" in TSOP, and an "S" for
"shrink" in TSSOP.  An Exposed Pad (EP) means that there is a large
exposed pad purportedly on the bottom of the IC that acts as a heat
sink.

Now, if you want some great background information on the current
state of affairs, the 7400 series integrated circuit article is a
great one.

20190101/https://en.wikipedia.org/wiki/7400-series_integrated_circuits

<!-- more -->

So, what are the important things we've learned?  First of all, only
the original 5 V 7400 series chip is available in a through hole
mounting package.  All of the additional variants, such as 3.3 V
variants, are available in surface-mount device packages.  Second, the
variety of surface-mount device packaged chips address 3.3 V logic
quite well.  So, long story short, if you want 3.3 V logic chips,
you've got to use surface-mount device packages, albeit being so small
that they are difficult to solder.  And, in the end, indeed this _is_
what I want, as another thing that I didn't like about needing to use
additional chips with the Raspberry Pi is the size and bulk that they
can add.  Surface-mount device packaging aims to keep this to a
minimum.  The main disadvantage is that in the present day, these
smaller form factors entail a higher design and engineering cost any
way you put them.  Robotic pick and place machines are the mainstay of
mass production with these chips, but getting a custom job with these
machines is unfortunately quite expensive.  Therefore, most people
will hand-solder these chips in the early design phases, although that
also entails more cost it is difficult to learn how to do this due to
their small physical size.

Worthy of note is that the 7400 series chip runs off of 4.5 V
unregulated power from 3 AA batteries just fine.

Let's continue searching for more information on the larger Internet.

20190101/DuckDuckGo socket surface mount integrated circuit

Ball grid array (BGA) and pin grid array (PGA) sockets are listed in
here, but not the other surface-mount types.

20190101/https://www.futureelectronics.com/c/interconnect/ic-sockets

Basically the same story for sockets here too.

20190101/http://www.te.com/usa-en/products/connectors/card-socket-connectors/ic-sockets.html

Possibly there are the devices you are looking for on Ebay.

20190101/https://www.ebay.com/sch/i.html?LH_CAds=&_ex_kw=&_fpos=&_fspt=1&_mPrRngCbx=1&_nkw=surface+mount+socket&_sacat=&_sadis=&_sop=12&_udhi=&_udlo=&_fosrp=1

Sparkfun!  That's always a very informative site for beginning
hobbyists like me.  Indeed, this site has some useful information that
was not found on the Wikipedia article.  Notably, a very useful
accelerometer/gyroscope module comes inside a quad-flat no-leads (QFN)
package.

20190101/https://learn.sparkfun.com/tutorials/integrated-circuits/all

Okay, but I'm still looking for sockets for surface-mount devices.
Sockets features for through-hole plastic leaded packages galore.

20190101/DuckDuckGo surface mount plcc ic socket smt smd base  
20190101/https://www.electronics-notes.com/articles/electronic_components/surface-mount-technology-smd-smt/plastic-leaded-chip-carrier-plcc.php

Ah, finally!  Getting to some useful links, through Electronics
StackExchange of course.  Here's some listings for J-lead
surface-mount devices.

20190101/https://electronics.stackexchange.com/questions/185655/soj-socket-to-pcb  
20190101/http://www.morethanall.com/images/products/175496295148302c5ae8f40.jpg  
broken/http://chufon.sell.curiousexpeditions.org/pz56f008a-plcc-socket-soj-socket-adapter-with-tin-plated-contact-and-84-pin-plcc-socket.html  
20190101/http://www.shopsri.com/pdf/augat/soj.pdf

Okay, now that was quite a hard search, and only partially successful,
I must reckon.  Mainly, I was trying to prove that there are in fact
surface-mount device sockets available on the market, and I've found
at least one such example.  But, upon further thoughts, maybe these
sockets are more effort to use than they are worth.  In any case,
socket or no socket, I'm going to need to solder something down to my
boards.  Yes, I've already covered the hand soldering iron tricks.
Those work well for surface-mount devices with protruding pins, but
for quad-flat no-leads (QFN) packages with their pads sitting squarely
underneath the bottom of their packages, soldering gets a bit tougher.
Yeah, maybe you can use larger pads and conduct heat along the exposed
pad to get a good solder joint.  Maybe even this technique can be
extended to ball grid array (BGA) packages.  Reiterating the Sparkfun
article, "[i]f you can hand-solder a BGA-packaged IC, consider
yourself a master solderer."

But, alas, if I can't get hand soldering to work, I can look toward
doing my own reflow soldering.  Okay, so I've read that you can build
your own reflow soldering ovens relatively easily and the process
itself isn't that difficult.  Let's review the subject here.

Oldies but goodies.  The IEEE Spectrum article I first read to learn
about this trick.

20190101/DuckDuckGo ieee spectrum build your own reflow soldering oven  
20190101/https://spectrum.ieee.org/geek-life/hands-on/the-poor-mans-solder-reflow-oven

Wow, so here are some nifty tricks conveyed in this article.  First of
all, you can use an existing toaster oven with convect (to avoid hot
spots) capability as a base upon which to build your reflow soldering
oven.  Some hobbyists stop there, with using only relatively crude
temperature control and air cooling.  Second, getting a PID ramp/soak
controller is quite cheap at of 2012, only $75.  So, if you are
willing to do some electronics hacking on your toaster oven, you can
get some very good results for a very good price.

Looking to the Internet for more information, I found this other
article.  This one, unlike the last article, details the overall
process in more detail.  First, you lay out the solder paste manually
by hand onto the pads.  Second, you place the components on top of the
pads.  Don't worry if it's a little messy, the reflow soldering
process can straighten things out a little.  Surface tension from the
melted solder paste will cause the components to shift around so that
their leads are in the center of the pads.

Here, this author used crude temperature control, square-wave style
temperature setpoints and durations, but got quite good results.  This
author also noted that others have noted that you you can also simply
heat the board up to the reflow temperature for four minutes and that
will also give you just as good results.  Additionally, the author
notes that once you are done prototyping a design, you can prepare a
solder paste stencil mask to make applying the solder paste much
easier and faster.

20190101/DuckDuckGo reflow soldering oven at home  
20190101/http://www.cupidcontrols.com/2013/12/home-reflow-soldering-on-a-budget/  
20190101/http://www.cupidcontrols.com/wp-content/uploads/2013/12/recipelist.png  
20190101/https://en.wikipedia.org/wiki/Toaster#Toaster_ovens

N.B.: A toaster oven is basically just a smaller form factor of an
electric oven.  That, of course, is preferable for making small job,
single custom printed circuit boards as it is less energy to heat the
smaller space.  But, if you have a larger electric oven with convect
capability, you can use that just as well for the crude temperature
control techniques.

What is the temperature control curve for lead-free, RoHS solder
paste?  Naturally, it''s a few degrees Celsius higher than that of
leaded solder paste.  Don't worry, it's not too much higher.  Chances
are that if you have an oven that can reflow leaded solder paste, it
can do lead-free paste as well.  I've also found some nice
confirmation information on the temperatures to use for leaded reflow
soldering too.  Note that passive air cooling, by simply turning the
oven off and letting it cool or letting the board cool in open air,
works quite well at the end of the process for cool-down.

20190101/DuckDuckGo temperature curve rohs refow solder paste  
20190101/nts/download_center_1/reach___rohs/Standard_Reflow_Wave_Solderprofil_LF.pdf  
20190101/https://www.compuphase.com/electronics/reflowsolderprofiles.htm

Here's another interesting idea.  Rather than using soldering paste,
you can make your own pads out of conventional solder on the printed
circuit board.  Then, you use _adhesive tape_ to hold the components
in place instead of soldering paste.  You put the whole board in the
reflow oven, then you observe the components adhere to the solder.

This SparkFun article is a great capstone on all my notes on reflow
soldering thus far.  It details the process that SparkFun uses for
electronics assembly, from small hand-assembled batches to larger
production batches.  An important point that this SparkFun article
brings up: solder paste has an expiration date and should be used up
completely relatively quickly after its date of purchase.  This has to
do with the flux added to the metals for the paste consistency.  Also,
you have to be careful about another defect that can happen during
reflow soldering.  Sometimes for really small components, if one side
adheres but the other doesn't, the reflow causes the component to
stand on one side, called "_tombstoning_."

20190101/https://learn.sparkfun.com/tutorials/electronics-assembly

Also, your idea about taping components down?  Indeed, in larger
assembly runs, sometimes components are glued in place, rather than
being held by solder alone.

Also, there's another important step that they cover: washing.  I
thought this step to not be necessary in the simplest of soldering
jobs, and maybe that is true.  But, if there is any residual flux left
on your parts, that can turn into a sticky residue over time, even
become acidic, and make your solder joints brittle.  Cleaning with hot
distilled water in a cheap crockpot and a toothbrush is a good way to
do this at home.  If you only have a small number of connections to
clean, a Q-tip with some isopropyl alcohol works quite well.

UPDATE 2019-01-06: Okay, so why did I never had to clean the flux from
the solder before?  I have a serial cable that I've soldered together
quite a few years back, and it still works just fine.  Well, it was
nominally 60% tin 40% lead solder, and possibly Rosin-core.  Maybe
that since it came with a starter kit, it was formulated to make this
be less of a problem.

UPDATE 2020-03-15: Indeed, this is the case.  There is a such thing as
"no clean flux" that is used in some kinds of solder, and it could be
that is the kind of flux they used in that particular solder.

----------

Alas, I must concede that the leaded versus lead-free solder paste
situation makes me feel much the same as I do about black and white
versus color film developing.  Black-and-white film is easier to
develop and more forgiving toward process variations, but it is not as
featureful as color film.  Hence color film was preferred for mass
market film developing... until it was made obsolete by digital.
Technically speaking, however, the situation is a bit different for
solder paste.  Black and white film developing can easily be
environmentally friendly.  Indeed, however, comparing lead-free hand
soldering versus lead-free reflow soldering, running an oven hotter is
easier than handling a hotter soldering iron.

Now, I've got an interesting idea.  Is it possible to do all of your
electronics projects with only solder paste?  Now that I think about
it, the answer is "no."  Typically, there will be wire connections to
battery power terminals that you will, of course, prefer to solder
down the wires rather than put on paste and put the whole in a reflow
oven.  So, although you can do an entire project using only
conventional solder, you cannot do an entire project using only
soldering paste.

----------

UPDATE 2019-01-03

How do we know that reflow soldering in your home kitchen's oven
really works?  Take this piece of vernacular knowledge.  If your
laptop is not working, put your laptop in the oven with a wet towel
around it, and that will fix it.  Indeed, that's how we know it works.
Although, it is more effective if you remove the circuit boards, and
the wet towel probably isn't necessary.

UPDATE 2019-11-05

However, please note that the lead-free reflow soldering temperature,
about 260 degrees Celsius, is above the melting point of most
plastics, about 200 degrees Celsius.  This means that you _cannot_ put
an electronic in an oven whole to do a reflow solder.  It would melt
the plastic casing and it would be ruined.  You must put **only** the
circuit boards in the oven and remove all other external casing,
batteries, SD memory cards, and so on.
