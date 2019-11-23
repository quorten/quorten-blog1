---
layout: post
title: GPU accelerated video decode on Raspberry Pi?
date: 2018-02-17 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner, raspberry-pi]
tags: [3d-scanning, 3d-scanner, raspberry-pi]
---

Important!  Is there a way to get GPU-accelerated video decoding
through FFMPEG?  This is important so that we can have GPU
acceleration for video scaling in our 3D scanning algorithms.  Indeed,
there is.  There are plugins "codecs" for FFMPEG that do exactly that.
So, good news to get this going on the Raspberry Pi quickly and
efficiently.  Unfortunately, there are reports of lower quality from
using these algorithms for video encoding.

VDPAU, XVMC, VA API

20180217/DuckDuckGo ffmpeg gpu video scaling  
20180217/https://stackoverflow.com/questions/5554933/ffmpeg-hardware-acceleration-gpu-directshow  
20180217/https://stackoverflow.com/questions/18286334/convert-video-with-ffmpeg-using-gpu

20180217/https://en.wikipedia.org/wiki/VDPAU

Don't bother, NVIDIA-only.

20180217/https://en.wikipedia.org/wiki/Nvidia_NVDEC  
20180217/https://en.wikipedia.org/wiki/X-Video_Motion_Compensation  
20180217/https://en.wikipedia.org/wiki/Video_Acceleration_API

Okay, let's be particular to the Raspberry Pi.  Looks like it is
possible through FFMPEG.

<!-- more -->

20180217/DuckDuckGo raspberry pi ffmpeg hardware accelerated decoding  
20180217/https://stackoverflow.com/questions/40175644/ffmpeg-hardware-acceleration-on-raspberry-pi  
20180217/https://www.raspberrypi.org/forums/viewtopic.php?f=28&t=182960

Okay, so apparently this tutorial enlightens you, and you may need to
custom-compile packages to get adequate hardware video acceleration.

20180217/DuckDuckGo raspberry pi play video hardware acceleration  
20180217/https://stackoverflow.com/questions/34851897/hardware-acceleration-for-video-playing-and-streaming-on-raspberry-pi-2  
20180217/https://www.raspberrypi.org/forums/viewtopic.php?f=66&t=59814&start=150

`omxplayer` is the way to go if you want to see an example of hardware
accelerated video decoding on the Raspberry Pi.

20180217/https://learn.adafruit.com/raspberry-pi-video-looper/overview

Take note.  For FFMPEG, x86 MMX/SSE decoding is not available in the
LGPL licensed version, only GPL.  Yes, you'll notice a slowdown if you
use a less richly licensed version.

20180217/DuckDuckGo No accelerated colorspace conversion found.  
20180217/http://www.ffmpeg-archive.org/No-accelerated-colorspace-conversion-found-td942709.html

Also, take note!  The new version 2 of SDL is **not** backwards
compatible with SDL 1.2.

20180217/https://en.wikipedia.org/wiki/Simple_DirectMedia_Layer
