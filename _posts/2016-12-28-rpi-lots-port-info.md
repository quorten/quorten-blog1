---
layout: post
title: "Raspberry Pi GPIO info, HATs, camera, UART, lithium-ion
        battery, USB gadgets mode, schematics, anti-static paper"
date: 2016-12-28 21:00 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, time to figure out how the GPIO pins work on the Raspberry Pi.
What voltages do we get?  Answer: 3.3 volts from the GPIO pins.  In
other words, straight out the max voltage of your laser module.  Also
the typical voltage for CMOS circuits, of course.  Also, note that the
Raspberry Pi Zero provides 3.3 volt and 5 volt pins.  These are
digital-only pins, of course.  If you need analog and such, you'll
have to use ADC and DAC devices.

20161228/DuckDuckGo raspberry pi gpio voltage  
20161228/https://www.raspberrypi.org/documentation/usage/gpio/  
20161228/https://www.raspberrypi.org/forums/viewtopic.php?f=28&t=40150&p=329080

----------

Wait, what was the alternative mentioned on Adafruit to soldering a
pin header to the Raspberry Pi GPIO pin slots?

Adafruit page for Raspberry Pi Zero v1.3:

20161228/https://www.adafruit.com/products/2885

Oh, it was HATs.  Pi HATS & PLATES:

20161228/https://www.adafruit.com/categories/286

<!-- more -->

So you want Wi-Fi and Blutooth for your Raspberry Pi Zero?  You can
use this Red Bear IoT pHAT to gain those.  $16.95 though, so not cheap
compared to the Raspberry Pi Zero.

20161228/https://www.adafruit.com/products/3329

* UPDATE 2019-11-20: Raspberry Pi Zero W was released as an
  alternative with built-in Wi-Fi, so you can use that if you don't
  mind having short antennas.  Otherwise, to get longer antennas, you
  are better off with just Raspberry Pi Zero and rolling your own
  solution for wireless.

Now, this one is particularly interesting.  It is a TFT LCD
touchscreen that uses GPIO rather than HDMI.  So, I am told that using
GPIO rather than HDMI brings the cost down by not needing to include
an HDMI decoder.  Well, given the cost, $19.95, for the size of its
display outputs, 5" or 7" displays, this has a pretty good cost.  Oh,
wait, is the display not included?  I may be doing my cost equations
wrong if this is the case.  Yep, TFT display not included.  Okay, so I
was a little bit misled by the price, then.

20161228/https://www.adafruit.com/products/2453

Now this one is also an interesting one.  3D sensor?  How does it
work?  This 3D sensor uses electric charge sensing, so it specifically
does not work on conductive materials such as metals.

20161228/https://www.adafruit.com/products/2325

Cirrus Logic sound card.  Now, why do I include this?  Well, the most
interesting thing mentioned on the page is the sampling quality for
output.  24-bit 192 kHz.  Yes, so good enough to do ultrasound, at
least low-frequency ultrasound that is.

20161228/https://www.adafruit.com/products/1761

----------

On the Raspberry Pi Zero Adafruit page, there are links to many other
HOWTOs for interesting things that you can do with your Raspberry Pi
Zero.

But, the most interesting of them all, this article on how to build a
Raspberry Pi Wearable Time Lapse Camera.  At one of the steps, it
recommends 3D printing for the case, so this is definitely being
written by a _digerati_ and their related socioeconomic status, not so
much for more normal people for whom owning a 3D printer would be a
prohibitive expense.

Also, it has instructions on how to setup a Lithium-ion polymer
battery to power your Raspberry Pi.  The battery and board requires
additional surface area space similar to that of the Raspberry Pi Zero
times two, so the resulting construction is not nearly as compact as I
thought from the looks of the picture.  Then again, that's probably
also why the Raspberry Pi camera looks so small on the face of the
device, simply because the device itself is a bit bigger than I
expected.

20161228/https://learn.adafruit.com/raspberry-pi-wearable-time-lapse-camera

Oh, and for the camera lens.  I see what happened.  In the pictures,
there is a supplementary lens placed in front of the main
construction.

Oh, and actually, the battery and control circuit are stacked
underneath the Raspberry Pi Zero.

Oh, and at the end... it includes a section on converting to video.
It indicates that there are very many different ways to do this, and
illustrates only one way that uses proprietary software, in addition
to making suggestions about the use of proprietary software.  So,
there you go.  Definitely a digerati.

----------

Turn your Raspberry Pi Zero into a USB gadget?  This is what I have
been looking for!  It's exactly it!  So, here is what it does.  You
have a Raspberry Pi Zero, and you want to plug it into a PC just as if
it were a USB networking device or a USB flash drive.  How do you do
it?  Through the Linux USB gadgets system.

