---
layout: post
title: "Reiterate transmission line bus construction, RS-485 line
        drivers, comparison with LocalTalk, and power over RS-422/485"
date: 2019-12-05 22:01 -0600
author: quorten
categories: [raspberry-pi, reiterate]
tags: [raspberry-pi, reiterate]
---

After some thought analysis about what I've learned about transmission
line reflections theory, I can re-affirm my explanation of
transmission line bus construction.  Changes in current flow are the
primary cause of reflections.  So, when the question comes down to how
to tap out a T connection to your device connected to your bus wire,
the solution is simple.  You simply want your device on the T
connection to be a "high impedance" connection, i.e. it does not draw
much current from the line.  This way, you are minimizing your
interruptions to the line current when connecting.

But on second thoughts, there may be other considerations.  You can
have multiple receivers on the connection simultaneously, but only one
sender can send at a time.  So, although you can have a high-impedance
receive, you must have a low-impedance send.  And ultimately, you want
to be able to electrically remove a device from the transmission line
when it is not sending so that it does not provide a current flow path
that would interfere with other senders.  Ah, yes, looking at the
Wikipedia article for "three-state logic" in more detail, this is
precisely what it is: in addition to an output being able to assert
two states, it can also assert itself to be electrically removed from
the connection, creating a high-impedance state.

20191209/https://en.wikipedia.org/wiki/Three-state_logic

<!-- more -->

So, that's the magic on control of the sender side.  So, finally, your
primary current path is pretty much just the "bus" line connection
itself, and you finish that off by terminating the ends of the bus
line with resistors equal to the characteristic impedance of the line.
These resistors, of course, have lower resistance than the high
impedance receive connections, which are designed to have a higher
impedance so as to not interfere with the line.

So, another consideration.  What kind of cable should you use for your
own IoT network where you plan on connecting devices via RS-485?  In a
large scale construction, sure, you could use cheaper cable, but my
recommendation would to be to simply use the same standard Cat6A cable
that you are using for building out the Ethernet network, and likewise
strive to wire it up in a star topology.  This provides for easy
upgrade to a high-speed Ethernet network should the need arise in the
future.  "Design for the future, because it will be here sooner than
you think."  And especially for construction at the building scale,
often times there are sources of delay and procrastination with making
any changes at all that more than tilt the cards to building
future-resistant structures that can still provide value even under
procrastination and deferred maintenance.

Now, what if you want to put a single RS-485 receiver at the hub of a
star topology with point-to-point connections?  How can you do this
that provides for proper termination at the characteristic impedance?
Simply use line drivers for termination, this will provide for
electrical isolation of the current loops of different wires.  Then,
you can wire-OR everything together on the board-side of your circuit,
without worrying about creating interference in the lines.

Okay, so enough hypothesizing, let's take a look at the data sheets
for some actual RS-485 line drivers.  Indeed, I can confirm my
explanation in the data sheets.  The input impedance determines the
maximum number of transceivers that can be connected, such as 32.
That's also especially why you must use a purpose-built "receiver"
circuit if operating on multiple access bus communications.  Likewise,
only one transmitter can be connected at a single time, and all other
transmitters must be in the high-impedance state.  High impedance
input, low-impedance output.

20191210/DuckDuckGo digikey rs-485 line driver  
20191210/https://www.digikey.com/catalog/en/partgroup/rs422-rs485-differential-line-driver/11774  
20191210/https://www.digikey.com/catalog/en/partgroup/rs-422-rs-485-transceivers/9879

There are also some nice through-hole DIP components to boot.

20191210/https://www.digikey.com/products/en?mpart=ADM485JNZ&v=505  
20191210/https://www.analog.com/media/en/technical-documentation/data-sheets/ADM485.pdf  
20191210/https://www.digikey.com/products/en?mpart=ADM488ANZ&v=505  
20191210/https://www.analog.com/media/en/technical-documentation/data-sheets/ADM488_489.pdf

This last one is probably more complicated than needed for practical
applications, but it may be useful for experimentation.  Typically you
only use either full duplex or you use half-duplex with 3-state logic.
It also has the slowest data rate at 250 kilobits per second, but
that's still plenty fast.

20191210/https://www.digikey.com/products/en/integrated-circuits-ics/interface-drivers-receivers-transceivers/710?k=ADM489&k=&pkeyword=ADM489&sv=0&pv16=96863&sf=0&quantity=&ColumnSort=0&page=1&pageSize=25

RS-422 and RS-485 are 5 V logic, easy as that.  Use level shifters to
interface the input/output of these line drivers with 3.3 V logic.

Whoa, this RS-485 line driver is rated for 30 megabits per second.
Much faster than I could ever need for most of my projects.

20191210/https://www.digikey.com/products/en?mpart=ADM1485ANZ&v=505  
20191210/https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1485.pdf

Okay, but I still don't know about the whole T connector thing.  Well,
if I had to throw in by best guess, it is that you want the branch on
the T connector to be as short as possible, if such a design is
unavoidable.  And termination is agreed to be 120 ohm resistors for
twisted pairs.

20191210/DuckDuckGo rs-485 t connector  
20191210/https://eeci.com/rs-485.pdf  
20191210/https://www.windmill.co.uk/rs485.html

