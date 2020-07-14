---
layout: post
title: "Summary of DIY printed circuit board manufacturing, and tips
        on solder fume protection"
date: 2020-07-10 16:26 -0500
author: quorten
categories: [raspberry-pi, reiterate]
tags: [raspberry-pi, reiterate]
---

Again, I reiterate, because this is important!

Want to make your own printed circuit boards?  Or, to put it rather
more bluntly... commercial printed circuit board ordering as-a-service
typically has a minimum order quantity greater than one.  If you only
need to manufacture exactly one printed circuit board of a design,
commercial services will leave you with 2-10 extra circuit boards.
So, to get that manufacturing in quantity of one, you have to
do-it-yourself.  How?

There are three main methods at your disposal as a DIYer.

1. Chemical etching: use a laser printer to create a photoresist mask,
   iron it onto copper-plated bare board, then chemically etch away
   the non-conductive parts.  The disadvantage is that you have to buy
   extra metal that gets dissolved into your chemical etching solution
   that thebn gets disposed.  Also, the fact that you have to work
   with wet chemicals.

2. Chemical deposition: use an inkjet printer or similar to deposit
   conductive ink onto an unplated circuit board substrate, then use a
   copper ion bath to electroform the metal traces.  The disadvantage
   is that you'll typically be left with unused metal ions in your ion
   bath, which will need to be either saved for future use or disposed
   of.  Also, the fact that you have to work with wet chemicals.

<!-- more -->

3. Mechanical etching: use a CNC milling/drilling machine to etch away
   the metal from a copper-plated bare board.  The disadvantage is
   that you have to use a noisy milling/drilling machine and deal with
   the etched off metal dust, but the advantage is that the etched off
   metal dust is potentially easier to recycle and reuse than the
   chemical baths.  Also, if you are working with through-hole
   components, you might have to drill holes anyways, so this solution
   also gives you ready access to the necessary drilling tools to do
   so.

So, there is no clear "easy" way to make your own printed circuit
boards, but it is definitely doable if you're willing to make some
personal sacrifices.

Also, once your done with the circuit board, if you are doing reflow
soldering, I've mentioned there are easy and cheap ways to do that
with a conventional oven that give you reasonably good results.  I'll
briefly summarize the important tips I've mentioned previously.  Use
an approximate temperature ramp-up curve to bake out any moisture that
may have been absorbed into moisture-sensitive components before
reaching the reflow temperature.  Also, I recommend **not** to use the
same oven you use for your kitchen food, and especially not an oven
built into the wall, a toaster oven is the best.  Why?  Even if you
are working with lead-free solder so as to avoid food poisoning risk,
the secondary problem is that the flux itself is chemically similar to
paint remover.  It has to be, if the goal is, you know, to clean
metals for optimal joining.  Especially for lead-free solder, the flux
is much more profuse, so the problem is potentially magnified... that
doing so may ruin your oven's internal paint or coatings.  Hence, the
recommendation to use an _expendable_ toaster oven, not to mention
that the smaller volume means less energy to heat it up to the
required temperature.

Finally, this applies with both hand soldering and reflow soldering.
Keep in mind where your flux fumes are being vented, you don't want it
touching random indoor surfaces as it can cause damage due to its
paint remover style chemistry.  Ideally, use an air filtering system
to suck in and catch the solder flux fumes before they can touch any
vulnerable surfaces, walls and ceilings being a first obvious target.
A simple fan with an activated carbon filter is the cheapest, but
certainly not of ideal effectiveness, actually considered totally
ineffective by some if the purpose is to protect human operators.
But, something is better than nothing.  Also, another cheap solution
you can use.  If your indoor environment is controlled with minimal
random wind and clearly directional air flow, then you can set up your
own "catchment" or "mini-ceiling" where the solder fumes will be known
to strike first.  This will at least immobilize most of them before
the remainder touches the walls or ceiling of your room.

UPDATE 2020-07-12: Digi-Key now offers a really nice service where you
can upload a design and compare prices from multiple different board
houses.  Many of these are based in California, USA.  And, the best
part about it, you can order in quantity of one!
