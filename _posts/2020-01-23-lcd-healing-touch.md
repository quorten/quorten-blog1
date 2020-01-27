---
layout: post
title: "LCD screens, the touch of death and the healing touch of life"
date: 2020-01-23 21:46 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Over the course of the past two weeks, I've had a very interesting
experience with the LCD screen in an old flip phone cellphone.  On one
moment, I made a bad touch to it and very nearly lost it all.
Literally.  And, in the following moment, I literally came back with a
healing touch and completely restored its original, fully functional
state.  Overall, this was a very great learning experience with
lessons to teach for working with LCD screens modern electronics,
especially DIY hobby projects where you are likely to handle the bare
LCD screen components before all protections are installed.

So, what happened?  What did I do that started my bad touch to the
screen?  I wanted to check my phone quickly while I was laying in bed,
but I had to turn on my phone first because it was powered off.  To do
this, I was first ruffling around frantically in my bed on a winter
day when the air was dry, then I quickly reached over to my phone on
the nearby table.  I had to open the flip phone to power it on, and
while I did, I made a few accidental touches to its internal LCD
screen.  Herein lies the problem.  All that ruffling around in my bed
on a dry air winter day built up a considerable static electric
charge, and reaching over quickly to touch my phone didn't help
either, as that meant that the static charge didn't have time to
slowly dissipate.  And, being that my phone was on my table, my table
was made of a more conductive material, so that meant touching things
on my table would lead static electricity to discharge through those
things more readily to my more neutralized table, and the two ends
especially had differing electric potentials at this moment.

<!-- more -->

Yes, what happened was that my phone's LCD screen met with
electronics' arch-nemesis: electrostatic discharge (ESD), the "touch
of death."  And thus began the problem.

Left behind was a swipe pattern of several black spots where my finger
touched.  Oh no!  Dead pixels?  If they're not, maybe a power off an a
power bavck on will remedy the problem.  Nope, likely dead pixels.
But, when you looked at the spots carefully, you could tell they
weren't totally black.  So these pixels weren't totally dead, or maybe
this was something else like bad video RAM.  In any case, powering
off, leave it sitting for a few hours, then power back on can be a
great way to heal electronics when they behave in a failure mode
similar to a tripped polyfuse.  So I did that, power off for 8 hours,
then power back on.  Nope, dead pixels don't heal themselves.

But, here's the surprise.  The next day, I kept my phone in my pocket
all day long, and upon removing it, I noticed that there were not as
many dead pixels anymore.  Wait, dead pixels don't heal themselves?
This is where you turn around and say, "Not quite, dead pixels can be
healed, if with a little external assistance."

So, over the course of trial and error that I will not detail here,
this is what I've learned.  First of all, here is a reference of what
Wikipedia has to say about LCD screen burn-in and how to reverse it.

20200125/https://en.wikipedia.org/wiki/Screen_burn-in  
20200125/https://en.wikipedia.org/wiki/Image_persistence

Second, Wikipedia's knowledge was pretty much not applicable to my
particular circumstances.  So how was it solved?  Heat.  Heat alone,
actually, was the "healing touch."  Exercising the crsytals via
display and power off may have helped a little, but by any means it
was only useful for starting the healing process.  The rest was simply
exposure to the correct amount of heat, and a consistent heat at that.
What better source than your own human body.  It maintains consistency
in its temperature quite well, not to mention us being water-logged
humans being a big part of this fact.  Through sufficient heat
exposure, by keeping the phone in my pocket and also sleeping with the
phone in my pocket to guarantee sufficient continuous, uninterrupted
temperature exposure, the problem was completely eliminated.

What happened when I was not consistent in exposing to to sufficient
temperature?  The LCD screen deformity grew.  Growing out with
spider-like veins, or the claw-like look of a dead tree as a haunted
house prop.  Growing like a viral infection threatening to consume my
entire LCD screen into useless "crystalization," useless rock content.
Because crystals, of course, take on the properties of their
neighbors: if a crystal has bad neighbors, it too grows up to be a bad
crystal.  In particular, cooler temperatures seemed to stimulate the
deformity to grow faster.

And, furthermore, getting the visual deformity to completely vanish
was not enough.  Once there was no more deformity visible, the screen
then had to be exposed to heat for a few additional hours to guarantee
that the deformity would never come back.  Otherwise, it came back and
started growing once again.

So, there you go.  Now you know one good way to heal LCD screens,
expose them to sufficient heat for a sufficient period of time, say
100 degrees for 48 hours continuously.
