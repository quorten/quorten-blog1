---
layout: post
title: Corrections on Raspberry Pi boot-time GPIO behavior
date: 2020-10-25 20:43 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

My past great article about what I found out happening to the GPIO
pins on RESET?  I was... only partially right.  Some of the
information turned out to be time-sensitive and has changed.

NOTE: [My discussion in the old blog post]({{ site.baseurl }}/blog/2020/03/04/rpi-rtos-reset-watchdog).

So, let's get this straight.  The BCM2835 has a default power-on state
where all GPIOs are configured as inputs.  Although pull-ups are
maintained in their past state even in power-down, on the next
power-on, they are reset to the defaults.  GPIOs 0-8 are configured as
pull-up inputs and GPIOs 9-27 are configured as pull-down inputs.
Then when the Raspberry Pi bootloader comes up, it initializes the
pins to the default values in its Device Tree configuration.  There is
about one second of time between the initial reset and the first GPIO
reconfiguration actions.  Finally, after the Linux kernel finishes
booting and loading the system, your own code will have full control.

In old versions of the Raspbian and bootloader software, the early
boot environment configured the GPIO pins as high-impedance inputs
without any pull up/down.  This was responsible for the observed
behavior of an output flicker on the GPIO ports, it was actually just
a flicker of a pull-down resistor being applied and then removed.
Current Raspbian and bootloader versions now set the bootloader
initial value to the hardware initial value to eliminate this flicker.

<!-- more -->

The old articles:

20201025/https://raspberrypi.stackexchange.com/questions/1032/what-is-the-power-on-state-of-the-gpios  
20201025/https://www.raspberrypi.org/forums/viewtopic.php?t=7443&p=93865

Note of BCM default GPIO configuration, page 102 of the BCM2835
datasheet:

20201025/DuckDuckGo raspberry pi device tree set gpio pin boot state  
20201025/https://raspberrypi.stackexchange.com/questions/51479/gpio-pin-states-on-powerup#51480

Recent references about the default configuration:

20201025/DuckDuckGo raspberry pi gpio pulse during boot  
20201025/https://raspberrypi.stackexchange.com/questions/75019/gpio-status-during-boot  
20201025/https://discourse.osmc.tv/t/gpio-set-to-output-by-default-on-bootup/21892  
20201025/https://www.raspberrypi.org/forums/viewtopic.php?f=107&t=162242  
20201025/https://github.com/raspberrypi/firmware/blob/master/extra/dt-blob.dts
