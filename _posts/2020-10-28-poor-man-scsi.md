---
layout: post
title: "Poor man's SCSI via parallel port revisited"
date: 2020-10-28 03:06 -0500
author: quorten
categories: [vintage-computing, mac-classic, raspberry-pi]
tags: [vintage-computing, mac-classic, raspberry-pi]
---

SCSI over parallel port?  No kidding, is a really great way to access
high performance devices from what use to be a cheap, low-cost, and
fast interface.

Looking into this is more detail, a lot more is possible than I
originally thought!

First of all, the question of needing to exclude parity bits?  Well,
you can wire together a simple combinatorial logic circuit to generate
the parity bits from the data lines, just an XOR circuit.  Okay, but I
guess there's a problem here, you have to know what direction the data
lines are being asserted to know if you should generate the parity bit
or not.  But this is actually an easy problem to solve: use the I/O
line to control the output driver.

Where does our Vcc come from for our logic circuit?  I'd say we
diode-OR some control pins together that we know are never going to be
all low simultaneously.  Well, okay... that's tricky because those are
pull-up resistors powering us!  So, diode-OR everything together, that
will maybe give us 200 ohm resistance to power on average.  Maybe we
really do need another dongle to get power from somewhere else, like
USB?  Oh, and that also brings into question, what if our driver does
drive a lot of current on high?  Well, that's where our
current-limiting resistors can help, as we'll discuss later.

<!-- more -->

Now, what about if you want to use a PC parallel port as a target
rather than an initiator?  Well, that is possible too through a clever
hack observation.  Out of all the control lines driven by the target,
which one is least frequently used?  Surely, it is the `BSY` signal.
This is only set and cleared at the beginning and end of a
transaction.  Now, let's think about the other signals.  Are they ever
going to be all zero at the same time?  I don't think so.  But even if
this could happen, surely there is a combination of those control
lines that will never happen in proper protocol communications.  Use
combinatorial logic on a specific combination of asserted values to
determine the clock signal to a toggle register that drives the `BSY`
signal line.  The `RST` signal clears the toggle register, of course.

That fully covers the few extra signals that you need for SCSI that
you can't drive with a PC parallel port.  What else is missing?
Electrical standard.  What?  You mean they're not compatible?  Yes,
they're not compatible.  This is going to be a lot harder, then...

Here's the problem.  SCSI uses passive bus terminators that are
basically low-resistance resistors to power and ground.  Then the idea
is to use open collector drivers to sink current from these resistors
to pull the voltage of the signal lines low, namely by providing a
low-resistance path to ground.  This means that the open collector
drivers need to sink a lot of current due to the low resistance, and
therefore high current supplied on the lines.

The solution?  Well, there isn't an easy solution short of using line
drivers that are rated to sink the required amount of current, namely
48 mA.  This number is computed from the fact that passive SCSI
terminators use a 220 ohm resistor to a 5 V and two such terminators,
one on each end of the bus.  Thus, I = V / R = 5 V / 220 ohms = 22.727
mA.  Two of these wired in parallel provide half the resistance and
twice the current, or about 46 mA, and definitely less than 48 mA.
However, in practice, many practical SCSI bus implementations only use
a terminator on one end of the bus.

But, there is a mitigation that can be applied within limits.  Add
resistors between your transceivers and the signal lines.  This has
another benefit: if your parallel port drives low-impedance power at
logic-level one ("totem pole" driver), rather than higher impedance as
it should, this will decrease the power that gets sunk into your SCSI
device on the other side.

However, the open collector output resistor and the passive terminator
resistors together effectively act as a voltage divider.  Actually,
because you have resistors in parallel to ground (both the open
collector output and the passive terminator resistor to ground), the
voltage on the bus is slightly different.  So, good news, thanks to
the passive terminator resistor to ground, there is slightly lower
voltage on the bus, and we still get to cut the current sunken to the
transceiver!

Let's show the calculations.  Remember, two SCSI bus terminators are
two resistors in parallel, which divides the resistance by two and
likewise increases the current by two.

One or two SCSI bus terminators, measure the voltage with high
impedance:

TERMx1: 5 V * 330 ohms / (330 ohms + 220 ohms) = 3 V  
TERMx2: 5 V * 165 ohms / (165 ohms + 110 ohms) = 3 V

New "bottom leg" voltage divider resistance with open collector output
pulling the line low, assume 1 ohm source impedance:

TERMx1: 1 / (1 / 330 ohms + 1 / 1 ohms) = 0.997 ohms  
TERMx2: 1 / (1 / 165 ohms + 1 / 1 ohms) = 0.994 ohms

