---
layout: post
title: Other reflections on math software libraries
date: 2020-06-22 20:10 -0500
author: quorten
categories: [unlipic, media-prog]
tags: [unlipic, media-prog]
---

In the course of finishing up my blog article on parallel compute
primitives, I had a lot of great ideas to write down in the reflection
conclusion, but after further thought about the general direction I
wanted that blog article to go, I decided that it would be better to
leave those out to a separate blog article.  Again, they're all very
good ideas worth reflecting on.

* Reflection on the typical structure of libraries.  Typically, most
  popular software libraries are "hand-hacked" optimized toward a
  particular set of assumptions, and naturally, these assumptions are
  never quite general enough.

* And why is this?  Well, as I can punctually testify from my
  experience of writing up this more general code, there's simply less
  things the human programmer needs to keep track of!

* And indeed, it is very much close to the metal.  Very much like
  assembly language programming.  The classic tenets of assembly
  language source code you've seen in the 80's and 90's graphics
  programming, complete replete reproduction in a more modern
  environment.

* The tendency of game programmers is to hand-hack things up to only
  target a very specific set of circumstances, often time computer
  hardware trends of the time.  And then the software would not work
  on my computer, it always required some special feature or function
  that was only available on newer computers.  Why?

<!-- more -->

* Intuitively, there was no reason I could see as a user.  As a user,
  the similarities are stronger than the differences.  Just that one
  set of software was programmed with a different set of hard baked-in
  assumptions.  Yes, indeed, lack of generality.

* But, I was not satisfied with such inflexibility.  I wanted to build
  off of what I was already seeing in other people's software:
  constant re-invention of an identical set of core concepts, each
  time with some implementation improvement for a particular
  environment.  But why stop there where such internal APIs were
  fractured development efforts?

  I wanted to be able to write software from a single source code,
  that through the magic of compile-time options and switches, I could
  have it run across a whole host of different computer systems.  Old
  to new, without a GPU, with a GPU, with a GPGPU, or no GPGPU at all.
  I wanted to efficiently cover everything when it was available, and
  still get working software even when not all the new stuff is
  available.

  And, ultimately, I wanted software that can run on simple computer
  systems, computer systems that are simple enough to build yourself
  and fully understand yourself.

* Yes, I totally understand, the motivation behind fractured
  development efforts.  Literally, it allows for development in
  parallel.  Now we're not talking the software running in parallel,
  but the humans behind the software development, those people running
  in parallel.

  And literally, what this means.  While one group is in the last
  stages of perfecting an old technology for commercialization and
  production, a different group is in the process of working on a
  technology that is not remotely available for commercial use yet,
  but when it is, it will be so much better than what came before it
  that it will completely displace it.

* And that's just the thing.  It's not that I wouldn't use older
  software at all that came before me.  It's that I'd use it primarily
  as a source of reading code for reference, to get an idea of what
  the old software did.  But ultimately, when it comes down to
  implementing it in my own software, my refactoring is so severe and
  intense that as a matter of practice, I cannot copy the old code.

  Yes, the concepts are there, but the idea of copying the code
  directly, it's not there.  So, therefore, neither is the concept of
  copyright.

* Most importantly, I wanted to illustrate this core math library well
  used by a suite of useful applications featuring advanced features
  and functions: projection 3D graphics rendering, high DPI laser
  printer resolution 2D graphics rasterization, analog electronics
  simulation, raytracing 3D graphics rendering, statistical analysis
  and data plotting software, 3D printing slicer computations,
  particle physics simulations, computational fluid dynamics
  simulations, thermal simulations, acoustic simulations, machine
  learning, just to name a start.

  Without useful demonstrations, or more importantly, without useful
  practical applications, it's pretty hard to convince other
  programmers of the utility of such a library.
