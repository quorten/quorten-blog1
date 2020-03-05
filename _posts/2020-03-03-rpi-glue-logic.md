---
layout: post
title: Lowdown on glue logic with Raspberry Pi
date: 2020-03-03 16:08 -0600
author: quorten
categories: [raspberry-pi, reiterate]
tags: [raspberry-pi, reiterate]
---

When GPIO pins are abundant, you just connect every single GPIO pin
directly to your input or output devices.  But, when GPIO pins are
sparse, often times you can use combinatorial "glue" logic to achieve
the functions you need and also save on GPIO pins.  But, there's a big
question.  Which chips are readily available for the functions you
need?

Not all theoretically possible chips are easily available for
purchase.  Only the most popular ones are manufactured and on the mass
market, and additionally, only a subset of such chips are available in
the hobbyist-friendly through-hole design.  From earlier discussion,
I've noted that for hobby projects, sometimes it makes sense to use
basic logic chips rather than a PLD because it keeps your overall
system complexity down by not needing another layer of programmable
chips, even though this can come at the expense of more complex
wiring.

So, here's the thing.  Sometimes more complex wiring is a necessary
evil when working with buying logic chips and wiring them together for
glue logic.

<!-- more -->

Let's start with the basics: NOT, AND, OR, NAND.  These logic chips
are easily available in all form factors.  Must you always use one of
these logic chips, rather than a simpler approach like, say, diode-OR
or wire-OR?  When working with CMOS logic, in general, yes.  The
wire-OR trick definitely does not work with bidirectional currents
that will be experienced during CMOS, positive will just short to
ground and the output will essentially be an AND gate rather than an
OR gate, though resistors could be used to mitigate this.  Likewise,
the diode-OR doesn't really work with CMOS either because it doesn't
allow for bidirectional currents, except for a little semblance of
"reverse bias."  Similar can be said in relation to AND gates via BJT
transistors... remember this is CMOS not TTL!  But... if you use
pull-down resistors, then actually you can use diode-OR gates and BJT
AND gates just fine.  All that being said, using the logic OR chips
will likely save you power over any of the cheaper component
approaches.

Okay, that's all nice and well, but what about interfacing multiple
inputs/outputs to a single GPIO pin?  There are two main techniques
for this, (1) shift registers and (2) multiplexers/demultiplexers.
The advantage of shift registers is that the persistently maintain
their state, the disadvantage is that they are stateful logic so you
must take care to wire RESET signals and also send a RESET signal on
board-level power-on.  Likewise, the advantage of multiplexers is that
they are stateless, but the disadvantage is that they do not hold a
persistent value for their outputs.  However, this can also be an
advantage because it can be used to limit the simultaneous power draw
of your system and therefore simplify power wiring circuitry by, for
example, eliminating the need for transistors to route higher currents
than the GPIO pins can handle.

For example, a multiplexed 4-digit 7-segment LED display would
required transistors on each common cathode to handle the current in
the case that every single segment is illuminated simultaneously.  But
if you can only illuminate one segment a time because you are using a
demultiplexer, those transitors can be eliminated.

There's also another approach to interfacing with a multiplexed
4-digit 7-segment LED display.  You can give yourself a serial
communications interface similar to how it would be if the whole
device were a shift register.  Simply use a shift register for only
the contents of a single 7-segment digit (8 segments including the
decimal point), but then when you shift in more than 8 bits, you
increment a counter chip.  The counter chip drives a multiplexer to
select which digit to display.  You've then got an easy serial
interface to the whole contents of the display.  If you are driving
the shift register via an SPI bus, the interface is even simpler
because the SPI slave select signal can be used to drive the counter
directly.  Of course, you still must continuously scan the display for
all digits to remain visible.

Now, let's discuss the shopping equation for dual inline package (DIP)
of various logic chips.

Here is a good 8-bit serial in parallel out (SIPO) shift register.  In
particular, its two levels of output buffering is good because often
times when you are shifting in data during load, you don't want the
shifted values to appear on your output pins.

