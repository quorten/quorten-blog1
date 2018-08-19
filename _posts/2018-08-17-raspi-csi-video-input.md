---
layout: post
title: "Video input through the MIPI CSI-2 camera connector on
        Raspberry Pi?"
author: quorten
date: 2018-08-18 11:15 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Now I'm wondering.  Raspberry Pi has CSI video input for the camera.
Surely it should be easy to connect a composite video to CSI adapter
to this input to record video from a composite video source, should it
not?

Well, as it turns out, unfortunately it is quite hard, mainly due to
the lack of market interest.

<!-- more -->

20180818/DuckDuckGo composite video to csi camera input

Heree we see that there were plans by Raspberry Pi Foundation to
officially release such a board.

20180818/https://www.raspberrypi.org/forums/viewtopic.php?p=209166  
20180818/DuckDuckGo raspberry pi camera board composite video input  
20180818/DuckDuckGo raspberry pi camera composite video input board hat

Here we see chatting on StackExchange by many people who do not really
know what they are talking about.  This is only one out of several
such similar question articles.

20180818/https://raspberrypi.stackexchange.com/questions/13450/can-i-use-the-composite-video-connecor-to-send-video-into-the-raspberry-pi

Now we see there is this third party that produced this PiCapture
adapter that does exactly what you wanted.  Technically it is a HAT
that fits on top of select Raspberry Pi models, Raspberry Pi Zero not
included in this list, unless you use adapters for the GPIO pin
dimensions.

20180818/https://www.electronicsweekly.com/blogs/gadget-master/raspberry-pi-gadget-master/picapture-captures-video-raspberry-pi-2016-09/

Indeed, they still are in business and have a site that is alive and
well.

20180818/https://lintestsystems.com/  
20180818/DuckDuckGo picapture

Unfortunately, upon closer analysis through this review, all the
colors are a little bit off from this PiCapture board.  Sure, you can
correct for this in software, especially via GPU acceleration before
encoding to H.264 video, I just need to figure out how to program
that, though, and that will take time.

20180818/https://www.raspberrypi.org/magpi/picapture-hd1-review/

I can't access this page because of a server error, but it looks
interesting if I could access it.

broken/https://www.element14.com/community/thread/46092/l/connect-analog-cctv-to-rpi-2?displayFullThread=true

This is an analog-to-digital board, but it doesn't have enough
sampling bandwidth to convert full video.  Nope, use it more for
motors and mechanical sensors.

20180818/https://www.tindie.com/products/cburgess129/10-bit-adcvms-board-hat-for-raspberry-pi-v21/

This is how you easily mount composite video onto a Raspberry Pi Zero.

20180818/http://www.mrhobbytronics.com/raspberry-pi-video-adapter/

Now I saw mention of another third party adapter named Auvidea.  This
one only converts HDMI, though.

20180818/DuckDuckGo Auvidea hdmi input raspberry pi  
20180818/https://www.raspberrypi.org/forums/viewtopic.php?p=458852

Now this is unfortunate.  So you know the official Raspberry Pi
Foundation camera video input board that was planned?  It turns out
that they basically shelved that idea, due to not knowing market
demand for it.  So third party sources are your only option for your
idea.

20180818/https://www.raspberrypi.org/forums/viewtopic.php?f=43&t=24660&start=275#p465911  
20180818/https://auvidea.com/  
20180818/https://raspberrypi.stackexchange.com/questions/63653/auvidea-b102-and-rpi3-b

Now down this list we have a long list of failed crowdsourcing
projects to go and do likewise.

20180818/https://www.geeky-gadgets.com/raspberry-pi-hdmi-input-allows-hd-recording-video-14-03-2014/  
20180818/https://www.kickstarter.com/projects/1419380698/connect-your-hd-camcorder-to-your-raspberry-pi?ref=discovery  
20180818/https://www.kicktraq.com/projects/1419380698/connect-your-hd-camcorder-to-your-raspberry-pi/
