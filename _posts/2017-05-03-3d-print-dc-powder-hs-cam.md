---
layout: post
title: "3D printer design with DC motors, powder bed, high-speed cameras"
date: 2017-05-03 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner, 3d-printing, pentax-k-1-camera]
tags: [3d-scanning, 3d-scanner, 3d-printing, pentax-k-1-camera]
---

So now you're wondering about 3D printer design.  How does the optical
positioning encoder work in an inkjet printer?  Well, let's do a
search.  Surely we'll find some useful information.  Ah yes, I'm told
that the inkjet printers use a quadrature optical encoder.  Yes,
indeed I'm being told that this is to be used with an optical
alignment strip and LEDs.  Also it's interesting that the optical
encoders are purpose-built hardware that are calibrated to specific
optical positioning patterns that come with the printer.  So it's not
like it's something that the printer manufacturer fully understands,
in other words, nor is that the case with the software running in the
printer.

* Also, this is important too.  Commentary on why DC motors are used
  in modern inkjet printers rather than stepper motors.  DC motors are
  stronger, faster, and cheaper.  So that explains it!  That's why our
  newer HP printer is so much faster than our older Epson printer.

  Also, DC motors can generate less heat than stepper motors.

20170503/DuckDuckGo inkjet printer optical position encoder  
20170503/http://www.reprap.org/wiki/Microstepping_with_optical_feedback  
20170503/https://electronics.stackexchange.com/questions/208434/inkjet-printer-and-digital-encoder

<!-- more -->

Oh yes, I am coming back to the RepRap.  It seems there is a great
community around the RepRap with lots of great information on how to
build 3D printers.  So much, that I want to revisit the Wikipedia
article on this.  Is this the one that mentions the RecycleBot?  Yet
it is!

* Renote.  Again, I reiterate, because this is important!

20170503/https://en.wikipedia.org/wiki/RepRap_project  
20170503/https://en.wikipedia.org/wiki/Sarrus_linkage

  Although Charles-Nicolas Peaucellier was recognized for being the
  first to invent such a straight-line mechanism, the Sarrus linkage
  was invented earlier; it went, however, largely unnoticed.[1]

20170503/https://en.wikipedia.org/wiki/Peaucellier%E2%80%93Lipkin_linkage

Wow, the link to the "Desktop manufacturing" article goes to the 3D
printing article, and indeed, is it just me or has this article been
revolutionized with dramatic development in recent years?  Wikipedia
is an interesting machine.  It has all kinds of unusual biases.  This
time, it's showing its strength in 3D printing article documentation
but a curious weakness in 3D scanning article documentation.

20170503/https://en.wikipedia.org/wiki/Desktop_manufacturing

* One of the good things about the article above is that it includes
  integrated coverage of the legal aspects of mass market 3D printing,
  something that you emphasized must be covered when discussing 3D
  scanning.  Renote.  Again, I reiterate, because this is important!
  Yes, and we know why this is true.  Because changing technologies
  that make new things possible threaten to cause old cultural
  concepts to become obsolete.  Wow, that came out kind of
  differently, but you get the idea.  New technologies that bring
  things to people's attention that they were not aware of before,
  despite the fact of already being a constant possibility.

Ah yes!  So you know those "powder 3D printer" articles you've found
earlier?  Read carefully, these are in fact "inkjet printers" that
deposit powder and binder!  Yes, just like your ideas on how to build
an economic 3D printer by modifying an inkjet printer.

20170503/https://en.wikipedia.org/wiki/Powder_bed_and_inkjet_head_3D_printing

----------

Are there any high-speed cameras in the size and cost envelope of a
smartphone camera?  No?!  Oh, come on!  It's not that hard, is it?
Well, okay, fine, so it looks like the smallest and cheapest
high-speed camera available (as of 2017) is on the order of the size
of a small point-and-shoot camera of about $100.  Actually, some of
the newer point-and shoot cameras are augmented with high-speed video
capabilities, Sony cameras in particular.  Even some of Sony's DSLR
cameras can do high-speed photography, in addition to 4K video
shooting.  Oh, what the video luxuries you could get if you buy from a
brand name other than Pentax.  Yeah, but, Pentax is pretty good for
shooting for still photography, and the Pentax K-1 has some nice
features for such use that are not yet available in the other DSLR
camera brands.

Oh yeah, the cost of these Sony cameras you ask?  Still around a
couple of hundred dollars, over a thousand dollars for the higher end
models.

On the high-end of the high-speed cameras spectrum?  You can get 500
million frames per second.  Yeah, but those cameras probably cost a
fortune.

20170503/DuckDuckGo high-speed video camera small smartphone size  
20170503/http://newatlas.com/fps1000-affordable-slow-motion-camera/34161/  
20170503/http://mctcameras.com/  
20170503/DuckDuckGo high-speed video camera compact  
20170503/https://www.theverge.com/2015/6/10/8761045/sony-rx100-mark-4-rx10-mark-2-a7r-mark-2-price-announcement  
20170503/https://www.theverge.com/2014/3/3/5463784/sony-rx10-review
