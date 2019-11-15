---
layout: post
title: Attach a serial device as Xorg keyboard
date: 2019-11-03 18:19 -0600
author: quorten
categories: [unix, raspberry-pi]
tags: [unix, raspberry-pi]
---

Suppose you have the really odd idea that you have some primitive
computer device with a keyboard that outputs data via a serial
communications line, and you want to route that to an Xorg keyboard
input device.  Actually, this isn't that bad of an idea, old fashioned
barcode readers and smart scales used this trick before the advent of
USB and Bluetooth.  Well, here's the long story short of the easy way
to do this.

```
inputattach --baud 2400 --sunkbd /dev/ttyUSB0
```

There are a variety of different devices supported through different
drivers, if you have a matching such device (unlikely), then pick that
one.  Otherwise, simply pick whichever device you can find the best
documentation on for the protocol and develop your peripheral to
support that.  Sun keyboard, Sun mouse, and Microsoft mouse are all
pretty well documented.

----------

Now, here is the lowdown of my twisted search.  In the end, beyond
merely being able to find information on the Internet, some lateral
thinking was required to make things work out.

<!-- more -->

20191103/DuckDuckGo linux use a serial port input as a keyboard  
20191103/DuckDuckGo linux use a serial port input as a gui keyboard  
20191103/DuckDuckGo linux serial keyboard driver  
20191103/https://wiki.archlinux.org/index.php/Serial_input_device_to_kernel_input  
20191103/DuckDuckGo xorg serial port keyboard  
20191103/https://askubuntu.com/questions/288324/how-to-forward-serial-devices-input-to-x  
20191103/https://help.ubuntu.com/community/BarcodeReaders  
20191103/https://launchpad.net/serial-text  
20191103/DuckDuckGo xorg serial keyboard  
20191103/DuckDuckGo xorg keyboard ttyUSB0  
20191103/DuckDuckGo xorg keyboard ttyS0  
20191103/https://help.ubuntu.com/community/SerialMouseHowto

Ah, yes, here it is!  Specifications on the communication protocol of
Sun serial keyboards.  Yeah, it wasn't exactly what I was looking for,
I was looking for a really dumb keyboard driver that could support
RS-232 ASCII data directly and translate it into keyboard input
events, but on second thought, the Sun keyboard protocol is pretty
simple and it isn't that bad to write my own Sun keyboard driver
wrapper on the Apple II side.  Plus, it would make for more features
than I was originally envisioning.

20191104/DuckDuckGo stowaway serial keyboard  
20191104/https://sourceforge.net/directory/?q=serial%20to%20keyboard  
20191104/DuckDuckGo barcode reader inputattach keyboard

This is an interesting though not very informative read.

20191104/http://lkml.iu.edu/hypermail/linux/kernel/0612.3/0400.html

20191104/DuckDuckGo ps/2 keyboard over rs-232  
20191104/https://en.wikipedia.org/wiki/PS/2_port

This is a great information source.

20191104/DuckDuckGo sun serial keyboard  
20191104/http://kentie.net/article/sunkbd/  
20191104/http://kentie.net/article/sunkbd/page2.htm  
20191104/http://kentie.net/article/sunkbd/KBD.pdf  

As for other serial keyboard protocols... well, a cursory web search
seems to point that some of the less popular ones are naturally no
very well documented.  That being said, I'd favor the more popular
ones over the less popular ones for simply that reason.

20191104/DuckDuckGo dec serial keyboard

Information on creating an adapter for an Apple Newton keyboard.

20191104/DuckDuckGo newton serial keyboard  
http://jimandnoreen.com/?p=259  

20191104/DuckDuckGo microsoft serial mouse protocol  
20191104/https://www.kryslix.com/nsfaq/Q.12.html  
20191104/DuckDuckGo sun serial mouse protocol  
20191104/https://linux.die.net/man/4/mouse

In regard to Raspberry Pi projects, attaching a serial keyboard has
some significant benefits, namely that it makes it easier to develop
and test your own computer keyboards.  Hooray!
