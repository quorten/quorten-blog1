---
layout: post
title: RAW photos with Raspberry Pi camera?
author: quorten
date: 2018-08-23 17:23 -0500
categories: [raspberry-pi, pentax-k-1-camera]
tags: [raspberry-pi, pentax-k-1-camera]
---

So, how do you capture RAW images with the Raspberry Pi camera?  Look
here.  Unfortunately, the process is more complicated than it should
be due to undocumented proprietary systems that have to be reverse
engineered, but here it is.  First, you put the camera in RAW capture
mode.  It will emit JPEG + RAW images, the RAW data in an
incompatible, non-standard, undocumented format.  Next, you run it
through some libre software to convert the RAW data to a DNG, which
you can then process any way you please using the tools of your
choice.

20180823/DuckDuckGo raspberry pi camera raw file  
20180823/http://bealecorner.org/best/RPi/  
20180823/https://github.com/illes/raspiraw  
20180823/https://www.raspberrypi.org/forums/viewtopic.php?p=1001567  
20180823/https://picamera.readthedocs.io/en/release-1.10/recipes2.html#raw-bayer-data-captures

Also interesting is that the forum members found some source code on
the same hardware in earlier mobile phones.  Unfortunately some of it
was programmed against an obsolete interface.

Here is more useful and interesting information on the Raspberry Pi
camera.

20180823/https://picamera.readthedocs.io/en/release-1.10/fov.html#camera-modes  
20180823/http://www.andor.com/learning-academy/ccd-binning-what-does-binning-mean  
20180823/https://www.dxo.com/us/more-information-about-color-shading
