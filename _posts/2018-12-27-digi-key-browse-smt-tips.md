---
layout: post
title: Digi-Key explorations, and surface-mount device soldering tips
date: 2018-12-27 20:37 -0600
author: quorten
categories: [raspberry-pi, reiterate]
tags: [raspberry-pi, reiterate]
---

So, I started looking around on the Digi-Key website, and I noticed
that they have quite a bit of useful general information on their site
too, in addition to the parts that they sell.  Interestingly, Digi-Key
employs a lot of people 24/7 to help with customer support, like their
Applications Engineering department that is filled with nearly one
hundred Engineers and technicians.  Not only do they help answer
customer questions from hobbyists and professionals alike, but they
learn a bit of new things along the way.

Digi-Key created a KiCad library of real Digi-Key components that you
can use if you are using KiCad.  Indeed, I must admit, KiCad is
getting really popular to use nowadays, more so than competitor gEDA.

20181227/https://www.digikey.com/en/resources/year-in-review  
20181227/https://www.digikey.com/en/blog/the-start-of-the-digi-key-kicad-library

Chip-on-board LEDs give a bright, uniform light source that can be
viewed from a wide angle, due to being able to pack the individual LED
modules much more densely.  The main disadvantage is the limited
number of colors available.  Chip-on-board LEDs typically require an
external driver circuit.

20181227/https://www.digikey.com/en/articles/techzone/2016/aug/the-basics-of-chip-on-board-cob-leds

<!-- more -->

This is an interesting, a top 10 things to know before getting started
with Raspberry Pi.  Again, I reiterate, because this is important!  I
must note, however, that the comment about never powering the
Raspberry Pi from the GPIO pins is **not** correct, especially in the
case of the Raspberry Pi Zero that does not even have that polyfuse
protective chip that is self-reseting and can be replaced.

Also, there is another such interesting guide about the top 10 things
to know about getting started on an Arduino.  Particularly interesting
is the tiny Arduino models available from Adafruit.  Oh, and Digi-Key
also carries Adafruit and Sparkfun products, so that is helpful for
you to be able to buy all the parts you need from a single source.
The Arduino article also covers some very basic things to keep in mind
when getting started on a project, and says that even the author, as a
professional electrical engineer for over 10 years, still does the
most basic of tests on a new board like blinking an LED to verify that
they at least have a sane setup where they can control the board and
see that it is functioning.

20181227/https://www.digikey.com/en/articles/techzone/2017/feb/10-things-to-know-before-starting-a-raspberry-pi-project  
20181227/https://www.digikey.com/en/articles/techzone/2017/jan/10-things-to-know-before-starting-your-arduino-project  
20181227/https://www.digikey.com/product-detail/en/adafruit-industries-llc/1500/1528-1020-ND/4990769

So, since Adafruit does so many interesting and useful things
nowadays, what does Wikipedia have to say about Adafruit Industries?
Oh, quite a bit, and I learnec a few other new things along the way
too.  MicroPython is a variant of the Python interpreter designed to
run on microcontrollers.  The BBC Micro Bit is a new microcontroller
which is, you guessed it, made by the BBC in homage to the BBC micro.
Like the BBC Micro, it as integration into educational curriculums.
Zephyr is a lightweight operating system designed for realtime
embedded targets.  So, that is useful for looking into for the sake of
my minimal systems investigations.

20181227/https://en.wikipedia.org/wiki/Adafruit_Industries  
20181227/https://en.wikipedia.org/wiki/MicroPython  
20181227/https://en.wikipedia.org/wiki/Micro_Bit  
20181227/https://en.wikipedia.org/wiki/Zephyr_(operating_system)

Good article on power supply decision considerations, make versus buy.

20181227/https://www.digikey.com/en/blog/the-make-vs-buy-decision-just-tipped-to-buy-for-1-to-10-amp-dc-regulators

----------

So, unfortunately after searching around a bit on Digi-Key, it appears
there aren't really any more good options for buying a surface-mount
motor control chip pre-mounted to a board.  Okay, well maybe there
are, but there sure aren't as many of those as there are of buying the
surface-mount chips directly.  So, my verdict is to buy some of the
surface-mount chips like the good old Toshiba TB6612FNG motor control
IC and hand solder it to a board myself.

So, let's review and search for more info on hand soldering
surface-mount components.  Indeed, the general process is what you've
thought you read before.  You use a soldering iron to touch each
surface-mount pin.  However, there are a few more notable tricks that
I've found.  One is applying flux to the pins to help the solder
spread and adhere correctly with minimal rework.  Another really nifty
trick is to just drag a ball of solder across the pins after flux has
been applied.  Surface-mount soldering can be done without flux under
some circumstances too.

20181228/DuckDuckGo hand solder surface mount components onto circuit
  board  
20181228/https://www.instructables.com/id/Soldering-and-Desoldering-Surface-Mount-Components/  
20181228/https://www.wayneandlayne.com/smt/hand-soldering-smt/  
20181228/https://www.youtube.com/watch?v=MiJOv3aRCYk

----------

So, here I have an idea of my own to help ease soldering surface-mount
components.  Now, one of the problems with getting surface-mount
components is getting the component lined up on the pads as there is
no mechanical structure to hold it in place in only the designated pad
locations.  But, who said you can't build a miniaturized version of
your own such structure?  Rather than having the indentations deep
enough to be a full through-hole component, the indentations need only
be deep enough so that you can line up the pins in their proper
locations.  By stacking up sheets of paper, you can easily design
shallow trenches in which to insert the pins.
