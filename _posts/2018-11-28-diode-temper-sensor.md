---
layout: post
title: Diode as a cheap temperature sensor
author: quorten
date: 2018-11-28 18:00 -0600
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Suppose you want to design a whole large matrix of temperature sensors
to sense multiple points in an entire room.  You should be able to do
this with diodes, correct?  I do remember reading that a laser diode's
performance is dependent on its temperature.  Cooler diodes require
more energy to pump the same light output.

So, now let's go searching.  How do you setup a diode as a temperature
sensor?  Ah, yes, you use the variable reverse bias effect of a diode
to sense the temperature within 5 degrees Celcius or so.  Given that
it's not real good accuracy, well it might not make as much sense as
you thought to use a large array of cheap temperature sensors in a
room.  Maybe one expensive temperature sensor would be just as
effective.  Even half a degree Celcius, which roughly corresponds to
one degree Fahrenheit, isn't all that good for accuracy either.

20181128/DuckDuckGo diode temperature sensor  
20181128/https://www.arrow.com/en/research-and-events/articles/using-a-simple-diode-as-a-ballpark-temperature-sensor  
20181128/https://en.wikipedia.org/wiki/Hysteresis

Wait, so this sensor IC can measure both temperature and humidity?
Oh, apparently what happened here is that the Arrow website classified
it under "temperature and humidity sensors," but really it's only good
for temperature measurements.

20181128/https://www.arrow.com/en/products/lm95235cimmnopb/texas-instruments  
20181128/DuckDuckGo LM95235CIMM/NOPB datasheet  
20181128/https://www.ti.com/store/ti/en/p/product?p=LM95235CIMM/NOPB  
20181128/http://www.ti.com/lit/ds/symlink/lm95235.pdf
