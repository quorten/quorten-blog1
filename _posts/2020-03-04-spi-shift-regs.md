---
layout: post
title: "Use SPI to drive plain old shift registers and HX711 ADC, and
        easy SPI to asynchronous serial communications conversion
        circuits"
date: 2020-03-04 22:33 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

I have been in the middle of an epic pin shortage when designing a
multi-purpose Raspberry Pi measurement device.  But then, I had an
epiphany.  The SPI bus can be used to directly drive a plain old 8-bit
shift register.  The solution is simple.  The SPI bus can use a rising
edge clock for the data bus transfer, and that matches the clock
discipline of a shift register.  The SPI output is then wired to the
shirt register data input.  And, best of all, the SPI slave select
signal can be used to your advantage.  Once all bits have been shifted
in and slave select is de-asserted, you can use that signal to trigger
the switchover of the internal buffer of your shift register to set
the outputs to the new values.  And, what's more, you can go and do
likewise with shift register inputs.  Even more, using the SPI
interface to program your shift registers is both easier and faster
than programming via GPIO pins.

20200304/https://en.wikipedia.org/wiki/Serial_Peripheral_Interface

Putting this altogether, I found out that I can restructure my
"overdesigned" Raspberry Pi Zero system so that the 4-digit 7-segment
display, 16-key matrix keyboard, 4 motor outputs, and one analog input
(via HX711 Wheatstone bridge ADC) are all on the single SPI0
connection.  The only GPIO pins I would use would be one for RESET on
the display-keyboard module, and one for "AUX SPI slave select"
between the display-keyboard versus motor outputs.  Of course, I could
alternately use SPI1 which has three slave selects, but either way
it's the same number of pins used.  But that being said, I have enough
pins freed to use both SPI0 and SPI1 simultaneously, as I might need
if I use those fast custom optimized SPI display drivers.

<!-- more -->

Regarding using SPI for HX711... you actually can't do it quite
directly as I thought, but luckily there is still a nifty trick you
can use and still be able to use the SPI port.  Although the Raspberry
Pi SPI library used here can only configure in the SPI word size in
multiples of 8, multiple bytes are transferred to get an divisible
number.  Also, the interface is wired up in a non-standard way to
generate freqency divided signals to match up properly, and characters
such as 0xAA are sent.  Now, here's the thing... looks like this
wasn't the most skilled programmer writing this code, so of course it
falls short compared to how it could have been implemented.  But,
nevertheless, I like the ingenuity and it does show it is indeed
possible to connect HX711 to SPI... even if hackery is required.

20200304/DuckDuckGo raspberry pi spi hx711  
20200304/https://github.com/dudapickler/hx711_SPI

Regarding HX711 on SPI... one thing to keep in mind though is length
limits of SPI bus communications.  Due to the separate clock signal,
it is effectively a parallel communications bus, so the capacitance of
long distance wires effectively limits the length of cable you can use
from your HX711 ADC inside your scale to your Raspberry Pi unit.  For
3D scanning, a 6 ft cable may be typical... but alas, that is too long
for SPI communications.  Not to mention that to even get near that
length, you've got to use a really slow clock.  That being said, I'd
probably need to use an Arduino to convert to asynchronous serial
communications, then connect that to the Raspberry Pi.

20200304/DuckDuckGo What's the maximum distance of spi communications  
20200304/https://www.avrfreaks.net/forum/max-spi-distance  
20200304/https://electronics.stackexchange.com/questions/163468/spi-max-distance

But, here's a mad idea.  Maybe I don't need an Arduino for simple
conversion from separate clock communications to asynchronous serial
communications.  Here's how it works with just basic logic chips.  You
have your local clock, sure, and you have local state registers.  When
you are in the idle line state, you watch for a start bit.  When the
start bit is received in the idle line state, you RESET the local
clock and change the idle line state.  Then your local clock runs your
local counters and fills the shift register until you've read in 9
bits, 1 start bit + 8 data bits.  (The start bit is shifted out and
ignored.)  Then you reset your local state to the idle state and watch
the line for the next start bit.

20200304/https://en.wikipedia.org/wiki/Asynchronous_serial_communication

Okay, so what chips are needed?  1 counter chip, crystal oscillator +
frequency divider chip, 1 latch chip, 1 shift register chip, 1 AND
chip.  And that's all there is to it!

But that only covers receive, not send.  If you have shift register
and a clock, and you want to send... this comes down to using a
counter to keep track of where you are in the communications cycle,
and inserting start and stop bits as required.  Probably something
like 1 counter chip, 1 AND chip, 1 shift register.

Okay, so that covers packing up SPI serial communications into
asynchronous serial communications, but what about unpacking?  Now,
this is quite clever.  Basically, your UART serial communications
conversion introduces one additional layer of intermediate shift
registers.  SPI master writes are sent immediately, but SPI master
reads are delayed by one 8-bit byte.  Unless, of course, you add the
assertion line "RTS" to your serial communications to indicate that
the master wants to read, and you configure your SPI master to also
wait the time of at least one start bit before pumping the data clock.

It would be nice if I could buy a chip that performs precisely the
purpose of the outlined designs, but it looks like I have to design my
own simple circuits for that.  FPGA/CPLD is the best I can do.
