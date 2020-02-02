---
layout: post
title: Cheap 3D scanner designs, moving parts, camera selection
date: 2016-08-03 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner, important]
tags: [3d-scanning, 3d-scanner, important]
---

Oh yeah, this is very important.  3D scanner notes continued.  So, you
were asking this question.  Yes, as noted above, you learned about
some practical designs for cheap scanners, but you've also noted that
those cheap scanners don't get very good resolution.  Now you're
asking the question.  How do you get a scanner that is both cheap and
high quality?

Okay, here's one approach that works very well.  You attach your laser
line generator to the carriage inside of a flatbed scanner.  To keep
the cost down, it is very simple and cheap to get an old unwanted
flatbed scanner that you can modify.  If you suppose that your flatbed
scanner only scans one line at a time and needs to step the carriage
to scan the very next line, and if your flatbed scanner is capable of
scanning at a resolution of 1200 DPI, then you know that the stepper
motor that controls the carriage is capable of stepping in increments
of 1/1200 inch, or 21.167 micrometers.  Pretty good resolution, eh?
In other words, this is about 1/50 of a millimeter.

BUT... you complain, this requires mechanical moving parts!  Aren't
you saying that modern electronics have been increasingly moving away
from mechanical moving parts?  "Zero moving parts" is the trend in
high-tech computer and information technology equipment.  Yes, yes, I
know, zero moving parts is the cool new spiffy trend, but look.  Hard
disk drives still have a much higher information storage density and
much better storage economy than solid-state drives.  So, although the
"zero-moving parts" solutions may be trendy, the fact of the matter
is, at present, they are not quite practical to complete deprecate
systems that have some moving parts.

<!-- more -->

Okay, but anyways, is it possible to design alternative systems that
have no moving parts?  Yes, it is.  Consider the projector display
solution.  Rather than moving the laser line, you can just change the
image that is displayed to the projector.  This makes it very simple
to step the projected line in small increments, provided that your
projection display has adequate resolution.  I recommend using a
projector with at least "2K" resolution.  Unfortunately, in the realm
of projectors, such 2K projectors have only very recently (as of 2016)
become economically viable to manufacture in mass numbers, and even
then buying one is considerably expensive, measuring in the hundreds
of dollars.  (And remember, because they are so recent, it's pretty
hard to get an "old" one at a discount.)  On the other hand, 2K
digital cameras have existed since about 2003.  And today (again, as
of 2016), 2K digital cameras have gotten considerably smaller and
cheaper, down to the price of $25.  So, I think it is clear that we
have a general trend such that high-resolution sensor equipment is
cheaper than high-resolution production equipment.

That being said, one would hope to offload the logic of high
resolution capture into the camera system, if possible.  Try this
idea, for example.  Rather than having a precision motion system for
your line projector, you just use a cheap $3 laser line generator and
move it by hand.  Then, you use a high-speed camera to compensate for
the fast motion and still get a scan with a high line density
regardless.  Unfortunately, in the present, the cheapest such
high-speed cameras still cost a few thousand dollars.

BUT... now this is really tricky.  If you've been keeping up on the
latest technological developments, you'll know that delta-image based
high-speed cameras are a forthcoming development, and with them will
come the capability to build a 10,000 Hz camera at only the cost of a
60 Hz camera.  Wow, that's really impressive.  And, considering the
fact that we will prefer to keep the camera stationary while moving
the laser, the number of image updates will be constrained to only the
small area of the image where the laser line is moving, which will
dramatically decrease the upper limit on image bandwidth between the
camera and the computer system.  The only challenge in implementing
this system, beyond the fact that the related technology does not yet
exist, is writing the software to take in delta image updates and use
those to generate the 3D data.  However, once all the parts of this
system are in place, I think this system will be by far the cheapest,
fastest, and highest quality system of all of options mentioned above.

20160803/http://spectrum.ieee.org/at-work/start-ups/startup-profile-sanstreak-lowers-the-cost-of-highspeed-photography

Cottage industry?  Interesting.

20160803/https://en.wikipedia.org/wiki/Putting-out_system  
20160803/https://en.wikipedia.org/wiki/Ironmonger

----------

3D scanner notes continued continued.  What about the kind of camera
you want to use?  Look, I think I want to make this point clear.
First of all, get a camera that has some kind of image focus ability.
Smartphone cameras that have no image focus abilities are notorious
for giving you out-of-focus images for near-range photographs.  It's
absolutely necessary to have a focus mechanism if you are
photographing small objects.  This might mean that you want to go for
a full macro lens from a DSLR camera.

Oh, but this is interesting.  Not all smartphone cameras are poor at
focusing.  Yeah, and I've picked up a few other entertaining links in
the process, though they are not as informative to the primary
objective here.

20160911/http://petapixel.com/2016/09/07/iphone-7-7-plus-announced-dual-cameras-zoom-bokeh/
20160911/http://petapixel.com/2016/09/08/iphone-7-simulate-shallow-depth-field/

Wow, now I must say this is interesting.  Yes, definitely as the
author of the article has said, there are not many electronics in this
newer camera.  The space is not packed and busy like the rhetoric of
older cameras.  It doesn't quite have as much of that echo of a
sophisticated industrial product.

20160911/http://petapixel.com/2016/09/09/teardown-take-peek-inside-canon-5d-mark-iv/  
20160911/http://petapixel.com/2016/09/09/photographer-makes-website-seeking-sugarmama-fund-adventures/  
20160911/http://petapixel.com/2016/09/07/patent-shows-canons-digital-lens-displays-may-look-like/  
20160911/http://petapixel.com/2016/09/08/shoot-portrait-levitating/

----------

Very important.  This is the site of the department at the University
of Minnesota that is likely to be the one to go to to get your 3D
scanner ideas moved forward.

20160914/http://www.dtc.umn.edu/
