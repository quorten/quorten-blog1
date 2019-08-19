---
layout: post
title: Raster video display over a serial connection
date: 2019-06-14 18:08 -0500
author: quorten
categories: [unlipic, computer-history, tour-de-force]
tags: [unlipicc, computer-history, tour-de-force]
---

Okay, now let's answer this challenge question.  What kind of serial
communications data rates do you need to be able to sustain a direct
drive of a raster display?  You pass a binary communication channel
that is then processed by a very simple DAC to drive a VGA CRT
display.

    1280 * 960 * 32 * 60 = 2359296000 bits per second
     = 2359296 kbps
     = 288000 KiB/sec
     = 281.25 MiB/sec

Insane!  There is no way you could possibly cobble together simple
serial communications electronics to do that when 115.2 kbps is
considered "fast" for serial communications.  By contrast, 10 Mbps is
considered "slow" for Ethernet, in fact this was the speed of first
commercially available variant of Ethernet.  Even 100 Mbps (12
MiB/sec) Ethernet is still too slow for this uncompressed HD video.

Okay, okay, fine, let's go down to standard definition, 256 color.

    640 * 480 * 8 * 60 = 147456000 bits per second
     = 147456 kbps
     = 18000 KiB/sec
     = 17.6 MiB/sec

<!-- more -->

Okay, wow, that's still too fast for even 100 Mbps Ethernet to handle,
we gotta go monochrome then, and decrease the frame rate while we're
at it.

    640 * 480 * 1 * 30 = 9216000 bits per second
     = 9216 kbps
     = 1125 KiB/sec
     = 1.01 MiB/sec

Okay, so now we're finally in the range of 10 Mbps Ethernet, but still
way too fast for even a fast serial connection.  That means we have to
decrease our resolution and frame rate even further.

    320 * 240 * 1 * 10 = 768000 bits per second
     = 768 kbps
     = 93.75 KiB/sec

Even that low resolution is still too fast for serial communications.
At this point, the only efficient way to dramatically decrease the
necessary bit rate is by decreasing the spatial resolution.  Let's go
down to 200 x 200.

    200 * 200 * 1 * 10 = 400000 bits per second
     = 400 kbps
     = 48.8 KiB/sec

Still too fast for even fast serial communications.  If we brought the
frame rate down to 1 frame per second, that would be within the range
of "fast" 56 kbps serial communications, but the user experience would
be dismal for all but the most basic of still image display.  Okay
then, let's try further decreasing the spatial resolution.

    100 * 100 * 1 * 10 = 100000 bits per second
     = 100 kbps
     = 12.2 KiB/sec

Now it's slow enough for a "fast" 115.2 kbps serial connection.
However, that means you can only look through a 100 x 100 pixel window
to get your graphical view into the digital world of your computer
board under test.

What would the resolution need to be to work well under the slower
serial connections like 9.6 kbps?

    50 * 50 * 1 * 3 = 7500 bits per second
     = 7.5 kbps

Okay, wow.  So basically, you get to see only one medium-sized
monochrome icon if you want to get framebuffer graphics out of a slow
serial connection.  Absolutely abysmal.  What if we want to see a
slightly larger icon?

    64 * 64 * 1 * 3 = 12288 bits per second
     = 12.3 kbps

Then you need a slightly faster serial connection, but at least it's
still not too fast.  Alternatively, you could reduce the frame rate to
2 frames per second to get it working better in the slower speed
ranges.

    64 * 64 * 1 * 2 = 8192 bits per second
     = 8.2 kbps

Okay, so I think 2 frames per second is livable... it means you have
to wait half a second before you can see the results of your user
input, but if it gives me that much more resolution, hey, I guess I'll
go with it.  How high can our spatial resolution go at 2 frames per
second?

    128 * 128 * 1 * 2 = 32768 bits per second
     = 32.8 kbps

Looks good, but hey, let's assume I have a "fast" serial connection.
Let's go higher.

    256 * 256 * 1 * 2 = 131072 bits per second
     = 131 kbps

Oops, that's a little too fast, maybe.  If you have a really fast
serial connection, yeah you could probably do it.  Otherwise, 200 x
200 does the trick.

    200 * 200 * 1 * 2 = 80000 bits per second
     = 80 kbps

With 8 x 8 pixel characters, how many lines and columns can you see?

    200 / 8 = 25 lines

25 lines, that's good.  But that's not quite enough columns.  Divide
the width by 2 and you get 50 columns, that sounds pretty good.  It's
like we're talking early 8-bit home computers here.  The Apple II gave
you a 40 x 24 monochrome text screen in standard 40-column resolution
mode, and that was basically the limits of readable text you could get
on an NTSC color television.

Well, what can I say?  200 x 200 pixels was the resolution of my
Flying Bunny movie graphics, and I guess if you can watch monochrome
version of that movie, that's pretty good.  But at only 2 frames per
second?  Heck no.  No, you need at least 10 frames per second to get
an interesting movie.  But still, you could get much more convincing
ordered dither grayscale at 60 frames per second.  2.6 bit grayscale,
then add error diffusion on top of that and you should be pretty good.
You could also try watching at only 100 x 100 resolution, and that
would be mostly okay.

Also, as it turns out, that neighborhood of resolutions is about the
same resolution that the COSMAC ELF could get for driving a graphics
display.

20190614/https://en.wikipedia.org/wiki/COSMAC_ELF

----------

Okay, now after all of that, let's take a look at the far-far end of
modern technologies.  We're talking 16K Ultra-Ultra-HD resolution,
high dynamic range wide-color gamut with a 32-bit floating point
number per each color channel, 240 Hertz refresh rate.  What is the
data rate of this?

    (8 * 1920) * (8 * 1080) * (32 * 3) * 240
     = 3057647616000 bits per second
     = 356 GiB/sec

Whoa, now that's a dewsey.  About ten million times the speed of our
slow serial communications graphics.

But come on, that's like you can only see one 8.5 x 11 inch page at
1200 DPI on your display.  Clearly, that's an obsolete printing
technology.  With modern displays, you want to be able to see at least
two full 8.5 x 11 inch pages on your display, so we need to double the
resolution for that.  Plus, we want to also be able to see 2400 DPI
pages with no aliasing, so lets do another (2 * 8 = 16) on the
resolution for that.  And seriously, it would be nice if we could get
1000 frames per second out of this monitor, again without aliasing, so
let's increase the refresh rate to 9600 Herz.

(32 * 8 * 1920) * (32 * 8 * 1080) * (32 * 3) * 9600
  = 125241246351360000 bits per second
  = 14 PiB/sec

14 pebibytes per second, wow, that's a lot of data to be flowing
through your computer display of the future.  Alas, we might never get
there as it is apparent that the average consumer really doesn't care
for that much resolution, similar to the fact that commodify computer
audio sampling rates have stopped at 48 kHz, although the professional
equipment keeps getting higher in sampling rate.
