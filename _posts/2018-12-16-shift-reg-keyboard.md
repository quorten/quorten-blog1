---
layout: post
title: Building keyboard with shift registers instead of a matrix
date: 2018-12-16 13:13 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

On the subject of building keyboards.  I happened to remember an IEEE
Spectrum article about building a keyboard into a typewriter by the
way of shifter registers.  Why exactly did they choose to use shift
registers instead of a standard keyboard matrix?  Indeed, it is
simpler and uses less circuitry to use a conventional keyboard matrix.
The shift register design was purely for making the custom
construction and fitting into a myriad of different typewriter designs
easier.  The shift registers mean that the microcontroller board can
be external to the typewriter, and only a few wires need to be run to
connect them together.  This is important because many typewriters may
not have much space to put the microcontroller board within.  Also,
another benenfit of the shift register design is that it forms
somewhat of a repeating pattern on the circuit board internal to the
typewriter, so the board can be cut to any length without
repercussions.  Also, interestingly enough, they choose to use the
Atmel ATmega68 microcontroller for the project too, the same
microcontroller that is used in the Arduino board.

Lo and behold, this is an oldie but goodie: the IEEE Spectrum article
is from 2011.

20181216/DuckDuckGo ieee spectrum keyboard shift register  
20181216/http://spectrum.ieee.org/geek-life/hands-on/a-typewriter-is-a-terrible-thing-to-waste

<!-- more -->

----------

So, here are more technical details on how the shift register circuit
works.  The CPU continuously shifts a 1 bit down the input of the
shift register.  When a key is pressed, it channels a cell to register
as a 0 bit instead.  The CPU can then read out the bit pattern and
decode this to determine which keys were pressed.
