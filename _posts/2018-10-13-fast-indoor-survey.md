---
layout: post
title: Fastest measurement techniques for indoor surveys
author: quorten
date: 2018-10-13 12:00 -0500
categories: [home-network, raspberry-pi]
tags: [home-network, raspberry-pi]
---

So, now it's obvious.  If you want to create a 3D model of a house as
quickly as possible, you use a laser range finder as a replacement for
a measuring tape.  Then you want to input that data into your modeling
software as quickly as possible.  That means it's easiest to have your
modeling software running on a mobile Raspberry Pi and your laser
range finder connected directly to your Raspberry Pi.  So, how do we
do this?

How do laser measuring tapes work?  How do you know you are getting
the right thing?  First of all, there are two main types of laser
measuring tape.  One is the _phase shift_ type, that sends out a
pulsing pattern with a multitude of wave frequencies and checks the
return signal for interference levels against the original signal.
The distance is solved using the _phase shift_ of the various
frequencies.  The other method is the _time-of-flight_ method.  This
uses clever techniques such as a lock-in amplifier and
super-resolution to get a higher timer resolution, so reasonably
precise measurements can be made.  Finally, some really cheap devices
are not a laser measuring tape at all, but actually just a sonar range
finder that use a laser beam to help you aim.  Also, some devices are
simply just infrared near proximity sensors.  Don't go with those if
you are trying to replicate an aluminum measuring tape.  Also, of
course, laser tape measures have a distance limit, and very long tape
measures compromise on precision.

So, what are your options?  Around the years 2011 - 2014, some people
tried to hack low-cost laser tape measures.  Some companies such as
Leica specialize in survey products and have higher-end equipment that
exposes a 9600 baud serial interface.  But nowadays, apparently you
can buy the laser rangefinder modules separately and get a nice serial
interface that you can connect to a Raspberry Pi.  An extreme option
is to build your own laser rangefinder.  However, for one attempt at
this, it was not recommended for production use due to the fragility
of the setup.

20181013/DuckDuckGo raspberry pi laser range finder  
20181013/https://www.raspberrypi.org/forums/viewtopic.php?p=1169231  
20181013/DuckDuckGo laser measuring tape raspberry pi  
20181013/https://www.sparkfun.com/tutorials/323  
20181013/https://hackaday.com/2014/03/29/hacking-a-laser-tape-measure-in-3-easy-steps/  
20181013/https://hackaday.com/2014/02/28/homebrew-phase-laser-rangefinder/  
20181013/https://blog.adafruit.com/2012/09/28/raspberry-pi-distance-measuring-sensor-with-lcd-output/  
20181013/DuckDuckGo Sharp GP2Y0A02YK0F  
20181013/DuckDuckGo how a laser measuring tape works  
20181013/https://home.howstuffworks.com/laser-tape-measure.htm  
20181013/http://fardevice.com/how-does-a-laser-distance-measurer-work/  
20181013/https://physics.stackexchange.com/questions/255947/how-do-laser-tape-measures-work  
20181013/https://en.wikipedia.org/wiki/Lock-in_amplifier
