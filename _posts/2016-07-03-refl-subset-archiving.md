---
layout: post
title: Reflections on subset archiving
date: 2016-07-03 22:00 -0600
author: quorten
categories: [inven-sys, asman, reiterate]
tags: [inven-sys, asman, reiterate]
---

Again, I reiterate, albeit grudgingly.  When your computer does not
have very much space, you often times make a preference to store only
executable code that needs to make fast changes to memory internally,
and all static data is stored externally in printed documentation.
That was the historic modus operandi of computers when they didn't
have very much in the way of storage space.

BUT... what about now that computers have oodles of digital storage
space?  Well, sometimes you may still run into this problem when
working with embedded systems.  In that case, your course of action is
to store the data only in computer systems that are large enough to
contain it all.  The small systems will have to do without.

Oh yeah, and when you work with huge amounts of data, yes, you will
have to define storage volumes that work with a certain "order of
magnitude" of data.  Yes, that does mean that some forms cannot store
all data.

And what about data originating from paper?  Here, you have a
particular problem in that you need the software to generate the
optimal form data to be completely automated with absolutely no user
intervention.  In the case that is not possible, the digital storage
form will in fact be a liability to manage and a considerable expense,
so you might as well only go with the physical paper form in that
case.

<!-- more -->

Okay, so why don't we start?  Why don't I start by defining those
orders of magnitude?  Get a head start on what I must be heading to.

Okay, here's what I have.

```
77 MB computer generated text
1.8 GB small selection of "large" media files
```

Interestingly, the "large" media files occupied considerably less
different types of file formats than the small compact media files.
Maybe that says a thing or two about the future of digital
preservation and archival.  In other words, we're looking toward a
pretty bright future for the purposes of digital archival.  Plus, many
of these large files are either standardized or could be easily
converted to standard file formats.

```
find -name \*.7z -o -name \*.au -o -name \*.aup -o -name \*.aup.bak -o \
-name \*.bmp -o -name \*.tar.bz2 -o -name \*.tar.gz -o -name \*.jar -o \
-name \*.jpg -o -name \*.JPG -o -name \*.mov -o -name \*.mng -o -name \
\*.tga -o -name \*.tif -o -name \*.pdf -o -name \*.png -o -name \*.PNG \
-o -name \*.wav -o -name \*.WAV -o -name \*.WMA -o -name \*.zip -o \
-name \*.cab -o -name \*.ps -o -name \*.psd -o -name \*.sfx -o -name \
\*.xps
```

Actually, think about the case of PDF.  A PDF file can in fact be a
container format for JPEG and PNG images.  So, you could just say "all
your documents are to be identical PDF files" and that would end the
file format issue.

So, what were you going to say?  I was going to assign partition
sizes, but now that you've brought this up.
