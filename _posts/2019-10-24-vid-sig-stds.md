---
layout: post
title: Computer and television video signal standards
date: 2019-10-24 03:16 -0500
author: quorten
categories: [vintage-computing, mac-classic, raspberry-pi, media-prog]
tags: [vintage-computing, mac-classic, raspberry-pi, media-prog]
---

In the process of trying to figure out how I can interface video with
the Megascreen 3 video expansion card in my Macintosh SE, I've done a
bunch of research on video signal standards.  So, here it is.

First of all, information on the ECL video standard, which was used on
Sun and Apollo workstations.  It's almost the same as the Megascreen 3
DE-9 connector, but not quite.  The logic levels match, 5 V TTL, but
pin assignments don't quite match.

20191024/ECL video signals  
20191024/https://allpinouts.org/pinouts/connectors/computer_video/ecl-video/  
20191024/https://web.archive.org/web/20100103055725/http://www.monitorworld.com/Cables/video_standards.html

This looks like a good ECL to VGA adapter.  It appears to use active
circuitry, so it can handle odd-ball signals.  Then again, it is
designed specifically for the Atari TT, so I'm not sure if it is
sufficiently general for other systems.

20191024/DuckDuckGo ecl video adapter  
20191024/https://shop.inventronik.de/index.php?id_product=28&controller=product&id_lang=2

Interestingly, there was an Atari workstation built that also used ECL
video.

20191024/https://en.wikipedia.org/wiki/Atari_TT030

<!-- more -->

----------

This is a useful page on video signal adaption between TTL and VGA.
VGA is 0.7 V peak to peak, so not compatible with TTL, except for the
sync pulses which are 5 V.

20191024/Google ecl video adapter  
20191024/http://www.epanorama.net/faq/vga2rgb/interfacing.html  
20191024/http://www.repairfaq.org/REPAIR/F_vidconv.html#VIDCONV_023

20191024/DuckDuckGo vga 0.7V  
20191024/http://microvga.com/faq/electrical/what-are-vga-voltage-levels

Composite video and component video is 1 V.  Technically, the standard
polarity is reversed so it is -1 V.  Both for RCA jacks and for BNC
connectors.  So if you want to connect TTL video to VGA, you need to
step down the voltage, the easiest way is using 450/470 ohm resistors.
The proper voltage conversion relies on the assumption of an internal
75 ohm resistance inside the monitor... yeah, like 75 ohm BNC
connectors.  Otherwise, you provide an external termination resistor.

20191024/DuckDuckGo composite video voltage  
20191024/http://www.broadcaststore.com/pdf/model/793698/TT148%20-%204053.pdf  
20191024/http://www.bradsprojects.com/generating-video-signals-with-a-microcontroller/  
20191024/DuckDuckGo composite video voltage ntsc  
20191024/DuckDuckGo bnc video voltage  
20191024/https://en.wikipedia.org/wiki/BNC_connector  
20191024/https://electronics.stackexchange.com/questions/149511/50-ohm-terminator-voltage-divider  
20191024/DuckDuckGo bnc component video voltage

----------

How do NTSC composite video signals work?  Here is some great
information.

20191024/DuckDuckGo composite video voltage  
20191024/http://www.broadcaststore.com/pdf/model/793698/TT148%20-%204053.pdf

My biggest question was how the horizontal sync and vertical sync
signals work in NTSC composite video.  First of all, the video signal
is "inverted": a full value means black and zero means white.  And
actually, black is not the full value.  The horizontal sync signal is
the full value and corresponds to "blacker than black."  It is held
high for the full time to do a horizontal return.  So, that makes it
real easy, essentially it's exactly the same as VGA horizontal sync,
except for voltage differences.

The vertical retrace signal is the trickiest signal to interface
compatibly with a VGA output signal.  In abstract, you combine the
vertical retrace signal and horizontal retrace signal using an XOR
gate.  However, at the vertical retrace signal region, the horizontal
retrace actually need to be spaced a half-line apart rather than a
full line apart.  The time span of this half-line coding must span 9
fields.  This is so that the television circuitry can detect this is
an NTSC vertical.  Also, keep in mind the requirement for logical
"one" and "zero" must be contained within the voltage logic levels of
the black and blacker-than-black region.

The color burst explanation also explains why my cheap "VGA box" has
the flickering colors problem when displaying a grayscale signal.  It
fails to detect that there is no color burst signal and switch to
grayscale mode accordingly.
