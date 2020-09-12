---
layout: post
title: "More information on box certificate size limit, DIM weight,
        info on pallets"
date: 2020-09-01 02:57 -0500
author: quorten
categories: [inven-sys, raspberry-pi]
tags: [inven-sys, raspberry-pi]
---

Size limit on the box certificate?  What exactly does this mean?  It
is a single measure specified in inches.  According to Wikipedia, it
is the sum of the width, height, and depth.  However, trying that out
on some actual boxes, the result doesn't match the number that is
filled in.  Well, let's search around to try to see how that works.

20200901/https://en.wikipedia.org/wiki/Corrugated_fiberboard  
20200901/DuckDuckGo box certificate size limit

Okay, we get some hints here, it is related to the calculations of
dimensional "DIM" weight and planning pallet loads.

20200901/https://www.thepackagingcompany.com/knowledge-sharing/how-to-read-box-makers-certificate/  
20200901/https://www.thepackagingcompany.com/knowledge-sharing/glossary/corrugate/

20200901/DuckDuckGo calculate dim weight  
20200901/https://www.shipbob.com/blog/dimensional-weight-explained/

Okay, so now I know how to calculate DIM weight and now I know this
method of "DIM weight" is the tool that couriers use to compensate for
the fact that shipping high volume, very lightweight objects will have
higher operational expenses when shipped using the same motor vehicle
equipment optimized for heavier loads in their storage volume.  But, I
still don't understand size limit!

<!-- more -->

Okay, the other thing, calculating pallet loads.  Let's see if we can
find anything about this on Wikipedia.

20200901/https://en.wikipedia.org/wiki/Pallet

Well, that Wikipedia page sure had a lot of good information on
pallets directly, but it didn't say anything about the means to
calculate how to optimally pack a load onto a pallet.  One good thing
I wanted to point out from the article, the requirement for treatment
of wood palletes to prevent the transportation of invasive species
during international shipping.
