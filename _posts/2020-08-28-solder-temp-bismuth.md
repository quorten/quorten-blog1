---
layout: post
title: "Lead-free soldering iron temperature, bismuth solder, solder!
        More info about keeping soldering iron tips clean."
date: 2020-08-28 19:17 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, okay, after my first few times working with lead-free solder,
specifically 99.3% tin, 0.7% copper, I've come to some conclusions.
Yes, this solder is indeed reasonably workable under the right
circumstances... it is harder to wet... but most of all, the higher
melting point makes it so much harder for me to get it to melt, flow,
or stick to the soldering iron at all!  Yes, I'm still using my cheap
fixed-temperature Radio Shack soldering iron, 750 degrees
Fahrenheight.  Surely due to Newton's Law of Cooling and the like, a
higher iron temperature is necessary to compensate for the fact that
it takes longer to heat up and it the cooler surroundings cool down
your parts faster.

So, let's go searching the Internet, what do other folks recommend?
Ah, they actually recommend doing the same as for leaded solder!  400
Celsius, 750 degrees Fahrenheight for a small tip or low-effect
soldering iron.  A large tip or high effect soldering iron, you don't
need such a high temperature.

20200828/DuckDuckGo tin 99 soldering iron temperature  
20200828/https://www.build-electronic-circuits.com/right-soldering-temperature/  
20200828/https://www.quora.com/What-is-the-correct-iron-temperature-to-solder-with-99.3-tin-0.7-silver-solder?share=1

<!-- more -->

So, I guess if I want to go lead-free, bismuth solder is the way to go
for the lower temperature.  But, well... now there's some
complications if you use that long-term.  Bismuth, despite being
fairly non-toxic to humans, is actually a rather rare earth metal,
only twice as abundant as gold.  Worse yet, bismuth is extremely
difficult to recycle, all current means are un-economic so the metal
simply isn't recycled.  That means that although bismuth is cheap and
abundant today, it won't be in the future.  That's also really too bad
since bismuth-based solder uses bismuth in a majority role rather than
a minority one.  At least it's less toxic than Indium.

20200828/https://en.wikipedia.org/wiki/Bismuth  
20200828/https://en.wikipedia.org/wiki/Indium

Well, I guess that means I must confine my nifty whole-board lead-free
reflow soldering with through hole header components to prototyping
only.  Not recommended for production, not even recommended for kit
builds unless you're targeting total novices.  If you want to go
lead-free economically, you've got to go high temperature.

Okay, okay, now here is the low-down on what's going on.  Sure, I know
I messed up on a number of counts leading up to this.

* I didn't want a desoldering pump so I opted to use solder wick since
  it can be used with your soldering iron.  But, solder wick
  especially has a prospensity to wick away your tinned tip to an
  untinned tip.  Nevertheless, solder wick is essential for fine-tuned
  cleanup, desoldering pumps are aimed at coarse and blunt work.

* There were many times when I was not skilled in applying solder and
  had to use solder wick a number of times, accelerating the solder
  wick problem.

* Given the issues with using solder wick, I should have had wider
  diameter Rosin-activated flux core solder at my disposal.  Alas, I
  did not because I did not want to use such strong fluxes (I picked
  no-clean flux, I didn't want to have to clean it either), and I
  thought using thinner diameter solder wire would make soldering
  small joints much easier.  Well, I was right on it being easier to
  use with small joints, less worries with thrusting in too much
  solder wire and getting too much solder on your joint.  But when you
  have absolutely no thick wire available, tinning your full tip takes
  that much longer.  And you do not have that time when your tip is
  oxidizing.  Plus, no-clean flux will be too mild to help keep your
  tip clean when this happens.

* Due to the difficulty of keeping paper towels wet, I was sometimes
  wiping on dry paper towels, and also sometimes paper towel fragments
  would get stuck to the soldering iron tip and burn leaving
  impurities.

* I waited too long to get tip tinner/activator and my soldering iron
  tip has some spots that were too badly burnt for the tip activator
  to bring them back functioning.  And now I don't want to use the
  polishing bar, emery cloth, or or soft steel brush that would be the
  next step required.

Well, all that mentioned... indeed, if the temperature is adequate for
lead-free soldering, and the recommendation is to not go higher than
the temperature I have as that only greatly accelerates tip oxidation,
then the only other path to make such soldering easier is to use a
bigger tip.  Or... yes, the equivalent I was getting at, get as much
tip surface area as clean as possible, so as much of the heat that the
soldering iron puts out on the tip is readily available for conduction
to the point where you are applying lead-free solder.

20200828/DuckDuckGo how to solder tin wires  
20200828/https://forum.digikey.com/t/how-to-clean-tin-and-maintain-soldering-iron-tip/2006

So, well, all that said about soldering iron tips and the lessons I've
learned, are there any other tips in particular on how to tin wires in
general?  Well, here are two articles, they don't really provide much
info out of the ordinary.  Tin your iron, touch your wire to your iron
to get it heated up first, then touch your solder wire to your wire to
tin it.  One thing I must advise against, holding your fingers close
when tinning wire tips.  This is not good for safety.

20200828/https://www.thespruce.com/tinning-stranded-electrical-wires-1152893  
20200828/https://www.instructables.com/id/Strip-and-Tin-Wires-Like-a-Pro/

Okay, so I have to verify.  Is steel wool a suitable substitute for
using a soft steel brush to clean off bad oxidation?  Yes, it is
acceptable, again so long as you use the softest/finest possible steel
wool, just as you need to use a soft and fine steel brush.  It should
work pretty well to get the bad oxidation off the metal surface and
get a nice shine.

**Do not** take the alternative approach "if you don't have steel
wool" of using wet and dry sandpaper of the finest grit.  Of course
you want to be as fine as possible to avoid scarring and ruining the
soldering iron's plating, but just don't even do this as there isn't
any justifiable reason unless you have a very worn out tip.

20200901/DuckDuckGo steel wool polish corrosion off soldering iron  
20200901/https://electronics.stackexchange.com/questions/398336/can-i-use-steelwool-for-soldering-iron-cleaning  
20200901/https://www.doityourself.com/stry/5-tips-for-cleaning-a-soldering-iron

This is also a good discussion here.  Worthy of note, lead-free
soldering requires much more frequent use of tip tinner/activator than
leaded soldering.  Yes, because with the higher temperatures required
for lead-free soldering, it's that much more important to get optimal
heat transfer, not to mention that oxidation happens faster at the
higher temperature.

20200901/https://electronics.stackexchange.com/questions/371836/wet-sponge-or-brass-sponge-for-solder-tip-cleaning

----------

Oh yeah, another point for soldering.  There was one retrofit wire in
particular where I had a really hard time soldering to it after
reworking it a few times.  Was it just a copper-plated aluminum wire?
That would most definitely be it if that was the reason why it became
almost impossible to solder to.  According to the Digi-Key tech forum
post, "if [copper is] exposed to solder, it will quickly dissolve into
the solder."  So, lesson learned, be especially careful with these
wires?  Apply the solder correctly the first time or else dispose of
the wire and replace with a new one.  Once you start working, the
solder will start dissolving the copper off the surface, and if you
end up removing this solder and trying to reapply it, you will not
have any copper surface left to solder to.
