---
layout: post
title: Decisions on Raspberry Pi GPIO connections
author: quorten
date: 2018-11-23 22:30 -0600
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So now I need to make some decisions on some base nice-to-have Molex
PicoBlade connectors that I will solder directly onto the GPIO pin
header.  Here are my plans so far.  Remember, with soldered pins, you
can always add more easily, but removing existing ones is a bit
tougher.  So, the base ones installed on by default better be designed
to be pretty reusable.

The main problem with soldering on connectors in advance is that if
you solder on too many or connectors of the wrong type, you will have
to remove those and re-solder.  Also, although it sounds like a very
good general idea to just have each pin independently accessible, this
tends to be a real nuisance when it comes to connecting standard
components on that require multiple pins.  So, the idea is to make a
good choice between soldering on multi-pin connectors, avoiding
overwork in soldering, and keeping the system modular and reusable.

Okay, my idea.  How about we approach it like this.  You can start by
soldering on large connectors that group together multiple GPIO pins.
So, let's start with the most demanding case: an EEPROM chip with a
32-bit address bus.  Do we even have enough GPIO pins to support that?
Well, let's see.

* 32-pin connector for 32-bit address

* 8-pin connector for 8-bit data

* 4-pin connector for the flash chip control signals

Suppose instead of one 32-pin connector, you want four 4-pin
connectors.  No worries, you can just connect a special splitter
connector to break those apart.  Same if you want to break apart a
4-pin connector into a 2-pin connector.

But, I'm getting ahead of myself.  To answer my earlier question, do
we have enough GPIO pins?  In the case of the Raspberry Pi Zero, no.
Remember, we only have a 40-pin header, and some of those are
power-only and ground-only pins.  44 pins > 40 pins.

<!-- more -->

Okay, so that's too much.  Let's step back, then, and consider a less
demanding but still useful case.  The BCM2835 that the Raspberry Pi
uses has a handful of integrated hardware peripherals that, when
enabled, require a set of specific GPIO pins.  Although there are a
few choices for reconfiguring which GPIO pins they may use, these "few
choices" may mean picking from one of four possibilities.  Yes,
essentially only a small handful of reconfiguration choices.  The most
general choice that the hardware peripherals hold in common,
especially in the case of the Raspberry Pi Zero, is disabling all the
built-in peripherals, in which case virtually all GPIO pins are
user-accessible.

So, what are these hardware peripherals?  We've got a list that comes
straight from the official manual on the chip.

20181123/DuckDuckGo raspberry pi BCM2835 peripherals  
20181123/https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf  
20181123/DuckDuckGo raspberry pi pwm  
20181123/DuckDuckGo raspberry pi hardware pwm  
20181123/https://circuitdigest.com/microcontroller-projects/raspberry-pi-pwm-tutorial  
20181123/https://raspberrypi.stackexchange.com/questions/4906/control-hardware-pwm-frequency  
20181123/https://jumpnowtek.com/rpi/Using-the-Raspberry-Pi-Hardware-PWM-timers.html  
20181123/https://circuitdigest.com/microcontroller-projects/raspberry-pi-pwm-tutorial  
20181123/DuckDuckGo raspberry pi i2c  
20181123/https://learn.sparkfun.com/tutorials/raspberry-pi-spi-and-i2c-tutorial/all  
20181123/DuckDuckGo raspberry pi i2s  
20181123/https://www.dimdim.gr/2014/12/the-rasberry-pi-audio-out-through-i2s/  
20181123/https://en.wikipedia.org/wiki/I%C2%B2S  
20181123/https://www.raspberrypi.org/documentation/usage/gpio/

* Timers (obvious, no pins required)
* Interrupt controller (obvious, no pins required)
* DMA controller (obvious, no pins required)
* GPIO (obvious)
* I2S
* I2C
* SPI (also "PCM")
* Mini SPI
* PWM
* UART
* Mini UART
* Composite video output (Raspberry Pi only)

First, let's cover the list of obvious power/ground pins and such that
must be reserved.

* 5 V power bus input/output: Total 3 pins: Uses pins 2 (5 V), 4 (5
  V), 6 (GND)

* 3.3 V power bus output: Total 1 pin: Uses pin 1

* Reset: Total 2 pins

So, now let's go down the list of the non-obvious built-in hardware
peripherals, describing their GPIO pin requirements so that we know
which pins to reserve for those purposes.

* I2S: Total 0/4 pins: Uses pins 12 (BCK), 35 (LRCLK), 39 (GND), 40
  (DATA).  NOT high quality due to clock sync limitations, so no need
  to reserve these pins for I2S in my opinion.

* I2C: Total 4 pins: Uses pins 3 (I2C.1 SDA), 5 (I2C.1 SCL), 27 (I2C.0
  SDA), 28 (I2C.0 SCL)

