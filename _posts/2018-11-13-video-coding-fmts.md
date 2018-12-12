---
layout: post
title: More discussion on video coding formats
author: quorten
date: 2018-11-13 11:11 -0600
categories: [media-prog, important]
tags: [media-prog, important]
---

Important!  More discussion on video coding formats.

So you thought that MPEG video coding formats were the end-all and
be-all in video format standards?  Well, for the most part, you are
right, 100% correct that these are the popular and volumous formats,
and are therefore least likely to fall out of modern support due to
obsolescence.

But, when you look into the range of more specialized video formats
used in digital cinema and professional post-production, some things
might surprise you.  Yes, I've long had the idea and understanding
that one reasonably good and basic method of video compression is to
simply encode each frame as a JPEG image.  You still get most of the
compression benefits, but you don't have to deal with the extra
programming complexity of delta frame video coding.  Surprise
surprise, for one point in the distant past, this video compression
method was actually the preferred delivery format for digital cinema:
JPEG 2000 compressed video frames with uncompressed LPCM audio.

Here is the online archive article from the IEEE Spectrum Magazine.
There are no pictures in the online article, unfortunately, even
though there were pictures in the magazine publication.

20181203/https://spectrum.ieee.org/semiconductors/optoelectronics/bits-on-the-big-screen

<!-- more -->

But, since that old IEEE Spectrum article was written, that format has
since fallen out of favor and popularity.  True, indeed it was a
critical turning point toward bringing digital cinema more mainstream
by creating an open standard with minimal proprietary patent licensing
issues and reasonably good existing software support.  Also, the
temporal compression artifacts in MPEG was considered unacceptable for
fast action on the big screen at 24 frames per second, though
perfectly acceptable for smaller television screens, possibly
displaying video at higher frame rates.

So, the modern stuff.  Nowadays we tout MPEG, MJ2 and friends as
_intra-frame codecs_.  _Intra-frame coding_ is the use of spatial
compression only to compress video, without temporal compression,
motion prediction, motion compensation, and so on.

And no, Wikipedia does not have a list of patents article for H.264,
but we do know that most of the core patents are expiring a couple of
years from now, 2023/2024.  The important core parts of the standard
were finalized 2003/2004.  Chances are this patent expiration will be
the same as the last, MPEG-2.  Although the newest stuff will no
longer use it, there will still be important users of the video
standard, as there were back in its heyday.  Just as MPEG-2 is still
_the_ standard for DVD Video, digital video broadcast, and standard
definition video capture applications, H.264 MPEG-4 will still be
_the_ standard for standard/high definition Internet video streaming.
It's just that the second time through, there will be no patents to
worry about anymore.  So, relax!  Go ahead and start programming,
developing, recording, and producing against the de facto standard of
today, H.264 MPEG-4, and rest assured that it will still be a viable
standard a few years from now, still widely used and adopted, but
without patents the next time through.

20181113/https://en.wikipedia.org/wiki/H.264/MPEG-4_AVC  
20181113/https://en.wikipedia.org/wiki/Motion_JPEG  
20181113/https://en.wikipedia.org/wiki/Motion_JPEG_2000  
20181113/https://en.wikipedia.org/wiki/JPEG_2000  
20181113/https://en.wikipedia.org/wiki/Intra-frame_coding  
20181113/https://en.wikipedia.org/wiki/Group_of_pictures  
20181113/https://en.wikipedia.org/wiki/FFV1  
20181113/https://en.wikipedia.org/wiki/Apple_ProRes

Well, the JPEG 2000 standards sure were nice from a conceptual and
mathematical standpoint, but unfortunately, ultimately the format did
not become very popular with applications and users.  Without lots of
data, a data file format standard is basically nothing from a _de
facto_ standpoint.
