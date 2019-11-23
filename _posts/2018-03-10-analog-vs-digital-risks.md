---
layout: post
title: "Nothing will fully replace analog, risks of digital data
        storage, tech interface layers, small objects"
date: 2018-03-10 22:00 -0600
author: quorten
categories: [inven-sys, tour-de-force, reiterate]
tags: [inven-sys, tour-de-force, reiterate]
---

* Nothing will fully replace analog.  Paper, 2D images, you can't beat
  it.

    * Again, I reiterate, because this is important!  I searched for
      this and found it, that means it's important!

The risks of digital data storage, format obsolescence, and conversely
the non-issue of optical storage.  Specifically, microfilm archival.
Simplicity and ease of use.  Likewise, "well-established" computer
compatibility patterns, or lack thereof.

Computers have been around for quite some time for now, and one
unfortunate trend that has become quite proven out in general is the
difficulty of data migrations.  This was more a problem early on in
computers than it is today.  Historically, most digital data was
stored in proprietary file formats, and any effort to migrate data
digitally from an old system to a new system almost always entailed a
complex process of reverse engineering the proprietary file format,
writing a computer program to do a file format conversion, running the
converter, and copying the converted data to the new computer system,
which might involve the use of special adapters and communications
protocols, of which interfacing both sides between the old and the new
systems is difficult.  Yes, computer systems have a long history of
creating obsolescence.

<!-- more -->

How does the general trend work?  First, a "new standard" is
developed.  It gains traction for a short period of time, but almost
always, eventually there is a "compelling new" technology that is
completely different from the old technology.  It is so much better,
and so many people race to it so quickly, that the fact that this new
technology is incompatible with the old one is basically forgotten.
Come on, "almost no one" used the old technology, but now "everyone"
uses the new technology, what's the point of writing file format
converters?  Often times, the way things work out is that the original
designers of the new technology weren't trying to make it compatible
with the old technology because they didn't think it was meant to
capture the same market.  And they were right.  It's just the
specifics they were wrong on: they thought they'd capture a much
smaller market, but in the end they captured a much larger market.

So, the compatibility problem?  Given the specifics mentioned above,
this is mostly looked upon as a sad fact, an element of misfortune.
But sure, it is also looked upon as predictable: surely customers of a
historically small market knew they would have to do things much
differently from the mass market, right?  They'd be working in
esoteric custom-rolled file formats, so they'd have to write esoteric
tools to convert their way out.

Nevertheless, even today, we see the same thing going on, even in
markets of the same size.  A standard is developed, say an operating
system.  The operating system has support for a range of hardware
built in, via device drivers.  But eventually, new hardware with an
incompatible interface is introduced, and the old hardware with the
old interface falls out of favor/popularity.  Eventually new operating
systems drop support for the old hardware device drivers and
interface.  Likewise, the old operating systems no longer have support
for the new hardware that has risen in popularity to the point of
replacing the old hardware.  Suffice it to say, even in modern times
when computers number in the billions (via smartphones), the same
pattern of incompatibility still holds with virtually every symbolic
interface, from hardware to software.  One cannot guarantee nor place
their faith in the assumption that they will always have a
pure-digital lossless migration path for their data.

But wait!  In spite of the inevitable fact of breaking change in the
world of computers and inevitable requirement to be prepared for
format migrations, there are some emerging patterns of where the more
reliable and less reliable standards are to be found.  Let's take a
look at what these are.

First of all, let's review our stack of symbolic interfaces used in
interactive computer software from Tour de Force.

* Physics (analog data sources)
* Hardware interface
    * Network communications interfaces
    * Graphics hardware
    * Storage hardware/interfaces
    * RAM interfaces, CPU sockets, PCI bus sockets, other internal
      connectors
* Driver interface
* Operating system interface
* OS native library interface
    * Network communications protocols
    * OS-native file formats
* Platform abstraction library interface
    * Platform independent file formats
* HTML 5 Web API interface
* User interface

Now, as we've just said, all of these interfaces are subject to
change.  However, out of this stack where most things are subject to
change, there are a few things that are most resistant to
incompatibility and breaking changes:

* Network communications interfaces
* Network communications protocols
* Platform independent file formats
    * Especially platform-independent file formats that are very
      frequently used in electronic communication, especially when
      they are used by a very large number of people

Conversely, there are a few things that are least resistant to
breaking changes and incompatibility:

* Network communications interfaces
* Graphics hardware
* RAM interfaces, CPU sockets, PCI bus sockets, other internal
  connectors
* User interface

So, that should give you a pretty good idea of what choices you need
to make if you want to preserve information, and what things you
should avoid if you don't want to be caught by surprise by
incompatibility and obsolescence.

----------

What is the most intuitive and convenient way for humans to work with
very small objects?  Computer-like use.  It's well-established as a
practical means of working with very small objects.  After all, that's
what computer hard disk drives and graphics displays do.

* But, the corresponding issue when working like that for long periods
  of time.  You need to take breaks to get exercise, unlike working in
  the macro scale which does not demand such.  Taking breaks from
  over-exercise is what would be done in the macro scale instead.

** Why this is interesting.  Shrink it down when you don't care about
   it, expand it up when you do.  In some sense it is a paradox.  You
   don't want it anymore, so you get rid of it?  Nope, you just crush
   it down into a tiny amount of storage space when you don't want to
   see it, then you expand it back out to thousands of times its
   physical size when you do want to see it.

----------

* The fact that America has engineering capacity but not manufacturing
  capacity... it is very much in the same position that developing
  nations are in related to engineering capacity.  They have the
  computers, the money to purchase them, but not the engineering
  capacity to get there.  The technology simply comes from a "foreign
  nation."  Literally, in the meaning of the word foreign.  So yes,
  for American consumer culture too.  Americans have the engineering
  capacity to design the doodads required for consumer culture, but
  America does not have the manufacturing capacity to feed consumer
  culture's consumptive electronics habits at the current economic
  rates it is expecting.  Only a literally "foreign power" can produce
  that which is demanded by consumer culture, at its desired price.

* Mistakes in software?  The state of software engineering today is
  very similar to the state of mechanical engineering in the 1800s.
  Locomotives were unpredictable, fussy, and sometimes dangerously
  crashy, explosive, and deraily.  Nowadays those machines are very
  predictable and reliable, but we currently have unpredictable and
  unreliable software that is prone to glitches, crashes, bugs, and
  errors.  So, yes... what I am saying is that the newest technologies
  come with predictable problems, but older technologies are very well
  behaved and reliable.
