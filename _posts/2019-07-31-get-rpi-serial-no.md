---
layout: post
title: Get Raspberry Pi serial number
date: 2019-07-31 22:15 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

How do you get the serial number of a Raspberry Pi?  Note that the
serial number is **not** printed on the circuit board.  You
must get the serial number in software.

```
cat /proc/cpuinfo
```

That's all there is to it, and the value in "Serial" is it.  The MAC
address, matter of fact, is generated from the serial number by
default.

20190731/DuckDuckGo raspberry pi get serial number  
20190731/https://raspberrypi.stackexchange.com/questions/2086/how-do-i-get-the-serial-number