20161228/https://learn.adafruit.com/turning-your-raspberry-pi-zero-into-a-usb-gadget

One thing that I must comment on is that this howto says that you need
a USB console cable.  Well, technically you don't even need that for
prep, what you can do is prep the image inside of a Raspberry Pi
emulator on your PC, and once it is ready, you can copy the image to
your MicroSD card, insert that into your Raspberry Pi, and just boot
right up.

Also, as an aside, did you see the PuTTY dialog box?  How many
different gadgets did this article writer purchase?  Yeah, again,
we're kind of running up against a digerati here, for sure.

Indeed, the Linux USB gadgets system has been around for quite a long
time.  It looks like Overo Gumstix was instrumental in its
development, along with many other earlier embedded chipsets.  Of
course, this was all before they were nearly as cheap as they are
today.

20161228/http://www.linux-usb.org/gadget/

So, what about Overo Gumstix?  Can I get more history from Wikipedia.
Unfortunately, no.  But, their website has a little tiny bit of
history in the "About us" section.

20161228/https://en.wikipedia.org/wiki/Gumstix  
20161228/https://en.wikipedia.org/wiki/File:Gumstix_oconnor.JPG  
20161228/https://www.gumstix.com/  
20161228/https://www.gumstix.com/about-us/

I must admit, the Overo Gumstix extension board does make the Gumstix
a little bit more powerful than the Raspberry Pi with a little bit
less space.  Oh, sure, maybe there are appropriate Pi HATs I can get
to do likewise with the Rapsberry Pi.

----------

Wait, wait.  You need a lot more information if you want to use the
USB console cable on a Raspberry Pi Zero successfully.  Namely, you
need to know the GPIO pin-out.  What is that, anyways?  Can you show
me exactly what it is?  Unfortunately, that is a bit harder to come
across.  Yes it's true that the Raspberry Pi community is among the
biggest of embedded systems communities, but it feels that it just
isn't all that big compared to the pure software developer
communities.  Not as big in total size.  Well, never fear, even though
there is a shortage of information on the Raspberry Pi Zero, I've
found _just enough_ information to verify that the GPIO pins are
designed to be compatible with that of the older systems (B2), and
from the schematic diagrams and photos, I've found that the "J8" label
on the top of the Raspberry Pi Zero board is indeed indicative of the
orientation of the GPIO pin labels between the schematic and the
physical board.

20170518/https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=127116

Also, never fear about your existing console cable being the wrong
one.  Studying one of the photographs carefully, you do indeed have
the same kind of cable as was shown in the picture.  Yet the red lead
supplies 5 volts, but the TxD and RxD leads should be the correct CMOS
logic level.  The "TTL" label in your packaging may have just been an
error on ThinkPenguin's part, but the manufacturer of the device
should be the same.

* But wait!  Even on Adafruit, they call it a "USB to TTL" serial
  cable, even though it is really a "USB to CMOS" serial cable.
  UPDATE 2019-11-20: the cable likely auto-detects TTL/CMOS logic
  levels.

Before you can use the CMOS serial connection, you must enable it
using one of these two methods:

1. Edit `/boot/config.txt`.  At the bottom, last line, add
`enable_uart=1`.  You can do this on the SD card directly from a
computer, rather than booting the Raspberry Pi.

* Note that on my version of Raspbian, I have found that `enable_uart`
  does not cause any changes.  Maybe this only has an effect on newer
  versions of Raspbian.  Or maybe only on older versions.

2. * `sudo raspi-config`
   * Advanced Options > Serial > Yes
   * When asked to reboot, answer "yes."

Yep, just like you must enable the camera before you can use it.
Security, security.  Yes, I know, this is a good default
configuration, especially since the Raspberry Pi Zero has so many
hardware features and functions that a novice could get lost and
accidentally leave some unwanted features enabled.

And remember, connect to the serial console just like this:

```
sudo screen /dev/ttyUSB0 115200
```

Oh yeah, and before you get stuck not being able to login.  In the
Raspbian default distribution image, the default "pi" user's password
is "raspberry".

Actually, honestly, for the Ethernet gadget, you don't even have to
log into your Raspberry Pi to make those modifications.  You can make
them entirely by tweaking the configuration options on the SD card
from your computer.  So, you don't need to have any extra computer
hardware beyond the Raspberry Pi Zero to get started.

Finally, one last note on the Ethernet gadget.  On older GNU/Linux
distributions, you'll have to manually run the following command to
setup Bonjour/Zeroconf networking on your hot-plugged network device:

