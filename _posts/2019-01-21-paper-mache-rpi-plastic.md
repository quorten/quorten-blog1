---
layout: post
title: "Paper mache works well for Raspberry Pi cases, and notes on
        plastic health hazards pertaining to 3D printing"
date: 2019-01-21 14:00 -0600
author: quorten
categories: [raspberry-pi, mat-sci, 3d-printing]
tags: [raspberry-pi, mat-sci, 3d-printing]
---

Previously, my past few blog posts in this same category discussed
some of the enviornmental and health hazard implications of some of
our favorite modern materials, namely the issue of endocrine
disruptors.  Plastics are ubiquitous in modern mass production of
electronics, so if you are building your own Raspberry Pi embedded
electronics project, surely you want a nice plastic 3D-printed case,
now don't you?  So, that's where come back to the question of
environmental and health hazardous materials full circle.
Contemporary 3D printing for hobbyist projects is done generally at
home with your own 3D printer that functions by means of melting
plastic.  Whenever you heat any material up, there is the potential
for fumes to be emitted.  Sometimes these are pleasant fumes like from
a baking a delicious pie, other times they are noxious,
headache-inducing fumes like from melting polycarbonate for 3D
printing.  And it is the second type that has been called into serious
question.  Are stinky chemicals bad for your health?  Yes!

Sure, PLA 3D printing may still be a viable option for custom design,
but maybe not so much for mass production.  So, with all the potential
for hazardous endocrine disruptors in mass produced materials, do you
really need/want to use a similar material for your custom electronics
project?  As practical matter, I have found there to be very little
technical justification for this.  Paper mache can be just as strong
and lightweight as plastic for the same thickness, which means its
only disadvantage for hobby projects is lack of water resistance.
Without needing to heat the material, you'll get less stink when
constructing it.  Is this good enough for your project requirements?
For me, given that many electronics are not rated waterproof, this is
good enough for most of my projects.

<!-- more -->

Alas, if you think you can look to paper for a material less hazardous
to the environment and your health, well maybe that is true.  But,
even in paper, due to the use of BPA in "printer ink, newspapers, and
carbonless receipts," you'll find there are endocrine disruptors in
recycled paper (i.e. the most desirable paper for you to use).

20190121/DuckDuckGo does pla plastic contain endocrine disruptors  
20190121/https://www.motherearthnews.com/natural-health/dangerous-plastics-safe-plastics-zmaz09aszraw

Okay, so what if you grow your own paper?  Can you rid yourself of the
encodcrine disruptors that way?  Not so fast.  By this point in time,
the phthalate endocrine disruptors have leached their way into many
soils and groundwaters.  Even if you grow your own trees to make your
own paper, they might end up still containing phthalate endocrine
disruptors, though maybe less than the quantity found in recycled
paper.

Matter of fact, corn PLA plastic does **not** contain BPA.  Also,
according to this source, polyethyline (at least HDPE and LPDE) and
polypropyline _can_ be free of endocrine disruptors.  (Namely, these
materials almost never contain plasticizer additives.  Whether they
contain flame retardants that might be endocrine disruptors is unknown
to me) Polycarbonate should be avoided.  Also, do you smell the "new
shower curtain stink" on some plastic?  If so, that might be the
phthalates you are smelling.  Yep, that's you inhaling the endocrine
disruptors.  It's no surprise, then, that PLA, polyethyline, and
polypropyline are some of the favorite materials to be used for 3D
printing... alas, for 3D printing, other additives are used to make it
more easily printable.

20190121/https://articles.mercola.com/sites/articles/archive/2011/06/24/europe-bans-penis-shrinking-chemical-america-does-not.aspx

So, about brominated flame retardants.  What kinds of plastic contain
them, and what kinds don't?  Now, there is a much longer and more
interesting story behind this than yoi may realize.  First of all, out
of the many different kinds of brominated flame retardants, only some
of them are toxic, such as the ones that are halogenated.
Particularly, the halogenated ones are being phased out.  The
particular problem with halogenated flame retardants is that the small
molecules can migrate out of the material, and that's when it becomes
toxic, in addition to reducing the fire retardant property remaining
within the material.  The modern material move is toward polymeric
flame retardants.  These chain-link bind with the plastic polymer very
tightly, essentially fusing in to be an essential part of the plastic
material at the time of manufacture, so they have much less
prospensity to leak out of the material over time.  Now, in the old
days, we thought that brominated flame retardants were safe because
they were fused into the plastic and couldn't escape, but now we know
better that they do in fact escape.  That being said, suffice it to
say that we do not fully understand the environmental impact of this
new material, but with the best of our current knowledge, we believe
it to be better than the previous options.

