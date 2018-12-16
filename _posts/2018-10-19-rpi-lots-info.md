---
layout: post
title: "Lots of Raspberry Pi info: optical viewfinder, connector
        information, displays, eccentric peripherals, 2.8 V power
        trick"
author: quorten
date: 2018-10-19 22:26 -0500
categories: [raspberry-pi, reiterate, important]
tags: [raspberry-pi, reiterate, important]
---

So, for the Raspberry Pi 3D scanner, camera, measuring device, etc.
The verdict is clear.  I will be using an optical viewfinder on the
camera when I need to see what the camera sees.  Now, the problem just
comes down to where to buy the part?  Well, you can't really buy a
readymade part for this purpose.  Your easiest options are to scavenge
the optical viewfinder from a point-and-shoot camera or build your own
optical viewfinder.  After some tough searching, after failing, with
the fist idea of searching for a readymade device, I found a great
site that has this nice lens search tool for finding precisely the
lens you need, without needing custom manufacturing.  Otherwise, that
was the second best option when you need a very specific lens size and
focal length, but all else equal being plastic.

20181019/DuckDuckGo build your own plastic lens  
20181019/https://digital-photography.wonderhowto.com/how-to/howto-build-your-own-camera-lenses-0118179/  
20181019/https://www.diyphotography.net/build-your-own-lenses/  
20181019/https://www.surplusshed.com/

BUT, beware.  So I did a search on their site, and although you can
get _lenses_ alright, there don't appear to be any markings on the
materials of the lens.  Plastic?  Glass?  I don't know.

Also, there are other interesting parts on there.  LCD for a Sony rear
projection TV for only $18?  How, you could make a pretty spiffy
digital video projector with that!  If only you could figure out the
signaling on that cable, that is.

<!-- more -->

20181019/https://www.surplusshed.com/pages/item/L14553.html  
20181019/https://www.surplusshed.com/pages/item/L14552.html

Now, let's look for JST connectors.  Ut oh, wait.  A JST connector is
not actually what I thought it was, upon closer inspection.  So, I
found this very Sparkfun page on electronics connectors, and now it is
clear that I am looking for a _crimp connector_.

20181019/DuckDuckGo internal small electronic connector types  
20181019/https://learn.sparkfun.com/tutorials/connector-basics/all  
20181019/https://www.sparkfun.com/news/2328

Now, pin headers or no pin headers?  Well, it turns out many hobbyist
buyers are preferring pin headers.

20181019/https://www.sparkfun.com/news/2027

This is a really interesting and also risky method of removing pin
headers.  Cut the pin header plastic apart, remove the plastic heads,
use the soldering iron to liquify the solder, then slap the board
against the table, briskly but not too rough.  The solder and pin will
come flying out, and you must also be careful wear goggles and cover
skin given the associated risks of the dangerously hot solder, though
it does cool quickly.

20181019/https://www.sparkfun.com/tutorials/339

Wow, now this is interesting.  Cutting edge technology, neutrino
detectors, Iridium satellite communications, and other cool stuff.
But, the economic risk involved in stocking these products.  Who will
use them?  Hou could a neutrino detector be useful to most people?
Why would people want to use satellite communications when cellular
communications will work just fine and be much cheaper?

20181019/https://www.sparkfun.com/news/2025

Okay, now for LCD digit displays?  In short, find them on Digikey.
Beyond that, I found some other useful tutorials.  Oh, and there's
lots of advertising for pairing those full LCD graphics displays with
a Raspberry Pi.  There are the character-style displays, but I want to
avoid that as it is unnecessary complexity for my use case.  Typically
you will need controllers for more complicated screens.

20181019/DuckDuckGo raspberry pi lcd screen chiclet key calculator face  
20181019/DuckDuckGo raspberry pi calculator lcd screen  
20181019/DuckDuckGo raspberry pi digit lcd screen  
20181019/DuckDuckGo raspberry pi 7 segment lcd screen  
20181019/DuckDuckGo 7 segment lcd module  
20181019/https://projects.drogon.net/7-segment-led-display-for-the-raspberry-pi/  
20181019/https://www.modmypi.com/blog/how-to-drive-a-character-lcd-display-using-the-raspberry-pi  
20181019/https://pimylifeup.com/raspberry-pi-lcd-16x2/  
20181019/https://averagemaker.com/2014/05/raspberry-pi-7-segment-display.html

This is one of the companies that does custom LCD display
manufacturing.

20181019/https://www.displaytech-us.com/7-segment-lcd-displays

Now, what about the Zero Phone, the mobile phone designed around a
Raspberry Pi Zero?  This uses a graphics-style monochrome LCD screen.
The keyboard is buttons soldered onto a PCB with a microcontroller to
send signals to the Raspberry Pi.

20181019/DuckDuckGo zero phone  
20181019/https://hackaday.io/project/19035-zerophone-a-raspberry-pi-smartphone

NOTE: You were asking what a "mega" is in relation to multiple serial
connections for a Raspberry Pi?  They must have been referring to an
Arduino Mega (ATMega microcontroller), not an IOMega or anything more
esoteric.

20181019/DuckDuckGo raspberry pi calculator keyboard  
20181019/https://raspberrypi.stackexchange.com/questions/5007/using-an-old-laptop-keyboard-with-raspberry-pi

Now, this is really interesting.  NumWorks calculator?  It uses a nice
fast ARM CPU, a 320x240 color LCD screen, and a rechargeable
lithium-ion battery.  Also, it can be programmed in Python.  But
that's not all: the design and software source code are extensively
and openly published too.  Curiously, though, it doesn't have very
much more RAM and flash memory than the older TI graphing calculators
that came before it.  On the other hand, it is a wholly open design.
Interestingly, there isn't a Wikipedia article on it.

