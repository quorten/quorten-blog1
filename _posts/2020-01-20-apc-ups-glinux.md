---
layout: post
title: Using an APC UPS with GNU/Linux
date: 2020-01-20 11:20 -0600
author: quorten
categories: [battery-backup, home-network, raspberry-pi]
tags: [battery-backup, home-network, raspberry-pi]
---

Okay, cool, so I got an APC UPS to provide battery backup to my home
network equipment.  It has an RJ45 port, so it's Ethernet and we're
good, right?  Not so fast.  That is nothing more than an RJ45 port
that provides a collection of custom pinout circuits.  You can connect
either a USB or a serial cable to that port, and the USB cable is
included in the box.  So, no plugging this UPS box directly into your
network for remote status information, it's got to go through another
computer first.

Okay, well how do I get it set up with GNU/Linux?  The good news is
that this is actually rather quite easy.  Just install and configure
`apcupsd` to connect with USB devices, and you're all set to get
status information by issuing `apcaccess status`.

Please note that unfortunately, some of the newer UPS's went through a
stint with a proprietary Microlink protocol.  For a short time, that
was the only protocol that was supported, but a firmware upgrade was
released to have fallback compatibility with the existing open
protocols.  Purportedly an open specification on the protocol would be
published, but that looks to have never happened.

On the other hand, the good news is that the newer UPS's support
Modbus over USB, which gives more detailed information than the basic
USB protocol.  For a while, `apcupsd` only supported over Modbus over
serial, but I'll have to check back for more details on the latest
versions.

<!-- more -->

In my particular case, I'm using a Raspberry Pi as a home server
nearby, so the USB wiring is no issue at all, the software works on
Raspberry Pi, and is available in the Raspbian repositories.  This
makes it real easy to get the status of the UPS over the network.
Hooray!

20200120/DuckDuckGo linux apc ups serial protocol  
20200120/https://forums.apc.com/spaces/7/ups-management-devices-powerchute-software/forums/general/9870/managing-smart-ups-x-1500-with-linux  
20200120/DuckDuckGo apc Microlink protocol in Apcupsd  
20200120/https://forums.apc.com/spaces/5/smart-ups-symmetra-lx-rm/forums/general/5993/microlink-protocol-in-apcupsd

Getting `apcupsd` up and running on Debian-based systems is pretty
simple.

```
sudo apt-get install apcupsd apcupsd-doc apcupsd-cgi
sed -i -e '/^UPSCABLE/c\UPSCABLE usb' \
    -e '/^UPSTYPE/c\UPSTYPE usb' \
    -e 's/^DEVICE/# DEVICE/g' \
    /etc/apcupsd/apcupsd.conf
sed -i -e 's/ISCONFIGURED=no/ISCONFIGURED=yes/g' \
    /etc/default/apcupsd
```

20200120/http://www.apcupsd.org/  
20200120/http://www.apcupsd.org/manual/manual.html#quick-start-for-beginners  
20200120/http://www.apcupsd.org/manual/manual.html#choosing-a-configuration-type  
20200120/http://www.apcupsd.org/manual/manual.html#monitoring-and-tuning-your-ups  
20200120/http://www.apcupsd.org/manual/manual.html#testing-apcupsd