* SPI: Total 5/7 pins: Uses pins 17 (3.3 V) 19 (MOSI), 21 (MISO), 23
  (CLK), 24 (CE0), 25 (GND), 26 (CE1)

  There are three SPI interfaces available!  SPI0 is the full SPI
  interface.  SPI1 and SPI2 are mini SPI interfaces, which only
  implement an SPI master.  SPI2 is only accessible on Raspberry Pi
  Compute Module.  SPI1 requires 40-pin header for access, so that
  includes the Raspberry Pi Zero.

  See my notes on the second revision later in this article for
  information on SPI1.

* PWM: Max 2 hardware PWM ports, choose from following GPIO ids.
          PWM0: 12,4(Alt0) 18,2(Alt5) 40,4(Alt0)            52,5(Alt1)
          PWM1: 13,4(Alt0) 19,2(Alt5) 41,4(Alt0) 45,4(Alt0) 53,5(Alt1)

  So, pins!  Total 2/4 pins.  GPIO -> Pin: 12 -> 32, 13 -> 33, 18 ->
  12, 19 -> 35, 40 -> N/A, 41 -> N/A, 52 -> N/A, 53 -> N/A.  High
  numbered pins don't exist on the Raspberry Pi Zero.  Potential pins
  to reserve: min 2, max 4.

* PL011 UART: Total 2/4 pins: Uses pins pins 8 (TxD), 10 (RxD).  Also
  need to connect to GND bus.  CTS and RTS are supported.  Where are
  these pins wired?  User-configurable?

* Mini UART?  Total 2 pins: Uses pins ? (TxD), ? (RxD).  Also need to
  connect to the GND bus.  Note that the Mini UART is, in fact,
  declared that it is the one that is _intended to be used as a
  console_ in the Broadcom manual.

* Composite video output: Total 2 pins

So, if we add up only the pins mentioned above that are on the 40-pin
header, what do we get?  19 pins optimistic, 29 pins pessimistic.  As
you can see, that doesn't leave many pins left for additional devices
like EEPROM programmers.

Okay, but let's consider another useful GPIO device that may be
simpler than an EEPROM programmer.

* Parallel port: Total 19 pins: 8 data, 5 status, 4 control, 1 hd, 1
  dir

19 + 19 = 38

On the 40-pin header. the non-GPIO pins are as follows:

* 8 GND pins
* 2 3.3 V pins
* 2 5 V pins
* 2 pins (ID_SD and ID_SC): Reserved for ID EEPROM

So, adjusting for additional reserved pins not counted in the
optimistic pin count, we get the following.

19 + 19 + 7 + 1 + 2 = 48

So, we need to compromise on 8 pins from our optimistic layout in
order to add a GPIO parallel port.  What would make the most sense
given the hardware layouts above?

* 2 pins: Replace PWM.  We can make an assumption that if we are
  connecting a parallel port, surely we're connecting to external
  physical hardware that has a PWM control circuit of its own if
  needed.

* 2 pins: Replace one of the UARTs.  Surely for most applications
  where a parallel port is connected, we can get by with only one
  UART.

Now, with 4 more pins needed, we can balance our GPIO pin budget by
removing either one of the following two reservations.

* 4 pins: Replace I2C.  This gives us exactly the number of pins
  needed to correctly get.

* 5 pins: Replace SPI.  This leaves one additional pin free.

So, how do we want to lay out the parallel port in pin reservation
terms?

* The power and ground leader pins are single-wire.

* For sure, we want a full 8 GPIO pins grouped together that does not
  conflict with any of the built-in hardware devices.  That leaves 11
  pins remaining to be divided.

* PWM pins will turn out to be just single wires, for the sake that
  other pre-groupings don't make sense for circuit reuse.  That gives
  us up to 4 single-wire pins at each potential PWM GPIO.

* Each UART will have its TxD and RxD grouped together into a 2-pin
  header.  CTS and RTS are single-wire pins.

* Group together I2C pins into a 4-pin header.

* Group together SPI pins into a 5-pin header.  Single wires for its
  3.3 V and GND.  You can always add these into another header with 7
  pins later.

* Group together I2S pins into a 4-pin header.

So, how many pins are grouped together total in this arrangement?

1 + 1 + 1 + 1 + 8 + 1 + 1 + 1 + 1 + 2 + 2 + 1 + 1 + 4 + 5 + 1 + 1 + 4 = 37

Now, that is including all optional pins (i.e. "pessimistic") and the
overlapping parallel port GPIO requirements.  We need to add a few
more pins for a full total.

37 + 5 + 2 = 44

