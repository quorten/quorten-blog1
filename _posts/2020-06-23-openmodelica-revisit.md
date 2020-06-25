---
layout: post
title: OpenModelica revisited
date: 2020-06-23 18:16 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

OpenModelica is a good framework for physics simulation, so I am told.
So I revisit it, in the year 2020, and the result... looks like the
website hasn't been updated in years!  Argh... the style looks just
the same as the last time I visited years ago, which although it
looked fairly modern back then on the old computer I was viewing it
from, times have changed around the website, but the site itself has
not.

Well, anyways, the main question I had on my mind in relation to
OpenModelica was, what is its GPU compute acceleration support?
Unfortunately, looks like it has no such support.  Tough luck, it only
transcodes to C code, but has no special provisions for generating
OpenCL code.

20200623/https://www.openmodelica.org/developersresources/devdocumentation  
20200623/https://en.wikipedia.org/wiki/OpenModelica  
20200623/https://en.wikipedia.org/wiki/Modelica

Nevertheless, because it is an old software thing after all, it is
used by a lot of old-time players like car companies.  And... now
here's the thing.  For the Modelica model description language on its
own, there is a whole host of proprietary implementations, some of
which may indeed have GPU computer acceleration support.
