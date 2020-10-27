---
layout: post
title: "How to configure Raspberry Pi HAT EEPROM to automatically load
        DT overlay"
date: 2020-10-21 22:43 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, so I found out that `pi-parport` does not have the EEPROM
configured to automatically load the device tree overlay.  Let's
figure out how to make this enhancement.

Simple, you modify the EEPROM build commany line to include a file
containing the contents or name of the overlay file as a third command
line parameter.

```
eepmake board.txt board.eep overlay_name.txt
```

In my case, the name is `parport-gpio`, this instructs the system to
load the `/boot/overlays/parport-gpio.dtbo` file.

20201021/DuckDuckGo raspberry pi hat eeprom automatically load dtoverlay  
20201021/https://www.raspberrypi.org/documentation/configuration/device-tree.md  
20201021/DuckDuckGo raspberry pi hat eeprom fields  
20201021/https://github.com/raspberrypi/hats/blob/master/eeprom-format.md  
20201021/https://github.com/raspberrypi/hats/blob/master/devicetree-guide.md

Okay, but I'm still having trouble, what did I do wrong?  I see that
the `i2c-dev` is indeed loaded, so that should not be an issue.  How
can I debug the kernel device tree?  Like this.

<!-- more -->

```
dtc -I fs /sys/firmware/devicetree/base
```

<!-- more -->

20201021/DuckDuckGo raspberry pi hat overlay not automatically loading  
20201021/DuckDuckGo raspberry pi show hat device tree blob  
20201021/DuckDuckGo raspberry pi show device tree  
20201021/DuckDuckGo linux show device tree  
20201021/https://unix.stackexchange.com/questions/289563/how-to-list-the-kernel-device-tree#289630

Now, how do I dynamically load a device tree overlay without
rebooting?  This would be extremely helpful.  Yeah, I saw from one
blogger they said "in 2017, nowadays," device trees overlays can be
loaded dynamically.  But how?  Apparently I guess the way to do it on
Raspberry Pi is via the old shell script system, though other Linux
embedded boards use `configfs` to patch in new overlays after boot.

Wait, no, I've found it.  Read the official documentation carefully.
On Raspberry Pi Linux kernel 4.4+, use the `dtoverlay` command to add
and remove overlays in a stack fashion.

20201025/https://www.raspberrypi.org/documentation/configuration/device-tree.md

Particularly useful is using the `dtoverlay` command to dynamically
install and remove the `i2c-gpio` interface for reprogramming the
EEPROM on a Raspberry Pi HAT.

```
sudo dtoverlay i2c-gpio i2c_gpio_sda=0 i2c_gpio_scl=1 bus=3
sudo dtoverlay -r i2c-gpio
```

Okay, I figured out the reason why my DT Overlay was not being
automatically loaded, by reading between the lines very carefully.  I
saw a commit to the documentation I've found on the subject indicating
the addition of a feature not just to recognize names of the form
`myhat` => `/boot/overlays/myhat.dtbo`, but also `myhat` =>
`/boot/overlays/myhat-overlay.dtbo`.  And, I went investigating, what
if I try embedding the DT Overlay directly?  And that was just it.  I
found out that even older versions of Raspbian _only_ support
embedding the DT Overlay, so keep this in mind when you are designing
Raspberry Pi HATs, especially if you want maximum backwards
compatibility or are intending them to be used specifically for
vintage computing.
