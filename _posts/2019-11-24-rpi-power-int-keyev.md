---
layout: post
title: "How to implement a Raspberry Pi power button, and using
        `gpio-keys` for interrupt-driven GPIO key events"
date: 2019-11-24 14:29 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

I have previously seen inside the Raspberry Pi device tree (DT)
overlay information on how to wire up a power button for a Raspberry
Pi.  Now that I am about to use a Raspberry Pi as a desktop PC
replacement, I have a more immediate need for an actual power button.
So I thought I better do some additional web searching and write an
actual blog article with the information on how to do this.

A cursory search brings up an article about how to create a Raspberry
Pi power button **without** the use of the device tree (DT) overlay.
After a little bit more searching, it looks like this is the "old
technique" as the necessary device tree overlay, `gpio-shutdown`, did
not exist in earlier versions of Raspbian before Debian Stretch.

20191123/DuckDuckGo raspberry pi power button  
20191123/https://howchoo.com/g/mwnlytk3zmm/how-to-add-a-power-button-to-your-raspberry-pi

That being said, it is my preference to use the device tree (DT)
overlay version instead because I think it is simply a cleaner way to
solve the same problem.

<!-- more -->

20191124/DuckDuckGo raspberry pi power button overlay  
20191124/DuckDuckGo gpio-shutdown overlay  
20191124/https://raspberrypi.stackexchange.com/questions/77905/raspberry-pi-3-model-b-dtoverlay-gpio-shutdown  
20191124/https://www.stderr.nl/Blog/Hardware/RaspberryPi/PowerButton.html  
20191124/https://github.com/raspberrypi/firmware/blob/master/boot/overlays/README

Also noteworthy is the `gpio-poweroff` overlay.  This is an overlay
meant to provide additional support for external power devices so that
when the Raspberry Pi computer board shuts down, it can also send a
signal to the power controller to cut off power to the Raspberry Pi
board (and maybe also larger system) completely, rather than simply
having the Raspberry Pi board idle in the halted state.

Also interesting, from the last link, is mention of the `gpio-keys`
device tree (DT) overlay.  This one allows you to generate arbitrary
key input events when a GPIO button is pushed.  Indeed, a much cleaner
way to implement than a daemon that polls the GPIO event states, and
this likewise allows you to effortlessly take advantage of the the
ability to generate interrupts when a GPIO event occurs, since we have
the required kernel mode code running to intercept the interrupts.
Again, `gpio-keys` was not available in the older versions of Raspbian
before Debian Stretch, so here again is an occurrence of "new way
versus old way."  Yeah, too bad they couldn't get that feature rolled
out earlier in time.