On the other hand, Apple LocalTalk was very similar to this whole
RS-485 thing, and they used transceiver modules that two connectors
for the daisy chaining.  And, they had automatic termination and some
additional filter electronics inside the modules.  Filter electronics
such as an inductor, capacitor, and some resistors.  Then there is a
finite length of wire for connecting between the module and your
Macintosh.

Yeah, really interesting that the LocalTalk article does not mention
RS-485, the similarities are many.

20191210/https://en.wikipedia.org/wiki/LocalTalk  
20191210/https://en.wikipedia.org/wiki/Choke_(electronics)

But, looking elsewhere, the magic trick is revealed.  Here is a
datasheet that shows how you can connect an RS-485 transceiver to a
LocalTalk network.  So, what's actually in that LocalTalk interface
box?  A transformer is used to electrically separate the transceiver
from the LocalTalk line bus network.  This effectively allows you to
isolate the impedance effects of your "T connector" from the LocalTalk
bus wire, keeping its electrical path as straight as possible.
However, it also imposes different electrical standards, such as the
inability to pull the line high or low and the need for proper
communications frequency matching.  The receiver circuit is connected
to with two 1 K resistors, thus providing the required high-impedance
input.  Also, each transceiver input/output is filtered with a 100 pF
capacitor to ground surrounded by two 22 ohm resistors.  The LocalTalk
bus wire is terminated with 120 ohm resistors.

Additionally, it is also possible to directly connect to an LocalTalk
network without the transformer, and using full duplex with separate
twisted pairs for transmit and receive.

20191210/DuckDuckGo localtalk rs-485  
20191210/https://html.alldatasheet.com/html-pdf/547355/LINER/RS485/2150/14/RS485.html  
20191210/https://html.alldatasheet.com/html-pdf/547355/LINER/RS485/2304/15/RS485.html

Okay, enough with the nonsense on that site, let's get it straight
from the Digi-Key source.

20191210/DuckDuckGo digikey ltc1321  
20191210/https://www.digikey.com/product-detail/en/linear-technology-analog-devices/LTC1321CSW-PBF/LTC1321CSW-PBF-ND/891269  
20191210/https://www.analog.com/media/en/technical-documentation/data-sheets/lt1321.pdf

One more point in hand.  LocalTalk is also limited to 32 devices per
network, just like RS-485.  So indeed, the input impedance
configuration is not somehow superior to that used on RS-485.

20191210/https://en.wikipedia.org/wiki/AppleTalk

----------

Again, I reiterate, because this is important!

Now this really gets me thinking.  Isolating transformers on a
RS-422-style differential communications through LocalTalk?  Well if
that works just fine, now I'm thinking power over RS-422, similar to
Power over Ethernet (PoE).  As I've learned on the Wikipedia article
on Power over Ethernet, PoE is pretty simple to implement due to the
center tap transformer design of Ethernet transceivers.  Now I see
that clearly for RS-422/485 communications too, thanks to the
LocalTalk schematics.  In the case of RS-485, you'd use a spare wire
pair to carry the other common-mode power or ground, whichever is the
opposite of what is carried on the data wires.

Likewise, the schematics of the Raspberry Pi 3 Ethernet jack are also
very insightful for the particular design of Power over Ethernet.
Note that the center tap on the Raspberry Pi side of the circuit is
used for the power.  Notably, there are also ferrite core chokes used
to suppress any common-mode noise common across _all_ Ethernet wires
on the outside world input/output side.

20191210/https://en.wikipedia.org/wiki/Power_over_Ethernet  
20191210/https://en.wikipedia.org/wiki/Transformer_types#Pulse_transformer  
20191210/https://hackaday.com/2018/06/01/raspberry-pis-power-over-ethernet-hardware-sparks-false-spying-hubub/

The particular types of transformers used in Ethernet jacks are called
_pulse transformers_.  These are transformers that are optimized to
work with square wave signals.  Also, a duty cycle near 50% is pretty
much required.  Okay, so thinking about this, sure that may work well
for Ethernet and LocalTalk, but it may encounter problems with RS-422
and RS-485 serial communications.  But surely, there is technical info
on how to make it work for that application?  Indeed there is.

So, here's what looks like the trick is to putting RS-485 through
isolation transformers.  You might add an additional oscillator for
signal modulation so that your flat runs of high signal value will
register as the presence of high frequency oscillation.  But, I guess
I don't fully understand exactly how the pulse transformer is matched
with the serial communications frequency and what the frequency
response curve looks like.

20191213/DuckDuckGo rs-485 pulse transformer  
20191213/https://www.ti.com/lit/ds/symlink/iso35t.pdf  
20191213/https://www.digikey.com/catalog/en/partgroup/iso35t-series/58979

Also, thinking more about PoE, if you extract your power on your
device's side of the transformer, the common mode power source must
also be an alternating current signal in order to make it through the
transformer.  Ah, yes, so that's why the article on the Raspberry Pi's
Ethernet jack noted that the transformer needed to pass the
alternating current power through.  You don't want to use a direct
current common mode signal because then you must tap out away from the
device side, and you render in the risk of ground loops and limiting
the common mode voltage range.

Yeah, the whole concept of these transformers in longer data
transmissions lines is pretty much the same as that of the isolation
transformers in single-wire earth return.
