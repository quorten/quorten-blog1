---
layout: post
title: Raspberry Pi boot caveats
date: 2015-12-26 21:00 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

DuckDuckGo raspberry pi boot from usb stick

20151226/http://jonathanmh.com/boot-raspberry-pi-from-a-usb-stick/  
20151226/http://raspberrypi.stackexchange.com/questions/1187/boot-from-external-usb-stick-drive  
20151226/https://www.raspberrypi.org/forums/viewtopic.php?f=66&t=12015

ARG!!!!  Can you boot a Raspberry Pi a USB floppy disk drive?  How
about a USB memory stick?  How about a USB optical disk drive?  How
about a USB serial port?  How about a USB Ethernet interface?  No, no,
no, no, and no.

Why can't a Raspberry Pi boot from anything useful?  Why does today's
technology have to be so brittle in its compatibility matrix?

Here's why: The Raspberry Pi's booting process is revolves around
completely incompatible, non-standard, proprietary software.  In fact,
the Raspberry Pi is labeled as a single-board computer that has a
fatal flaw by the Free Software Foundation.  According to Debian, the
Raspberry Pi boots off of its GPU, and its GPU needs to load its
firmware from the SD card.  Without the firmware, the proprietary
binary blob, the Raspberry Pi cannot boot.

20160104/https://www.fsf.org/resources/hw/single-board-computers  
20160104/https://wiki.debian.org/RaspberryPi  
20160104/https://en.wikipedia.org/wiki/Raspberry_Pi#Driver_APIs

<!-- more -->

I guess when people don't care about compatibility and efficiency,
that's when you get the problem of a million incompatible interfaces
and lack of sufficient bridge interfaces.

Yeah, you know, the IEEE Spectrum article on the laptop with no
secrets?  Yes, this is the problem that we're talking about, Linux
being used as part of a board support package.

Gosh, so many different HDMI connectors.  I'm going to have to buy
physical adapters for this.

20151226/https://en.wikipedia.org/wiki/HDMI  
20151226/https://en.wikipedia.org/wiki/File:HDMI_Connector.jpg
