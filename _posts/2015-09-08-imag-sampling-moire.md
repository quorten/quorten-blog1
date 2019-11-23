---
layout: post
title: Imaging systems, moire patterns, sampling
date: 2015-09-08 21:00 -0600
author: quorten
categories: [media-prog]
tags: [media-prog]
---

Imaging systems and Moire patterns.  Why does the human eye not have
these artifacts ever?  That's because the sensors on the human eye are
not arranged in a perfectly crystalline grid structure.  Thus, it is
extremely unlikely for aliasing artifacts to occur on the human
retina, though in theory, it is still possible.  This is also the same
reason why advanced raytracing systems use a random sampling of pixels
rather than a perfectly uniform grid structure: to make the
probability that aliasing artifacts will occur extremely unlikely.
Thus, it will not be necessary to do Fourier frequency analysis to
avoid aliasing artifacts when downsampling.  Really?  That's really
interesting.  It's too bad that Blender is not designed by perfect
principles like that.  It's amazing that anything gets done correctly
when you realize exactly how many problems our current multimedia
technology has.

That's a very interesting idea to pursue.  Design a downsampler that
uses randomized point distributions to avoid Moire patterns.  You use
randomization to in effect reduce the probability that a Moire pattern
will occur to zero.

<!-- more -->

So, why do telecommunications equipment rely so heavily on regular
rectangular grid arrangements?  Because it's cheaper!!!  It's cheaper
to produce a regular rectangular grid of sensors than it is to produce
one where the sensors are randomly distributed.  Besides, you can
simulate randomly distributed sensors in software by downscaling an
image with randomized selection of which sensor to grab data from,
can't you?  Yes, you can.  Hey, could this also be a solution for
sharp downscaling of images on displays where the resolution doesn't
match perfectly?  It could be.  "I like my pixels nice and square."

How do you map a random sample distribution into a square one?  You
combine and average the samples.  Yeah, but if you do that for all
samples when the source is a raster image, you'll end up with Moire
patterns, won't you?  Yes, you will.  You have to somehow be able to
take a raster image and avoid the fact that it is rectangularly
sampled entirely.  The only way to do this is to introduce some
sampling grid alignment error into either the source or the
destination.  Of course, when both the source and the destination are
rectangular grids, it doesn't matter which one you introduce the error
into.  Then you have to compensate for the gaps caused by the error if
it is in the source.  Okay, let's only do it to the destination, then.
Give it a film grainy feel, even though it is in fact pixels.  But the
problem then is that the quality of the original will get worse and
worse with each copying generation.  Exactly, that's what's happening
after all when you don't make an exact copy of the digital original.

When the number of copy generations at the same resolution increase,
the introduced noise will gradually decay the original signal.

By the way, enlargements need not worry about Moire patterns in
general, except in the case where the enlargement is by a relatively
small factor.  Error diffusion of jaggies or blurs or both.  So, for
enlargements?  Use a random interpolation between neighboring points
for any new points added.  But this means the contrast ratio will be
decreased?  Okay, maybe you can use a filter that maximizes the
contrast ratio then.  How do you know to blur or to sharpen?  That
depends on what the principle contrast ratio is.  Well, whichever one
introduces less error from the original data points.  If the original
data points had high contrast, and you introduce a new data point that
is smack in between them, you are in effect causing maximal error, in
terms of introducing a new color that never existed in the original.
But if you were to choose either exact color instead, then the amount
of error you introduce is significantly less.

But then as the number of random high contrast pixels selected
increases, you get a noisier and noisier downscaling of the image.
That's right, because you are trying to preserve contrast.  Oh, so
you're saying, when you have to loose so many details that you should
just give up on contrast preservation?  Yeah, that makes sense if
you're trying to avoid too much random image noise.  When you have
random noise beyond more than just the adjacent cells, then you should
start to blur.  Randomly?  Only on the question of how many
neighboring cells to inclue.  Within a region, all samples will be
included.  Minimizing the error introduced into the choice of colors
for an image, I like that.

This seems like a good article to read up on.  I have yet to finish
reading it.

20150908/https://en.wikipedia.org/wiki/Multidimensional_sampling
