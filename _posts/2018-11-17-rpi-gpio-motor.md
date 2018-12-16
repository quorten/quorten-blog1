---
layout: post
title: Discussion on GPIO and motor connections with Raspberry Pi
author: quorten
date: 2018-11-17 23:35 -0600
categories: [raspberry-pi, 3d-scanning, 3d-scanner, reiterate]
tags: [raspberry-pi, 3d-scanning, 3d-scanner, reiterate]
---

Discussion on GPIO and motor connections with Raspberry Pi.

Granted that I am building a motor control circuit for my own 3D
scanner design, I realize that the FabScan Raspberry Pi design of
course also needed to use a motor control setup.  So, for my own sake,
I might as well review what they used in detail and summarize the key
points that are pertinent to me.

20160829/http://hci.rwth-aachen.de/materials/publications/lukas2015a.pdf

So, what do I have to say about the specifics of their design, things
worth noting, and differences with my design?

* Overall, their design requires more complicated electronics design
  and manufacturing.  More electronic components are called for
  all-around.  The use of printed circuit boards scales well for mass
  production, but it is not very friendly toward the kind of use case
  of building a custom design by hand, using it for a while, then
  being able to easily disassemble it and reuse the parts in a new
  project piecemeal.  By far and large, this is the one thing that has
  bugged me most about some older electronics boards I have: there are
  some components soldered onto a PCB that I have in my immediate
  physical vincity but am no longer using in the present.  I would
  love to quickly and easily repurpose those components for new
  projects, but alas, removing them from the PCB is too difficult.

* The use of stepper motors requires more complicated motor control
  driver ICs than is required for plain DC motors.

<!-- more -->

* The design of the FabScan calls for more motors, of course.

* The FabScan still uses an Arduino-compatible microcontroller to
  control the motors directly.  The Raspberry Pi is in addition to the
  Arduino microcontroller and connects via GPIO.  My design, by
  contrast, doesn't really need a microcontroller for motor control.

* The Arduino-compatible microcontroller is soldered onto a
  custom-designed PCB.  This custom-designed PCB is also designed to
  conform to the Raspberry Pi HAT standard, namely that it provides
  identification information so that the Raspberry Pi can
  automatically identify the PCB and assign the GPIO pins correctly.

* The motors run off of 12 volts.  Therefore, the FabScan Pi HAT is
  designed to have a 12 V DC.

----------

Again, I reiterate, because this is important!

So, let's review.  What was the proper way to use the GPIO pins on
Raspberry Pi?  For LEDs, you need to wire a resistor in series.  What
value of resistor is required?  The official Raspberry Pi guide says
that anything 50 ohms or greater should be okay.  Indeed, I've checked
the schematics in my 200 in 1 electronics kit that wire 3V power to an
LED, and they use the 100 ohm resistor.  So, we're on the same page
with that detail.

Now, what about limits on current draw?  I thought I read something
like no more than 35 mA for the 3.3 V GPIO connectors, is that
correct?  Well, actually it's just a rule of thumb.  Another rule of
thumb recommendation is to limit the current draw from a single 3.3 V
GPIO pin to 16 mA.  The exact details are actually a little foggy, as
the maximum current draw from a GPIO pin is contingent on the maximum
3.3 V current supply available.  Suffice it to say, the maximum 3.3 V
power supply available is everything left over after you subtract 5 V
power drains, the Raspberry Pi Zero board itself, and the camera
module.

Now, if you're wondering about current draw on the 5 V power supply
pins on the Raspberry Pi.  Remember that the Raspberry Pi's current
draw at the 5 V power supply is limited to 1 A.  The full circuit will
never draw more than 1 A of power at 5 V, including power for the
board, all USB peripherals, and any directly connected 5 V devices.
That means you can't really do too much with connecting motors to the
5 V power supply: with about 250 mA for the Raspberry Pi Zero board
itself when under high CPU load and 250 mA for an attached Camera
Module, that doesn't leave much current to spare for powering a motor.
If you also want to use HDMI, then you subtract another 50 mA.  Each
connected USB device in turn subtracts more from the available
current.  One really low power 5 V motor, yes that might work, though,
so long as you don't carry around too many extra power draining
doodads.

So, now let's calculate some final numbers for available 3.3 V power
supply pin current.  If you are using 500 mA of 5 V current, that
leaves you with 1 Watt - 5 V x 250 mA = 2.5 Watts of power left over
to channel to to 3.3 V power sources.  In 3.3 V terms, that is 2.5
Watts / 3.3 V = 758 mA of current available for all 3.3 V devices.
Indeed, this is comparable to the Raspberry Pi StackExchange member
that tested up to 800 mA of current can be drawn from the 3.3 V supply
pin.

Some other important notes relating to power supply specifics.  Note
that the Raspberry Pi Zero does not in fact have any voltage
protection circuitry on the power supply, unlike the other Raspberry
Pi modules, so "the use of a power safety diode is probably
superfluous."  Also, the Raspberry Pi Foundation does make
recommendations on how to power the Raspberry Pi from through the
expansion header power pins for HATs, so this is a commendable way to
power the Raspberry Pi.  However, the info does note that "Under no
circumstances should a power source be connected to the 3.3V pins."
Now, is this claim really backed by any evidence, or is it just a
misinformed warning?  Indeed, it is a sound claim: the voltage
regulators that generate the 3.3 V, 1.8 V, and core 1.2 V voltages are
sourced off of the 5 V power supply pin.  If you supply power into the
3.3 V pin, there will be no power source for the core voltage, hence
your Raspberry Pi will not boot.  So, now you know that this is why
the NumWorks calculator hack wired the 2.8 V input to the Raspberry Pi
5 V input.

