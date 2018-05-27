---
layout: post
title: Reuse old laptop display for Raspberry Pi
author: quorten
date: 2018-05-25 11:54 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Raspberry Pi notes.

Come on!  Do I really have to buy an expensive video display if I want
to have a Raspberry Pi like a standalone computer?  Not so.  I've got
a handful of old laptops around that already have those expensive LCD
panels inside of them.  All I've got to do is connect them to the
Raspberry Pi.

So, what is required for this?  Basically, you have to buy an LCD
controller board to connect to that LVDS interface already on the
panel.  These run for around $25, but they can be more expensive if
you build your own from an FPGA.  Make sure you get the right
controller board for the monitor you have.  Purportedly, those with
VGA output are cheapest, so you'll have to use that standard HDMI to
VGA converter with your Raspberry Pi.  Other than that, you should be
able to reuse all the other parts.  Unfortunately you're going to have
to reverse engineer many other details such as the pinout, the
specifics of the LVDS data format, etc.

20180525/DuckDuckGo use laptop lvds display with raspberry pi  
20180525/https://raspberrypi.stackexchange.com/questions/848/connect-pi-to-an-old-laptop-screen  
20180525/https://www.ebay.in/itm/271008855606?ViewItem=&item=271008855606  
20180525/https://elinux.org/RPi_Screens#DSI_port  
20180525/https://www.raspberrypi.org/forums/viewtopic.php?f=7&t=2061#p39441  
20180525/https://g3nius.org/lcd-controller/  
20180525/https://www.cnx-software.com/2016/02/05/re-using-your-old-laptop-screen-with-raspberry-pi-or-your-computer/

Ah, interesting.  Motorola LapDock.  Unfortunately that is rather
expensive, although it has been used by many to reuse a laptop
keyboard and display for a Raspberry Pi.

20180525/https://www.cnx-software.com/2012/06/06/make-your-own-raspberry-pi-laptop-with-a-motorola-lapdock/  
20180525/http://www.instructables.com/id/Home-Raspberry-Pi-Desktop-With-Old-Laptop-Screen/

Okay, now another thing that would be nice, and we've ought to be
clear on.  Power a Raspberry Pi from a laptop battery pack.  That
would save me a ton and be very convenient.  Yes, it is possible.  In
fact, someone has used both the LVDS hack and the battery hack.  In
addition, they've added keyboard and speaker support.  Wi-Fi antennas?
Unfortunately that must not be utilized yet.

20180525/DuckDuckGo power raspberry pi from laptop battery  
20180525/https://hackaday.com/2017/12/30/laptop-with-raspberry-pi-inside-learns-to-speak-battery/  
20180525/https://github.com/thedalles77/Pi_Teensy_Laptop  
20180525/https://www.youtube.com/watch?v=Gh3VTcLiJrI
