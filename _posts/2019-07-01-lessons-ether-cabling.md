---
layout: post
title: Lessons learned from a first major home cabling project
date: 2019-07-01 23:24 -0500
author: quorten
categories: [home-network]
tags: [home-network]
---

So, a few weekends ago, I got a 1000 ft spool of Cat6A cable, some
Cat6A keystone jacks, some 25 ft metal fish tape, and some other
miscellaneous items for an in-wall Gigabit Ethernet home cabling
project.  Cool!  Alas, being a first timer at this kind of thing,
there were some errors made the first time through and some lessons to
be learned.  So, here is my summary of what those lessons are.

* Use T568B wiring scheme, period.  Don't bother even considering
  T568A.  If you look around at the color coding in all the Ethernet
  patch cables you have, you'll notice they're all T568B.  Besides,
  Internet HOWTOs on building your own patch cable don't bother even
  mentioning T568A wiring, they only specify a single wiring scheme,
  and that one matches the color codes for T568B.  Also, chances are
  that if you look carefully at the hints in the cabling, jacks, and
  equipment you've bought, it's all optimized to make T568B wiring
  physically the easiest to wire up.  Not to mention that the Ethernet
  cable companies simply sell much more T568B equipment than they do
  T568A.

<!-- more -->

* If there is a question you have about some technical information,
  don't be fooled by the Wikipedia article on the subject, it is
  written with an inherent bias in "official" writings rather than
  common knowledge.  Instead, search around on the Internet with a
  priority toward Internet discussion forums.  There is where you will
  find the real knowledge from real community members.

  This is specifically the problem I've made: I was unsure whether to
  use T568A or T568B wiring, so I went to Wikipedia for guidance.
  Wikipedia made it sound like T568A was better, so I went with that.
  Bad idea... it may have seemed like a better idea in the 1990s, but
  the only reason why was for the sake of color compatibility with old
  analog telephone lines.  Analog telephone lines?  Ha!  Even my older
  family relatives who were out and about using land line telephones
  at the time have practically long since forgotten that analog
  telephone lines were even a thing.  I mean, seriously.  If they ever
  want to call someone in the modern era, their smartphone is their
  first go-to device.  The heck with analog telephone wiring codes!
  Who needs to bother requesting a second telephone line to their
  apartment, house, or bedroom in 2019?

  With this base of common consumer electronics knowledge, there is
  absolutely no reason to believe that the next generation of techies
  will even lift a finger toward considering wiring schemes compatible
  with analog telephones.  Please, please, please, just use the same
  color wiring scheme you see in your mass market manufactured
  computer Ethernet cables.  Yes, the thing that you bring to a new
  wireless access point when someone requests more smartphone and
  tablet Internet usage capabilities.

* Do not plug in an RJ11 6P6C analog telephone plug to an RJ45 8P8C
  Ethernet jack.  Why not?  Well, as the RJ11 plug is only designed
  for 6 positions, the edges of the RJ11 plug have raised outer edges
  that will press up against the outer two contacts on your 8P8C
  Ethernet jack.  Once you remove your RJ11 plug, you may realize that
  the outer two contacts in your Ethernet wall jack were ever so
  slightly bend upward.  Sure, you may still be able to get your
  computers to connect okay, but I can't help but point out the damage
  you've done to your shiny new jack after the very first foolish
  insertion done with an analog telephone jack.  So, that means there
  is no such thing as straight backwards compatibility with telephone
  plugs.  Please, please, please, if you so dare to be using an analog
  telephone over the Ethernet wiring, build a converter cable proper
  with an RJ45 plug on one end and a RJ11 jack on the other, and plug
  your old fashioned analog telephone into that RJ11 jack.

* If you crimp your own Ethernet patch cables, please note that the
  contacts on uncrimped plug heads are raised up.  Do not plug one of
  these plug heads into any jack, or you risk damaging the jack by
  bending the contacts upward!  When you crimp the Ethernet heads onto
  the cables, please make sure you push the contacts all the way down
  so that they are sunken beneath the plastic ridges, otherwise you
  risk damaging your jacks by inserting such plugs.  In practice, I've
  found that this means you can't do the clever minimal tools crimping
  technique of using a screwdriver to push down the raised contacts
  because I was unable to push them down with enough force to get them
  below the threshold.  Nope, you gotta have the real crimping tool.

* How do you test your Ethernet cables with punch-down block Ethernet
  jacks installed, using only cheap, easily available home equipment?
  Computers and switches, period.  Do not bother with electrical
  continuity testing to verify all connections are wired, it is a
  joke.  Only do this if you are desperately curious to learn what is
  going on.  But, seriously, don't bother.  The tools you use to test
  and diagnose RS-232 serial cable wiring connections won't remotely
  stand a chance to giving you insight as to why an Ethernet cable
  isn't working.  I mean, come on!  Seriously, if you've been
  following along my previous blog posts, I've noted just how
  remarkably slow "fast" 56 kbps serial communications is compared to
  "slow" 10 Mbps Ethernet.

  At Ethernet communication speeds, mere electrical continuity doesn't
  determine whether a cable is game-ready or not.  With high frequency
  signals, sharp edges, nicks, fractures, and other deformities that
  deviate from smooth cable geometry with clean-cut ends and
  punch-down termination cause high-frequency signal reflections off
  of the deformities such that the signal interferes with itself,
  thereby greatly reducing the speed classification of the cable by a
  factor of 10, 100, 1000, or even more.

* Be careful about jacket stripping.  If you have the Ethernet jacket
  stripper tool, great.  However, if you're attempting to get by with
  less tools and are using a pair of scissors instead, then use that
  pull string to strip back more jacket, and cut off all the wires
  clean where you were using the scissors to weaken and tear off the
  jacket.  That way, if you happened to nick any of the wires, you
  would have cut off the nicked part of the wire cleanly after
  trimming.

* If you wire an Ethernet cable to a punch-down block Ethernet jack,
  and it doesn't work, do a clean cut through the whole cable and try
  again.  If you have punch-down blocks on two ends and are unsure of
  which one is the bad one?  Cut off the one you did first.  Chances
  are you knew more of what you were doing on the second one, and it
  could just as well be good and usable.

* If you're bringing down spread-out wires in a punch-down block, and
  it doesn't quite work right, try to avoid coming back up.  If you do
  have to come back up, you might as well cut all the spread-out wires
  and try again cleanly.  Otherwise, you could get the aforementioned
  fracture signal interference problems.
