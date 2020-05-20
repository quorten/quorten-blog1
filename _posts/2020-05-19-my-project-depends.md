---
layout: post
title: My complex project dependencies
date: 2020-05-19 17:58 -0500
author: quorten
categories: [unlipic, pentax-k-1-camera, media-prog]
tags: [unlipic, pentax-k-1-camera, media-prog]
---

Ugh, when working on my various projects, I keep asking myself.  Is
this really necessary?  As the answer, unfortunate for me who is
impatient and wants to hurry through these things, is yes, they are
necessary.  The reason why I am doing this is because I want to really
build in more quality than you get from the stock commodity solutions
on the market.  That means I've got to put more effort into adding
quality into the things which are currently just being sosld as-is on
the market for a lower quality, albeit at a much higher price.

Really?  Well, I mean, you get the solution faster, but to you, it
comes at a higher monetary price over a shorter period of time, all at
a over level of quality than would be possible had you designed your
more expensive solution first, expensive in terms of your time though
not in terms of your money.  I mean, come on, what is your unpaid free
time worth?  Substantially, you'd be led to believe that it is worth
zero, because you are being paid zero.  And that's why it's cheaper
because it's not worth as much on a monetary scale.  When not many
people care about high quality solutions, often times it doesn't pay
to try to build more quality into a product than the ones the market
already seems to be satisfied with, but are of a lower quality.

So, here is the dependency graph of some of my high priority projects
that I am in some way working to move forward.

<!-- more -->

```
DEPENDENCIES:

Bootstrap GUI : bootstrap graphics library

Stable GUI foundation : Qt OR bootstrap GUI

Graphical file manager : stable GUI foundation AND JPEG
  decompressor interface

Journaling file system : Graphical file manager OF MY OWN

Photo scanning workflow software : Graphical file manager OF MY OWN

Finish organizing my files and bring all backups up-to-date :
  Journaling file system

Finish Raspberry Pi project board soldering : New soldering
  workspace strategy to protect the ceiling from solder flux
  fumes damaging the ceiling finish

Paper weight scale : Finish Raspberry Pi project board soldering
  AND Proof of concept scale software

Finish magazines scanning project : Photo scanning workflow software AND
  Paper weight scale

Finish 3D scanner : Image/video library interface AND finish testing
  3D math library AND cleanly separated lens distortion interface

3D printed photo scanning rig : Finish 3D scanner AND 3D scan
  existing rig

Finish photo scanning : 3D printed photo scanning rig

Artificial intelligence machine learning : Lots of original
  source data, both 2D and 3D.

Market, advertise, and sell my own business to raise revenue :
  Marketing research, learn from the masters by analyzing all the free
  marketing materials available to me, digitized from my own sourcing.
```
