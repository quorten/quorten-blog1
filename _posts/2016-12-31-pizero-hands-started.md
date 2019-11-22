---
layout: post
title: Raspberry Pi Zero in my hands, getting started
date: 2016-12-31 22:00 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, first of all, so I got my new Raspberry Pi Zero, and now I've
got the USB on-the-go cable, but I can't get the hub to work!  So,
first I start searching.  Apparently, there is a known problem that
the Raspberry Pi Zero does not work well with all USB hubs.  For some,
it works great.  For others, it works with caveats.  Still others, it
might not work at all.

20161231/http://raspberrypi.stackexchange.com/questions/57606/raspberry-pi-zero-refuses-to-detect-usb-hub-tried-multiple-hubs  
20161231/https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=127158  
20161231/http://raspberrypi.stackexchange.com/questions/57014/does-a-usb-hub-work-with-raspberry-pi-zero

So anyways, next I get to experimenting.  With power, without power,
turn on, turn off.  After lots of experimentation, here's what I've
found works well with my Sabrent USB hub.  Well, I shouldn't say it
works well, but it works, with caveats.

First of all, turn on your Raspberry Pi Zero.  At this point, your hub
should have both buttons on it turned OFF.  The power should be
plugged in, though.  Having the hub plugged into the Raspberry Pi Zero
through the USB on-the-go cable is optional.

<!-- more -->

Now, plug in your USB hub to your USB on-the-go cable, if you haven't
already, and note that the USB on-the-go cable is assumed to already
be attached to the Raspberry Pi.  So now, you should have your hub
attached to the Raspberry Pi Zero, but all ports are powered off.
Make sure there is nothing plugged into the hub at this point.  Push
only the FIRST button to power on the first 6 ports (and the last port
at the end of the hub).  Your hub should now be fully initialized, and
you can proceed with plugging in your USB devices.

----------

```
sudo apt-get install telnet
sudo apt-get install libegl1-mesa
sudo apt-get install libegl1-mesa-dev
sudo apt-get install libglm-dev
# The first two installs were just me stumbling around.  The one above
# is okay if you only want OpenGL ES, however.
sudo apt-get install libgl1-mesa-dev
sudo apt-get install libglew-dev
```

You're wondering about glgears?  There is gtkglext demos, and there
are mesa-demos.

20161231/https://github.com/peepo/openGL-RPi-tutorial

Raspbery Pi works better with OpenGL ES than it does regular OpenGL.

sudo apt-get install git cmake

Okay, try that tutorial, maybe that will work better.

20161231/http://raspberrypi.stackexchange.com/questions/41150/virtual-keyboard-activation

sudo apt-get install matchbox-keyboard

Then you have to reboot, and verify it is available from the menu.

Oh my goodness!  First encounter with a deleted GitHub repository.
Not available on the Internet Archive Wayback Machine.

20161231/https://www.raspberrypi.org/forums/viewtopic.php?t=50418
broken/https://github.com/nfz/RPIGears

RPIGears.
