---
layout: post
title: "Does anyone outside of Inkscape use lib2geom?  Not yet..."
date: 2020-05-14 10:57 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

`lib2geom`, ah yes, the graphics math library that has been in
Inkscape for many years designed to be reusable outside of Inkscape.
But, really, I have to wonder?  Has it actually ever found success
outside of Inkscape?  All the related software I ever heard of in the
intervening years always used their own library, again duplicating on
the trend of app developers making a library of potentially sharable
subroutines that never get shared and reused in practice.

Well, that's far from the full story.  Actually, Inkscape's `lib2geom`
library was actually only ever fully available for an independent
public release two years ago.  So, that's the big reason why none of
the other projects you've heard of ever used Inkscape's library, it
simply wasn't mature enough and ready yet.  Second, about your
naysaying and criticism that the shared library will never get reused,
in fact many game developers and graphics programmers have been
inquiring over the years about the possibility of reusing Inkscape's
graphics math code in their own software.  Also, the library wasn't
just created by Inkscape devs, but it was a partnership with the
Monash University researchers hoping to get more widespread use of the
result of their research, so they too were eager to not just make
their results available in Inkscape, but also as a separate library.
So, let that be said, the effort to make it a separate library was
prudent and well-guided.

20200514/DuckDuckGo lib2geom  
20200514/https://inkscape.org/news/2018/11/11/graphics-math-library-2geoms-first-release-availab/

<!-- more -->

So now, this really gets me questioning about CGAL.  Indeed, the two
libraries are quite related in some ways, what's the difference?  The
most obvious difference from my standpoint is that `lib2geom` seeks to
be smaller and simpler, focusing more strongly on the specific use
case of vector graphics.  Also, whereas CGAL uses arbitrary precision
for all operations, I'd believe that `lib2geom` strives to used
floating point with a fixed number of bits of precision as much as
possible.
