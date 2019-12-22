---
layout: post
title: An overdesigned Raspberry Pi Zero system
date: 2019-12-17 09:19 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

What is the most complicated, fullest featured way you could build out
an electronic system around a Raspberry Pi Zero?  This.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2019-12-17-rpi_plan.svg"
        width="500" height="925">
  <img src="{{ site.baseurl }}/blog/images/2019-12-17-rpi_plan.png"
       alt="Electrical outlets picture"
       width="500" height="925" />
</object>

<!-- more -->

So, what is this monstrosity?  We'll explain it a little at a time.

Let's start at the top.  This is the power system and serial
communications system.  It is possible that power can be supplied via
the serial communications header similar to Power over Ethernet (PoE).
In this case, the "center tap" of the pulse transformer is used to
extract the common-mode voltage.  This power is then sent to the
switch-mode power supply, mainly to buck it down from 12 V or higher
down to 5 V.  We also have support for battery power (implies
buck-boost switch-mode power supply), and DC jack input almost
directly to the regulated power mains (there must be a Schottky diode
to prevent backfeeding that would violate the plug/socket power supply
safety standards).  There is also the recommended polyfuse on the
power path to the Raspberry Pi Zero.  Matter of fact, since we're
likely using 2.5 A max wires and connectors, you might consider
placing it in the whole power supply circuit.

For long distance support, we use RS-422 transceivers for the serial
communications.  RS-485 is not much more difficult to support, so we
also support that, plus it allows for a multiple-access shared bus.
Finally, we also throw in a few more serial connectors on the other
end like RS-232. possibly **without** a complete transceiver circuit
to save cost (and cheap RS-232 ports will not output 12+ V anyways),
pin header CMOS serial, and maybe even 3.5 mm audio connector serial.

Now, down to our Raspberry Pi, we have _everything_ connected to it:
UART, I2C, SPI, GPIO, USB hub, and Raspberry Pi Camera.

* The sole connection to SPI here is a graphics display, but there
  could even be a slave selector network for multiple SPI devices.

* I2C at the very minimum has a GPIO expander connected, from which we
  can connect all kinds of additional devices, such as DC brushed
  motor drivers, an low-frequency IR transceiver, 1-bit buzzer, and
  LEDs in particular.  The idea is that we only connect devices here
  that require low frequency control, and high-frequency controls are
  directly connected to GPIOs on the Raspberry Pi.

* A 4 x 7-segment digital LED display and 4 x 4 matrix keypad is
  connected via GPIO with pin sharing directly to the Raspberry Pi,
  but this could also be connected via an I2C controller to save on
  directly connected GPIO pins, at the expense of more chips and
  higher cost.  The keypad itself is designed to be multi-purpose:
  telephone, calculator, video game console, hexadecimal input, and so
  on.  N-key rollover is required for video game console use.

* PWM outputs are provided on their own headers.  In addition, there
  may be a selector network to share the two PWM outputs across
  multiple end points.

* "Analog inputs" are provided as GPIO pins directly connected to the
  Raspberry Pi.  The idea is that we want the fastest possible timing
  in case we want to use one of the ADC methods that require realtime
  software timing loops.  Otherwise, these are just additional GPIO
  pins directly connected to the Raspberry Pi for any other use.

  Additionally, there could also be a "selector network" connected to
  the Raspberry Pi as a alternative to an I2C GPIO port expander.
  This allows for fast sampling from the Raspberry Pi of a larger
  number of inputs or outputs, so long as they do not need to be used
  simultaneously.

* One important device we want to connect to analog input is a
  force-sensing resistor (FSR) so that we can measure the weights of
  objects.

* Finally, of course, we need to have all kinds of fancy devices
  connected via USB: Ethernet, Wi-Fi, Google USB TPU, quality A/D
  audio output + microphone input, video capture input, and so on.  We
  also want to have two USB on-the-go ports so that we can connect
  directly to the Raspberry Pi Zero rather than through the hub, and
  maybe auto-disable the hub connection or provide a DIP switch.

In addition, there is a 40-pin expansion header that connects directly
to the 40 pins on the Raspberry Pi Zero, intended to allow you to plug
in HATs as-is.  Of course, you cannot use the full 40 pins in an
expansion at the same time you are using all other board functions, we
may even consider providing DIP switches on board to switch off the
on-board peripherals.

The display-keypad is pretty good, but how could it be better?

* Separate directional arrow keypad with central "enter" button.
* L and R buttons on sides of console.
* 8 to 12 digits.
* Full characters via "union jack" display.

Indeed, if we're thinking about connecting a much more sophisticated
keypad and digit/character display, we would give it a serial protocol
and connect through I2C rather than GPIO.

MORE MODULES:

* Parallel port
* Board-level reset.
* All peripherals reset, output pin from Raspberry Pi.

* Motor control selector network.  The ability to select a motor to
  control.  ADVANCED: And to hold it at a certain PWM frequency.
  Otherwise, you do PWM frequency select scanning in software.

  Last thing you can do is to have the whole multiplexed controller
  connected to a serial bus like I2C rather than direct parallel
  connection.

And this is to say that for most practical applications, you will not
need to use all such functions all at once, but onl a subset of
available functions will be required.

----------

Yes, in general, the way to build ultra-sophisticated computer
controlled systems is to use serial buses.  All the way down.  Until
you get to the bottom where you have multiplexers, shift registers,
daisy chaining, and matrix networks.

* NOTE: Multiplexers are generally easier to program with than shift
  registers because they are stateless.  For many simple circuits,
  they can be used with the same number of pins as would otherwise be
  required to control a shift register.  The disadvantage, of course,
  is that a multiplexer has no memory, so you cannot hold multiple
  outputs high simultaneously.

What can a serial motor controller do?  With only two-byte commands,
you can command and control a full 256 motors.  Wow, and that's all
through the magic of serial communications.  Makes a tough challenge
look tiny.

Likewise, you can have multiplexed analog inputs that can share a
small number of, or even just one, ADC, if you don't need simultaneous
sampling.

Keyboards and switch matrices are easy to connect.  Read state command
method, 1 byte covers 256 switch states.  Send delta event method, 1
byte covers 128 switch states.

Force-sensing resistor matrices require a bit of finesse, use Schottky
diodes and full diode isolation, but it can be done.

Capacitive sensing matrices, well now that is hard.  With diodes
current can only flow in one direction.  When a capacitor is charged
up, current can no longer flow.  But then how do you discharge it?  It
will just hold its charge and only leak slowly if you do nothing else.

----------

Connections within a single box electronic system, short distance:

1. If you would normally do a direct parallel connection via GPIO
   pins, but you've got too many pins to attach to the processor's
   directly available GPIO pins, add a microcontroller on the I2C bus.

2. If you need more speed than what I2C offers, move to SPI.

3. If you need more speed than what SPI offers, move to inter-chip
   USB.

   20191218/https://en.wikipedia.org/wiki/InterChip_USB

4. If you need more speed than what USB offers, well then you've
   really got to prepare for a heck of an electrical engineering
   challenge with high frequency circuits.  The PCI family of buses is
   the next faster choice.

Connections between different electronic box systems, mid distance:

1. Serial communications: RS-232, RS-422, RS-485.

2. CAN-Bus

3. USB.

4. Ethernet.

Connections between different electronic box systems, long distance:

1. Serial communications: RS-422, RS-485.

2. Ethernet.

3. Coaxial.

4. Fiber optic.
