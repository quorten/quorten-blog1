---
layout: post
title: Final verdict on Raspberry Pi optical viewfinder
author: quorten
date: 2018-11-17 13:04 -0600
categories: [raspberry-pi, pentax-k-1-camera]
tags: [raspberry-pi, pentax-k-1-camera]
---

So, you're wondering about optical viewfinders for a Raspberry Pi
camera?  I've give you the final verdict on this.  Start out with the
cardboard viewfinder trick.

First of all, some discussion on camera viewfinders.  What does
Wikipedia mean by "reverse telescope" when discussing camera
viewfinders?  Basically, they mean a refracting telescope that uses a
convex objective lens and a concave eyepiece lens so that you see the
image rightside up, also known as a "Galilean telescope."  By
contrast, the much more popular Keplerian telescope uses a convex lens
for the eyepiece, so the image appears inverted, i.e. upside down and
left side on the right.

The cheapest of camera viewfinders, "direct optical viewfinders," are
constructed exactly as an "inverse telescope."  The main problem with
using an inverse telescope for a camera viewfinder is that you do not
see a sharp line at the edge of the camera's viewable surface.
Rather, a blurred line is seen due to the edge that defines the image
boundary to be out-of-focus.

<!-- more -->

By contrast, DSLR camera viewfinders use a more complex design to
achieve a sharp edge at the image boundary in the viewfinder.  The
camera optics project the image onto a matte surface.  This image is
upside down.  Additional optics adjust the convergence of the light so
that the user can focus their eyes on the image that is physically
right in front of their eyes.  These optics also flip the image upside
down again so that it appears rightside up.  With the image boundary
in focus, in a DSLR camera, it is also very easy to insert data
displays that the user can see just beyond the edges of the image
boundary.

Of course, all this being said, we're not interested in high-end
optical viewfinders for a Raspberry Pi camera if our goal is to be
saving as much money as possible.  So, back to the cardboard
viewfinder concept.  What do I mean by "cardboard viewfinder"?

Basically, review the concept of a cheap optical viewfinder that uses
telescope optics.  The main caveat that I've pointed out with this
system is that the edges of the viewing boundary appear blurred to the
use.  The cardboard viewfinder also shares this limitation.  Now you
know what I'm talking about: yes, you just cut out a frame with
cardboard and you look through that to determine the contents that are
visible within the image boundary.  With this concept in hand, the
remaining problem that needs to be addressed is the field of view.
With a simple window, looking through it at different distances will
give you different fields of view visible.  How do you design
the system so that you know you are getting the "right" field of view?

Easy, you just use two cardboard windows rather than just one.  The
only way you can be looking through the cardboard viewfinder at the
right field of view is then if both windows visually appear to be the
same size as each other.  You move your eye close enough to just start
seeing the bounds of the far window, then you move away until the
bounds are no longer visible.

The main disadvantage with cardboard viewfinders is that they must be
constructed to be larger than telescope optics viewfinders, due to the
exclusion of optics.  But, that being said, there's another problem
looming.  How do you construct a correct cardboard viewfinder for
ultra-wide optics?  The problem we're facing is that the far window is
going to need to be huge compared to the near window.  But, we have an
modification that works somewhat well.  Use a viewfinder for a narrow
field of view simply for the sake of making sure the user places their
eye at the correct distance.  Then, around the either the near side,
place a larger cardboard frame that indicates the wide-angle
viewfinder boundaries.  Now you have a reasonably compact wide-angle
cardboard viewfinder.

Finally, another option that works well if you're willing to use but a
single plastic lens.  Construct a through-the-lens viewfinder that
projects an upside-down image on wax paper, simply by placing the lens
in front of the wax paper and adjusting the image bounds over there.

----------

Finally, if you are willing to cut open old cameras to harvest the
viewfinder parts, that is also an option to get a viewfinder on the
cheap.  My recommendation in that case is to use the viewfinder from
an old disposable camera, but if you want something higher-end, you
can try taking the viewfinders out of other kinds of old cameras.

20181117/https://en.wikipedia.org/wiki/Viewfinder  
20181117/https://en.wikipedia.org/wiki/Refracting_telescope  
20181117/DuckDuckGo raspberry pi disposable camera viewfinder  
20181117/DuckDuckGo disposable camera viewfinder  
20181117/https://www.lomography.com/magazine/139546-viewfinder-from-a-disposable-film-camera  
20181117/https://www.pentaxforums.com/forums/136-pentax-q/171113-make-your-own-optical-viewfinder.html  
20181117/https://www.adorama.com/ipxqvf.html?utm_source=rflaid65093  
20181117/https://www.35mmc.com/02/08/2016/diy-35mm-mini-viewfinder/
