---
layout: post
title: Lessons learned from trying to search for integer math libraries
date: 2020-04-13 17:15 -0500
author: quorten
categories: [tour-de-force, 3d-scanning, 3d-scanner]
tags: [tour-de-force, 3d-scanning, 3d-scanner]
---

One thing that has been an ongoing challenge in the design of my 3D
scanner software, well, almost any of my software in general I guess I
could say, was the lack of good integer math library routines.
Surely, there's got to be good integer math library routines out
there, I just need to search for them, right?

Well, that's the catch.  Yes, there are good integer math routines out
there, but traditionally, you won't find them in a nice standalone
library.

Come on, think about the greatest software you know of that uses
integer math extensively.  Not just the basics, but integer arithmetic
for higher level mathematics.  The Doom and Quake game engines come to
mind, along with the MPEG-2 audio/video codecs.  How did they
implement their integer math routines?  Did they find them in a shared
library?  Nope, they wrote them all on their own.  Did they even
create a shared library of their own?  Nope, they wrote them solely
for the purpose of embedding in the Doom and Quake game engines.  For
the MPEG-2 audio/video codecs, although the audio/video interface is
exposed as a shared library, the integer math routines are not.  So
the greatest integer math programmers did that, so you must do it
yourself if you want great integer math for software of your own.

<!-- more -->

Really, think about it.  Often times, integer math primitives require
careful numerical analysis, and the specific primitives implemented
will be highly specific to the specific application.  Floating point
arithmetic requires no such rigor because the users probably aren't as
concerned about numerical stability and all that.  Therefore, it is
far easier to create a general-purpose floating point shared library
than it is to create a general-purpose integer arithmetic shared
library.

So, naturally, floating point math libraries are prolific and well
established, whereas integer math libraries are scare and barren.

At the end of all of this, yes I am writing my own integer arithmetic
routines.  They are awesome, but at the same time, I can see how they
will end up being fairly specific to the particular applications I am
writing and are unlikely to find their way into many more
applications.  At the end of the day, there's politics, and also the
fact that with the politics of software developers, the average
software developer is not particularly skilled at advanced
mathematics.
