---
layout: post
title: "Reflow soldering nylon connectors, and using solder paste with
        through-hole components"
date: 2020-04-06 21:30 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Molex PicoBlade, yes, one of my favorite connectors thus far.  Can you
reflow solder the header versions of these connectors directly onto a
printed circuit board?  Most of these connectors are made of Nylon,
which is deemed unsuitable for reflow soldering due to its high
moisture absorption rate.  I searched around on Digi-Key for PicoBlade
headers using a different insulation material, but I've found nothing.
So, is there other information out on the wider Internet about reflow
soldering with Molex PicoBlade connectors?  Yes...

20200406/DuckDuckGo molex picoblade reflow soldering

According to this Wikipedia article, many JST connectors are made of
Nylon and are unsuitable for reflow soldering, though there are a few
versions made of a different insulation material that will work with
reflow soldering.  Ah, that's not very helpful, other than hinting
that maybe it's not possible.

20200406/https://en.wikipedia.org/wiki/JST_connector

<!-- more -->

But seriously... I've seen commercial electronics with Molex PicoBlade
connectors positioned such that they could be coming straight out of a
circuit board.  And indeed, there is quite the trick here.  This is a
great article listing lots of information about reflow soldering,
along with lots of great tips on parts selections to best prepare your
designs for automated mass production manufacturing.  For example,
parts should have a flat surface so that they can be picked up using a
standard vacuum suction pipette, thereby not requiring more
specialized grippers or pipettes.

20200406/https://www.phoenixcontact.com/assets/downloads_ed/global/web_dwl_promotion/52004352_EN_HQ_Connectors_for_SMT_Production_LoRes.pdf

But, of course, the best thing that this article says is in relation
to using Nylon in reflow soldering.  You can, in fact, use Nylon in
reflow soldering environments, it's just that you have to pay
attention to the specifics of the moisture sensitivity level.  This is
a quantitative specification about how much time a part can spend
outside of the bag within the general factory floor space at room
temperature before it has absorbed too much moisture and has to be
rebaked to eliminate the moisture.  Specifically, baking at 125
degrees Celsius for 4 hours.

So, here's the key.  What if you don't know what the specific moisture
sensitivity level of a component is?  Apparently, moisture sensitivity
level is specified clearly for many surface-mount IC packages, but
connector headers tend to be devoid of such specifications.  In this
case, the ability to rebake components to eliminate moisture will save
you.  You simply assume that the component is the most sensitive
moisture sensitivity level and you must rebake it before performing
reflow soldering.  This will eliminate all the moisture inside the
component, so then you can safely subject it to the full reflow
soldering temperature without risk of delamination.

In essence, this is simply like an extended pre-heat section of the
reflow soldering curve.  Now you _really_ know why pre-heat is
recommended during reflow soldering.  Yes, it is to introduce
components to a more gentle rise in temperature to avoid fractures and
other breakage.  However, it's not just for temperature, it's also to
allow for a more gentle elimination of humidity in case the outer
casings of components may have absorbed some moisture.

20200406/https://en.wikipedia.org/wiki/Moisture_sensitivity_level  
20200406/https://en.wikipedia.org/wiki/Polyamide  
https://en.wikipedia.org/wiki/Nylon_6

Also, that great resource on reflow soldering specified another great
subject: reflow soldering wtih through-hole components.  You **can**
use solder paste for through-hole components.  How?  Push the solder
paste into the through-holes so that it fills them completely and
pokes out a little bit on the other side.  Then, push your
through-hole components into the board.  There will be a little bit of
excess solder paste on the bottom of the through-hole component legs.
That's okay, leave that there and try not to disturb it.  Then place
the board in the oven.  The solder reflow will spread all the solder
around the component nicely and create a meniscus of solder at the top
of the board.

So, what's the problem with using a soldering iron with solder paste
and through-hole components?  It's the whole "top of board" thing.
Usually, when working with a soldering iron, you work on the bottom of
the board, so if you used this technique, the solder wouldn't spread
around so nicely like it does when you do the full reflow soldering
technique in the oven.

By the way, through-hole components typically only make sense to place
on a board single-sided because, well, when the legs must extend all
the way through the board, that's surface area that is consumed on
board sides of the board to support the legs, so there isn't much of
an advantage to put such components on both sides of the board.
