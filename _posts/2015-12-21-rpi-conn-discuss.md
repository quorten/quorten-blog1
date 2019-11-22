---
layout: post
title: "Raspberry Pi power, boot, DMA, USB, Ethernet, phone connectors
        discussion"
date: 2015-12-21 21:00 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Raspberry Pi and USB!

Note: Although USB supports video devices, the USB 2.0 bandwidth is
not fast enough for a USB SVGA video capture device to make sense.
Not unless the video stream is compressed.

You were wondering.  Why do you have to supply power to an Ethernet
switch?  Why can't it just get it from all of the connected computers?
The reason why this is is due to the standardization of Ethernet.
Ethernet standardizes electrical isolation; thus, the switch needs to
have its own power source.  USB, on the other hand, standardizes a
common ground.

20151221/https://en.wikipedia.org/wiki/USB

Raspberry Pi power packs?

20151221/http://www.raspberrypi-spy.co.uk/2013/06/12000mah-li-on-battery-power-bank-test/http://www.raspberrypi-spy.co.uk/wp-content/uploads/2013/06/pi_power_bank_test_03.jpg  
20151221/https://www.raspberrypi.org/forums/viewtopic.php?t=19341  
20151221/http://makezine.com/projects/portable-pi-power-raspbery-pi-to-go/  
20151221/https://www.raspberrypi.org/forums/viewtopic.php?f=46&t=6457

<!-- more -->

Oh, and how do you boot a Raspberry Pi for the first time?  You need
to boot from an SD card.  What about a USB memory stick?  Would that
work?  Only if the USB hub is working.

20151221/http://www.cnet.com/how-to/first-boot-with-the-raspberry-pi/  
20151221/https://en.wikipedia.org/wiki/XBMC

Be careful of DMA devices.  With all of the new hardware being
manufactured these days, and all of the multitasking happening in
computers, we now have to be weary of new attacks from untrusted
hardware.

20151222/https://en.wikipedia.org/wiki/DMA_attack

Wireless USB!  Like you were saying, continued extensions of USB.
But, security is of issue.

20151222/https://en.wikipedia.org/wiki/Wireless_USB

No, here's the real issue.  The real issue is that there are
fundamentally two different kinds of networks: ones where information
can only reach targeted recipients, and ones where information is only
broadcasted.  Because of the nature of the underlying network, one
communication mechanism may need to be emulated using another.

----------

Finally, what are the pin-outs on telephone cables?  What about
parallel ports?   I need to know what I'm heading into before I try
buying the relevant USB adapters.

20151222/https://en.wikipedia.org/wiki/Modular_connector  
20151222/https://en.wikipedia.org/wiki/Structured_cabling  
20151222/https://en.wikipedia.org/wiki/Tip_and_ring  
20151222/https://en.wikipedia.org/wiki/RJ11  
20151222/https://en.wikipedia.org/wiki/SCSI-1  
20151222/https://en.wikipedia.org/wiki/Parallel_communications  
20151222/https://en.wikipedia.org/wiki/Telephone_plug

Look, let's put additional adapters on hold for now.  For now, let's
wait until we can actually test the devices we've placed the order for
before moving any further.