20190121/DuckDuckGo which plastics contain retardants  
20190121/https://www.plasticstoday.com/materials/toxic-flame-retardants-are-still-being-used-plastics-even-though-there-are-alternatives/199932598957570

In this article I learned that PCBs were the precursor to PDBEs.
First PCBs had to be phased out, PDBEs were rushed in without too much
safety research, now PDBEs are being phased out too.  Also, lower
brominated PDBEs are more popular and more of a health concern than
higher brominated PDBEs.  The lower brominated PDBEs are known to
bioaccumulate.  Also, note that PDBEs can make toxic fumes when
burning.  So, for the sake of 3D printing at home, you want to avoid
recycling any plastics that might contain flame retardants that could
make noxious/toxic fumes.

20190121/http://nutritionwonderland.com/2009/09/plastic-troubles-brominated-flame-retardants-pbde/

Now, about the original question, well I guess I am content with the
information I learned so far.  Sure, I don't know what kind of flame
retardants a particular plastic may contain, but at least I know there
are better optionws available.  Okay... let's keep searching.

20190121/DuckDuckGo what kind of retardant hdpe jug contain

The Wikipedia article contains no information about the flame
retardants used in HDPE, but it does note that it is increasing in
popularity and market share thanks to the concerns about PVC and BPA.

201900121/https://en.wikipedia.org/wiki/High-density_polyethylene

Let's search more specifically.

20190121/DuckDuckGo polyethyline fire retardant

Ah, yes!  Although this article doesn't say much, some creative
thinking around the material provided does enlighten.
Reactive/incorporated flame retardants are added during the
polymerization of the plastic and change the properties of the
polymer; so, if you see the plastic recycling resin code on the
container, you know it doesn't use reactive/incorporated flame
retardants.  That leaves us with only the possibilities that it either
is "added" to the material, that is mixing that does not alter the
polymerization, or coated with the flame retardant.  Adding is
cheapest, so that's your indicator as to the most likely method used
for LDPE/HDPE food containers.

This also means right off the bat that we're not going to be using a
copolymerization flame retardant.

20190121/https://sciencing.com/how-12071421-make-polyethylene-fire-retardant.html

Now, speaking of all that discussion, now that makes me really wonder.
For electronics cases, sure plain paper and cardboard are great
materials to use, as I found cardboard being used in place of a
circuit board in my 200 in 1 electronics kit.  What makes paper fire
resistant and smolder instead of burning is its tendency to absorb
water vapor from the air.  But, if you add glue that potentially makes
the substance more flammable, that's a no-go.  Does adding Elmer's
glue to paper make it more flammable?  It seems like it
would... Elmer's glue has a distinctive smell and it is made from
petrochemical processes.  I'd be surprised if a chemical like that
didn't have a flammability **and** didn't use a flame retardant of
some sort.  Alas, Elmer's glue is quite elusive to get information on
due to its "proprietary" formulation.  In their safety data sheet,
they claim that Elmer's School Glue is slightly flammable, but it
doesn't have a flash point, and many questions about hazards to human
health or the environment either say "non hazardous" or "no data
available" quite elusively.  By the way, Elmer's School Glue is
**not** acid-free, so be forewarned if you are thinking of using it
for archival grade constructions.

20190121/DuckDuckGo does elmer's glue burn?  
20190121/http://www.1st-class-software.com/qna/Would_burning_elmer_s_glue_toxic-qna77941.html  
20190121/http://elmers.com/about/faqs  
20190121/http://elmers.com/about/faqs/general  
20190121/http://elmers.com/msds/category-search  
20190121/http://www.elmersbrands.com/docs/default-source/sds's-(safety-data-sheets)/se301.pdf?sfvrsn=2

Okay, enough of that, let's try looking into ways to make your own
vegetable oil.  Surely you can create a less flammable glue that way.
Well, maybe not.  It appears that most vegetable oils need to be based
off of starches or something with polymer chains that can break down
and release energy in a fire.  By far, the most popular recipe is
wheatpaste.  Second to that is one based off of corn starch.

20190121/DuckDuckGo how to make vegetable oil book binding glue  
20190121/https://en.wikipedia.org/wiki/Wheatpaste  
20190121/DuckDuckGo make glue from vegetables  
20190121/https://www.ehow.com/how_12133280_make-vegetable-glue.html  
20190121/https://sustainableecho.com/homemade-natural-glue/  
20190121/https://www.wikihow.com/Make-Glue

Okay, so how is it done with Portland cement in concrete?  We know
that material is not flammable.  Well, as it turns out, the exact
chemical processes of Portland cement hardening are not well
understood, but it is some kind of crystalizing that causes the
adhesion, rather than polymer chains.

20190121/https://en.wikipedia.org/wiki/Portland_cement
