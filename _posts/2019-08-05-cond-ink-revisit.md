---
layout: post
title: Conductive inks revisited
date: 2019-08-05 20:38 -0500
author: quorten
categories: [raspberry-pi, mat-sci]
tags: [raspberry-pi, mat-sci]
---

Previously, I've written a [blog article about conductive rubber]({{
site.baseurl }}/blog/2019/03/01/more-kbd-btn-build) and included a
link to a really good article that included information on a great
conductive ink repair chemical.  Unfortunately, revisiting that
article and reading it through, I've come to realize that for my own
practical use, it is probably a bit too specialized.  Namely, it is
marketed as a more durable solution to conductive ink that does not
wear off.

But, for those projects where cheap is good enough, conductive ink
does the trick.  Okay, so let's go a-seaching for solutions on that.
There are two primary chemical formulations:

* Carbon-based (i.e. graphite)
* Silver-based

Carbon-based is probably more preferrable to most projects, especially
those involving the repair of conductive rubber buttons, rather than,
say, the drawing of long conductive traces on paper.  Silver-based is
intuitively better for the latter, since it will have a lower
resistance.

There are also purportedly a few other formulations that are less
common, but may still fit the bill for some projects:

* Copper-based

Okay, so here is the preliminary results of our search.  You might not
want a conductive ink _pen_ because maybe it might not be felt-tipped
like you like it.

<!-- more -->

20190805/DuckDuckGo conductive ink pen  
20190805/https://www.circuitscribe.com/  
20190805/https://www.amazon.com/Archaic-Elements-Graphite-Conductive-Paint/dp/B07GL4S6GP/

You can in fact make conductive ink from pencil lead.  Simply find
some good low-resistance lead, verified with a multimeter, grind it up
by pounding it in a bag with a hammer and cloth pad, dissolve it in
warm/hot water, and mix in some glue to thicken the solution.

20190805/DuckDuckGo make conductive ink from pencil graphite  
20190805/https://www.youtube.com/watch?v=0hAuzWZH40E

----------

PLEASE NOTE: I've also written a [previous blog article]({{
site.baseurl }}/blog/2018/05/22/potato-cleaning) with the following
link to the great nickel-plating instructable, a useful reference for
electroplating in one particular circumstance.

20180522/http://www.instructables.com/id/High-Quality-and-safe-Nickel-Plating/

Another good point that has been mentioned in the comments on the
Amazon product page.  Electroforming a leaf by first applying the
conductive ink?  Oh wow, interesting.  So you can use conductive ink
to electroplate objects too?  What is the difference between the
terminology of electroplating versus electroforming?

The difference is an important technical differentiation in the
methods of the processes.  Technically speaking, _electroplating_
refers to applying a layer of metal on top of an already conductive
metal object, such that it can be used directly as the cathode in an
electrical circuit.  If you want to apply a layer of metal on top of a
non-conductive, non-metal object, the technically correct vocabulary
for that is _electroforming_, since prep-work needs to be done on the
object before it can be used in an electrical circuit.

20190811/https://en.wikipedia.org/wiki/Electroforming  
20190811/https://en.wikipedia.org/wiki/Metal_forming  
20190811/https://en.wikipedia.org/wiki/Electroplating

So, do you want to nickel-plate an arbitrary object?  Here's the
high-level process.

1. Paint a layer of conductive ink onto the object to prepare it for
   electroforming.

2. Electroform a layer of copper onto the surface of the object.

3. Electroplate a layer of nickel onto the copper surface.

20190811/http://www.instructables.com/id/High-Quality-and-safe-Nickel-Plating  
20190811/http://www.instructables.com/id/High-Quality-Copper-Plating/