20200303/https://www.digikey.com/product-detail/en/texas-instruments/SN74HC595N/296-1600-5-ND/277246

Here is a good 8-bit parallel in serial out (PISO) shift register.
Only one level of input buffering, but that's pretty much all you need
for inputs.

20200303/https://www.digikey.com/product-detail/en/texas-instruments/SN74HC165N/296-8251-5-ND/376966

Here are some good multiplexers, 4-input and 8-input.  The 4-input one
contains two multiplexers tied to the same selector pins, so it
actually allows you to select a 2-bit input in one go, if you set the
strobe pins as such.

20200303/https://www.digikey.com/product-detail/en/texas-instruments/SN74HC153N/296-8238-5-ND/376970  
20200303/https://www.digikey.com/product-detail/en/texas-instruments/SN74HC151N/296-8236-5-ND/376974

Demultiplexers are tougher to find.  A challenging search brought me
to a 3-to-8 demultiplexer that is active high, but most demultiplexers
are active low.  Worst comes to worst, you can always buy the NOT gate
IC to get the desired signal levels.  Only 10 mA output current is
supported, so don't use directly for any high-current peripherals.

20200303/https://www.digikey.com/product-detail/en/texas-instruments/CD74HC238E/296-25983-5-ND/1506865

Worst comes to worst, you can build your own active high 2-to-4 line
decoder/demultiplexer as follows.  You just need a few NOT gates, AND
gates, or alternatively NOT gates and OR gates.

20200303/DuckDuckGo active high 4 line decoder deumultiplexer  
20200303/http://www.play-hookey.com/digital/combinational/decoder_demux_four.html

Here is a simple 4-bit counter chip that would work well for
sequentially scanning a multiplexer circuit.

20200303/https://www.digikey.com/product-detail/en/texas-instruments/SN74HC161N/296-8244-5-ND/376952

Here is a 4-bit counter chip that is more complicated than you need
for simply controlling a sequential scan multiplexer circuit.

20200303/https://www.digikey.com/product-detail/en/texas-instruments/SN74HC193N/296-8262-5-ND/376956

Bilateral switch here.  ON = control high.

20200303/https://www.digikey.com/product-detail/en/texas-instruments/CD4066BE/296-2061-5-ND/67313

Another such switch, older series but better for sample-and-hold
applications.

20200303/https://www.digikey.com/product-detail/en/texas-instruments/CD4016BE/296-2036-ND/67251

So what's a bilateral switch?  It's simply a switch that can conduct
current in both directions, just like a relay.  Hence it eliminates
the need to worry about input/output as is often the case with digital
logic circuits... and it also creates the problem of phantom current
loops if not properly managed.  But the point is, if you're going to
use a diode, you might as well just use a buffer IC instead because
that accomplishes the same task.

A bilateral switch is also, therefore in a sense, like a buffer that
supports high-impedence for adding tri-state logic.  "Bus switch" is
also another word for similar devices because they are used to switch
access on a shared bus.

20200303/https://en.wikipedia.org/wiki/Analogue_switch

Of course, if you only want the signal to flow in one direction, you
better use a tri-state logic buffer chip instead of a bilateral
switch.

Again, I reiterate, because this is important!  Remember, if you have
multiple devices connected to a shared communication bus, all devices
not participating in active communications must be in a high-impedance
state to minimize current supply requirements and high frequency
signal reflections.  Only a single transmitter can be low-impedance at
a time.  If there is more than one receiver, the receivers should be
low impedance relative to the transmitter, and the impedance
parameters form the limits on how many simultaneous devices can be
connected to the same shared communications bus.

Again, I reiterate, because this is important!  Also, please note that
once you start wiring complex logic with several logic chips, it
becomes paramount that you use proper decoupling capacitors, otherwise
you'll get glitches in your logic and your system simply won't be
working as it should.  100 nF ceramic per every logic chip is a good
rule of thumb if you don't know any better, but for low-speed designs
you can often get away with only 10 nF ceramic per a cluster of logic
chips.
