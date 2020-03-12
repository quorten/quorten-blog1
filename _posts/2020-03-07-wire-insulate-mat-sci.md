---
layout: post
title: Hook-up wire jacket insulation materials
date: 2020-03-07 13:09 -0600
author: quorten
categories: [raspberry-pi, mat-sci]
tags: [raspberry-pi, mat-sci]
---

Searching around for hook-up wire jacket materials on Digi-Key, I am
met with a variety of choices for the jacket material, but which ones
to choose?  For the sake of simple hobby projects, there is an obviosu
eliminating answer.  How hazardous are the materials?

There are a variety of jacket materials that incorporate fluorine.
The advantage of these materials is increased strength and durability,
increased working temperature range.  The problem though... if they
are burned, they release hydrofluoric acid...  as gas, into the air
that you breathe.  And that is a really dangerous nasty chemical that
you don't want touching your body.  Now that's all fine and all if the
working temperature range is well beyond soldering temperatures, but
as it turns out, the temperature limit is 150 degrees Celsius (300
degrees Fahrenheit).  That's well below the temperature of soldering
irons, so any materials with fluorine in them are a no-go for me.

20200306/https://en.wikipedia.org/wiki/ETFE

What is irradiated polyethylene?  Here's the key.  When polyethylene
is exposed to radiation, that causes cross-linking which increases the
strength of it.  Okay, great!  All is good in terms of materials
properties and composition as far as I am concerned.

20200306/https://en.wikipedia.org/wiki/Polyethylene  
20200306/https://en.wikipedia.org/wiki/Irradiation  
20200306/https://en.wikipedia.org/wiki/Cross-linked_polyethylene

<!-- more -->

Now, one last material.  "Polyphenyl" materials?  Well, you look at
the chemical composition, you see hexagonal rings.  Sure, that
acceptable to work with, but be cautious about the whole endocrine
disruptor thing, if this gets burned, like accidentally during
soldering, it could release endocrine disruptors, you could breathe
those in, and it could mess with your endocrine system in all those
negatively subtle ways.

20200306/https://en.wikipedia.org/wiki/Polyphenyl_ether
