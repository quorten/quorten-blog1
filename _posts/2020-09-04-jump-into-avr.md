---
layout: post
title: "Jumping into AVR development, what you need to know"
date: 2020-09-04 05:52 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, time to jump straight into Arduino AVR microcontroller
development head-first.  I've got the `simavr` simulator right here,
so I can start coding.  How do I compile?  Yes, the hint right there,
use `avr-gcc` and `avr-libc`.  And how do I use the compiler
specifically to produce ATTiny85 firmware?  Just like this.

```
avr-gcc -o MacPlusRTC.axf -Os -mmcu=attiny85 MacRTC.c
```

20200904/https://github.com/buserror/simavr  
20200905/https://raw.githubusercontent.com/buserror/simavr/master/doc/manual/manual.pdf  
20200905/DuckDuckGo attiny blink demo code  
20200905/https://www.instructables.com/id/Attiny85-USB-Development-Board-LED-Blinking-With-A/  
20200905/DuckDuckGo gcc avr  
20200905/DuckDuckGo gcc avr attiny  
20200905/https://github.com/vladbelous/tinyAVR_gcc_setup  
20200905/http://www.lightner.net/avr/ATtinyAvrGcc.html  
20200905/https://www.digikey.com/product-detail/en/microchip-technology/ATTINY85-20PU/ATTINY85-20PU-ND/735469  
20200905/https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2586-AVR-8-bit-Microcontroller-ATtiny25-ATtiny45-ATtiny85_Datasheet-Summary.pdf  
20200905/http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2586-AVR-8-bit-Microcontroller-ATtiny25-ATtiny45-ATtiny85_Datasheet.pdf

<!-- more -->

But Arduino sketches don't compile with `avr-gcc`, the library
functions they are using are missing.  But surely, looking at them,
they're simple macros, easy to include straight into your source code,
right?

So, yes, the source code for the Arduino library functions is on
GitHub, you say?  Indeed it is, it really is just plain C source code
with copying and pasting headers and footers, look over here.  Now I
can look at these and use them to transform Arduino sketches into
vanilla C source code that compiles with `avr-gcc`.

20200905/https://en.wikipedia.org/wiki/Wiring_(development_platform)  
20200905/https://github.com/arduino/Arduino  
20200905/https://github.com/arduino/ArduinoCore-avr  
20200905/https://github.com/arduino/ArduinoCore-avr/tree/master/cores/arduino  
20200905/https://github.com/arduino/ArduinoCore-avr/blob/master/cores/arduino/Arduino.h  
20200905/https://github.com/arduino/ArduinoCore-avr/blob/master/cores/arduino/wiring_digital.c  
20200905/https://github.com/arduino/ArduinoCore-avr/tree/master/variants

Okay, but I'm not seeing ATTiny85 pin mappings in the Arduino source
code.  But surely, it must be possible if this source code was using
the technique.  Maybe there's a ATTiny85 plugin for Arduino Studio?
Indeed there is.

20200905/DuckDuckGo attiny arduino studio  
20200905/https://www.arrow.com/en/research-and-events/articles/attiny85-arduino-tutorial  
20200905/DuckDuckGo arduino attiny github  
20200905/https://github.com/damellis/attiny  
20200905/https://github.com/damellis/attiny/blob/master/variants/tiny8/pins_arduino.h

How to update fuse bits on AVR microcontrollers, you can't include it
in your same standard firmware image, you need to use a separate
special command, but at least it can still be scripted.

20200904/DuckDuckGo avr-gcc flash fuse bits  
20200904/https://www.instructables.com/id/AVR-Microcontroller-Fuse-Bits-Configuration-Creati/

The ATTiny85 only has one pin change interrupt service routine.  Is
there any register that indicates which pin changed?  Looks like there
isn't, you just have to monitor the pin values and do the change
detection yourself, which purportedly isn't hard since there are so
few pins.

20200905/DuckDuckGo pcint0 source  
20200905/https://arduino.stackexchange.com/questions/70348/pcint0-pcint1-pcint2-etc-on-attiny45-85

Can you do open-drain signaling with an AVR?  Yes you can, you simply
change a pin to an input-no-pullup when you want it to be
high-impedance.  Yes, just like I thought.

20200905/DuckDuckGo avr open drain pin  
20200905/https://www.avrfreaks.net/forum/open-drain-0

However, for multiple pin change interrupts on the ATMega 328, there
is indeed the PCIFR register where the bits will be set based off of
which pin triggers the pin change interrupt.  Very useful to have that
information at your disposal.

20200905/DuckDuckGo avr interrupt pin change source flag register  
20200905/https://www.avrfreaks.net/forum/pin-change-interrupt-atmega328p

But hey, actually there's an important note here when using timers.  I
was searching to try to solve my problem of timer slipping.  But,
anyways, when configuring the timer registers, to be on the safe side,
make sure you set all bits, else you don't know that they might not be
properly defined.  Though I'd reckon, of course they have to be
properly zeroed to sane values on RESET.

20200906/DuckDuckGo avr generate one second wave  
20200906/https://www.avrfreaks.net/forum/generating-square-wave-0
