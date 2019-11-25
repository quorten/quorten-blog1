---
layout: post
title: "Pull-up versus pull-down, voltage level shifters, GPIO port
        expander, 1-wire"
date: 2017-03-04 21:00 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, how do you use the GPIO on the Raspberry Pi again?  I'm
wondering about the whole thing, what is "pull up" and "pull down"?
Why is it conspicuously missing from the Raspberry Pi Quick Reaction
Game tutorial?  What is this "gpiozero" library?  Okay, for the
answers.  So I searched for GPIO Zero, and I found the Raspberry Pi
blog post on it.  Basically, its name GPIO Zero is inspired by PyGame
Zero, the "zero" being added to the name so that the library can be
used with a minimum of boilerplate code.  And if you read the blog
post on it, in fact the creation routines like "Button" is
deliberately designed to mask the user from needing to configure
whether a GPIO input is "pull up" or "pull down," instead assuming the
common "pull up" by default.  As the blog post says, although this is
important to know about electronics, it is not necessary if all you
want to do is create some simple interactive setup for a classroom
activity.  So there you go, that's why mention of "pull up" and "pull
down" is conspicuously missing from the Raspberry Pi GPIO quick
reaction game.  It probably got rewritten after the advent of GPIO
Zero, but before that, there may have been an older version that
introduced the pull up and pull down concepts.

<!-- more -->

* Let me state the answer to the question more clearly here, though.
  "Pull up" means that a transition from 3.3V to 0V is a transition
  into the "on" state, "pull down" means that a transition from 0V to
  3.3V is a transition into the "on" state.

    * UPDATE 2018-11-25: With pull-up, you're connecting the
      button/switch to a constant ground rather than a constant
      voltage source, hence it is generally safer and less susceptible
      to RF interference.

      Pull-up means that your GPIO input pin is like a connection to a
      pull-up resistor (resistor to positive voltage source),
      pull-down means your GPIO input pin is like a pull-down resistor
      (resistor to ground).  So, for current to flow, the connection
      on the opposite side of a pull-up input should be ground, and
      for a pull-down input, it should be the positive voltage source
      3.3V.

      With this explanation, the phrase "pull-up termination" makes
      perfect sense.  You connect a pull-up resistor to the circuit
      that provides a positive voltage source on the GPIO pin, hence
      it is "pull-up."  Also, for the `gpiozero` library, pull-up is
      the default configuration for inputs, which is why the quick
      reaction game didn't need to configure it.

      In the case of output pins, however, "pull-up" and "pull-down"
      are literally true to their meaning like connection to pull-up
      and pull-down resistors.  A pull-up output will supply the
      positive voltage source when enabled, and a pull-down output
      will supply a path to ground when enabled.

      UPDATE 2019-11-24: Also, to be really technical about the case
      of input pins, "pull-up" and "pull-down" are also literally true
      to their meaning, but it takes a bit more effort to explain.
      CMOS logic gates must never be floating: the gate must either be
      connected to the positive voltage source or ground.  To ensure
      this is the case with GPIO input buttons that are "floating"
      when open and conducting when closed, a pull-up or pull-down
      resistor is also wired up on the gate side of the CMOS logic
      gate used for the GPIO input.  When the GPIO input button is
      floating, the value of the CMOS logic gate will be asserted to
      the value of the pull-up/pull-down resistor, but when the GPIO
      input button is conducting, the pull-up/pull-down resistor value
      will short to the opposite side of the GPIO input button, and
      the CMOS logic gate will be asserted to the voltage value on the
      opposite side of the GPIO input button.

      Matter of fact, if you wire up an LED to a pull-up GPIO input,
      you will see the LED will dimly light, showing that there is
      still current flowing even after the CMOS logic gate has been
      switched.  Also note that because CMOS logic gates only consume
      current when switching, we can take advantage of this fact to
      use a high value pull-up/down resistor and still get the proper
      voltage across the CMOS logic gate: because so little current
      flows after a CMOS logic gate has switched, the CMOS logic gate
      behaves as a very high impedance load, which means most of the
      voltage drop is across the CMOS logic gate rather than the
      pull-up/down resistor, so the voltage value at the gate is very
      nearly the source supply value.  The high-value pull-up/down
      resistor likewise limits the amount of current drawn when the
      GPIO input button is conducting.

      Keep this in mind when working with Raspberry Pi GPIO inputs at
      the lowest level.  When you configure a GPIO input as pull-up,
      you will get the value "1" when the button is floating and the
      value "0" when the button is conducting, which is the opposite
      of what you'd normally expect from a software standpoint.

      Also, note that microcontrollers other than the Raspberry Pi may
      not have built-in pull-up/pull-down resistors.  In that case,
      you must wire up your own pull-up/pull-down resistors when
      connecting GPIO inputs.  A 4.7 K resistor seems to be
      recommended as a good value to use.

      20191124/DuckDuckGo raspberry pi gpio input pull resistance  
      20191124/http://www.raspberryvi.org/stories/pull-up-and-pull-down-resistors.html

