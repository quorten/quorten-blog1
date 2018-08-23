---
layout: post
title: Smart home design criteria
author: quorten
date: 2018-07-20 18:00 -0500
categories: [home-network]
tags: [home-network]
---

* First of all, the best lesson to be learned up front.  A smart home
  can only be as smart as the homeowner.  Yes, in an ideal world, a
  home could be smarter than its owner, but for the time being, we
  have to rely on this unifying assumption: if the homeowner doesn't
  do at least some kind of maintenance, even as simple as calling
  another professional to do the maintenance, then things are going to
  run downhill and become dumb again.

<!-- more -->

* All rooms need "cable trays" where telecommunications cables can be
  run, removed, and easily upgraded.  Cable trays must be deliberately
  desgined to support running low-power lines for telecommunications
  equipment through them.

  When smart equipment is not in use, "smart plugs" must be supported
  to cleanly cover up the "smart holes."

* Smart cabinets: Every cabinet needs "cable trays" too, for data and
  power hookups.  Quite often, this might just mean "smart holes"
  drilled in the cabinets to support smart equipment.  Oh, also with
  the "smart plugs" in case smart equipment is not in use.

* Plumbing: All plumbing should have analog metering at the
  consumption end points, at an easy to access area.  The analog meter
  needs a visual meter and an analog electric coupling hook-up that
  can be used for connection to smart home equipment.  Otherwise, we
  "gracefully degrade" to only a traditional analog meter for manual
  regular inspection.

  With all endpoints metered, and the mains metered, it is possible to
  detect a leak in the water supply pipes.

  Detecting a leak in the sewage pipes?  Often times this is not as
  critical, as supply pipes are continuously filled but not sewage
  pipes, nor are sewage pipes in use when no one is around.  Plus it
  is more difficult to handle metering at sewage, and it can be prone
  to clogging.  Not good.

  UPDATE: Detecting flow in the sewage pipes.  You can't use a flow
  meter because solids need to go through too and you don't want to
  create extra complications for that, but you can use force sensors
  at the pipe mounting points.  This is because the sewage pipes are
  empty most of the time, except when they are being used, unlike
  water supply pipes.  However, this is still tricky as you need to be
  sure you isolate spurious vibrations that might come from things
  like heavy trucks outside causing the ground to rattle.

  Relating to water supply pipes.  Another nifty idea would be to have
  monitoring on intermediate pipe points too.  Unfortunately, there is
  no way for you to "gracefully degrade" such a system: either it's
  fully smart or it's not there at all.

* How about electricity?  Well, game on!  Yeah you can do this for
  electricity too in order to verify that there aren't any faults, but
  the particular problem with this is that often times the fault can
  be located in consumer equipment like an extension cord, or the
  consumer electronic device itself, both of which would need their
  own metering.  Unfortunately we know the state of affairs in this.
  There are no standards for communication on this, so you don't know
  if the energy is being used correctly, being wasted safely, or being
  wasted dangerously due to a fault.

  Suffice it to say, it's a good idea in theory, but it can't be
  implemented in practice, given the lack of standardization today.

  Yes, you can use hoses with faucets, but for most users such
  implements do not have their own flow control valves, are not filled
  up with water, and do not sit around long-term, hence they don't
  pose the same hazard as conventional water pipes to plumbing
  fixtures or power cords.

  Quick fix solution for the consumer: if there is a switch right at
  the source of every power outlet, this can significantly increase
  safety, albeit at a loss of convenience.  "Smart power plugs" that
  feature a switch on the end of the plug.  Or a "smart cage" that
  plugs into the end of a power outlet, provides switches, and
  protects against crimping by furniture.

  Now, it turns out there are already such "smart switches" on the
  market.  Again, we need to take the same approach here: there is an
  "analog couple" for the smart switch, so we can fall back to the
  manual method.  Probably in this case, we'd just either stack or
  replace the "wall warts."

    * Good point!  I really like the "smart cage" design, although it
      will need additional structural mounting beyond just the plug
      ends themselves.

      Oh!  Really good idea.  This solves my problem for finer-grained
      control of stand-by power consumption around my computers!

* Also must-have, but on the consumer side rather than the home
  builder side.  Power strips?  You need a slick outlet cover for that
  to prevent dust from settling inside unused outlets.  That's one of
  the disadvantages of having a vertically resting power stip, as
  opposed to ones that rest horizontally.

* Initial construction: The initial construction process must have
  plenty of documentation of the internal structure: precise
  post-construction measurements, photos of internal structure
  partially assembled in steps, videos.  3D scans.  Yes, advanced
  media materials like this, and detailed "as-constructed" plans, not
  just "as planned."

  How do you verify that such information will be collected up-front
  during initial construction?  Be clear to the construction crew that
  you also want a _survey crew_ of a sort throughout the process, and
  document the components that you want surveyed.  See my [More house
  systems]({{ site.baseurl }}/blog/2018/08/15/more-house-systems) blog post for more
  details.

* Initial construction: A sturdy foundation below both the house and
  the garage is a must.  There must be no stray metal beneath the
  basement floor, so that project work involving metal detectors can
  be done in the basement without signal interference.  Therefore,
  metal detectors must be used during initial construction to remove
  any stray metal objects from the ground, and the construction crew
  must be particularly diligent not to drop and loose even but one
  stray nail or staple.

* Lighting electrical supply must be able to support enough current to
  power traditional incandescent light bulbs, even if the current
  fixtures are more energy efficient alternatives.
