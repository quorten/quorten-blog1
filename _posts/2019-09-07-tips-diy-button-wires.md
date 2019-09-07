---
layout: post
title: Tips on home-grown electronic push buttons and wire shaping
date: 2019-09-07 10:28 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

For Raspberry Pi electronics projects, sure you can always buy push
buttons and wires, but why not use a more do-it-yourself construction
and electronics recycling approach?

You can develop your own push buttons with ease from paper, cardboard,
and aluminum foil.  The main consideration when designing such a
button is that you want the contacts to be relatively durable and
reasonably close together so that the button is easy to use.  At the
same time, you want some springiness so that the button doesn't stick
down or bounce.  With the right techniques, it is relatively easy to
construct a reliable push button.

* Basic cardboard bench spring.  You have two contacts on a base board
  like printed circuit board buttons, and aluminum foil on the bottom
  of a cardboard "bench" key cap.  Pushing down closes the contacts,
  the cardboard ensures a reliable release.

* Paper sprung button.  Similar to the cardboard bench spring, but
  using paper instead.  Use a sufficient quantity and stiffness of
  paper to get a reliable spring.  Use accordian folds if needed.

<!-- more -->

* Aluminum foil tube spring.  This one is a bit trickier and more
  clever to construct, but possibly has better long term durability
  than the others.  Strip two wire ends and wrap a tube of aluminum
  foil around exposed wire ends.  The idea is to create a reliable
  electrical contact between the two wires, but due to the stiffness,
  springiness, and other parameters of the aluminum foil tube, it will
  only close an electrical connection when pressure is exerted on the
  tube.  The whole construction itself should be inside of another
  enclosure such as a paper sleeve, behind a cardboard key cap, and so
  on.

If you pull wire out of random old electronics or phone lines for use
in electronics projects, there are some considerations you need to
keep in mind for this.  First off is the stiffness of the wires.
Wires designed for long cables are generally more stiff than would be
ideal for working on an electronics project, unless you are
specifically intending to use such wires for long cabling.  However,
if the wire is for "patch cable", the stiffness may be entirely
contained in the insulation, and heating it up with a soldering iron
may be all that is needed to bend it into the required sharp curves
for your electronics project interior.  Verify that the interior is
composed of stranded wiring, not solid core wire.

Phone line wires will be tricky to work with because the strands are
not twisted together, so when you strip the insulation, you need to
twist together the wires before working.  Also, you need to be careful
not to strip out too many wire strands when stripping off the
insulation, otherwise you should try again on a new cut.
