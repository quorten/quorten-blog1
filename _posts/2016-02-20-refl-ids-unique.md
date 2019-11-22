---
layout: post
title: Reflection on IDs, uniqueness, and rich object information
date: 2016-02-20 21:00 -0600
author: quorten
categories: [inven-sys]
tags: [inven-sys]
---

Again, I reiterate.  Things that can seem rather random to humans are
actually quite predictable to computers.  So, just because something
seems random to you doesn't mean that a computer will view that same
data as random upon further analysis.  Lesson learned, be careful in
how you generate the random suffixes for the object identifications.
Don't just use any computer random number generator.  Opt to use a
cryptographically secure one to generate these random suffixes.

Again, I reiterate, the problem with using local "centrally managed"
identification numbers.  If the identification numbers are not in a
public database, you'll need office hours access from personnel
working in the central database to access any metadata, such as
finding the owner's contact information of a lost pet to return the
pet to.

How about attach a USB stick to the dog collar?  "Additional
information inside."  One problem.  People nowadays who have
smartphones will have no way of reading the information inside of the
USB stick.  Okay, how about a Raspberry Pi Zero instead?  Okay, that
might be a little bit better, but... again, there may still be
technical difficulties.  How about on the Internet?  Again, the
problem is how will they know what site to go to?  What if you're
using a UUID?  The site to go to is subject to change?  Indirection?
Still, how are they ever going to find things?  Look, the problem is
that their simply just are no consistent standards in computer
technology to build additional applications off of that demand
consistency, sorry.  But for intermittent applications that only need
to work in the near term, such as marketing, then the current
semi-broken state-of-the-art is good enough.
