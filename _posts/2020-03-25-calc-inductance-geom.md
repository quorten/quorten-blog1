---
layout: post
title: "Understanding inductance calculation based off of geometry,
        and enlightenment on the readymade inductor market"
date: 2020-03-25 19:50 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Inductors, inductors.  The sophisticated looking "donut rings" that
taunt electronics hobbyists.  You wnat to get beyond the basics and
get into building your own switched-mode power supplies, and this
requires an inductor, ideally a "donut ring" inductor.  Okay, so how
do you approach getting one of those?  Some people buy their toroidal
inductors, others wind their own.  That being said... I want to know
how you wind your own.

The Wikipedia article on inductors contains some good equations for
calculating inductance based off of geometry.

20200325/https://en.wikipedia.org/wiki/Inductor

So, let's try out an example with the dimensions of one toroidal
inductor ferrite core that I found on Digi-Key.

20200325/https://www.digikey.com/product-detail/en/tdk-electronics-inc/B64290L0618X038/495-3861-ND/1830191

<!-- more -->

```
rectangular cross section
diameter = 22.6 mm = 0.889764 in
thickness, 1/3 total diameter (1/6 edge) = 3.8 mm = 0.149606 in
inside diameter = 22.6 - 7.6 = 15 mm = 0.590551 in
height = 11 mm = 0.433071 in
30 AWG wire diameter = 0.25 mm

Work out the area into turns, single layer...

One turn = 2 * (3.8 mm + 11 mm) = 29.6 mm
Surface area: pi * 11 mm * (15 mm + 22.6 mm) +
  2 * pi * ((22.6 mm/2)^2 - (15 mm/2)^2) = 1748.233 mm^2
1748.233 mm^2 / 0.25 mm = 6992.932 mm length wire @ 30 AWG single layer

Number of turns: 6992.932 mm / 29.6 mm = 236.248 turns

L = 0.00508 * 236^2 * 0.433071 * ln(0.889764 / 0.590551)
  = 50.226 uH
```

Wow!  That's quite a bit of inductance... too much for my particular
application, actually.  That assumes air core,
apparently... calculating with the ferrite core inductance factor
`A_l` is 617758.919 uH... gosh that's big.

Okay, better method to compute inductance, now that I am better
educated.

1. Find "effective length" (l_e) that states a measure of inner
   diameter that you can use with the diameter of your wire to compute
   the number of turns you can put on the coil.  Worst comes to worst,
   you can compute this yourself by looking at the geometry.

2. Compute the number of turns (N) on a single layer by dividing
   effective length by the diameter of your magnet wire.
   `N = l_e / wire_diam`

3. Find the "inductance factor" (A_l) and compute inductance as follows:
   `L = A_l * N^2`

Okay, let's try calculating on a smaller toroidal ferrite core.

20200325/https://www.digikey.com/product-detail/en/tdk-electronics-inc/B64290P0037X038/495-3873-ND/1830203

Smaller inductor, 61 turns single layer, inductance factor 2.53 uH.
Result: 9414.13 uH.  Okay, still too big.

Let's solve for the ideal, then.

```
L = 22 uF
22 uF = 2.53 uF * N^2
N = sqrt(22 uF / 2.53 uF) = 2.949 turns
```

Whoa... I must be doing something wrong here.  Or maybe it's just that
those donut rings are bound to have very high inductance.

Okay, how about a small cylindrical coil about the size of the ones in
doorbell ringers.

```
4 * 3.14 * 10^-7 * 1 * 200^2 * 0.000314 / 0.08
= 197.192 uH
```

Okay, that's pretty good.  So we know a doorbell ringer solenoid must
have a couple hundred micro-Henries of inductance.

One turn = one circle around the core, not a complete surface coverage
of the donut ring.  Remember, we started with the straight cylinder
inductors, and there it makes quite a bit of sense to count in terms
of turns around the cylinder.  So one turn, that's like one circle,
yes.

But hey, one point that I must make.  About air core versus ferrite
core inductors.  Why are ferrite core inductors recommended for
specific applications?  The key is that the core material itself is
non-conductive so that it resists the formation of eddy currents and
the _core losses_ that result.  This allows ferrite core inductors to
be efficiently useful at high frequencies.  Air is also, of course,
non-conductive so it is applicable to that particular use.  The only
disadvantage of an air core is that the physical size of an equivalent
inductor must be much larger than a ferrite core inductor.  However,
if you only need a low inductance value, say around 20 uH, and you
calculated that a resonable size geometry can deliver that inductance,
then definitely go with the air core inductor.  It will save you money
when it works well.

So, in case I didn't state the conclusion concisely enough... are you
building your own switched-mode power supply?  Don't worry about
hunting around for the ideal readymade inductor to buy.  Just 3D print
(or even paper mache) your own toroidal core, and wind your own coil
with enamel-coated magnet wire.  You'll easily be able to create the
needed air core 22 uH inductor, and by virtue of being an air core
inductor, it will be efficient switching at high frequencies without
core losses.

One important thing to state about cylindrical cores, though.  It's
easier to buy readymade bobbins to wind a cylindrical core inductor
upon, probably because it's just simply easier to wind a cylindrical
core than a toroidal core, so the market is that much bigger.

----------

Here is another source for information on building your own inductors,
but it appears to focus exclusively on cylindrical inductors.  Not
bad, but it could be better.

20200326/DuckDuckGo build your own 20 uf inductor  
20200326/https://hackaday.com/2017/06/12/design-a-coil-for-a-specific-inductance/  
20200326/https://rimstar.org/science_electronics_projects/coil_design_inductance.htm

----------

Ah... but maybe I spoke too soon on that one, about winding your own
inductors.  Why was I earlier having trouble finding an inductor on
Digi-Key for my switched-mode power supply?  I was too restrictive in
my search and didn't fully understand the requirements for the
inductor.  Here is a good readymade toroidal air core inductor.

20200326/https://www.digikey.com/product-detail/en/signal-transformer/HCTI-22-16-4/595-1721-ND/7362972

It's cheap, it's toroidal, it's air core, it's high current, it's low
DC resistance, but it's rather large.  If you're willing to exchange
for a smaller size at a higher price, you have options.

First pick, I assume this must be an air core inductor since its
design is identical to the other one that explicitly said it was air
core.  Less current, higher DC resistance, but otherwise still pretty
good.

20200326/https://www.digikey.com/product-detail/en/bourns-inc/2105-V-RC/M8850-ND/775389

And if you want horizontal mounting, you can use this one.  Vertical
versus horizontal is the compromise between minimizing required board
height versus minimizing required board surface area.

20200326/https://www.digikey.com/product-detail/en/bourns-inc/2105-H-RC/M8804-ND/775343

Interestingly, if you look at the inductors, they have exactly the
same geometric appearance in number of turns, inner diameter, and
outer diameter regardless of the physical size.  Indeed, this is
correct.  If you look at the inductance equations, the inner and outer
diameters factor into the equation in a proportional relation, so the
inductance is pretty much independent of the physical size of the
inductor provided that the geometric proportions are persevered.  This
is why those tiny canned inductors on the Raspberry Pi zero board can
have a surprisingly high inductance value.
