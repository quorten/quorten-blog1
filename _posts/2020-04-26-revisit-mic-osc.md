---
layout: post
title: "Revisiting building a cheap oscilloscope using PC microphone
        input"
date: 2020-04-26 17:41 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, okay, now that I've researched the actual voltage levels on
computer inputs, I can revisit the idea of building a microphone
input-based oscilloscope with more confidence.

A resistive divide-by-1000 voltage divider is a good starting point to
get 5 V logic down to a voltage level similar to that from a "dynamic"
moving coil microphone.

* Bottom leg: 100 ohm
* Top leg: To divide by 1000... 100 * 1000 = 100 K ohm

Yeah, this is the easiest selection of resistors, but technically the
total resistance is 100.1 K ohm, so the division factor is 1001, not
1000.  And is this sufficient resistor values for the current drain of
the sensor?  I'm pretty sure it is.

Are dynamic moving coil microphones those common ones you see on
stage?  Yes, these are the typical kind of microphones used on stage
amplification, where the listeners are in the same room as the
performer and it is important to use this type of microphone to
supress the "howling" feedback loops that result when the microphone
picks up the amplified output.  Try plugging one of these into your
audio input and see what kind of digital signal levels you get from
your particular microphone input.

<!-- more -->

Otherwise, if you really don't have one of these on hand, just
try divide by 1000 to be on the safe side, and if you still have
plenty of headroom on your digital input, you can step up to
divide by 100.

----------

What exactly is the voltage level output of moving coil microphones?
How does that compare to electret microphones?

20200426/https://en.wikipedia.org/wiki/Microphone  
20200426/https://en.wikipedia.org/wiki/Electret_microphone

Unfortunately Wikipedia doesn't give numbers to these different types
of microphones, so I have to search elsewhere.

20200426/DuckDuckGo output voltage dynamic microphone  
20200426/https://www.sweetwater.com/insync/understanding-signal-levels-audio-gear/

Ah yes, so this article labels microphone voltage levels into just two
different general classes of microphones, when they output less than
line-in levels.

* 2.5 mV low-output mics (i.e. dynamic microphones)
* 23 mV high-output mics (i.e. electret microphones)

Then, of course, consumer line-in starts at 316 mV (0.3 V) and
voltages go up from there to the more familiar voltage levels for
digital logic I/O connectors.

Indeed the numbers agree with [my previous recorded numbers]({{
site.baseurl }}/blog/2019/11/16/io-conn-volts)... just that I wasn't
exactly sure about which microphones those numbers were supposed to
refer to.

Now, revisiting the instructable that details how to build a cheap
oscilloscope using a PC microphone input... they recommend picking the
resistors to divide by 1.3 at minimum, and divide by up to 11 maximum.
Clearly, they are recommending resistive divider values only suitable
for line-in input, not microphone input.

* 22K high leg, 82K low leg.
* Up to 820 K high leg.
* Plus an additional 50K or 100K linear potentiometer on the high leg.

And they say the potentiometer is only necessary to adjust if the
input is above 5 V.

20200426/https://www.instructables.com/id/Use-Your-Laptop-as-Oscilloscope/

And they recommend plugging the 3.5mm stereo jack into LINE-IN/MIC.
Plugging into line-in for sure is safe with 0.8 V or less, 0.3 V being
a safer starting point if you really don't know about the specific
limits of your device.

Inductive coupling is also another approach that can work well.  This
may be an easier approach for stepping down really high voltages, and
it has the advantage of using separate electrical current loops.

Okay, let's fact check... here, they are recommending that the
microphone input accepts up to 100 mV.  Line-in can do up to 1 V.  I
would agree without any further knowledge of the hardware.

DuckDuckGo can laptop microphone input handle line in voltages  
20200426/https://forums.tomsguide.com/threads/pc-microphone-in-voltage.239703/

You can't measure DC signals with microphone input, can you?  Yes
indeed, sound cards are AC coupled and won't measure frequencies below
20 Hz.  Either that, or they use a high-pass filter on the input to
get the same effect.

This is an old but good info article on the electrical construction of
the line-in input on old PC sound cards.  Indeed, most sound cards
have a capacitor to act as a high-pass filter on the input of line-in,
and therefore especially also microphone input.

20200426/https://www.qsl.net/om3cph/sb/dcwithsb.htm?_ga=2.162187132.1923014167.1587942445-807676586.1587942445

But hey, here's another approach for measuring DC.  If the frequency
is too low, you can modulate the signal with a higher frequency
carrier wave.  Just a simple transistor amplifier to multiply the
output of an oscillator by your signal under measurement will do the
trick.  Need a cheap oscillator source?  Of course, use PC audio
output.  A USB audio device that provides both an audio output and a
microphone input is really handy and really cheap for this specific
purpose.
