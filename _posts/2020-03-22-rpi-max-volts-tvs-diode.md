---
layout: post
title: "Raspberry Pi maximum voltage and TVS diode voltage regulator"
date: 2020-03-22 16:45 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

What is the maximum input voltage that Raspberry Pi can handle?  5.25
V is what is claimed to be the maximum.  Beyond that, damage can
result to your Raspberry Pi.  Unless you have a Raspberry Pi 3, then
it handles this in an interesting way... there is a TVS diode that
will short if there is an overvoltage, and that will cause a high
current that will trip the polyfuse, thereby preventing any damage
from the overvoltage.  Please note that your polyfuse's max voltage
should be above the clamping voltage of the TVS diode, else your
polyfuse will get damaged before the TVS diode trips.

20200322/DuckDuckGo raspberry pi 5.2 maximum voltage  
20200322/https://lb.raspberrypi.org/forums/viewtopic.php?p=1604897

So, what is a TVS diode?  Ah, yes, the missing link that I was merely
hinting at in my summary of protective circuits.  Yes, indeed this is
the missing link... if you want a semiconductor diode voltage
regulator to provide a barrier against higher voltages in your
circuit, but you want something that can specifically tolerate higher
voltage transient spikes, a TVS diode will do that.  A TVS diode is
placed in reverse polarity in a circuit so it is normally
non-conducting.

20200322/https://en.wikipedia.org/wiki/Transient-voltage-suppression_diode

Also related is a "crowbar device."  Unlike a TVS diode that
dissipates much more excess energy as heat from itself, a crowbar
device creates a short circuit path for the excess current to flow
through.

<!-- more -->

Please note: If you are using a TVS diode in an application where
reverse polarity is assumed to "never happen," then you can use a
unidirectional TVS diode.  Otherwise, if you are using a Schottky
diode for polarity protection, you should use a bidirectional TVS
diode which is placed in front of your Schottky diode but behind your
polyfuse.  This way, the Schottky diode is protected from transient
voltages, and the polyfuse is also in the proper location to trip the
circuit if the TVS diode must act.

N.B.: Check the max voltage and max current ratings of your polyfuse
before using in relation with a TVS diode.  If either one of these are
exceeded, then your polyfuse may be damaged.

20200331/DuckDuckGo exceed max voltage of polyfuse  
20200331/https://electronics.stackexchange.com/questions/370847/specifications-to-consider-when-selecting-a-polyfuse

UPDATE 2020-04-07: I looked more carefully at the details of the
polyfuse and TVS diode combination in the Raspberry Pi 3 B+, and it
turns out that these are _not_ actually matched such that the TVS
diode tripping will also trip the polyfuse.  The polyfuse simply takes
too long to trip at the rated current, and the TVS diode is not rated
to last this long.  Nope, the graphs show a 10 ms spike as the maximum
duration of a transient voltage spike.  That's nothing compared to the
5 second time to trip the polyfuse.

So, the end all be-all of this conclusion is this... if you wire up a
constant voltage source to the Raspberry Pi 3, you will still have the
same risk of hardware damage as you would on the earlier Raspberry
Pi's.  The TVS diode there will only protect against _transient_
overvoltages, not persistent ones.  A persistent overvoltage would
first damage the TVS diode such that it provides no more protection
ability, and since this is parallel-wired, the overvoltage would
simply continue to flow through the main electronics power supply path
and cause the same damage as if there were no TVS diode.