Oops, we're over the pin budget.  All those ground pins can really
subtract from our available GPIO choices.  Luckily, we can subtract
precisely 4 pins by overlapping 4 of the optional single GPIO pins.

Subtract the CTS pin, RTS pin, and 2 extra mini UART pins.  Indeed,
the Raspberry Pi Zero does not have enough GPIO pins to relocate
either of the UART devices away from the first pin assignment.

20181124/DuckDuckGo raspberry pi mini uart  
20181124/https://www.raspberrypi.org/documentation/configuration/uart.md

So, now we're flush at the limit of our GPIO pins.

Okay, great!  Let's diagram the layout pin header layout and the
associated pin header groupings.

    J8                J8
        1   2        SW  3V  5V  SW
        3   4            B3  5V  SW
        5   6            B3  GD  SW
        7   8            B6  A1
        9  10            GD  A1
       11  12            D5  B2  PW
       13  14            D5  GD
       15  16            D5  D5
       17  18            3V  D5
       19  20            C4  GD
       21  22            C4  D5
       23  24            C4  C4
       25  26            GD  C4
       27  28            B3  B3
       29  30            B6  GD
       31  32            B6  PW
       33  34            PW  GD
       35  36        PW  B2  B6
       37  38            D5  D5
       39  40        B2  GD  B2

    Key: SW = Single Wire
         PW = PWM single wire
         Ax = 2-pin
         Bx = 4-pin
         Cx = 5-pin
         Dx = 8-pin
         5V = 5 V
         3V = 3.3 V
         GD = GND
         A1 = UART
         B2 = I2S
         B3 = I2C
         C4 = SPI
         D5 = 8-bit GPIO bus
         B6 = 4-bit GPIO bus

Okay, cool!  So, how many composite headers do we have sticking out of
our Raspberry Pi Zero with this arrangement?  6 composite headers.
How many single pins do we have sticking out?  8 single pins (4 power,
2 ground, 2 PWM).  That's pretty manageable for a physical topology.

Okay, now that was a pretty good design, but alas, of course I did
some more reviewing, reading, and learning and figured out I missed
some things.

* I should probably actually include power and ground in the UART and
  SPI connectors.  It will leave less single pin connections to be
  messed around with.

* I've only covered SPI0.  I missed SPI1.

* SPI1: MOSI (GPIO20 -> pin 38); MISO (GPIO19 -> pin 35); SCLK (GPIO21
  -> pin 40); CE0 (GPIO18 -> pin 12); CE1 (GPIO17 -> pin 11); CE2
  (GPIO16 -> pin 36)

  Nevertheless, I guess it is okay to leave off a purpose-built
  connector for this one.  It overlaps with so many of the other pins
  that I think are much more useful for my purposes (I2S/PWM).

  Nevertheless, I can rewire B6 to cover the pins used by SPI1 so that
  D5 doesn't straddle it.

* Pin 5 (GPIO3) can be easily configured by default to be a shutdown
  and power up button, so why not?  Wiring to pin 6 GND is the natural
  thing to do for this.

So, here's the second revision.

    J8                J8
        1   2        SW  3V  5V  SW
        3   4            B3  5V  B1
        5   6            B3  GD  B1
        7   8            D5  B1
        9  10        SW  GD  B1
       11  12            B6  B2  PW
       13  14            D5  GD
       15  16            D5  D5
       17  18        C4  3V  D5
       19  20            C4  GD  C4
       21  22            C4  D5
       23  24            C4  C4
       25  26            GD  C4
       27  28            B3  B3
       29  30            D5  GD
       31  32            D5  PW
       33  34            PW  GD
       35  36        PW  B2  B6
       37  38            B6  B6
       39  40        B2  GD  B2

    Key: SW = Single Wire
         PW = PWM single wire
         Ax = 3-pin
         Bx = 4-pin
         Cx = 7-pin
         Dx = 8-pin
         5V = 5 V
         3V = 3.3 V
         GD = GND
         B1 = UART
         B2 = I2S
         B3 = I2C
         C4 = SPI
         D5 = 8-bit GPIO bus
         B6 = 4-bit GPIO bus, cover remaining SPI1 pins

Note that it might be a good idea to group the single wires for 5 V
power, 3 V power, and ground into a 3-pin header.

Now for the numbers:

* 6 composite headers
* 5 single pins (3 power, 2 PWM)

Now, let's create a final diagram the connector board layout and
soldering.  Here I went through two revisions in order to optimize the
pin selection for ease of use and convenience.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2018-11-23-rpi_gpio.svg"
        width="500" height="300">
  GPIO wiring diagram...  Sorry, you need SVG support to see this.
  <!-- <img src="{{ site.baseurl }}/blog/images/2018-11-23-rpi_gpio.png"
       alt="GPIO wiring diagram"
       width="500" height="300" /> -->
