---
layout: post
title: "Make your own cheap capacitive pressure sensor, and list of
        simple sensor technologies"
date: 2019-12-03 20:25 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Weight sensors, yes, the infinite subject that I keep trying to search
for more information on.  But now, I take a break to try to think
through things myself and explain how this can all work.

The easiest way to build a weight sensor is to modify a spring-based
scale.  A spring-based scale uses the displacement caused from
compression of a spring, due to an applied force, to generate a
rotational displacement on the display dial.  The spring is
constructed to be as close to linear as possible, then the display
dial simply has a printing of linear numeric values that correspond
with the applied force.  The electronic version simply applies a
variable resistor in place of the display dial, which then generates a
resistance that linearly varies with the applied force.  The primary
disadvantage of this weighing system is that the spring requires a lot
of space, adding excess thickness to your weight sensor and making it
less attractive to use.

A thinner, but potentially less accurate, method to build a weight
sensor is via _capacitive_ means.  Two large, thin metal plates
sandwich a thin piece of insulator that is designed to compress under
load.  Effectively, this behaves as a capacitor.  When a force is
applied, it results in compression of the sandwiched insulator: the
thickness of the insulator decreases, which causes the capacitance to
increase.  In this case, the primary issue in accuracy is getting a
thin insulator material that has a linear compression response.

<!-- more -->

Wow, you can do a lot with simple resistors and capacitors, come to
think of it.  What are all the physical quantities you can measure
with them?

* Temperature
* Humidity
* Pressure, force, weight
* Light intensity
* Analog joystick location

Note that I've included slightly more specialized such devices in my
list too, i.e. photoresistor.

Now I go searching on the Internet, and wow, this is a really
interesting article, a larger project has been built around making
cheap capacitors using paper and aluminum foil.  Yeah, it really is
that simple if you use letter-sized paper and aluminum foil.

20191204/DuckDuckGo capacitive weight sensor  
20191204/https://blog.yavilevich.com/2017/10/40-cent-diy-pressure-sensor-based-on-a-capacitive-principle/

Also interesting is mention of many other weight sensor technologies,
force-sensitive resistors.  Well, I guess these can be simple to make
and intuitive to construct too.  Somehow the decrease in distance in a
resistor from an applied force results in a decrease in resistance, I
guess that could be one way.

Indeed, the capacitance of a parallel plate capacitor is inversely
proportional to the distance between the plates.  So, if you have an
insulator that compresses linearly by the applied force, i.e. twice as
much force doubles the decrease in thickness, the capacitance is
proportional to the applied force.  This is essentially to say that
you want an insulator that behaves as a Hooke's Law spring, so we
circle almost right back to where we were with the old fashioned
spring-based scale.

Another consideration when building your own parallel plate capacitor
is to choose an insulator that has a good _permittivity_, the ability
to "polarize" in charge when an electric field is applied.

20191204/DuckDuckGo capacitor distance between plates and capacitance  
20191204/https://electronics.stackexchange.com/questions/16457/why-does-the-distance-between-the-plates-of-a-capacitor-affect-its-capacitance  
20191204/https://en.wikipedia.org/wiki/Capacitor  
20191204/https://en.wikipedia.org/wiki/Permittivity  
20191204/https://en.wikipedia.org/wiki/Hooke%27s_law

Now, another idea that I have.  Often times when building cheap
aluminum foil and paper tactile switches, you may have trouble where
you build device that doesn't quite activate conductivity when you
want it to, yet the foil plates are very close.  Wouldn't it be nice
if you could have a hybrid between a conductivity and capacitive
sensor?  This seems easy enough if you only have on switch.  Simply
have both a tactile switch circuit and resistor-capacitor PWM circuit
wired up to the same device.  Alas, matrix keyboards are more of a
challenge.  Here, you cannot use regular diode isolation since diodes
have voltage regulation effect.  But maybe you could substitute
Schottky diodes instead of thte regular cheap silicon diodes and be
able to multiplex a capacitive sensing circuit.  No, that doesn't seem
to work, seems more like you'd need a transistor at every matrix
point.

Another good realization, you can use a pressure sensor to measure
fluid flow in a pipe.

20191204/DuckDuckGo capacitor pressure sensor  
20191204/https://instrumentationtools.com/capacitive-pressure-sensor/

Piezoelectric sensors can also be used to measure pressure.

20191204/https://www.avnet.com/wps/portal/abacus/solutions/technologies/sensors/pressure-sensors/core-technologies/capacitive-vs-piezoresistive-vs-piezoelectric/

> Something went wrong...
> www.avnet.com
>
> We truly apologize that this error has occurred. We take these
> matters very seriously and ask for your help in notifying us of the
> problem. Please email us at DIGITAL-SECURITY@avnet.com, using
> Reference Number:
>
> 18.eaafedcc.1575446291.3dd676c0
>
> Thank you in advance for your assistance in resolving this issue.
>
> Avnet Customer Care
