---
layout: post
title: "Lessons learned on switched-mode power supplies and battery
        power for the Raspberry Pi"
date: 2020-03-29 09:34 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Switched-mode power supplies for the Raspberry Pi, the ultimate way to
get your Raspberry Pi Zero to run off of alkaline AA batteries, right?
No, actually it isn't.  The ultimate way is to connect Nickel
Metal-Hydride (NiMH) AA batteries almost directly to your Raspberry
Pi.

So, what exactly is going on here?  The primary problem at stake is
the limits imposed by the power consumption of the Raspberry Pi Zero
and the current supply ability of your batteries.  Despite the
Raspberry Pi Zero being considered a "low-powered computer," it is
still a relatively high power consuming device on an absolute scale.
Really, 250 milliamps at 5 volts?  That's 1.25 watts of power.  Sure,
that's not much power compared to traditional desktop PCs and
traditional incandescent light bulbs in wall and ceiling mounted
lighting fixtures, but that's an awful lot of power to draw from AA
batteries.  According to Wikipedia (and other sites not referenced), a
single alkaline AA battery can supply up to 0.5 amps of current before
its charge supplying ability starts to sag significantly below its
rated charge capacity in milliamp-hours (1400 mAh) or kilo-Coulombs (5
kC).

20200329/https://en.wikipedia.org/wiki/AA_battery

<!-- more -->

So, what does this mean if you're using 3 alkaline AA batteries to
power a Raspberry Pi Zero?  The Raspberry Pi without a camera
connected will draw 1.25 watts of power at idle, so that's `1.25 W /
4.5 V = 278 mA` of current.  With a camera, you've got double trouble,
so that's 556 mA of current.  Yes, that's literally just over the 0.5
A mark!  Your alkaline AA batteries will not last for long if they are
powering a _complete_ Raspberry Pi Zero system, and you will only be
able to get a fraction of the rated charge capacity before your
alkaline AA batteries have voltage sagged too low to be usable any
longer.

Now, this is exactly the problem.  What does a switched-mode power
supply do when the voltage sags from the batteries?  It _boosts_ the
current draw.  With alkaline AA batteries, this is going to further
exacerbate the problem you already have and the boost switched-mode
power supply on alkaline AA batteries will end up buying you almost
nothing.  So, point in hand... if you really want to power your
Raspberry Pi project using alkaline AA batteries, only use a buck
switched-mode power supply.  Or, limit the minimum current that your
boost switched-mode power supply operates on to 3 V to keep the
current boost effect under control.  If you want to get longer battery
life with alkaline AA batteries, prefer to wire more batteries in
series to provide a higher supply voltage at a lower current, the
alkaline AA batteries will thank you with many times increased energy
delivery in return.  So, let's answer the question: If you're
consuming 5 watts of energy, how many AA batteries should you use to
limit the current draw from them to 100 mA?

```
P = V * I
P = 5 W
I = 0.1 A
V = P / I
V = 5 W / 0.1 A = 50 V

