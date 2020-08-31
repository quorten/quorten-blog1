---
layout: post
title: "Interesting Digi-Key articles, Peltier module cooling,
        one-pair industrial Ethernet, rotary encoders, port expanders"
date: 2020-08-24 10:58 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Cooling with electricity?  Yes, it's possible, Peltier module is the
name of the game.  Thermoelectric cooler in other words.  The big
gotcha: the function is based off of a long electrical series circuit,
and mechanical stress can cause this to break.  So, be careful in how
you mount your Peltier module.

20200824/https://www.digikey.com/en/articles/important-factors-for-improved-peltier-module-reliability

Get the inner scoop of the theory behind Peltier modules here, I still
feel like the whole idea is running circles around my head.  Oh, I
see, so this is really interesting.  Basically, the invention stems
from an observation of what happens if you pass an electric current
through the circuit of a thermocouple, normally a thermocouple
generates electricity from heat, but if you pass an electric current
through it, you force the heat flow a specific direction in the
thermocouple.

20200824/https://en.wikipedia.org/wiki/Thermoelectric_cooling  
20200824/https://en.wikipedia.org/wiki/Thermoelectric_effect#Peltier_effect

<!-- more -->

So, now the thing that I realize with thermoelectric cooling.  All
these years, I didn't realize the true identity behind this, we've had
this small refrigerator unit where it was once plugged in backwards so
it turned into a heater rather than a cooler.  Really bad.  But, why
did it happen?  Of course, it was a thermoelectric cooler, with a heat
sink and a fan on the outside to assist in the cooling effect.  Now,
here's the interesting part, though.  Large thermoelectric cooler
modules are rather expensive, so how does this factor into the full
cost of building such a cooler?  Pretty much the bulk of the cost is
in the thermoelectric cooling element itself, and the rest is
comparatively cheap on top of that.

One-pair ethernet?  Yes, it's really possible!  There exists
specialized industrial equipment for encoding Ethernet over only a
single wire pair.  The tech is making its inroads into cars, so why
not offices and homes too?  Well, that's what I'm wondering.  Another
note, Common Industrial Protocol (CIP) CIP and PROFINET are some
specialized protocols developed for industrial automation that sit
atop TCP/IP networking.

20200824/https://en.wikipedia.org/wiki/BroadR-Reach  
20200824/https://en.wikipedia.org/wiki/OPEN_Alliance_SIG  
20200824/https://www.digikey.com/en/articles/ethernet-ip-versus-profinet  
20200824/https://en.wikipedia.org/wiki/Common_Industrial_Protocol

Rotary encoders, interesting, there are three types.  Beyond the basic
optical rotary encoders, there are also magnetic and capacitive
encoders, with their own strengths over optical encoders.  Their
primary weakness?  I'd reckon its up-front cost, though the article
notes that the total cost of ownership is probably lower with the
other options.

20200824/https://www.digikey.com/en/articles/weighing-the-advantages-and-tradeoffs-of-encoder-technologies

Interesting Digi-Key article about using port expanders when it feels
like you need another logical child node.  So, their approach
specifically?  I2C and SPI are the wiring methods, depending of the
frequency chosen, 3 to 9 feet can be achieved.  Yes, that's because
they effectively recommend parallel buses rather than serial buses.

20200824/https://www.digikey.com/en/articles/easily-efficiently-add-child-nodes-to-iiot-endpoints-using-port-expanders