20170304/https://www.raspberrypi.org/documentation/usage/gpio/  
20170304/https://www.raspberrypi.org/learning/python-quick-reaction-game/  
20170304/https://www.raspberrypi.org/blog/gpio-zero-a-friendly-python-api-for-physical-computing/  
20170304/DuckDuckGo raspberry pi gpio pull up pull down  
20170304/https://www.raspberrypi.org/forums/viewtopic.php?t=42544&p=343203  
20170304/https://www.raspberrypi.org/blog/using-the-gpio/  
20170304/https://www.raspberrypi.org/blog/make-your-own-ribbon-cable-with-gert/

Now, I'm also interesting.  Is it possible to build an (E)EPROM
programmer with an Arduino or a Raspberry Pi?  I'm thinking there may
be more information on how to do it with an Arduino, so I better
include both in my search query for safe measure.  Alas, I was wrong.
In fact, the information on how to do so with a Raspberry Pi proves to
be more readily available on the Internet.

20170304/DuckDuckGo build a eprom programmer raspberry pi arduino  
20170304/http://www.instructables.com/id/Raspberry-Pi-Python-EEPROM-Programmer/

* One particularly key and important note that I must make on the
  Instructable is that the exact wiring depends on the technical
  specifications sheet.  So, you must be sure to find this for your
  electronics in question should you attempt to use this technique.

    * Nevertheless, I consider it highly instrumental that I can just
      wire up and program a Raspberry Pi should I want to read and
      write ROM/EEPROM cartridges.  Also this accounts easily and
      gracefully for different sized cartridges, unlike a
      purpose-built ROM programmer.

Okay, one thing that the Instructable skimps on is the limited GPIO
pin count.  What if you want to control more GPIO pins than your
Raspberry Pi has?  Then, I am told that the solution is to use a _Port
expander_.

20170304/DuckDuckGo control more pins than raspberry pi gpio  
20170304/http://raspberrypi.stackexchange.com/questions/3452/getting-more-than-26-gpio-pins  
20170304/https://en.wikipedia.org/wiki/Port_expander

* "They go by several names, such as "switch", "hub" or "splitter",
  but they all do the same thing."  No they don't!  The electrical
  implementation of a GPIO port expander is drastically different than
  that of a Ethernet network switch.

20170304/https://en.wikipedia.org/wiki/EEPROM  
20170304/https://en.wikipedia.org/wiki/EPROM

Indeed, it is very easy to build an EEPROM programmer with a Raspberry
Pi.  Literally, it's just a direct wire-up between the Raspberry Pi
and the EEPROM chip!  CMOS 3.3 V the whole way through.  But wait,
there must be a caveat for programming an EPROM.  Indeed, there is.
EPROMs require higher-than-normal voltage levels for programming.  Of
course, very similar to traditional PROMs.  So I would need some sort
of additional amplifier chip if I wanted to program an EPROM.
However, I suspect one of those must be fairly cheap, right?  What
would one of those be anyways?  They are in fact called "level
shifters."  And we're in luck because Wikipedia has sufficient
information on these.

20170305/DuckDuckGo raspberry pi amplify gpio pin output  
20170305/http://electronics.stackexchange.com/questions/162685/how-to-increase-the-voltage-of-a-digital-signal  
20170305/https://en.wikipedia.org/wiki/Logic_level#Logic_voltage_levels

I imagine that ROM programmers must be fairly cheap nowadays.  By the
way, does Wikipedia have an article on that?  Indeed it does, but it
is short, poorly written, and has a few spelling, grammatical, and
punctuation errors throughout.  Well, there you go.  I trekked the
ground not tredded very often on Wikipedia.  As we know, Wikipedia is
biased.

20170304/https://en.wikipedia.org/wiki/Programmer_%28hardware%29

Off-topic:

20170305/https://en.wikipedia.org/wiki/Prom  
20170305/https://en.wikipedia.org/wiki/Charge_pump  
20170305/https://en.wikipedia.org/wiki/1-Wire

Interestingly, you can use a UART to implement a Dallas 1-Wire bus
master.

20170305/https://www.maximintegrated.com/en/app-notes/index.mvp/id/214

Single-wire earth return is the way to create a true "one-wire"
connection.  Principally, Dallas 1-Wire devices require at least two
wires, one for power and data, the other for ground.

20170305/https://en.wikipedia.org/wiki/Single_wire_earth_return
