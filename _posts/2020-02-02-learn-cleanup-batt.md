---
layout: post
title: Lessons learned on cleaning corroded battery contacts
date: 2020-02-02 23:32 -0600
author: quorten
categories: [mat-sci, raspberry-pi]
tags: [mat-sci, raspberry-pi]
---

For quite a while, I was saving up my notes on how to clean corrosion
on battery contacts, and well, I finally got around to trying it out.
And boy, did I learn one lesson the hard way.

The online sources recommended using an acid of some sort to clean the
contacts.  I've tried that previously, to no avail in cleaning power.
Yeah, the problem was that when I tried it, it was only immediate
contact for the particlar clean, then remove it all in the course of a
few minutes.  The online source recommended soaking for some more
time, like maybe 24 hours?

Now, **that** is where you have to be careful.  What kind of metal are
you cleaning?  If you are cleaning, say, bare copper, than this method
will work fine.  Yeah, it's essentially the same method to make a
copper penny shiny: the top-most layer of corroded metal is stripped
away.  But, if you are cleaning nickel-plated copper or any other
plated metal, be forewarned that this cleaning method can strip off
your plating.  And alas, that's what happened to me.  At the outset,
it is merely cosmetic damage.

<!-- more -->

So, here's the problem point to keep in mind.  If battery acid does
cause damage to battery contacts, it will quite likely strip away a
bit of the top layer of your contacts.  Often times, battery contacts
are nickel-plated, so this means that if your battery contact got
corroded by battery acid, your nickel plating could just as well be
stripped away in those areas.  Be forewarned about that.  Often times
you can use very non-invasive cleaning using just plain dishwashing
soap and tap water to clean off enough corrosion to make the battery
contact usable.  Avoid distilled water as that can cause more
corrosion than would be the case with tap water... because of
distilled water's "thirst" for ions.

After cleaning with dishwashing soap and tap water, a good final touch
involves polishing with steel wool, that's a pretty good way to remove
any minor surface oxidation.  Don't use sandpaper because apparently
that's not strong enough to polish metal, you'll end up breaking the
sand grains off your sandpaper.

If you really must clean with acid to get rid of the corrosion... be
prepared to follow up by redoing the electroplating with nickel.

20200209/DuckDuckGo how to clean nickel plating  
20200209/https://www.doityourself.com/stry/how-to-polish-nickel-plating  
20200209/https://www.thehighroad.org/index.php?threads/how-do-you-clean-your-nickle-plated-guns.648780/

So the lesson learned... cleaners can penetrate the nickel plating,
which is actually porous, and attack the copper underneath, causing
the nickel plating to peel.