50 V / 1.5 V per AA battery = 33.33 AA batteries
```

Whoa... now that's a lot of AA batteries.  If we make
compromises... limit power draw to 2.5 watts and tolerate drawing 200
mA of current, then we can get much more reasonable numbers.

```
2.5 W / 0.2 A = 12.5 V
12.5 V / 1.5 V per AA battery = 8.3 AA batteries
```

But still, it's not very impressive.  Think of the size and the weight
of all those AA batteries?  That hardly makes for a good portable
project, much less a "mobile device."

So, if at the very least, if you want to be more satisfied with
getting power from a battery power source that is not too far detached
from the fundamentals of electronics, you're better off using Nickel
Metal-Hydride AA batteries, AAA work well too for shorter-term uses.
These batteries work much better with high current draw applications,
their rated charge capacity will not sag nearly as much under high
current load as alkaline batteries do.  Also, with a nominal cell
voltage of 1.2 V, you can connect 4 of these batteries in series
directly to a Raspberry Pi Zero and get 4.8 V of power, well within
the 2.9 V to 5.2 V operating range of Raspberry Pi Zero.  By contrast,
4 alkaline AA batteries would push you over the limit that the
Raspberry Pi can handle.

But, how much is too much for NiMH batteries?  Looks like the "too
much" is well outside the range you may work with for Raspberry Pi.
NiMH batteries can definitely do well supplying 1.5 A of current, and
apparently NiMH batteries can also do well supplying 10+ A of current.
However, please note that before we start talking about such high
current draws, you've got to make sure that the wires and connectors
(if any) from your battery to your switched-mode power supply are
rated to handle that much current.

20200329/https://en.wikipedia.org/wiki/Nickel%E2%80%93metal_hydride_battery  
20200329/DuckDuckGo maximum current draw nimh battery  
20200329/https://www.eevblog.com/forum/projects/maximum-aa-battery-current-draw/

So, here is the crux of the point.  _Only_ if you are using NiMH
batteries is it safe to connect them to a boost switched-mode power
supply that will even boost when the voltage runs down to 2 V.
However, please note that at this point, chances are your wires and
connectors (if any) will be the limit on your maximum current draw, so
plan accordingly!  If unsure, set the minimum battery voltage so that
battery current is limited to 1 A.

Otherwise, if using alkaline, to limit the current draw from the
batteries, you should cut-off at 3 V.  But that's already what the
Raspberry Pi Zero does on its own due to the tolerance limits of the
internal buck switched-mode power supply... it has a minimum fixed
buck voltage of about 1.1 volts, and since the core voltage must be
1.8 volts, the supply voltage must be at least 2.9 volts.  So, if
these limits are _already_ in place, and you plan on connecting no
more than 3 batteries to your Raspberry Pi Zero, and you will either
use alkaline AA batteries or NiMH AA batteries but don't know in
advance, then there is absolutely no reason to use an additional
switched-mode power supply in front of the Raspberry Pi.

Otherwise, if you really want to use 4 or more AA batteries in front
of the Raspberry Pi but don't know their chemistry in advance, then it
makes sense to use a predominantly buck switched-mode power supply.
And actually, it wouldn't be a bad idea either to use an exclusively
buck switched-mode power supply either, given the constraints that
I've mentioned.  As you can see, if you want to build a project that
can take any random AA battery as a battery-powered voltage supply,
the chain is only as strong as the weakest link.

This is why a lot of computer-grade electronics don't run off of
standard AA battery cell sizes or the like.  There are just too many
dooming assumptions that must be made.  Yeah, you _can_ design your
device to run off of AA batteries, but surely the user will not be
happy.  The battery won't run long enough on a single charge... the
user will want rechargeable batteries for convenience, the user will
want a light battery pack, the user wants to continue using the
computer while the batteries are charging, the user doesn't want to
have to remove batteries for a charge or carry around two battery
packs, and the user would rather recharge frequently than carry around
a giant battery pack that doesn't need to be charged or changed very
frequently.  With all of these assumptions in place, the only thing
that matters for standardization is a standard way to plug in to
recharge the batteries, and that amounts to an AC wall adapter that
sends power to the computer, and the computer does all the rest with
charging the batteries.

Sure, those are pretty restrictive assumptions, but can't you at least
have some degree of serviceability and standardization on those laptop
battery packs?  Why can't you like open up those laptop battery packs
and get a series of standard AA cells that can be swapped out with the
right chemistry?  Well, first of all, if you let the user open up the
battery pack, they might replace with the wrong chemistry, and then
you'd have to handle that possible case with more complex logic inside
your smart battery pack.  Second, lithium-ion cells are dangerous.
Third, modern lithium-ion battery packs don't use standard can-shaped
cells anymore.  Each additional restriction and complication gets
added simply because of the rawness of sheer consumer demand and their
lack of interest to have an electronic that a novice can open up and
service to even the most basic extent.  Finally, the most dooming
assumption that has been made with modern smartphones is that the user
will never bother replacing their own battery, heck they're not going
to want to own the same smartphone for that long.  So, the smartphones
are now sealed up with no modular design for replacing the battery.

For makers, it's a sad story, I know.  But 'tis the course that all
modern mass market electronics must follow.  It already happened long
ago with the migration from through-hole components to surface-mount
devices in computer-grade electronics.  It was only a matter of time
that likewise would happen with the battery power supplies of
computer-grade electronics.

So, yeah... in conclusion, I dropped you some great guiding facts,
assumptions, and principles for battery-powered Raspberry Pi projects.
One thing I didn't cover was the idea of using D cell batteries, but
presumably you wouldn't want to use those anyways due to their sheer
size and weight.  In general, Raspberry Pi consumes too much power to
be easily usable with basic AA battery types.  Alkaline AA battery
power is more of the domain of lower-power microcontrollers like
Arduino.

Oh, and one last point I left open about switched-mode power supplies
and Raspberry Pi.  Indeed, you must first select your guiding
assumptions on what kind of battery and load you're using before
switched-mode power supply decisions become relevant.  Second, once
you do, there are a few more guiding tips to completing your journey
if you do decide to use a switched-mode power supply.

* Low current draw, of course, is king.  If your power consumption is
  below 5 volts at 500 milliamps, you have a whole host of options
  available to you, particularly some very nice maker-friendly boards
  that put a collection of high quality surface mount components
  together with 1/10 inch through-hole pads for the essential
  connections.

* If you must use a high-current draw, your choice of switched-mode
  power supplies is suddenly more narrow.  You might find you need to
  build your own, but then you'd opt to use through-hole components
  and find yourself with a much smaller market of opportunities due to
  your omission of all the nice surface-mount devices there are out
  there.  So then, another factor at steak becomes more crucial.
  Remember this key: if you need _high current draw_, chances are
  you'll be picking a _switching controller_ instead of a _switching
  regulator_.  This is a PMIC (Power Management Integrated Controller)
  that controls an external MOSFET of your own choosing for the main
  power switching, and this allows you to size it so that it can
  handle much higher current loads than a builtin switching MOSFET can
  handle on the inside of a _switching regulator_.
