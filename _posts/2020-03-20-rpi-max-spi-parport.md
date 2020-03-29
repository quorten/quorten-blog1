---
layout: post
title: "Raspberry Pi maximum SPI clock speed, parallel ports, LPC bus
        delays"
date: 2020-03-20 10:21 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Relating to using the `pi-parport` parallel port on the Raspberry Pi
connected via SPI, one question that came up was the timing delays
introduced via SPI serial communication may be unacceptable.  Curious
about this, I searched for information on the LPC (Low Pin Count) bus,
which is a serial bus used to connect the Super I/O chip on early
2000s "Windows XP" era PCs.  This is a 4-bit wide bus with a bus clock
speed of 33.3 MHz, four times faster than the 16-bit parallel ISA at
8.33 MHz.  On late 1990s "Windows 9x" era PCs, the Super I/O chip was
connected via the 16-bit wide parallel ISA bus at 8.33 MHz bus clock
speed, and there were also 24 parallel address lines at the same time.

A parallel port communication may involve sending or receiving an
8-bit data word and maybe an 8-bit/16-bit port number.  So on the ISA
bus, maybe this will take one bus cycle.  But, it may take 4 bus
cycles on the LPC bus.  Nevertheless, the timing delay is comparable
due to the higher bus clock speed.

20200320/https://en.wikipedia.org/wiki/Low_Pin_Count  
20200320/https://en.wikipedia.org/wiki/Super_I/O  
20200320/https://en.wikipedia.org/wiki/Industry_Standard_Architecture

<!-- more -->

Now comes the question, how does the maximum SPI clock speed of
Raspberry Pi compare to the delays introduced by the LPC bus?  The
maximum SPI clock speed on Raspberry Pi looks to be 125 MHz.  Divide
by 8 and you get an 15.625 MHz effective clock speed.  This timing
delay is in fact comparable to the ISA bus... if the full speed can be
reached.  The BCM2835 ARM peripherals specification warns that the I/O
pads cannot operate at such high frequencies.

20200320/DuckDuckGo raspberry pi maximum spi clock  
20200320/https://raspberrypi.stackexchange.com/questions/699/what-spi-frequencies-does-raspberry-pi-support#3444  
20200320/https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

This is some good information on using SPI on Raspberry Pi.  There is
also a nice C library for accessing the SPI peripherals specifically
on the BCM2835.

20200320/https://www.raspberrypi.org/documentation/hardware/raspberrypi/spi/README.md  
20200320/http://www.airspayce.com/mikem/bcm2835/
