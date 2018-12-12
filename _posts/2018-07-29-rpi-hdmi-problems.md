---
layout: post
title: Diagnosing Raspberry Pi HDMI signal communication problems
author: quorten
date: 2018-07-29 21:30 -0500
categories: [raspberry-pi, important]
tags: [raspberry-pi, important]
---

Important!

Having trouble with HDMI displaying from your Raspberry Pi on your old
HDMI TV?

* The Pi outputs a relatively weak HDMI signal. Some devices may not
  immediately notice the Pi's HDMI or may not do the negotiation.

* Set `hdmi_force_hotplug=1` makes sure the Pi believes the monitor/TV
  is really there.

* `config_hdmi_boost=4` or higher, up to 9, if your display needs a
  stronger signal.  Alternatively, use a shorter HDMI cable if
  possible.

* If the display is a computer monitor, use `hdmi_group=1` and if it
  is an older TV, try `hdmi_group=2`.

* Do not set `hdmi_safe=1` as that overrides many of the previous
  options.

* Make sure your Pi's power supply delivers 1A and not 500mA.

* If you see a problem with the red colour - either absent, or
  interference - then try a boost. However it might simply be that the
  display requires a stronger signal than the Pi can give.

* See the embedded Linux Raspberry Pi troubleshooting guide.

* Try setting `hdmi_drive=2` if you are still having trouble
  connecting to your TV.

20180729/DuckDuckGo raspberry pi hdmi not recognized old tv  
20180729/https://www.raspberrypi.org/forums/viewtopic.php?t=34061  
20180729/https://elinux.org/R-Pi_Troubleshooting#No_HDMI_output_at_all  
20180729/http://blog.mivia.dk/solved-hdmi-working-raspberry-pi/
