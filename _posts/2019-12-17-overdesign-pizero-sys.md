---
layout: post
title: An overdesigned Raspberry Pi Zero system
date: 2019-12-17 09:19 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2019-12-17-rpi_plan.svg"
        width="500" height="925">
  <img src="{{ site.baseurl }}/blog/images/2019-12-17-rpi_plan.png"
       alt="Electrical outlets picture"
       width="500" height="925" />
</object>

<!-- more -->

TODO KEYS:

* Special chars
* BKSP
* ENTR
* SPC

Otherwise, the keyboard is pretty good... mind that more keys, digits,
and characters would work better, of course.  What would be more
ideal?

* Separate directional arrow keypad with central "enter" button.
* L and R buttons on sides of console.
* 8 to 12 digits.
* Even better, full characters.

Indeed, if we're thinking about connecting a much more sophisticated
keypad and digit/character display, we would give it a serial protocol
and connect through I2C rather than GPIO.

MORE MODULES:

* NOT motor controller, motor driver
* DC/USB jack power input.
* Regulated power source.
* Route power to level shifters.
* Force-sensing resistor (FSR) for scale.
* Selector logic to multiplex PWM analog outputs.
* SPI slave selector network.
* Infrared transceiver.
* Parallel port

* USB Ethernet.
* USB Wi-Fi.
* USB Google TPU.

* Board-level reset.
* All peripherals reset, from Raspberry Pi.

N.B.: Motor control multiplex network.  The ability to select a motor
to control.  ADVANCED: And to hold it at a certain PWM frequency.
Otherwise, you do PWM frequency select scanning in software.

Save pins, control many motors all at once.  Last thing you can do is
to have the whole multiplexed controller connected to a serial bus
like I2C rather than direct parallel connection.

What about USB bus?  It is faster than SPI, so if you need speed, go
to USB.

Yes, in general, the way to build ultra-sophisticated computer
controlled systems is to use serial buses.  All the way down.  Until
you get to the bottom where you have multiplexers, shift registers,
daisy chaining, and matrix networks.

Connections within a single box electronic system, short distance:

1. If you would normally do a direct parallel connection via GPIO
   pins, but you've got too many pins to attach to the processor's
   directly available GPIO pins, add a microcontroller on the I2C bus.

2. If you need more speed than what I2C offers, move to SPI.

3. If you need more speed than what SPI offers, move to inter-chip
   USB.  TODO LINK.

4. If you need more speed than what USB offers, well then you've
   really got to prepare for a heck of an electrical engineering
   challenge with high frequency circuits.  The PCI family of buses is
   the next faster choice.

Connections between different electronic box systems, mid distance:

1. Serial communications: RS-232, RS-422, RS-485.

2. USB.

3. Ethernet.

Connections between different electronic box systems, long distance:

1. Serial communications: RS-422, RS-485.

2. ???.

3. Ethernet.

Why motor controller?  With only two-byte commands, you can command
and control a full 256 motors.  Wow, and that's all through the magic
of serial communications.  Makes a tough challenge look tiny.

Likewise, you can have multiplexed analog inputs that can share a
small number of, or even just one, ADC.  If you don't need
simultaneous sampling.

Keyboards and switch matrices are easy to connect.  Read state command
method, 1 byte covers 256 switch states.  Send delta event method, 1
byte covers 128 switch states.

Force-sensing resistor matrices require a bit of finesse, use Schottky
diodes and full diode isolation, but it can be done.

Capacitive sensing matrices, well now that is hard.  With diodes
current can only flow in one direction.  When a capacitor is charged
up, current can no longer flow.  But then how do you discharge it?  It
will just hold its charge and only leak slowly if you do nothing else.
