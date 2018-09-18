---
layout: post
title: Measuring the CPU/GPU temperature on a Raspberry Pi
author: quorten
date: 2018-09-06 22:30 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So you're wondering, how do you get the CPU temperature on a Raspberry
Pi?  Well, remember that both the CPU and the GPU on the Raspberry Pi
are one-in-the-same, so you go about this by getting the GPU
temperature.  Now, ideally you could use the standard Linux kernel
information files, but when I tried to use them, it failed, so I
instead had to use proprietary VidCore Broadcom means.

20180906/DuckDuckGo raspberry pi acpi cpu temperature  
20180906/https://www.cyberciti.biz/faq/linux-find-out-raspberry-pi-gpu-and-arm-cpu-temperature-command/

Proprietary Broadcom means, requires root access:

    vcgencmd measure_temp

Standard Linux means:

    cat /sys/class/thermal/thermal_zone0/temp

And if you want to make a whole complicated programming project out of
this, look here.  This uses the `gpiozero` library to get the
information, again non-standard for everything else except the
Raspberry Pi.

20180906/https://projects.raspberrypi.org/en/projects/temperature-log
