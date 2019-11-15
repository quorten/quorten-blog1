---
layout: post
title: Determine resistor resistance and power-rating for LEDs
date: 2019-11-06 20:03 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

I have an LED display circuit I am wiring up to a Raspberry Pi.  It
has a number of display cells that would each require a number of
protective resistors, but I don't have a particularly large number of
spare resistors on hand.  Can I gang together multiple LED cells onto
a single resistor?  The short answer is no, a single resistor only has
enough power rating to support a single LED.  Such a wiring would only
work if you could guarantee that only a single LED was powered on at a
time, such as a hardware multiplexer circuit.  But failing that, say
you have a shift register instead, you should use one resistor per
LED.

Here is why.  The typical power rating on resistors is 1/8 Watt or 1/4
Watt.  A typical resistor with specifications around 2 V 50 mA will
consume about 1/10 Watt power.  With ceiling room allowance for double
the power capacity to be on the same side, that really doesn't leave
you with any room at all for multiple LEDs on a single resistor.
Definitely nothing on the order of 10, but maybe something on the
order of 2 if you are careful.

20191106/DuckDuckGo resistor current rating  
20191106/https://www.dummies.com/programming/electronics/components/electronics-components-resistor-power-ratings/

This site has some good info on how to calculate the required
resistance nad power values for a LED's protective resistor.

20191106/DuckDuckGo led current  
20191106/https://www.sparkfun.com/tutorials/219
