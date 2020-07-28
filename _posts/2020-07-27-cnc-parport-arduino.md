---
layout: post
title: Arduino parallel port interface for CNC machines
date: 2020-07-27 22:26 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Got a CNC machine that uses a parallel port interface?  What's the
best way to control it?  In the field of CNC machines, GRBL is the
means of transmitting G-code via a serial communications connection.
So, basically, what you can do is run a serial communications
connection to an Arduino, then break out a parallel port from there to
connector your CNC machine.

20200727/https://hackaday.com/2014/09/16/usb-to-db25-adapter-uses-grbl-for-parallel-port-cnc-communication/
