---
layout: post
title: More news and methods of 3D scanning
date: 2016-12-19 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

What?  News of a possible 3D sensor?  Sort of.  Here's the deal.

20161219/https://youtu.be/0QNiZfSsPc0  
20161219/https://atap.google.com/soli/

The video touts the radar as "very high positional accuracy," which is
more vague than deserved, so here is an accurate number computed from
the specification on the Project Soli website.  60 GHz electromagnetic
radiation has a 5 mm wavelength, so being optimistic about
sub-wavelength detail recovery algorithms, "very high positional
accuracy" is measuring details within 1 mm of accuracy.

Also note that the portion of the video displaying the reflected waves
off of the hand to the sensor was drawn to spatial scale, given the
wavelength of the radar signal.  Time scale, of course, was greatly
exaggerated.

Before you go too far "imagining the possibilities," you still have to
remember the limits.

This is in fact "microwave" radiation.

20161219/https://en.wikipedia.org/wiki/Microwave

<!-- more -->

Oh, note a limitation with microwave radiation is atmospheric
transmissiveness to it.  The particular frequency selected for the
Google sensor is strongly absorbed by the atmosphere, but other nearby
low frequencies are very transmissive through the atmosphere.  Higher
frequencies, not so much.

Right after microwave radiation is far infrared.  Then again, wait,
actually there is not a formal distinction and there is overlap
between different terms used in different fields of study.

Oh wait, now I am told the sensor is capable of detecting with
sub-millimeter accuracy.  Yes, but there's a difference between "can"
do and "do well."  For scientific reasons, there are obvious limits as
to how far this statement can be stretched.

20161219/https://en.wikipedia.org/wiki/Google_ATAP#Project_Soli

Interesting, the Wikipedia article briefly mentiosn all of the related
techniques in a single sentence.  Wow, I'm impressed actually.  You
know, it't too bad that the other article is not as well written.

Yes, yes, yes, just like in all the literature you've read about
semiconductor manufacturing.  The minimum feature size is a scalar of
the wavelength of light used.

* Hey!  That's it!  Since you always use these 3D sensors by
  specifying a minimum feature size and a maximum distance, that works
  great for digital computer arithmetic!  No need to worry about
  arbitrary precision integers when you know the scope of your
  scanning equipment.  But then when you combine it all together...
  yeah, that's when you'll need to consider that.

* And definitely.  By the time I get around to my prototype, all of
  this will be old hat, not very interesting, and very well known and
  understood by the future community.

Oh yeah, but definitely note what it says on the website.

  Unlike traditional radar sensors, Soli does not require large
  bandwidth and high spatial resolution; in fact, Soli’s spatial
  resolution is coarser than the scale of most fine finger
  gestures. Instead, our fundamental sensing principles rely on motion
  resolution by extracting subtle changes in the received signal over
  time.

A big difference between 3D scanning versus 2D photography is that 3D
scanning tends to be distance and resolution limited based off of the
parameters of the scanner, whereas visible light's resolution and
distance often times depends only on the optics used.

* Now, time for a showcasing of consumer electronics that implement
  each of these techniques, or N/A if I could not find one.
  Seriously, this is something that just couldn't have been done a
  couple of years ago.

** Yes, although the technologies have been around for quite some
   time, they have long been locked up in extremely expensive
   industrial equipment.  Some of them still are, but many of them are
   fast approaching the mass market.

* Yeah, of course you can make a subject-level categorization, but
  often times it makes more sense to rank the available sensors by
  their costs.  Because, in the real world, you can go and get
  low-cost equipment right away, but expensive things, you're going to
  have to think about that for a while.  Also, once cost is pinned,
  the next questions to think about are quality and speed.

And, I have an interesting thing to say of my own.

A picture is worth 10,000 words but a gesture is only worth 50 or less
words.  Sure, that makes a gesture recognition device 200 times easier
to build (READ: 200 times cheaper) than a generic radar imaging
device, but it also means that the devices are distinctively limited
in their usefulness.
