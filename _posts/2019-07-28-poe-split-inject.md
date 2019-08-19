---
layout: post
title: POE splitters, injectors, and 12-volt lead-acid UPS power
date: 2019-07-28 17:28 -0500
author: quorten
categories: [home-network]
tags: [home-network]
---

Want to get POE to some equipment that doesn't natively support POE?
Don't worry, it's easy through the use of commercially available POE
splitters that take a POE Ethernet line and split it out into separate
standard power and Ethernet data plugs.  5 volt and 12 volt splitters
are plenty easy to find.  For 9 volt splitters, you'll find the market
to be much more hard-pressed.  More typical is "universal" 5 V, 9 V,
12 V splitters, but this equipment much bulkier and simply not as nice
as a purpose-built one would be.

There are also POE injectors available for situations where you may
only want to run one cable, but don't have access to a POE switch
port.

20190728/https://en.wikipedia.org/wiki/Power_over_Ethernet

This is a useful article about proper grounding for POE equipment.  It
should not be connected to local ground because it may not be at the
same potential as the remote ground, and you can get ground loops.  If
you want to connect to protective ground, you should do so with an
appropriate protective circuit.

20190728/https://electronics.stackexchange.com/questions/222630/grounding-a-poe-powered-device

20190728/DuckDuckGo 5 volt micro-usb poe splitter  
20190728/https://www.amazon.com/poe-splitter-micro-usb/s?k=poe+splitter+micro+usb

20190728/DuckDuckGo 12 volt poe splitter  
20190728/https://www.amazon.com/PLUSPOE-IEEE802-3af-Splitter-Ethernet-Switches/dp/B075CQD69R

20190728/DuckDuckGo 9 volt poe splitter

Not so successful, but luckily, it looks like step-down 12 V DC to 9 V
DC converters are easy to buy on Amazon.

20190728/https://www.amazon.com/Magnolian-Efficiency-Converter-Supply-Waterproof/dp/B00A71E52G/ref=sr_1_3?keywords=12+volt+to+9+volt+converter&qid=1564339891&s=gateway&sr=8-3

Now, let's see if this nifty gadget is available.  12 volt UPS.  There
is equipment available, but it is not being sold by Amazon.

20190728/DuckDuckGo 12 volt ups  
20190728/DuckDuckGo 12 volt output ups

The name of the game is additional battery power systems for use in
taxis and other cars.  Yes, so if you want to have a relatively
ready-made system to boot, look around for devices built for car power
systems.

20190728/https://www.powerstream.com/DC-UPS-1212.htm  
20190728/https://www.pimfg.com/product-detail/PIPS-UPS-12V

20190728/DuckDuckGo 12 volt dc ups  
20190728/ttps://www.powerinverters.com/
