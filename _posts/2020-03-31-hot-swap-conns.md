---
layout: post
title: "Hot-swapping connector designs, I2C connector design, my own
        SPI connector design, and \"Stop 'N' Swop\""
date: 2020-03-31 18:08 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, I'm in the process of designing my own modular SPI connectors for
my electronics projects.  There is, after all, no real standard for me
to copy, so I'm making my own just like everyone else has in times
past.  Now, I do remember Wikipedia stating some words on this in
relation to I2C, what were those anyways?

20200331/https://en.wikipedia.org/wiki/I%C2%B2C

Oh, interesting.  Here, the connector design is to prevent power and
ground from being connected with reverse polarity in the case that the
connector is inserted backwards, as can easily happen with the
unpolarized 1/10 inch pin headers common on prototyping electronics
boards.  Also, in this case, the power and ground are not placed right
next to each other, but staggered with data pins in between.  This
could also help prevent accidental shorts between the power pins.
Note that this Wikipedia article mention all comes from the advice of
one particular person giving their answer on StackExchange
Electronics.  So, yeah... it's not a really widespread thing, as you
might see.

Also, the Wikipedia article about hot-swappoing is also insightful.
In particular, the idea that you don't need to add special electronics
circuitry to enable hot-swapping, this can all be done through a
staggered connector design that ensures some pins make contact before
others.  In particular, ground pins make contact first, and power pins
make contact last.  (Staggered connectors were once thought to be an
expensive solution, but nowadays it is considered cheap.)

<!-- more -->

20200331/https://en.wikipedia.org/wiki/Hot_swapping

So, after all that, what connector design did I choose for my SPI
connectors?  These are 8-pin Molex PicoBlade connectors with the pins
in this order, from left to right with the two small keying notches
facing away from you in reference to a "socket" connector, so mirror
this if looking at a "pin" connector.

1. Common ground
2. RESET
3. Slave Select
4. 5 volt positive supply
5. CLOCK
6. MOSI
7. 3.3 volt positive supply
8. MISO

Here we are using Wikipedia's hot-swapping connector advice on putting
ground on the outer edges since they make contact first, and we are
using Wikipedia's and Electronics StackExchange recommendation to
avoid damage from plugging in connectors backwards... somewhat.  The
idea is that we cannot supply negative polarity voltage to the chips,
though we may end up putting a higher voltage on one of hte inputs or
outputs.  As long as it's not such a high voltage that it forces its
way through, I guess we're good.  Also, putting 5 volt positive supply
in the middle is to make it difficult to short 5 volt and 3.3 volt
together, and so that 3.3 volt power is guaranteed to be the last
power connected... assuming chips powered by it are more sensitive to
floating voltages than 5 volt chips.

So actually we have two layers of safety.  First we're using polarized
connectors, and if somehow the user still forces a connection, our pin
wiring prevents inverse power polarity.

----------

Off-topic.  This is a really interesting article about the idea to
integrate the "Stop 'n' Swop" feature into the Banjo Kazooie video
game, but that had to be canceled due to hardware changes in the later
Nintendo 64 hardware.  The idea was that when you turn off the
computer, the RAM persists its contents during poweroff for 10
seconds, during which you can switch the game cartridges, and the new
game can read data placed by the old game in special memory locations
for message-based communication.

20200331/https://en.wikipedia.org/wiki/Banjo-Kazooie_(series)#Stop_'N'_Swop

Well, what else do I have to say about this?  Now, this is
interesting, reflecting on my own basic electronics experience.  Yeah,
DRAM needs a dynamic refresh, but SRAM?  That can be pretty
interesting.  If you have decoupling/bypass capacitors on your board
to prevent voltage sags from complex logic current draw patterns, when
you switch off power to your board, the 100 uF or larger capacitors on
the path connecting the main power supply can retain a small amount of
charge for quite some time afterward.  And, this is the key.  SRAM
doesn't require much voltage to maintain its memory, nor does it
require any active refresh electronics.  So an SRAM-based system can
maintain its memory for quite a long time after system power off.
More than 10 seconds, more than 30 seconds, even more than a minute in
my basic observational cases.
