---
layout: post
title: "Embedding fuse bits in compiled AVR output, high-voltage
        serial programming"
date: 2020-09-17 02:53 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Is it possible to embed AVR fuse bit values inside a compiled C source
file for programming?  Indeed it is.  However, be forewarned that
getting this into `avrdude` is not as straightforward as you may like.
Essentially, you're going to have to extract the `.fuse` section and
pass in the value in a separate command.

20200917/DuckDuckGo avr-gcc fuse bits  
20200917/http://www.nongnu.org/avr-libc//user-manual/group__avr__fuse.html  
20200917/DuckDuckGo avr-gcc avr dude fuse section  
20200917/https://www.avrfreaks.net/forum/fuse-bits-c-source-avr-libc-and-program-avrdude

How do you do high-voltage serial programming for the ATTiny85?  Easy,
just build this circuit with Arduino, or a slight variant with more
level shifters Raspberry Pi.  The solution is rather simple, just use
a BJT transistor to control the 12 V signal.  Please note that 1K
resistors are used on all Arduino outputs, probably to protect the
Arduino from any unexpectedly high voltages.  A 1K resistor is also
used in the 12 V power supply path, to limit the amount of 12 V
current that can flow.

The Arduino sketch, in particular, just resets the fuse bits so that
you can use standard In-System Programming (ISP) over SPI to write the
rest of the program code.  `avrdude` does have high-voltage serial
programming modes in it, but I'm not sure how to use those with
Raspberry Pi.

<!-- more -->

Oh yes... I see what's going on with `avrdude` on Raspberry Pi.
Typically, you'll just use it with the `spidev` programmer type.
Otherwise, you would select "GPIO bitbanging using the Linux sysfs
interface."  Ugh... that's going to be slow.  There is an `arduino`
programer type listed, that would probably be your best bet if nothing
else is stated.

20200917/DuckDuckGo raspberry pi avrdude high voltage serial
  programming  
20200917/http://kevincuzner.com/2013/05/27/raspberry-pi-as-an-avr-programmer/  
20200917/https://www.electronics-lab.com/recover-bricked-attiny-using-arduino-as-high-voltage-programmer/
