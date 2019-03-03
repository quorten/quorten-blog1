---
layout: post
title: Video capture on Linux mapped out
date: 2019-03-02 21:06 -0600
author: quorten
categories: [raspberry-pi, media-prog]
tags: [raspberry-pi, media-prog]
---

So, for quite some time, I was wanting to get a video capture card for
a variety of purposes... viewing an Apple II screen on my laptop,
recording retro video game playing sessions from the real hardware, or
simply digitizing VHS videocassettes.  But, until now, I wasn't sure
what I wanted.  At one point, I was sure that I wanted to get the very
best, highest resolution video capture cards available.  Alas, I came
to the conclusion that those are unnecessarily featueeful and
expensive for my applications that are in most need of video capture,
especially in the near-term.  Thankfully, in light of the expiration
of the last MPEG-2 patent in the United States, the decision has
become much easier.

For sure, I don't need a video capture card that can do more than
standard definition, DVD-quality video.  If the device sends MPEG-2
compressed video, I'm okay with that.  No need for super high quality
uncompressed video streams for the time being.  Also, I must have a
device that connects via USB so that I can use it with a laptop or a
Raspberry Pi with ease.  PCI cards are a no-go as they require a
desktop PC.

So, how did I find out more information on such available devices?  I
continued from my previous basepoint of the USB video capture device
that I found that was partially adequate, but non-ideal.  Then I went
to the main Linux TV site, then to the Video4Linux driver
documentation.  From there, I could find a list of all supported
boards and chipsets.  That's where I could find the differentiation
between PCI or USB devices.  Note that webcam devices were listed
separately, and I did not look into those in great detail.

<!-- more -->

20190302/https://www.linuxtv.org/wiki/index.php/Ion_Video_2_PC  
20190302/https://www.linuxtv.org/  
20190302/https://www.linuxtv.org/docs.php  
20190302/https://www.linuxtv.org/downloads/v4l-dvb-apis-new/v4l-drivers/index.html

Anyways, I found there are really only a few chipsets for USB devices.

* AU0828 cards
* EM28xx cards
* TM6000 cards
* USBvision cards

20190302/https://www.linuxtv.org/downloads/v4l-dvb-apis-new/v4l-drivers/au0828-cardlist.html
20190302/https://www.linuxtv.org/downloads/v4l-dvb-apis-new/v4l-drivers/em28xx-cardlist.html  
20190302/https://www.linuxtv.org/downloads/v4l-dvb-apis-new/v4l-drivers/tm6000-cardlist.html  
20190302/https://www.linuxtv.org/downloads/v4l-dvb-apis-new/v4l-drivers/usbvision-cardlist.html

From here, you can see that one of these chipsets is said to not
really work at all: Trident TM6000.  Avoid buying any such device
using that chipset.

20190302/https://www.linuxtv.org/wiki/index.php/Trident_TM6000

Two chipsets are stated to work, but not much information is included
about the particular devices listed.  However, this may simply be due
to the fact that these were very early chipsets, and maybe they do
work quite well.  Some of these devices are USB 1.1 rather than USB
2.0, for example.  USBVision devices apparently work quite well, but
are old.  AU0828 looks like it is for (obsolete) tuners, maybe not so
good for S-Video capture.

20190302/https://www.linuxtv.org/wiki/index.php/AU0828  
20190302/https://www.linuxtv.org/wiki/index.php/Auvitek  
20190302/https://www.linuxtv.org/wiki/index.php/Microtune  
20190302/https://www.linuxtv.org/wiki/index.php/USBVision  
20190302/https://www.linuxtv.org/wiki/index.php/Nogatech_NT100x  
20190302/https://www.linuxtv.org/wiki/index.php/USBVision_devices

So, you might realize, our list of candidate devices is getting quite
narrow at this point.  If you want USB 2.0, we're down to one chipset,
EM28xx.  And, guess what.  There's a lot of devices that use this
chipset, but not many of them work perfectly.

20190302/https://www.linuxtv.org/wiki/index.php/Em28xx_devices

This device appears to work the best, supports USB 2.0, and has the
most information on its page.  BUT, take note that it uses exactly the
same video decoder IC and USB bridge IC as the Ion Video 2 PC family
of devices, so maybe there is really nothing special to see here,
other than that it uses a different sound IC.  The Ion Video 2 PC
family of devices purportedly has trouble with XRUNs on sound, and
although this can be fixed in software, maybe for me personally, the
cheapest and easiest way to fix this is through using the other chip
and driver.  Alas, this device is quite rare on the market, so in the
end it may not be worth the effort to try buying it.

20190302/https://www.linuxtv.org/wiki/index.php/SilverCrest_USB_2.0_Video_Grabber_VG_2000

This device can work pretty well if you make sure to not get a "v3"
board, otherwise it partially works.  Component-wise, this is very
similar to the Ion Video 2 PC family of devices, except that it uses a
different video decoder IC, SC8113.  However, this also appears to be
very rare on the market.

20190302/https://www.linuxtv.org/wiki/index.php/TerraTec_Grabby

This device appears to be a bit older, and its page doesn't have as
much information on it, but maybe it works well.  Alas, after looking
at the history on the article, for sure a previous contributor noted
the device works, but not all that great.  So indeed, it is a lack of
information problem at first sight of this article.

20190302/https://www.linuxtv.org/wiki/index.php/Plextor_ConvertX_PX-AV100U

This device has unknown support status, but it looks like it could
work.  Maybe getting it working would require more hacking than you'd
want to do.

20190302/https://www.linuxtv.org/wiki/index.php/V-Gear_PocketTV

So, after all this discussion, I think you may have realized that I
made a conclusive decision in a roundabout way.  I'm just going to end
up buying the same device that I found and noted down earlier.
There's not really a point to buying any of the other alternatives
that I've found.

----------

The Raspberry Pi CSI camera video capture trick?  Yeah, that would
have been nice, but I have to conclude that the hardware was expensive
and reviews stated the quality of its output wasn't all that nice.
You could get it to work nicely, but that would require some hacking,
and that takes time, and for some of these time-sensitive data
migration things we just don't have that time to wait.  That being
said, I'll go with one of my recently mentioned solutions that are
proven to work pretty well.
