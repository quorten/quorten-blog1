---
layout: post
title: "Using a crystal connection to drive a dedicated AVR timer"
date: 2020-09-10 06:00 -0500
author: quorten
categories: [raspberry-pi, mac-classic]
tags: [raspberry-pi, mac-classic]
---

As part of a making an classic Apple Macintosh RTC (Real-Time Clock)
chip replacement, I've run up against an interesting AVR programming
problem.  I'm using an ATTiny85 as the specific replacement chip.  In
order to support the serial protocol, the AVR core must run at 8 MHz.
But it also needs to use the 32.768 kHz crystal oscillator for
accurate time-keeping.  Normally you'd just connect up the 32.768 kHz
crystal crystal circuit to the XTAL1 and XTAL2 pins of the ATTiny85 if
you run the AVR core clock at the same speed.  But, how do you use the
crystal connection as a base frequency for a phase-locked loop that
generates the 8 MHz AVR core clock signal?

Well, searching around, looks like I've found the way, right here
described by the name behind the AVR itself, the "Microchip" named
company.  The appraoch given here works fully at runtime, but the
process to calibrate the system clock to the watch crystal ties up the
CPU.

20200911/DuckDuckGo avr phase locked loop low frequency crystal resonator  
20200911/DuckDuckGo avr crystal connection  
20200911/http://ww1.microchip.com/downloads/en/AppNotes/doc8002.pdf  
20200911/DuckDuckGo avr055 source code  
20200911/https://www.microchip.com/wwwAppNotes/AppNotes.aspx?appnote=en591195  
20200911/http://ww1.microchip.com/downloads/en/AppNotes/AVR055.zip

That aside, as a fragment of the code, a simple solution to do what I
want is obvious.  Just enable the asynchronous timer using the `ASSR`
register and the crystal connection will be used to drive the
respective timer.

<!-- more -->

Looking for a schematic to officially demonstrate what is described in
the AppNote?  Yes, find one here, and indeed you only do need to set
the ASSR register bits and the XTAL connection will be provided to you
as a separate oscillator/timer.

20200911/DuckDuckGo attiny async timer external crystal  
20200911/http://www.circuitstoday.com/how_to_work_with_32k_crystal_and_avr_microcontroller

But, that's all for ATMega, both in the AppNote and that either
example.  Unfortunately, scouring the ATTiny85 datasheet, I found no
mention of the `ASSR` register.  Looks like it simply doesn't have
one, your only other option is to run the system clock at 32.768 kHz,
and that is much too slow for my application's custom serial
communications.

20200911/DuckDuckGo attiny assr

Oh, yes, this StackExchange question mentions using at 32.768 kHz
crystal with an ATTiny85, but from the looks of this, it is running
the entire system clock.  And that is where the problem arises when
doing analog to digital conversion work.

20200911/DuckDuckGo avr async timer external crystal  
20200911/https://electronics.stackexchange.com/questions/87168/using-attiny-adc-with-a-system-clock-of-32-768-khz

This is a good discussion tech discussion on clock crystals over here
though it doesn't cover what I'm looking for.

20200911/DuckDuckGo avr 32.768 crystal  
20200911/https://www.avrfreaks.net/forum/32768-khz-crystal

But, wait for it... maybe there's another closely related AVR CPU that
does have the asynchronous timer features built-in?  Ah, yes,
searching my AVR include headers for the symbol definition, I found
it's in ATTiny87.  But, the surprise?  Looking at the datasheet, this
is a 20-pin device.  Ouch, that won't work... or maybe it will.  It
comes in the SOIC and TSSOP miniature form factors, so that leaves
room to spare to mount it on an adapter board that only breaks out 8
through-hole pins.  That is, it provides the through-holes and you can
solder a pin header to it to get a similar effect to a DIP IC.

20200911/DuckDuckGo attiny87 datasheet  
20200911/http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8265-8-bit-AVR-Microcontroller-tinyAVR-ATtiny87-ATtiny167_datasheet.pdf

Okay, so now I'm wondering, for the sake of building my own chips from
FPGAs.  What exactly is the special circuitry required to connect to
those crytsal oscillators surrounded with capacitors?  Reading around
in the AVR datasheets, I see mention that the crystal oscillator
connections "XTAL1 and XTAL2 are input and output, respectively, of an
inverting amplifier which can be configured for use as an On-chip
Oscillator."  So, what is an inverting amplifier?  It is a
special-case configuration of an op-amp.  Oh, okay, that's easy, easy
to implement on-chip by all means.

20200911/https://en.wikipedia.org/wiki/Inverting_amplifier

So, now that makes sense.  Basically, you feed the crystal oscillator
to the op-amp, and depending on the configuration you may connect the
output to feed-back or only connect the input.  But in any case, you
have a digital output signal that you can then feed directly as a
digital input to any GPIO port... really?  I think I might want to try
that out on a board if you ask me.  So, the point you're telling me,
is that if you add the op-amp into the circuit, you can just copy the
output of that and sample the clock input via a GPIO pin in software?

The other relevant articles on Wikipedia, clock generator and crystal
oscillator.  Yes, one idea is that you might connect the crystal
oscillator to a clock generator chip first, then the square wave
output of that can be connected to your other logic chip.

20200911/https://en.wikipedia.org/wiki/Clock_generator  
20200911/https://en.wikipedia.org/wiki/Crystal_oscillator
