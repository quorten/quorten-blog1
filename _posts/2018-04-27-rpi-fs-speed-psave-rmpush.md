---
layout: post
title: "Raspberry Pi file server speeds, power saving, remote push button"
date: 2018-04-27 21:00 -0600
author: quorten
categories: [raspberry-pi, important, reiterate]
tags: [raspberry-pi, important, reiterate]
---

Important!

What kinds of speeds can you expect out of a Raspberry Pi file server?

20 MB/s expectation from Raspberry Pi.  So, actually you can get a 100
Mbps speed out of a Raspberry Pi.  Raspberry Pi Zero?  Maybe, at least
it will come close.

20180427/DuckDuckGo raspberry pi zero sd card read speed file server  
20180427/https://raspberrypi.stackexchange.com/questions/15123/network-storage-on-sd-card

Words of unreliable SD cards?  How reliable are they with Raspberry
Pi?

20180427/DuckDuckGo raspberry pi how reliable sd card

Answer: Do make sure to have adequate backup, but don't worry
about the lifespan being too short.

20180427/https://raspberrypi.stackexchange.com/questions/38321/raspberry-pi-lifespan-reliability  
20180427/https://www.geek.com/chips/a-geek-tests-12-micro-sd-cards-with-a-raspberry-pi-to-find-the-fastest-1641182/

<!-- more -->

Important!  Again, I reiterate, because this is important!

Save power on the Raspberry Pi Zero.  Disable HDMI shaves off 25 mA.

20180427/https://www.jeffgeerling.com/blogs/jeff-geerling/raspberry-pi-zero-power  
20180427/https://www.jeffgeerling.com/blogs/jeff-geerling/raspberry-pi-zero-conserve-energy  
20180427/https://en.wikipedia.org/wiki/Standby_power

> Older devices with power adapters that are large and are warm to the
> touch use several watts of power. Newer power adapters that are
> lightweight and are not warm to the touch may use less than one
> watt.

Important!  Try to pursue setting up a Raspberry Pi that can be used
as an infrared remote control.

20180427/https://en.wikipedia.org/wiki/Remote_control

Remotely push a button with a Raspberry Pi?

> Find yourself an old school chime door bell. The sort that goes
> "ding dong" by shooting a battery powered solenoid against a couple
> of metal bars. Replace the door bell switch with suitable control
> circuitry and let the solenoid push the button.
> simples

Nice idea but... yes unfortunately this does depend on the force
needed to push the button, and the doorbell ringer probably won't
strike with enough force.

20180427/DuckDuckGo raspberry pi use a relay to push a button  
20180427/https://www.raspberrypi.org/forums/viewtopic.php?p=1054266  
20180427/https://www.youtube.com/watch?v=_cJmhcbBWWY

Using a servo motor, button pushing can be made strong enough,
apparently.  The motor is held in place.  There is a plastic "hammer
arm" connected to the motor.
