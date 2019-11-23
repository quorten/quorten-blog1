---
layout: post
title: "3D scanning file formats, failure of 3D PDF, 3D scanning users"
date: 2018-04-14 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner, inven-sys]
tags: [3d-scanning, 3d-scanner, inven-sys]
---

Relating to the failure of 3D PDF files.

20180414/https://tex.stackexchange.com/questions/1030/for-movie15-based-3d-embeds-how-to-get-u3d-files

This TeX StackExchange generated a very interesting discussion.  How
do you embed 3D files inside of a PDF file?  Quite quickly in, it
became obvious that the methods and techniques of one party did not
transfer to those of the other party.  "I'm working with imaging data,
not drawings, so those conversion methods will not work for me."

So, let's step back for a moment.  Think about what's going on with my
most recently collected information.  Even though we're all
purportedly working on the same problem, 3D data, each and every party
involved has their own preferred tools to use to approach the problem,
and poor interoperability is the norm, not the exception.

So, let's start off with the basics.  3D printing and 3D scanning are
two opposite sides of a spectrum.  They represent two very different
modes of usage, with a clear majority representation on the side of 3D
printing, in preference to the 3D scanning user base.

So, what's going on to cause this?  Fundamentally, it is due to user
and market segmentation.  So, what are these market segments?

<!-- more -->

* 3D printing
  1. Engineers
  2. Medical staff
  3. Artists
  4. Historical museum staff
  5. Architects
* 3D scanning
  1. Medical staff
  2. Survey crews
  3. Artists
  4. Historical museum staff
  5. Engineering verification

* Note that "artists" generally translates to "entertainment": movies,
  video games, decorative art, and so on.  Likewise, "historical
  museum staff" also includes "education" because education frequently
  draws off of history, for example.

Suffice it to say, there is much greater representation in the 3D
printing market segment than there is in the 3D scanning market
segment.  Of the overlapping users between the two, there tends to be
far greater use of 3D printing than of 3D scanning among those users.

* 3D drawing and printing is _idealistic_, 3D scanning is _realistic_.
  From the conceptual standpoint, it should be clear why the printing
  area has much greater representation than the scanning area.  Most
  people in modern society want the world to look like this ideal
  image rather than accept the world for the way that it already is,
  and 3D printing is a means to that end.

    * Wow, I think about this, and it is really interesting.  I can
      study and type about this subject on a computer that only has a
      fraction of the computational power required for modern 3D
      graphics use, necessary for 3D modeling before 3D printing.

The workflow of the mass majority of 3D users can be described as
follows.

1. Start out with a series of 2D drawings.  Architectural plans,
   engineering drawings, and concept art are the prime examples.

2. Have a human use those 2D drawings to draw up a 3D model in some
   sort of 3D drawing software package.

3. Export the geometry from the native 3D drawing software's format to
   a format suitable for 3D printing.

   In the case of game development, export the geometry from the
   native 3D drawing software's format to a format suitable for the
   game engine.

4. Send the 3D model to a 3D printer for manufacturing.

   In the case of architecture, it is also possible to skip steps 2-3
   and have a human construction crew use the 2D plans to manually
   manufacture the final product instead.

   In the case of game development, the exported 3D models are bundled
   together with a binary executable game engine that is sent to the
   user as a single, logical, user-friendly, easy to install and
   executable package.

So, this is really interesting in the case of games.  Why hasn't there
come to be a standard 3D modeling file format that is recognized
across all 3D applications on modern computers?  Because, as it turns
out, the lack of one such standard _is_ the standard.

The standard is that the data format standard is determined by the
interactive application that reads it.  The bigger standard, then, is
the API standard that the operating system and hardware provides to
user applications that provide 3D interactivity.

Historically, every 3D game engine had its own preferred 3D model
format, and that is actually still very much the case today.  However,
in recent years the number of game engines in modern use has
decreased, as each modern game engine has become increasingly more
complicated and the number of such game engine developers has remained
relatively fixed.  Therefore, we're starting to see common "standard"
3D file formats for game engines emerge simply because there are many
more people authoring for a much smaller pool of available game
engines.