Now, NumWorks features Apple-style site design and box design, and
plenty of views of Apple devices on their site.  So, you kind of get
the idea of the intended customer of this product, even though the
price point, at $100, is not much different from the TI calculator
offerings.  On the TI calculator side, the newer models are also
sporting higher resolution color screens and faster CPUs, though still
not ARM and Python.

Yeah, so the NumWorks calculator does a good job of making it look
better than it actually is on first sight.  If you take a spin through
the online simulator, you will find out that the calculator's Python
is still very far aways away from a true Python installation.  Also,
interestingly the calculator does not run Linux, but uses an extremely
compact stripped down kernel.

20181019/https://zardam.github.io/post/raspberrypi-numworks/

Wow, so reading that article, some important points about Raspberry Pi
Zero need to be stated.  Important!

* You actually **can** run a Raspberry Pi Zero off of only 3.3 V...
  actually, all the way down to 2.8 V.  Matter of fact, that's what
  the ARM-based NumWorks runs off of all of the time, and it works
  just fine.  Note that this only applies to the plain version, or the
  Zero W with Wi-Fi disabled.  Wi-Fi will bump the voltage demands
  above this limit.

  So, how exactly do you power off of only 2.8 V?  Do you wire
  directly up to the CMOS 3.3 V power pin?  Well, well, if the author
  of this article was true to his mistakes, then you would see that
  there is an unused solder joint on one of the 3.3 V pins in one of
  the photos.  So, looking carefully, this actually isn't the case.
  That must mean that the 2.8 V power is being fed in from the 5 V
  input.  And, according to further sources that I have cited later,
  this works because the regulator to step down to 3.3 V is a linear
  voltage regulator, not a switching one.  So, there will be no weird
  signal boosting dynamics.  As for the 5 V devices, you simply don't
  use them (HDMI and USB hub), so the fact that they don't get
  sufficient power is irrelevant.

  No, really, why does 2.8 V power work okay?  Indeed there is a 1.0 V
  to 1.1 V voltage drop through the 3.3 V voltage regulator, but the
  processor itself only needs to run off of 1.8 V, which is just in
  the usable sweep spot.  So, this also means that if you are running
  off of only 2.8 V, you're also not intending to use any devices that
  require 3.3 V power either.

  As for the VDD_BATx pin on the BCM2835, it doesn't actually do
  anything useful as far as a Raspberry Pi is concerned.

  Again, I reiterate, because this is important!  Check out the
  Raspberry Pi 3 B+ power supply article, because that article has
  some great details on the workings of the power supplies of older
  Raspberry Pi models too.

  20180821/https://www.raspberrypi.org/blog/pi-power-supply-chip/  
  20181209/https://www.exar.com/product/power-management/universal-pmics/universal-pmics/mxl7704

    * Yes!!!  It **is** in fact possible to power a Raspberry Pi Zero
      with only a 3 V power source, two AA batteries.  Yes, just like
      the original handheld Gameboy consoles, no need for weird three
      or four battery configurations unless you don't know what you
      are doing.

    * Unfortunately, the new MxL7704 PMIC used on the Raspberry Pi 3
      B+ has a minimum input voltage of 4.0 V.  This is not an issue
      for now as it is not being used on Raspberry Pi Zero boards, but
      it's something to watch out for in the future.  If future
      Raspberry Pi Zero boards start using that PMIC, they'll loose
      the ability to run off of 2.8 V input.

* You **can** connect displays to a Raspberry Pi Zero with quite the
  ease, actually.  You don't need the DSI/MIPI connector available on
  the Raspberry Pi A+/B+ to easily connect an internal display, nor do
  you need to use up a whole lot of GPIO pins.  And SPI-connected
  display will work just fine, at least for 320x240 resolution with
  18-bit color, maximum 60 Hz refresh rate.  Of course, for a handheld
  calculator-like device, you probably don't need to or want to exceed
  that resolution very much.

* Other ways to disable HDMI port power.  The easiest way to do this
  is through a boot option: `hdmi_blanking=2`.

20181019/https://en.wikibooks.org/wiki/Unofficial_Guide_To_Expanding_Your_Numworks/Getting_your_development_environment_set_up  
20181019/DuckDuckGo NumWorks  
20181019/https://www.numworks.com/
20181019/https://www.numworks.com/why/  
20181019/https://www.numworks.com/specs/  
20181019/https://en.wikipedia.org/wiki/TI-89_series#TI-89_Titanium  
20181019/https://en.wikipedia.org/wiki/TI-84_Plus_series  
20181019/https://en.wikipedia.org/wiki/Zilog_eZ80

Yeah, so about that Raspberry Pi Zero power trick.  Now, that is a
really obscure trick that almost no one else on the web has figured
out.  But indeed, there are plenty of people who would prefer to power
their Raspberry Pi Zero off of a 3.3 V battery pack, they just haven't
quite figured out the trick and are still 3 V to 5 V boost converters.

20181019/DuckDuckGo raspberry pi zero 3 v battery power  
20181019/https://raspberrypi.stackexchange.com/questions/32601/power-with-batteries-on-3-3v#40312  
20181019/https://www.modmypi.com/blog/running-a-raspberry-pi-zero-from-an-aa-battery-pack  
20181019/DuckDuckGo VDD_BATx BCM2835  
20181019/https://developer.qualcomm.com/comment/11688  
20181019/https://www.raspberrypi.org/forums/viewtopic.php?p=326812

But for sure, the good news is that the boost converter can be very
small and compact if you make sure to shop for the right one.  But,
for sure even at 3.3 V, you will still need a boost converter if you
are powering from Nickel Metal-Hydride rechargeable batteries.
