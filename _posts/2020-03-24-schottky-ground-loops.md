---
layout: post
title: "Beware of ground loops when using Schottky diodes to polarity
        protect multiple power supplies"
date: 2020-03-24 20:31 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Schottky diodes, yes, your primary go-to when you want to protect a
potentially battery-powered system from polarity inversion, right?
Yes, indeed, if you have one power supply voltage input, just use one
Schottky diode and you're done.  But what if you have a board with two
power supply inputs?  For example, you might have both 5 V and 3.3 V
logic components on your board, and assuming you do not use an
on-board switched-mode power supply, that means you'll have two power
connectors.  So, just use two Schottky diodes.

Hold on.  Now, this is where you need to scrutinize your specific
wiring.  Often times in logic circuits with both 5 V and 3.3 V power
supplies, a "common ground" return path is used for both voltage
potentials.  Assuming the worst in a prototyping environment, you
might connect a voltage source across the two different potential
levels.  So, how is this problematic?  Well, if your circuit design is
botched, you might have been assuming that current would never be able
to flow across that path and somehow have some short across that path.
Like, "Hey, I don't care whether this circuit gets 5 V or 3.3 V, just
give me either power supply that is available."  So you wire the 5 V
and 3.3 V together just like a "Y" connection, and, just like that,
you've got a short.

<!-- more -->

In any case of uncertainty about this, adding two more Schottky diodes
to enforce polarity on every pin in your two power connectors will
eliminate this possibility, even when using a common ground.  You must
still also use two separate Schottky diodes for each ground return
since otherwise you have another short circuit path on ground for the
same reason.

In my particular case, it's literally that I'm designing a "debug"
board module that can connect with any random board that I may not be
immediately aware of such wiring implications, so I figured it's
better to be safe than sorry.

What if you are designing a complete system where all extremes are
known, and you want to minimize the component count and cost as much
as possible?  If these assumptions are held, you can progressively
reduce the number of short circuit and polarity protection Schottky
diodes you have in your circuit.

* You have no short circuit connections between the voltage supply and
  ground return of any voltage supply, of course!

* You do not ever have any two different voltage supplies wired
  directly together.  If two voltage supplies must be wired together
  to provide an "either voltage X or Y" function, they are always
  connected with two diodes.

* You use separate ground return paths for each voltage supply, and
  the ground return paths are never bridged together anywhere in your
  circuit.

* Alternatively, if you use a common ground return path, you must have
  polarity protection Schottky diodes on each power supply's ground
  connection.

* Finally, the ultimate omission.  If you use a mechanically polarized
  power connectors on your board, **and** the final connection to the
  ultimate power source is polarized, such as a diode bridge rectifier
  connection to AC line power, then you can omit the final polarity
  protection Schottky diode from each power supply connector on your
  board.  That being said, it is worth reiterating that instead of
  using a Schottky diode to enforce polarity on your board, you could
  instead use a diode bridge rectifier... but as I've mentioned
  previously, the motivation of using a simple Schottky diode in place
  of a diode bridge rectifier is that it is cheaper.