As it turns out, 3D modeling software lives off on its own island of
compatibility.  We have not quite seen the same decrease in diversity
happen with 3D modeling software that we've seen happen with 3D game
engines.  3D modelling software is split across two large islands:
engineering modeling software and artistic modeling software.
Engineering modeling software tends to work with "solid geomertry"
because it is manufacturing-oriented, whereas artistic modelling
software tends to work with "surface geometry" because it is 3D
rendering oriented.  However, there is a neat tie-breaker that unifies
the two islands: mesh geometry.  A 3D mesh geometry is a series of
(possibly connected) triangles that exist in 3D vertex coordinates.
Higher-level polygons can always be tessellated down to a triangle
mesh.  Curved surfaces can also be tessellated down to a triangle
mesh, given a resolution limit.  Finally, there is a subset of mesh
geometry that can unify with solid geometry; _manifold_ mesh geometry.
As it turn out, 3D scanners tend to be "voxel based" in a way such
that emitting 3D mesh geometry is also the standard for 3D scanners.
All of these factors combined, it should be clear that mesh geometry
is the winner-take-all in 3D geometry standards.

However, that tie-breaker in standardization covers the standardized
concept only.  What about standardized file formats?  It turns out
that there is a small handful of such formats, each split across its
respective major application domain.

* OBJ (and MTL)
    * Industry standard 3D format for artistic 3D modeling software.
* STL
    * Industry standard 3D format for 3D printing, and by extension,
      engineering 3D modeling software.
* PLY
    * One old and somewhat well-known format for 3D scanning.  Due to
      the smaller market segment size, this format has failed to gain
      the same standardization status that the artistic and printing
      formats have gained.  Colored vertices are an odd extension that
      this format supports but many others do not.  However, this data
      can be readily converted to a texture-mapped OBJ mesh.

Texture mapping is the _de facto_ way to specify additional surface
details on top of a base 3D mesh.

Also, worthy of note in 3D modeling software is that there is much
greater support for export and import into different file formats than
is the case with 3D game engines.  This is the key reason why it was
possible for there to emerge _de facto_ 3D data standards across 3D
modeling software.  Otherwise, each software developer would still end
up choosing their own preferred native format and interoperability
would stop there.

Newer formats have emerged that try to extend the features and
functions of these base mesh formats, mainly by better supporting
curved surfaces.  However, it turned out that each such addition was
highly specialized to its particular market segment (COLLADA, PRC,
AMF. 3MF, etc.), and there has been a shortage of converters available
to directly convert between these newer formats.  Suffice it to say,
it's better to start out with one of the mesh geometry base formats,
then convert your way up to the more modern formats.  Notably, there
already exists software that can take mesh geometry and analytically
compute curved surfaces and solid geometry from it, so this is the _de
facto_ standard migration path when you need a fool-proof way to
communicate 3D geometry.

Also, historically for both manufacturing and rendering, it is
necessary to specify a multitude of data on top of the base mesh data.
Traditionally, the way this is done is by importing the mesh geometry,
then having a human artist or operator manually "key-in" the data
through a graphical user interface, given a list of instructions
written in a natural language, typically English, to communicate these
higher level settings.  Namely, this kind of information relates to
dimensions, materials, printer settings, and render settings.

* What if you want to compose this scene made up of multiple 3D
  objects?  Well unfortunately, there isn't really a standard for
  that, other than the software + data method that ties down to a
  common OS API or hardware interface.  Renderman Byte stream (RIB)
  was one contender, but it failed to become very popular in the
  hobbyist community, where Blender is a mainstay and strong force.
  Even in the professional community, it didn't take off as much as
  one would have expected it to.  POVRay scene files are another
  contender, but their main representation is in the hobbyist
  community and there isn't really a strong representation in the
  professional community.  Even in the hobbyist community, POVRay
  still has a fairly weak representation compared to Blender.

  Unfortunately, as it turns out, there has been no such format like
  PostScript that has really took off in the 3D community.  Part of
  the anti-motivation in the 3D community could be due to the need for
  extreme speed that isn't similarly required for 2D data, which is
  why PostScript was able to take off very early on and very swiftly
  in relation to 2D documents.

Fundamentally, the reason why standardization isn't as strong in 3D as
it is in 2D is because not as many people communicate in 3D, and of
those who do, they don't communicate as frequently and as regularly as
is the case in the 2D world.  Finally, 3D is much more mathematically
rigorous and computationally intensive than 2D, so there are not as
many people skilled in 3D as there are in 2D, and 3D didn't become
viable on cheap commodity computers as early as 2D did.

----------

Okay, my old advice was to have a _3D scanning first_ mindset.  Now it
becomes obvious that I was pursuing the wrong path for most of my
intents.  Probably, it is better to pursue a _3D printing first_
mindset, as (1) this is a bigger market than 3D scanning, and (2) it
seems 3D printing has a longer history of an established standard file
format than 3D rendering, where "the standard" is the engine ans the
OS/hardware interface, _not_ the data format itself.
