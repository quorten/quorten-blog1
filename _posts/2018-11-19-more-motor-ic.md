---
layout: post
title: "More about motor control ICs, looking for 3.3 V IC, and
        optical gyros"
author: quorten
date: 2018-11-19 11:58 -0600
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, you're wondering about the L293D just right off the bat?  Search
for some quick information on it, eh?  Well, well, this is what I
found out.

* Indeed, this chip is available from Digikey.

* The chip is also available from Adafruit, and they have a nice
  product information page on it for beginners who are not super
  skilled in electronics.

* The chip is in fact a dual H-bridge integrated circuit.  No magic
  involved in its design.

* You can also use the L293D to control stepper motors and solenoids.
  In the case of solenoids, 4 can be controlled with one motor control
  unit.

* There is a built-in inductive kick-back protection diode, of course.

* On the other hand, that means for motors that guard voltage
  regulators and diodes may still be required, in case the motor gets
  turned externally and runs in "generator-mode."

* PWM input can be used to modulate the motor speed.

* The L293D won't work well with 3 V motors, unfortunately.  Yes, you
  _can_ use it to control 3 V motors, but it won't work very well.
  Okay, that's it.  Some of the most important motors I have to
  control are 3 V motors.

* That being said, I better actually go searching for a motor
  controller that is good for controlling 3 V motors.  As a nice plus,
  if it also runs off of 3 V logic, I can control my whole system
  using only 3 V power.  Then, 5 V are only needed for USB and HDMI,
  which are purportedly only in used if you are "docked" to systems
  that have line power available.

* Perfboard friendly through hole chips are preferred over
  surface-mount PCB chips.

20181119/DuckDuckGo L293D  
20181119/https://www.digikey.com/product-detail/en/stmicroelectronics/L293D/497-2936-5-ND/634700  
20181119/https://www.adafruit.com/product/807

<!-- more -->

----------

So, a cursory search for 3 V motor controllers brings up this.  And
apparently there is an LM293D IC that can be used to control 3 V
motors.  Ah, so just a simple variation on the L293D is all that is
needed.  But looks like that runs off of 5 V too.

20181119/DuckDuckGo 3v motor control ic  
20181119/https://thecustomizewindows.com/2015/08/arduino-3v-dc-motor-control-transistor-ic-more/  
20181119/https://www.ti.com/store/ti/en/p/product?p=LM293D  
20181119/http://www.ti.com/lit/ds/symlink/lm293.pdf

Ah, I found something really promising here.  Yes, indeed there are
motor drive ICs that operate off of only 3.3 V, and here is one of
them as an example.  Although, if you look at the date of the article,
2017-11-20, these integrated circuits are decidedly quite recent and
new.  By contrast, if you're content with 5 V supply voltage, you can
choose from a long line of ICs that have been around for quite some
time.

20181119/DuckDuckGo 3v motor drive ic  
20181119/https://www.elektormagazine.com/news/3-phase-driver-ic-switches-bldc-mosfets

Also interesting.  As of very recently, 2018-11-05, optical gyros are
now available in a miniature form factor that can be used in
smartphones and tablets.  Previously an optical gyro was no smaller
than a golf ball, so they were not used in those applications.
Conventional gyros are micro electrical mechanical systems (MEMS) that
take measurements off of small vibrating weights inside.  The primary
advantage of optical gyros is that they are more accurate than MEMS
gyros.  But what about the cost?  Well, for now let's assume that is
tentative.  Purportedly the devices should be cheap simply because
they are small integrated circuits.

20181119/https://www.elektormagazine.com/news/optical-gyro-dwarfed-by-a-grain-of-rice

Also another interesting thing here.  A kit to get you setup using an
ePaper display on a Raspberry Pi.  What is the main advantage of
ePaper over LCD displays?  ePaper doesn't require power to refresh it.
Therefore, the controlling computer can power itself off until the
contents of the display need to be changed.

20181119/https://www.elektormagazine.com/news/papirus-epaper-for-raspberry-pi
