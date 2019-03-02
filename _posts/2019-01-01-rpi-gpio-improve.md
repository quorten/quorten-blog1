---
layout: post
title: More improvements and tradeoffs to my GPIO pin layouts
date: 2019-01-01 14:11 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

When I was reviewing the software GPIO interface for Raspberry Pi, on
second thought, I realized that if my 8-pin connector doesn't have the
GPIO pins selected so that all bits are continuous, I am going to have
a tremendous performance loss by trying to rearrange bits in software,
rather than simply being able to copy one byte and shift it around.
So, let's double-check.  Where are the holes in my otherwise
continuous range of GPIO pins on the 8-pin connector?

    8-bit  Pin  07, 13, 15, 16, 18, 22, 29, 31
           GPIO 04, 27, 22, 23, 24, 25, 05, 06

           GPIO 04, 05, 06, 22, 23, 24, 25, 27
                           X               X

Okay, that was a fail in being a continous range.  Let's try again,
trying to straighten up the holes in our nearly continuous range as
much as possible.

Unfortunately, it appears the verdict is clear.  To get ideal software
alignment, I would have to forfeit part of either SPI0 or SPI1, in
effect rendering it just another collection of GPIO pins.  Also, it
looks like I might need to forfeit I2S.  So, let's sample a layout
that forfeits SPI1 and the I2S DATA pin.

    8-bit  Pin  38, 40, 15, 16, 18, 22, 37, 13
           GPIO 20, 21, 22, 23, 24, 25, 26, 27
                SP  IS                  SP

Well, at least the hardware PWM pins are still free.

<!-- more -->

Now, with that rearrangement and consideration, I better seriously
consider the actual software GPIO numbers for the other pins and
connectors.  Lucky for me, nearly all the remaining connectors are for
special-purpose hardware inside the chip, so there is not as much room
for design error on my part.  That leaves only the 8-bit bus, the
remaining I2S pins, and the "remaining" SPI1 pins to be rearranged to
correspond with software GPIO order.  I know, now we're talking longer
wires, but this is an important modification if only for the sake of
performance.

Double-down on checking.

    I2S  Pin  12, 35, 39, 40
         GPIO 18, 19, GD, 21
                          XX
    SPI1 Pin  11, 36, 37, 38
         GPIO 17, 16, 26, 20
                      XX  XX

    SPI1 GPIO 16, 17, 20, 26
                      XX  XX

Okay, so it looks like my verdict, in the interest of optimizing for a
parallel port, will be to mix and match a 4-pin port out of this, and
be left with 3 remaining pins.

    CTL  GPIO 16, 17, 18, 19

The SPI0 port provides the remaining 5-pin header for status.

    STAT  Pin  17, 19, 20, 21, 23, 24, 26
          GPIO GD, 10, 5V, 09, 11, 08, 07

    STAT  GPIO GD, 5V, 07, 08, 09, 10, 11

And there is still room for improvement.  If this 8-pin bus was
aligned to the byte boundary, the data could be read/written even
faster.  What's stopping me?  Nothing, now that I've officially
decided to veto support for SPI1 and I2S.  So, here's yet another
revision.

    8-bit  Pin  36, 11, 12, 35, 38, 40, 15, 16
           GPIO 16, 17, 18, 19, 20, 21, 22, 23
    SPI0   Pin  17, 20, 26, 24, 21, 19, 23
    STAT   GPIO GD, 5V, 07, 08, 09, 10, 11
    CTL    Pin  18, 22, 37, 13
           GPIO 24, 25, 26, 27
    REM    Pin  39, 07, 29, 31
           GPIO GD, 04, 05, 06

    PWM    Pin  32, 33
           GPIO 12, 13
    UART   Pin  06, 04, 08, 10
           GPIO GD, 5V, 14, 15
    I2C    Pin  27, 28, 03, 05
           GPIO 00, 01, 02, 03

Two of the remainder pins can be used for the parallel port direction
pins.

Well, I must say, this is a pretty tight layout.  I literally use up
all available GPIO pins on the Raspberry Pi Zero with this
specification.  Notably, I2S and SPI1 (an AUX device) had to get the
boot to software optimize the 8-pin and 4-pin GPIO headers.  I think
this is a good trade-off for most projects, as I2S has some noted
problems and not many projects need more than one SPI interface.

JJJ TODO:

* Insert diagram.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2019-01-01-rpi_gpio.svg"
        width="500" height="300">
  <img src="{{ site.baseurl }}/blog/images/2019-01-01-rpi_gpio.png"
       alt="Raspberry Pi GPIO pin wiring diagram"
       width="500" height="300" />
</object>

Wow, that really looks like a mess.  I've reorganized the ordering of
the software critical GPIO pin headers (8-bit, SPI0, CTL, REM), but
otherwise left the other headers (PWM, UART, I2C) wired up largely the
same.  I don't know if there is a standard pin ordereing for modular
connectors on these interfaces.  I guess the standard is you have some
breakout pins that you wire up any which way works.

20190105/DuckDuckGo i2c connector pin order  
20190105/https://forum.sparkfun.com/viewtopic.php?t=20657
