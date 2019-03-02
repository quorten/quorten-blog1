---
layout: post
title: Why PWM motor speed control works
date: 2018-12-30 18:13 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

I've been wondering perhaps a bit too much about PWM motor speed
control of brushed DC motors.  Does it really work?  Why should it
work?  Won't it not work as well as motor voltage control?  After lots
of reading and thinking through this carefully, I think I can explain
this in a way that is sure to sway skeptics like myself.

Earlier, I've already read that the Raspberry Pi uses some sort of PWM
control to generate its built-in analog audio output.  Yeah, that
makes sense, as the original Macintosh did that too.  Just earlier
today, I've read in detail exactly how it works, and I've explained
why it is better than the original Macintosh's way of doing so.  But,
here is the most interesting specific part pertinent to our discussion
on motors.  A PDM audio signal can be trivially converted to an analog
signal via an RC (resistor-capacitor) low-pass filter circuit.
Indeed, simply by storing up the pulse charges in a capacitor, you can
blur out the waveform by averaging its values over a larger area to
get a nice analog signal.

<!-- more -->

Okay, so that's the key that you need to know related to motors too.
Yes, we do know that motors, being moving mechanical devices, have
inertia and momentum such that once a motor is set in motion, it will
keep moving.  So, if you have some jittery pulsed signal to slowly get
a motor started moving, it will keep moving at a certain pace that is
slower than maximum speed when you keep feeding it the same jittery
signal.  But why should we think that this jittery signal will
spurious vibrations in the motor that you otherwise wouldn't
experience were you to feed it a continuous, lower voltage signal?
Well, as we've said before, a low-pass filter circuit can be
constructed using resistors and capacitors, the capacitor's function
being to store up charge so as to smooth it out.  A brushed DC motor
is also an inductor, and as it turns out, that means that it also has
the capability to _store up energy_ on its own, albeit in a different
form.  Namely, it forms a residual electromagnetic field that causes
current to keep flowing even when you switch off power to the motor.
Likewise, a motor is also a form of resistor due to its high current
draw and energy dissipation.  There you go, you've got the basic
components of an RC low-pass filter right inside your motor.

With that in place, your only other concern for constructing an RC
low-pass filter circuit to convert a PWM signal to an analog signal is
that the PWM frequency is well matched with the roll-off frequency of
your low-pass filter.  Suffice it to say, a motor has a relatively low
roll-off frequency, so if you have a PWM that is good enough to
generate an analog audio signal, it is more than good enough to get
smooth motor motion.

Now, we know that motors must be connected to microcontrollers via
H-bridge motor controller integrated circuits, and this is where
things get interesting.  An L293D H-bridge motor controller has
built-in diode protection to allow the back-emf, the current that
wants to keep traveling that is caused due to the stored
electromagnetic field, to travel through an alternate safe path rather
than blowing out the microcontroller that tried to switch off the
motor.  When you simply disconnect the power and allow the back-emf to
flow freely, this is called _coasting_ since the motor is allowed to
continue rotating relatively freely on its own.  But, an H-bridge
motor controller circuit can also be configured to provide a sense of
drain or resistance to the back-emf, wnich is called _braking_ as it
causes the motor to slow down faster.  So, the point here is that if
you use PWM to switch back and forth between coasting and powering
relatively quickly, you should get some pretty nice smooth motor
motions without spurious vibrations introduced.  But, if you switch
back and forth between powering and braking relatively quickly, that
is going to cause much more of a vibration problem.  Additionally,
another useful control scheme is to use PWM to switch back and forth
between coasting and _braking_, in effect giving you variable control
over the braking power.  Of course, with electric motors, you can also
power in the opposite direction as an even stronger form of braking.

Notably, the choice of diode also affects the degree of coasting that
the motor experiences.  A diode that allows a more generous flow of
back-emf will allow for the greatest coasting with least resistance,
but you can also select a diode that does not allow as much back-emf
through.  As stated in the Wikipedia article on the Flyback diode,
this results in a speedier slowdown, but it also causes more stress on
your microcontroller's switch.
