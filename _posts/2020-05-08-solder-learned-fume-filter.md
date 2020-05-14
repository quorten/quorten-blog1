---
layout: post
title: Lessons learned from more soldering, do-it-yourself air filters
date: 2020-05-08 15:47 -0500
author: quorten
categories: [raspberry-pi, mat-sci]
tags: [raspberry-pi, mat-sci]
---

Soldering, solder fumes.  Do the solder fumes carry the actual metal
itself?  Possibly, it does, but only very tiny amounts, so the risk of
inhaling lead, for example, is much lower than the risk of inhaling
the other fumes.  So, what are the other fumes?  Those are the flux.
Yes, the cleaning chemical designed to remove impurities from your
solder work area, and to generally help make soldering easier and more
effective.

The problem I've discovered about soldering but was never told about
before?  Not only does the flux clean off your workpiece, it also
cleans off your drywall ceiling texture finish!  Arg, dang, now I have
tiny little "pin pricks" on my ceiling where the drywall paper is
exposed, and not only does it absorb water and darken when you try to
clean it with water, but it is also distinctively a more "creamy
white" "off-white" yellowish color than the surrounding ceiling.
Okay, okay, this is unacceptable, although the markings are very tiny
and only visible in the thinnest areas of the ceiling texture, if this
keeps going on it's not going to look very pretty at all.

<!-- more -->

Now I wonder, was this happening with my original solder or just my
newly purchased solder?  Looking closely at the markings, I see there
are markings consistent to state that it happened with my original
solder too.  In fact, if I look at the place where I originally made
my first few solders, with much lower quantity solder consumed than my
current project, I can see there is tiny, barely visible reshaping of
the ceiling texture around there, into the more "funny" looking
texture rather than the originally constructed texture visible
elsewhere on the undisturbed parts of the ceiling.  Alas, no drywall
paper is visible.  Yes, it is all in the quantity, but even the
tiniest amount that touches the ceiling does its damage.

----------

So, off I am to shopping for those more purpose-built soldering fume
extraction fans with the internal activated carbon air filter to trap
the solder flux fumes.  The simple desktop fan I'm using isn't good
enough because although it vents the flux fumes away from _me_, the
fumes still travel through the room until they touch the ceiling and
damage _it_.  You can't just blow your air pollution elsewhere, it
will keep going until it stops on something to damage.

Looking around, these devices are quite expensive.  For what reason?
Of course, the price you pay is for the efficiency of the air filter,
the better air filtering devices are considerably more expensive.
Basic devices that are just a fan with an activated carbon air filter
cost $100 or less.  Better filters that filter >99.9% of particles are
dubbed HEPA (High-Efficiency articular Air) and cost several hundred
dollars.

20200508/https://en.wikipedia.org/wiki/HEPA

After reading the Wikipedia article, I noticed that it said a certain
piece of paper inserted into a German gas mask was found to have a
remarkable filtering efficiency.  Ah, wow... maybe I'll try making my
own filters?

20200508/DuckDuckGo how well can paper filter air  
20200508/https://smartairfilters.com/en/blog/paper-towel-effective-against-viruses-diy-mask/  
20200508/https://smartairfilters.com/en/blog/best-materials-make-diy-face-mask-virus/

Yes, yes, looking around, here's the inner scoop.  Thick paper, like
standard office paper, does filter air with a pretty high efficiency,
but of course it's not very breathable, so it's hard to vent air
through thick paper with a fan for its filtering effect.  But, paper
towels are quite a bit more breathable than thick paper, and layering
two paper towels together does provide for 72% percent air filtering
of larger particles, though small particle efficiency is only 32%.
So, I have an immediate DIY solution to try out.

Immediately around the edges of my fan, on the exhaust side, layer two
paper towels, maybe even use a pleating fold for better air filtering
effect.  To block air pretty readily, while still allowing some
particle trapping function, use office paper.  Use this in the areas
around my workstation where I do not want air to escape, i.e. in the
sides opposite of the fan.  Also, using paper or cardboard to protect
the ceiling is another good idea.  Plastic wrap, yeah that will block
the fume clouds completely, but there is still the risk that they may
travel sideways until they do touch an unprotected area of the
ceiling.  Yeah, for lightweight absorption protection, use paper
towels.

Another heads up, you thought the leaded solder flux fumes were bad?
Well, lead-free solder flux fumes are purportedly far more profuse, so
absolutely be on the lookout to use a fume absorber when working with
lead-free solder.

----------

So, what kind of device to buy?  The cheapest devices are simply a fan
and an activated carbon filter.  When the filter turns white
(apparently the color of solder flux) and air is not sucked very well,
then it's time to change the filter.  Here is one of the better such
design iterations of that general parts list.  It does, of course,
come at an elevated price compared to the traditional design.

20200511/https://www.digikey.com/product-detail/en/FA400-04/1691-1039-ND/6228795/?itemSeq=326143837

If you really don't mind the traditional design, well then, chances
are you're better off making your own such fan as it will be cheaper,
and having built it yourself, you will be more confident that you can
disassemble, recycle, or otherwise repair it.

20200511/https://www.instructables.com/id/DIY-Fume-Extractor-for-5/

What is the filter efficiency of these fans?  Purportedly, they are at
least 80% efficient at filtering out air impurities.  If you really
want 99.97% efficiency, well then, that come at a considerable price
and weight, but you do get the added feature that such units come with
hoses so that the noise-generating fan filtration unit can be located
farther away from you.  Also, they have an indicator light that tells
you when the filter(s) need to be changed.  Here is the cheapest such
device I've found, again from the same manufacturer, 99.97% filter
efficiency.

20200511/https://www.digikey.com/product-detail/en/american-hakko-products-inc/FA430-16/1691-1040-ND/6228796

Hose and ducting kit sold separately:

20200511/https://www.digikey.com/product-detail/en/american-hakko-products-inc/C1571/1691-1035-ND/6228791

Oops... so that's the trick.  If you want the whole price to be
cheapest, go for this one instead, which is why it ranks higher in
Digi-Key's search results.  But please note, H13 = 99.95% efficiency.
U.S. standards recommend >= 99.97% efficiency.

20200511/https://www.digikey.com/product-detail/en/apex-tool-group/ZEROSMOGELKIT1N/ZEROSMOGELKIT1N-ND/6175267

However... indeed there is a think twice factor for the cheaper fume
extractors.  According to this article, the problem with the cheaper
fume extractors is that they simply don't actually provide the
required protection in regard to actual solder fumes.  Activated
carbon filters are designed primarily to filter out odors, not
particulate matter like smoke.  Also, very important, make sure to
double-check the actual filter efficiency and fan speed to verify it
actually functions as well as it should.

20200511/DuckDuckGo how long does a solder fume filter last  
20200511/https://www.sentryair.com/blog/solder-fume-control/comparing-solder-fume-extractors-its-all-about-the-filter/

Oh, and what about ceiling damage from solder flux?  Colophony is the
base product of rosin flux, it is the result after turpentine is
distilled from the resin of pine trees.  There you go, paint remover
chemicals right there.  Solder flux comes right out from paint remover
chemicals.

20200511/https://www.sentryair.com/solder-fume-extractor.htm
