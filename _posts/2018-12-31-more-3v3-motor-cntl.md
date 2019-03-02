---
layout: post
title: More methods to setup a 3.3 V motor control circuit
date: 2018-12-31 23:35 -0600
author: quorten
categories: [raspberry-pi, important]
tags: [raspberry-pi, important]
---

Okay, okay.  Despite all the discussion that I have thus set down on
the issue of motor control integrated circuits at 3.3 V, I am still
determined to search for information.  Can I get 3.3 V motor control
from through-hole packages?

20181231/DuckDuckGo 3.3 volt through hole h-bridge

So, here is another alternative, one that uses a simple MOSFET and
some diodes to source the motor control voltage and gate it by a
microcontroller switch.

20181231/https://electronics.stackexchange.com/questions/235845/3-3v-input-to-5v-output-for-motor-control

This is an interesting example that took an surface-mount integrated
circuit and put it on a printed circuit board to make connections to
it easier.

20181231/https://www.pololu.com/file/0J806/drv8838.pdf

Important!  The documentation on the Pololu motor controller notes
that the IC has overheat shutdown, but the overheat shutoff is quite
high, so the chip can get so hot that it can **burn you** before the
thermal shutoff kicks in.  Also, the documentation on this controller
notes that the controller heats up more when PWM control at high
frequencies is employed.  I'll discuss more on this in my next
article [on surface-mount techniques in general]({{ site.baseurl }}/blog/2019/01/01/discuss-smt-solder).

<!-- more -->

Here is yet another motor control integrated circuit that can run off
of 3.3 V logic levels and send 3.3 V power to a motor.  It might later
prove useful to me, hence me noting it down here.

20181231/https://www.nxp.com/files-static/analog/doc/data_sheet/MPC17531A.pdf

UPDATE 2019-01-01: Now, I happened to find the end-all be-all
explanation to the current state of affairs on Wikipedia.  See my blog
post [on surface-mount techniques in general]({{ site.baseurl }}/blog/2019/01/01/discuss-smt-solder).
