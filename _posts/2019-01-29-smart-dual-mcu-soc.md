---
layout: post
title: Smart thermostat dual MCU and SoC design
date: 2019-01-29 23:25 -0600
author: quorten
categories: [home-network, raspberry-pi]
tags: [home-network, raspberry-pi]
---

One of the problems with modern-style smart home devices is that
although they bring in the benefits of the larger, more complicated
software world into traditional applications, historically, often
times their design was also such that they bring in all the bugs known
to corrupt the large and complicated software world.  But, this doesn't
need to be the case.  What would a design look like that incorporates
"the best of both worlds," the best of traditional firmware
engineering for microcontrollers and the best of large and complicated
software-driven SoCs that can connect to the Internet?

    T = Temperature sensor
    F = "Firmware" traditional MCU
    S = SoC
    C = "Controller" tournament MCU

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2019-01-29-smart_thermo_1.svg"
        width="250" height="260">
  <img src="{{ site.baseurl }}/blog/images/2019-01-29-smart_thermo_1.png"
       alt="Smart thermostat diagram 1"
       width="250" height="260" />
</object>

<!-- more -->

Such a design is not conceptually difficult to create.  We'll analyze
the design of a smart thermostat.  At the outset, all you need is to
design the system so that there is a microcontroller (MCU) with
engineered firmware that sets hard sanity limits that cannot be
exceeded by the smart controller (SoC).  Both the MCU and the SoC get
input data from the temperature sensor, and although both have output
control capabilities, the MCU has the final say in the control
decisions.  Also, the SoC can read a status from the MCU to verify the
MCU is operational.  The SoC is merely an adviser, albeit a data and
communication rich one for that matter.  When operating within the
hard MCU limits, the smart controller can make additional smart
decisions to improve energy economy.

Additionally, the MCU and the SoC can have some degree of independent
operation that improves the overall reliability of the system.  If the
SoC looses smart temperature control abilities, it can send alerts via
its Internet connection while the MCU maintains sanity of the control
system.  If the SoC crashes, the MCU can continue to maintain single
set-point closed loop temperature control.  Likewise, if the MCU
crashes, the SoC can detect this condition and send an alert.  If
everything goes down, well a remote monitoring server can detect it is
getting no signal and report the fault.

One particular of this first design that may be of concern is that the
SoC has both read and write access to the MCU.  The SoC, being a
complex software machine, also has a higher propensity to being
commandeered by malware, and one that happens, with both read and
write access to the MCU, carrying out a successful exploit of that
part of the system is much easier.  You could argue that because the
firmware is going to be rigorously engineered and tested, this will
not be possible.  But, if you really are concerned that perhaps that
firmware is too complicated to sufficiently rigorously test, you could
modify the design somewhat to mitigate this risk.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2019-01-29-smart_thermo_2.svg"
        width="250" height="260">
  <img src="{{ site.baseurl }}/blog/images/2019-01-29-smart_thermo_2.png"
       alt="Smart thermostat diagram 1"
       width="250" height="260" />
</object>

An additional MCU is added whose sole purpose is as a "tournament
processor."  The independent decisions of the MCU and the SoC are
routed into this processor, and a very simple program is run that
implements the hard limit and adviser rules as previously described.
The full temperature control logic of the MCU that might be more prone
to bugs is run on a separate MCU where the SoC does not have
read-write access to it...  except through possible side channel
attacks through the temperature sensor.  In this case, due to the
addition of another discrete component, we want the SoC to be able
read a status from the tournament processor so we can send out an
alert if the tournament processor crashes.  Yes, that does mean that
there is a read-write path between the SoC and the tournament
processor, but... as we've said, the tournament processor is, by
design, more resilient against attacks than the temperature decision
MCU.

Finally, another minor improvement you could make to the design is to
instrument it with watchdog timers to reduce the incidence of freezing
of the controllers.  Literally, for the case where the controllers are
warming the building to keep it above freezing.

20190123/https://en.wikipedia.org/wiki/Fail-safe  
20190123/https://en.wikipedia.org/wiki/Watchdog_timer
