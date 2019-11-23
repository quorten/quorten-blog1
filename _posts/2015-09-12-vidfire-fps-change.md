---
layout: post
title: How VidFIRE changes the frame rate
date: 2015-09-12 21:00 -0600
author: quorten
categories: [media-prog]
tags: [media-prog]
---

So how does VidFIRE change the frame rate?  It doesn't just do a frame
interpolation, does it?  Nope, it uses motion estimation to move
various pixel regions in their direction of motion.  But even better,
would be to use object fidelity reconstruction with the help of a 3D
object recognition system.  However, that is beyond our current
technology, I guess.

20150912/https://en.wikipedia.org/wiki/VidFIRE  
20150912/https://en.wikipedia.org/wiki/Motion_estimation  
20150912/https://en.wikipedia.org/wiki/Colour_recovery  
20150912/https://en.wikipedia.org/wiki/Wiping  
20150912/https://en.wikipedia.org/wiki/Reverse_Standards_Conversion

Wiping makes sense from a practical perspective, when the cost of the
media is very expensive, though there tends to be a lot of modern
complaints about the practice.

Wow, very important find!  Not only is it the method for identifying
entertainment video works and such, it also takes an interesting
approach to implementation.

20150912/https://en.wikipedia.org/wiki/International_Standard_Audiovisual_Number
