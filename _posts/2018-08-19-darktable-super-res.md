---
layout: post
title: Notes on Darktable and super-resolution support
author: quorten
date: 2018-08-19 15:31 -0500
categories: [pentax-k-1-camera]
tags: [pentax-k-1-camera]
---

So, now I've gotten further into the lowdown of RAW photo processing.
I've tried out Darktable, and now I've become enlightened as to why I
wasn't quite getting the RAW photos that I wanted out of RAWTherapee,
namely that they didn't look as similar to the built-in RAW
development in my Pentax K-1 camera.

Digital cameras tend to have a non-linear luminosity curve profile
that they apply to the base linear luminosity data before converting
to sRGB gamma-coded image samples.  Darktable has corresponding
profiles for each such camera.  When I removed that luminosity curve
profile from Darktable, I ended up with developed RAW images that
looked very similar to those that I got from RAWTherapee.

So, once I got that out of the way, I had no more questions whether
Darktable supported my Pentax K-1 camera.  Of course it did, with
excellent quality development, giving me better results than I got
with my Pentax K-1 camera's built-in development.  Note when highlight
correction comes into effect, this means you'll be adjusting exposure
compensation manually when doing your own RAW development to get
equivalent results.

<!-- more -->

Indeed, Darktable supports Pentax K-1, with correct color profiles as
I've verified from testing.

20180819/DuckDuckGo pentax k-1 color profile darktable  
20180819/http://www.darktable.org/resources/camera-support/

This is an interesting site that is used by Darktable for automatic
regression testing on RAW file support.  So if you find sample RAWs
for your camera in there, you're good.

20180819/https://raw.pixls.us/

RawSpeed is the RAW decoding library used by Darktable.  So yes, a bit
different than the older systems that used `dcraw` or similar.  And it
is covered by Google Fuzz testing, which is not available to all
open-source projects.

20180819/https://github.com/darktable-org/rawspeed  
20180819/https://github.com/google/oss-fuzz  
20180819/https://www.coreinfrastructure.org/

But the challenges don't end there.  That's only considering simple
single-exposure photos.  Now, my Pentax K-1 camera also supports
super-resolution, dubbed Pixel-Shift Resolution (PSR), by taking 4
exposures at single-pixel sensor shifts and saving them into a single
DNG RAW file.  Likewise, the high dynamic range capabilities take
three exposures and saves them into a single DNG RAW file.  Now, I've
verified that both Darktable and RAWTherapee can open and process
those files okay, meaning that I have no worries about major data
loss.  However, I haven't yet verified that they can use the extended
data available in those files correctly.  At first sight, it appears
they are processing the first embedded exposure and ignoring the
subsequent ones.

So, does Darktable support super-resolution?  Inconclusive, but indeed
there is libre software available for you to do it yourself: `enfuse`.
But yes, that might mean that you first need to use the Ricoh Silkypix
software to split up multi-exposure RAW files into separate files
before piping them into.

20180819/DuckDuckGo darktable super resolution  
20180819/https://redmine.darktable.org/issues/9132

Take note, you might need to adjust the noise reduction filters
manually when using Darktable, compared to the camera's built-in
development.

20180819/https://photo.stackexchange.com/questions/41219/how-can-i-insert-my-own-demosaicing-algorithm-into-rawtherapee-or-darktables-pi

20180819/https://en.wikipedia.org/wiki/Super-resolution_imaging  
20180819/DuckDuckGo enfuse entropy weight photo

Beware, it's been a while since the enblend/enfuse software was last
updated, I may need to look for more up-to-date alternatives.  But, if
the software works well, then I guess there is no need.

20180819/http://enblend.sourceforge.net/enfuse.doc/enfuse_4.1.xhtml/enfuse.xhtml

Finally, comparing RawTherapee and Darktable.  My verdict: RawTherapee
is easier to use when your just getting started, when you have never
had the opportunity to do a digital RAW development workflow ever
before because you never before had a digital camera capable of saving
RAW files.  Darktable has a more difficult to use interface, though
its interface is also clearly targeted at speeding up the workflow for
power users.  Also, Darktable has more built-in presets than
RawTherapee, and this proved to be quite useful.  Finally, Darktable
is on a faster release cycle than RawTherapee, and from the outset
looks to have many more developers involved.  So yes, the future is in
Darktable, but I concede that Darktable is similar to GIMP in that the
user interface is made more complicated and more difficult than needs
be the case, for both first-time users and power-users alike.

20180819/https://en.wikipedia.org/wiki/RawTherapee  
20180819/https://en.wikipedia.org/wiki/Darktable

Now I've got to find libre software that can split apart
multi-exposure RAW DNG images, so I don't need to rely on Windows
emulation to run Silkypix.

Failed search.

20180819/multilayer dng  
20180819/DuckDuckGo split apart multiple exposures dng

Wait, hold on here.  You can shoot RAW on Android nowadays?  Oh,
excellent.  That means it must be possible on Raspberry Pi cameras
too.  You sure can do a lot with modern smartphone software that you
couldn't do with old-fashioned proprietary firmware digital cameras of
times past.

20180819/https://www.makeuseof.com/tag/shoot-process-raw-photos-android-youd-want/

> To shoot in RAW, your phone (or tablet) needs to support an optional
> part of the Android operating system called the Camera2 API. This
> must be implemented by the device’s manufacturer and cannot be added
> via an app. In other words, if your phone doesn’t support it, then
> RAW shooting is off the menu (unless you want to flash a custom
> ROM).
>
> Camera2 was introduced with Android 5.0 Lollipop. Most mid- to
> high-end phones launched since then are likely to support it; it is
> much more likely to be absent in budget handsets.