```
sudo avahi-autoipd usb0
```

20170518/https://learn.adafruit.com/adafruits-raspberry-pi-lesson-5-using-a-console-cable

Some very important photos and diagrams illustrating how to wire the
serial console up.  It goes like this:

```
       O  R*   B   W   G   O   O
      []   O   O   O   O   O   O
  J8
```

That is, looking from the Raspberry Pi Zero from the top ("J8" marking
visible), "square pin" at bottom left, the pins should be plugged into
the top row, with the left-most pin hole empty.  Then, the next pin to
the right can be the red 5V power pin, which is optional.  Only use
this if you want to power your Raspberry Pi from the console cable.
After that to the right, the black ground pin should be plugged in,
next the white TxD pin to the right, and last to the right is the
green RxD pin.

20170518/https://learn.adafruit.com/adafruits-raspberry-pi-lesson-5-using-a-console-cable/connect-the-lead  
20170518/https://learn.adafruit.com/assets/35695

These are the schematics, plus a few select links from the list:

20170518/https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/README.md  
20170518/https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/Raspberry-Pi-Zero-V1.3-Schematics.pdf  
20170518/https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/Raspberry-Pi-2B-V1.2-Schematics.pdf  
20170518/https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/Raspberry-Pi-A-Plus-V1.1-Schematics.pdf

This site particularly has the important diagram where a "square pad"
is shown for some of the pins, necessary to understand with confidence
the physical hardware orientation.

20170518/https://pinout.xyz/

Here is some additional information from Wikipedia to help increase
confidence.

20170518/https://en.wikipedia.org/wiki/Raspberry_Pi#Connectors  
20170518/https://en.wikipedia.org/wiki/File:Location_of_connectors_and_ICs_on_Raspberry_Pi_Zero.svg

----------

This is also useful.  How do you enable the Raspberry Pi camera
without needing to boot your Raspberry Pi and use `raspi-config`?
Edit `/boot/config.txt` and use `start_x=1` to enable, `start_x=0` to
disable.  I know, weird name there, but that's how you do it.

20170520/DuckDuckGo raspberry pi enable camera  
20170520/https://www.raspberrypi.org/documentation/usage/camera/  
20170520/https://raspberrypi.stackexchange.com/questions/10357/enable-camera-without-raspi-config

----------

So, I ask the question.  Is paper a viable anti-static material?  If
you build a computer case out of paper or cardboard, would that
provide sufficient protection for static-sensitive components?  The
answer is yes.

20161228/DuckDuckGo plastic case static sensitive electronic equipment

Industrial supplier of carrying cases for sensitive equipment.

20161228/http://www.iqsdirectory.com/carrying-cases/

20161228/DuckDuckGo is paper anti-static  
20161228/https://hardforum.com/threads/antistatic-bag-alternatives.1574261/

4LC4PON3 wrote:

> this is directly from the PDF they emailed me when I shipped out my
> GPU to them
>
> Please avoid the use of soft packages or padded mail envelopes as
> they will not provide adequate protection for the product. Any
> damage caused by inadequate protection during transit will void the
> warranty and the product will be shipped back as is.
>
> Please put the product in an anti-static bag (use a brown paper bag
> if an anti-static bag is not available) before packing the
> product. Avoid any materials which may increase risk for static
> electricity discharge such as aluminum foil, electrical tape, duct
> tape, etc. Only the faulty item is required. Please do not send any
> accessories

20161228/https://en.wikipedia.org/wiki/Antistatic_bag  
20161228/https://en.wikipedia.org/wiki/File:Antistatic_Bags.jpg

But, remember, paper has its anti-static limits.  In my own anecdotal
experience, in the winter, I've noticed small amounts of static
discharging through my body through the wallpaper on the walls, maybe
to neutralize with the "ground" of the sheet-rock in the walls.

Note that you can also buy special anti-static paper.  But, that's a
little bit beyond the initial motive of being able to use scratch
paper that you have around your regular physical environment.

20161228/https://www.alibaba.com/showroom/anti-static-for-paper.html  
20161228/http://www.correctproducts.com/ESD-Cleanroom-Products/ESD-Binders-Paper-Sheet-Protectors/ESD-Paper_4.html

----------

Raspberry Pi notes.

What are the RUN pins on the Raspberry Pi Zero?  If you connect the
two pins, that causes a RESET to the Broadcom CPU.

20170520/DuckDuckGo raspberry pi run pins  
20170520/https://raspberrypi.stackexchange.com/questions/29339/what-are-the-run-pin-holes-on-raspberry-pi-2