Oh, and another important note.  That earlier Raspberry Pi
StackExchange link that you found about powering with batteries on 3.3
V?  Looking at the in-depth details of the newer answer appear to show
that the other answer was relating to the original Raspberry Pi board,
not the B+, Zero, and newer board design friends.

Oh, and one last note this time.  Just to confirm, indeed I checked,
on Digikey, the PAM2306AYPKE IC that generates the 3.3 V and 1.8 V
supply voltages from the 5 V supply, and this is strictly a _buck
switching regulator_.  So, yes, you do need a buck/boost switched mode
power supply if you are powering off of batteries, especially for the
case of a 3 V battery pack: the 2.8 V threshold requires the battery
to be >93% of its original voltage, whereas you'd probably want to be
able to run the battery down to 10% of its original voltage.

Ah, I see they must have removed the comment about an LED burning out
after about 10 seconds if you use it without a resistor.  That was a
nice handy tidbit of information, though.

20181117/DuckDuckGo raspberry pi gpio led  
20181117/DuckDuckGo raspberry pi gpio led burn out 10 seconds  
20181117/DuckDuckGo raspberry pi led resistor  
20181117/DuckDuckGo raspberry pi gpio  
20181117/https://www.raspberrypi.org/documentation/usage/gpio/  
20181117/https://projects.raspberrypi.org/en/projects/physical-computing/16  
20181117/https://projects.raspberrypi.org/en/projects/physical-computing/4

20181117/DuckDuckGo raspberry pi gpio 5 v supply pin current draw limit  
20181117/https://www.raspberrypi.org/forums/viewtopic.php?p=158827  
20181117/https://raspberrypi.stackexchange.com/questions/9298/what-is-the-maximum-current-the-gpio-pins-can-output  
20181117/https://raspberrypi.stackexchange.com/questions/51615/raspberry-pi-power-limitations

20181125/DuckDuckGo PAM2306AYPKE  
20181125/https://www.digikey.com/product-detail/en/diodes-incorporated/PAM2306AYPKE/PAM2306AYPKEDICT-ND/7794266

Ah, so now you update me on this documentation aspect.  H-bridge you
mention.  What exactly is an H-bridge.  This.  Also, as it turns out,
the L293D motor controller IC is in fact a dual H-bridge circuit
inside.  Yes, I would have known that had I'd been looking at the spec
sheet more carefully the first time, but I just glossed over it hoping
I wouldn't need to understand the internals too carefully.

20181117/DuckDuckGo h-bridge circuit  
20181117/http://www.circuitstoday.com/h-bridge-motor-driver-circuit  
20181117/https://en.wikipedia.org/wiki/H_bridge

What are the keys to the H-bridge circuit?  The ability to reverse the
voltage using 4 transistors, each of which can be wired to a GPIO pin,
and the flyback diode to protect those transistors and the other
sensitive circuits from the inductive kick-back.  For simple
low-voltage micro motors, the cheap commodity silicon diodes (1N540x
and 1N400x) can be used.  Note that in my very simplest of cases of
motor control, where I just have a motor and a laser wired directly to
a power supply and the slide switch on the power supply is what I use
to "control" the motor, the motor control circuit can be further
simplified under some circumstances.

1. First of all, only a single flyback diode needs to be used for
   motor control if the motor can never be controlled in the reverse
   direction.

2. Second, in place of transistors on both sides of the motor, you can
   use two linear voltage regulators.  Literally, a simple Zener diode
   achives the desired effect: if the motor is mechanically rotated
   outside of electronic control, it will generate a voltage and a
   current.  The voltage depends on the direction speed that the motor
   is turned.  The "diode" function of the Zener diode prevents a
   negative voltage from flowing through the wrong direction on
   sensitive electronics.  The "voltage regulator" function of the
   Zener diode prevents the flow of too high of a voltage that could
   damage the sensitive electronics.

3. Third, you may note that it is not necessary to have a voltage
   regulator on each side of the motor.  If there are no other
   circuits in series with the motor and the power supply, only a
   single voltage regulator is needed to prevent current loops through
   sensitive electronics.

4. Fourth, if you know for sure that external forces will not cause
   over-voltage or wrong polarity currents to come from motor, then
   you may even eschew with the single linear voltage regulator and
   use only the cheap commodity silicon diode to protect against
   inductive kickback.

5. Finally, another note worth considering.  If you think additional
   circuitry is needed to protect the laser against the user
   installing the battery backwards, you might opt to instead place
   the voltage regulator on the laser power path rather than the motor
   power path.

6. Now, with all that was previously said about GPIO current draw
   limits, this means that unfortunately you probably can't power a
   motor from GPIO pins directly.  But, if you could, then even when
   you have electronic motor control, you could still make a
   drastically simpler circuit.

20181117/https://en.wikipedia.org/wiki/Flyback_diode

Also, that `circuitstoday` site noted some other important motor
control ICs to try: L298, TC4424, and LM2941.  Indeed, there is a 3 V
dual H-bridge motor control IC available, the L298, you don't need to
step down to only a single H-bridge if you want to do this.  Alas, the
L298 still requires 5 V power for its logic.

20181123/http://www.circuitstoday.com/h-bridge-motor-control-circuit-using-l298

Other notes about the flyback diode.  A flyback diode of a sort is in
fact used in the design of a switched mode power supply.  Well, that
being said, there are switched mode power supplies in integrated
circuit packages that reverse power protection.

20181123/https://en.wikipedia.org/wiki/Schottky_diode