</object>

----------

Now what about the case where you want multiple connectors and
components to share a common ground and only use a few GPIO pins?
Well... ut oh.  That won't work too well.  I'm thinking perfboard, but
this is where stripboard is better.  Well, yeah, this can be made to
work on perfboard, but it only works well if you plan it out in
advance.

Okay, so this is what we do to solve that problem.  We have "bus
wires" for common power and ground.  This can either be insulated
wires that are tapped along points, wire segments that are soldered
together one after another (my preference), or uninsulated "bus wire"
that is tapped anywhere, then tape wrapped around to finish it.  Well,
my word has been stated.  Just solder on bridges at a time to form
your bus wire.  Plus, that will give me lots of practice at soldering,
hopefully.  My whole idea was to be able to easily extend and expand
but still have soldered connections and something that works well as a
permanent design.  Especially important is that this solves the
problem of me trying to remove wires that I've soldered to my
Raspberry Pi Zero.  Just extend and replace at the wires ends soldered
away.  Do so with some nice modular connectors.  Reuse old telephone
wire rather than buying new bus-style wire.

The only thing is that this is kind of like an alternative to
perfboard.  Longer wires, then you tape components down onto whatever
board of your choice to get a nice 2D layout.

Perfboard bus wiring 

20181123/DuckDuckGo perfboard bus wiring techniques  
20181123/https://electronics.stackexchange.com/questions/1315/soldering-with-bus-wire-on-perfboard  
20181123/http://lucianifamily.org/getting-it-done/assembly-hints/assembly-hints-index.html#breadboard-hints  
20181123/http://lucianifamily.org/getting-it-done/assembly-hints/breadboard/breadboard-top.jpeg  
20181123/http://lucianifamily.org/getting-it-done/assembly-hints/breadboard/breadboard-bottom.jpeg

----------

Let's assume that chips with even larger memory capacity will use an
8-pin SPI interface.  Easy as pie.  Oh, and we need I2C pin hookups
too!  Oh, yeah, right.  We can solder those on later.  For now, just
take note of those pins and make sure to keep them clear.  Same for
hardware PWM output and mini UART if applicable.

Any advantage to using composite video output over HDMI?  For one, it
doesn't require 5 V power, 3.3 V is good enough.  Then again, that's
also the advantage of using SPI or I2C or I2S for video output: the
DAC runs off of the 3.3 V power supply.

Say, start with an 8-pin or 16-pin header that can be wired.

That's all the built-in peripherals there are to the Raspberry Pi!
The rest is software-defined as you like it.  So, let's cover some
options for that.

* Dallas 1-wire?

Well, I'll be.  Just those pin reservations easily uses up all my GPIO
pins on the Raspberry Pi Zero!  If I want more, I've got to either
look to one of the bigger Raspberry Pi modules with more GPIO pins, or
look into using a I2C/SPI _port expander_.  So, well, that being said.
Indeed if I want to do the 16-key keypad and LCD display via GPIO,
I've got to do that pin sharing trick to keep the GPIO load under
control.  And more than 16 keys?  Well, I'd recommend using the port
expander trick for that, or eschew on the ability to press multiple
keys simultaneously such that you use 16-key "key chords" to emulate
over 100 keys.  In that case, you're not even allowed to press more
than one key at a time simultaneously.

Indeed, you're definitely right.  32 pins is too much for a 40-pin
header.  16 pins means you're using up almost all of the 19 pins
required for a parallel port.

And parallel port speeds.  It seems that 2.5 Mbit/s is reasonably
achievable given a 800 MHz CPU clock.  Unfortunately, if I plan on
using my Raspberry Pi Zero as a print server for an LPT-connected
printer, I'll be experiencing a bottleneck mainly because the
Raspberry Pi Zero isn't fast enough to get speeds competitive with PCs
when running GNU Ghostscript.  That's the main bummer, but maybe the
faster Raspberry Pi 3 B+ will make Ghostscript fly.

20181123/https://github.com/garlick/pi-parport

For small array of individual push buttons and LEDs:

* Maximum 4 single-bit devices, either push button or LED.  Use a
  common voltage input or ground.

For 16-key keyboard matrix:

* 4-pin Molex PicoBlade for scan input
* 4-pin Molex PicoBlade for scan output
* Alternatively, a single 8-pin header for both input and output.

For 4-digit 7-segment LCD/LED display:

* 8-pin Molex PicoBlade for 7 segments of one digit.

* 4-pin Molex PicoBlade for 4 common cathodes of each digit.

For parallel port (and JTAG):

* Parallel port: Total 19 pins: 8 data, 5 status, 4 control, 1 hd, 1
  dir

For LibreBoot flash programming:

* Uses SPI, 5/7 pins, see previous discussion.
