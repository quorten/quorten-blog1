---
layout: post
title: S-Video explained
date: 2019-02-11 23:04 -0600
author: quorten
categories: [media-prog, apple-ii]
tags: [media-prog, apple-ii]
---

So, for quite some time, I've been doing a nifty trick with S-Video
and composite video.  I have this adapter plug that has a S-Video plug
on one end and a composite video plug on the other end.  I have no
idea how it works, or whether it was intended to be bidirectional or
not, but experimentally, I found that it is bidirectional.  So, any
time I wanted to connect an S-Video output to a composite video input
or vice versa, I would use that cable, without thinking exactly how it
works.  However, especially when working with Apple II video output, I
_did_ prefer to convert composite video to S-Video because I noticed
that television equipment displays S-Video with a higher resolution
than composite video, even with the same video input signal.  Now,
this makes me wonder.  How exactly does S-Video work?  I consult
Wikipedia, and lo and behold, I find the schematic diagram for my
adapter cable right in there.

20190211/https://en.wikipedia.org/wiki/S-Video  
20190211/https://en.wikipedia.org/wiki/File:S-video-composite-adapter.svg

<!-- more -->

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2019-02-11-S_vid_adapt.svg"
        width="688" height="250">
  <img src="{{ site.baseurl }}/blog/images/2019-02-11-S_vid_adapt.png"
       alt="S-Video and composite video adapter schematic"
       width="688" height="250" />
</object>

S-Video is really simple in concept, and when coupled with the
converter cable, really powerful in practice.  The primary goal of
S-Video is to improve video quality by carrying the luma and chroma
signals separately.  This allows each signal to be conveyed with
higher fidelity.  By contrast, when television equipment wishes to
display composite video, it must _filter_ out the chroma signal from
the luma signal, effectively reducing the resolution of the chroma
signal.

So, how does the composite video and S-Video conversion cable work?
Simple.  You pass through the luma signal directly to the composite
video signal pin, but the chroma signal must go through an
approximately 470 pF capacitor.  The grounds of each signal are wired
to the common ground of the composite video.  Wow, so that's how they
made that conversion cable so small and bidirectional.  To convert
from S-Video to composite video, you simply mix the signals together,
with a capacitor to process the chroma signal.  To convert from
composite video to S-Video, you simply separate out the chroma signal
using a capacitor and pass through the combined chroma-luma signal to
the luma.

Now, here's the catch.  With this video signal converter cable, you
realize something that unfortunately, many video equipment designers
have not.  You don't _need_ to filter the chroma signal out of the
luma signal.  In fact, black and white televisions work exactly by
displaying the combined chroma and luma signal.  The chroma signal
shows up a a random dot pattern that is otherwise negligible.  So, if
you wire in your composite video output into our television's S-Video
input, you get to bypass the low-pass filtering under all
circumstances, yet pass through the same video signal.  This gives you
a perceptively sharper image.  Especially in the case of Apple II
80-column monochrome text, the image is _literally_ sharper, and the
difference makes or breakes whether you can reliably read the text in
80-column mode.  So, now you know the story of the mysterious S-Video
and composite video conversion cable.
