---
layout: post
title: "Raspberry Pi Zero GPIO \"snap together,\" sound output, PWM,
        realtime, Pine64 computer"
date: 2017-02-25 21:00 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Failed search.

20170225/DuckDuckGo raspberry pi gpio pins snap together lego

So, I'm not sure if there is an easy solution that I can purchase to
have snap-on GPIO pin header mounts for the Raspberry Pi Zero.  I
could just as well have to make my own.

Okay, so now I'm wondering.  How do I get simple, cheap sound output
on the Raspberry Pi Zero?  Oh, this is a great reference.

20170225/DuckDuckGo raspberry pi zero sound crystal
20170225/https://learn.adafruit.com/introducing-the-raspberry-pi-zero/audio-outputs

These are also some other interesting related references.  Oh, shucks!
I could have gotten the HDMI to VGA adapter that has the sound output
jack on it if only I looked on Adafruit!

20170225/https://learn.adafruit.com/introducing-the-raspberry-pi-zero/video-outputs  
20170225/https://www.adafruit.com/products/1151

Also, this is useful if I want to add composite video output to the
Raspberry Pi Zero.

<!-- more -->

20170225/https://www.adafruit.com/products/2792  
20170225/https://www.adafruit.com/products/2793

Hey, but here we have more description on the GPIO pin header.  Oh, it
is suggested that you can put a socket mount on there, are there
links?  Unfortunately, I could not find any particular links, so I'd
have to go search their website.

20170225/https://learn.adafruit.com/introducing-the-raspberry-pi-zero/gpio-header-options

* Oh, also interesting is mention of thermocouple sensors on the
  Adafruit website.

Anyways, hey, getting back to the audio output discussion.  If you
looked at those two options for schematics, yes, those require that
you setup a considerable amount of external electronics.  So, now I'm
going back to the Apple II idea of just clicking the speaker.  That we
know requires considerably less external support electronics.  Okay,
come on, where can we find more information on setting this up?

20170225/DuckDuckGo raspberry pi pwm 1 bit sound output crystal

20170225/https://www.raspberrypi.org/forums/viewtopic.php?f=2&t=5386

Okay, finally, I found what I was looking for.

20170225/https://projects.drogon.net/software-pwm-on-the-raspberry-pi/  
20170225/http://raspberrypi.stackexchange.com/questions/53854/driving-pwm-output-frequency  
20170225/http://abyz.co.uk/rpi/pigpio/index.html

Wait, RPIO.PWM produces 1 microsecond PWM, whereas the previous
library I referenced produces up to 5 microsecond PWM.

20170225/http://raspberrypi.stackexchange.com/questions/298/can-i-use-the-gpio-for-pulse-width-modulation-pwm

Yes, lots more good links on that previous article.

Okay, with all this talk about Linux not being a real-time operating
system, yeah I know that's not entirely true.  We have real-time
Linux, so what efforts do we have to run real-time Linux on the
Raspberry Pi?  Yes, according to these sources, the necessary
real-time patches are already merged into recent mainline kernels.
However, there may be some drivers on the Raspberry Pi that don't play
well with the real-time patches and weren't tested as such.

20170225/DuckDuckGo raspberry pi realtime linux  
20170225/https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=2376  
20170225/http://raspberrypi.stackexchange.com/questions/1408/is-it-possible-to-run-real-time-software

----------

Less closely related, some information on the Pine64 computer, high
performance Raspberry Pi competitor, and an Adafruit article for
comparing some different single-board computers to each other.

20170225/https://en.wikipedia.org/wiki/Pine64  
20170225/https://www.yahoo.com/tech/meet-pine-a64-64-bit-quad-core-supercomputer-141831305.html  
20170225/https://learn.adafruit.com/embedded-linux-board-comparison