Corresponding voltage:

TERMx1: 5 V * 0.997 ohms / (0.997 ohms + 220 ohms) = 0.023 V  
TERMx2: 5 V * 0.994 ohms / (0.994 ohms + 110 ohms) = 0.045 V

Current through open collector output:

TERMx1: 5 V / (0.997 ohms + 220 ohms) = 22.625 mA  
TERMx2: 5 V / (0.994 ohms + 110 ohms) = 45.047 mA

Now, assume open collector with 100 ohm source impedance, bottom leg
resistance:

TERMx1: 1 / (1 / 330 ohms + 1 / 100 ohms) = 76.744 ohms  
TERMx2: 1 / (1 / 165 ohms + 1 / 100 ohms) = 62.264 ohms

Corresponding voltage:

TERMx1: 5 V * 76.744 ohms / (76.744 ohms + 220 ohms) = 1.293 V  
TERMx2: 5 V * 62.264 ohms / (62.264 ohms + 110 ohms) = 1.807 V

Current through open collector output:

TERMx1: 5 V / (76.744 ohms + 220 ohms) = 16.85 mA  
TERMx2: 5 V / (62.264 ohms + 110 ohms) = 29.025 mA

Initially, I thought that 220 ohms might be too much resistance, but
with my more precise calculations, could it be viable thanks to the
parallel resistor of 330 ohms in the SCSI terminator?  As it turns
out, yes.

Now, assume open collector with 220 ohm source impedance, bottom leg
resistance:

TERMx1: 1 / (1 / 330 ohms + 1 / 220 ohms) = 132 ohms  
TERMx2: 1 / (1 / 165 ohms + 1 / 220 ohms) = 94.286 ohms

Corresponding voltage:

TERMx1: 5 V * 132 ohms / (132 ohms + 220 ohms) = 1.875 V  
TERMx2: 5 V * 94.286 ohms / (94.286 ohms + 110 ohms) = 2.308 V

Current through open collector output:

TERMx1: 5 V / (132 ohms + 220 ohms) = 14.205 mA  
TERMx2: 5 V / (94.286 ohms + 110 ohms) = 24.475 mA

Okay, so the current is only a little better, but the voltage is much
more edgy.  But if you want to be really cautious about the
recommended current limits on your transceivers, this is the way to
go.  More importantly, for me personally, it means I can reuse my 220
ohm resistors when building a poor man's SCSI connection.

Additionally... if you think about it, this is also the perfect way to
attach to a SCSI bus without the need for an additional SCSI
terminator: with "totem pole" drivers, its a 220 ohm resistor to +5 V!
But, I must also note that even a higher-resistance terminator, like
1.4 k-ohm to +5V, is probably going to work well too.

Another hack, of course, is to omit one passive terminator from the
bus, this also reduces the current sinking requirements, with the
obvious caveat that signal reflections will be more of a problem.

I should also note, the Macintosh Main Logic Board and the NCR 5380
chips do not provide any SCSI termination on their side, so actually
you do not need to worry about sinking terminator current at all if
you don't put a SCSI terminator on your device and connect it straight
to the Macintosh without any other SCSI devices.

N.B. Looking for the 53C80 datasheet?  It's tough to find, but look
here.  Here is the 5380 datasheet, there really aren't substantial new
features introduced in the 53C80.

20201027/DuckDuckGo ncr 53c80 datasheet  
20201027/https://web.archive.org/web/20201028040115/https://ftpmirror.your.org/pub/misc/bitsavers/components/ncr/scsi/SP-1051_NCR_5380-53C80_SCSI_Interface_Chip_Design_Manual_Mar86.pdf

The NCR 5380 datasheet is much easier to find, this one is the one I
typically use for reference.

20201027/DuckDuckGo ncr 5380 datasheet  
20201027/http://koyado.com/Heathkit/Z67-IDE-plus_files/NCR_5380_SCSI_Interface_Chip_Design_Manual_May85.pdf

A very important point is worth mentioning about SCSI terminators.  In
most peprsonal computers, the purpose of the SCSI terminators is not
to prevent signal reflections to improve communications speed and
distance, but rather only to establish a default high-level voltage on
the bus since the connected devices use open collector signaling.  So,
even though a SCSI bus is officially specified to have two SCSI
terminators on each end, vintage PCs like the Macintosh only use a
single SCSI terminator on one end of the bus.  This works perfectly
fine because the SCSI cables are always kept to very short lengths in
these physically small computer systems.
