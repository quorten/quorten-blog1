---
layout: post
title: "Arduino board source code, more details on DIY chemical
        PCB etching"
date: 2020-07-24 01:15 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, according to the Wikipedia article on Arduino, the board is Open
Hardware, the design is shared under the Creative Commons Attribution
Share-Alike license.  Alas, Wikipedia provides no direct cite link,
and I did not find the board source code repository on GitHub.  So, where
is the source?

20200723/https://en.wikipedia.org/wiki/Arduino

Searching around quite a bit, I found it in a non-ideal location.
First, go to the Arduino store website.  Then, click on the product
you want the design information for.  Go to the Documentation tab, and
you'll see some links to the reference designs.  Those links will
point to a "downloads" area inside the website merely designated for
hosting file storage.  No version control, nothing fancy like that.  A
bummer.  Also, the designs are in EAGLE CAD format, no KiCad going on
here for the original board designs, but for some of the newer board
designs, they are also available in Fritzing format.

20200723/https://store.arduino.cc/usa/arduino/boards-modules  
20200723/https://store.arduino.cc/usa/arduino-uno-rev3  
20200723/https://store.arduino.cc/usa/nano-every

<!-- more -->

Searching around quite a bit more on the Arduino website, I found
these links to special designs meant to be easily manufacture DIY
circuit boards via the laser printer toner transfer photoresist mask
method.  The first page has broken links, but the links in the second
page for the updated version work just fine.

20200723/https://www.arduino.cc/en/Main/ArduinoBoardSerialSingleSided  
20200723/https://www.arduino.cc/en/Main/ArduinoBoardSerialSingleSided3

Manually etch a PCB, did I see mentioned?  No, they simply referred to
the DIY etching method.  But, nevertheless, I did search for this
topic and found some interesting results.  Namely, more information on
the laser printer etching process.  Once you print your photoresist
mask with a laser printer and do to the toner transfer with an iron,
you use ferric chloride to do the actual etching.  This can come
either in a liquid form or a powder form, you can buy the powder form
and mix with water to get the liquid.  This is also a very dangerous
chemical, the fumes will corrode steel.  So, not only need you be
concerned with protecting yourself by wearing gloves, eye protection,
proper ventilation, and respiratory protection, but also your
surrounding physical environment, so metal structures in your work
room do not get ruined.

The etching process typically happens in 5 to 10 minutes, a hot plate
to heat up to 75 degrees Celsius and agitation is required for optimal
performance.  Then you can wash the board off by soaking in plain
water.

How do you dispose of the etching solution when you are done?
Apparently, you can dilute it and pour it down the sink.  Why?
Because typically this chemical occurs in very low concentrations in
municipal water: after having been used in the city water filtration
and treatment plant, it is left in the water in very low
concentrations.  That being said, there's a really interesting trick
you can use to get ferric chloride: if it occurs in your city water
supply, you can collect and concentrate it from your own tap water.
Then you can use it for PCB etching, but it will take significantly
longer than using a proper high concentration solution would take.  On
the other hand, you might prefer the lower concentration solution
because it is less hazardous to work with.

Another interesting trick is that you can use a Sharpie permanent
marker to draw on your own photoresist, rather than a laser printer.
Worthy of note is that solid ink printers also work well, and
therefore, thermal transfer printers by extension.

20200723/DuckDuckGo etch pcb by hand  
20200723/https://circuits-diy.com/how-to-etch-a-pcb-printed-circuit-board-a-beginners-guide/

This is where the "PCB etching with water" trick is mentioned, on a
link to an EEVblog video.

20200723/https://www.ourpcb.com/pcb-etching.html  
20200723/https://www.instructables.com/id/Making-a-Hand-Drawn-PCB./  
20200723/https://www.instructables.com/id/Making-a-Hand-Drawn-PCB./

Now, I wonder.  Can you go and do likewise with an inkjet printer?
Maybe.  The idea would be that you can substitute pigment ink for
toner or wax.  But, toner, wax, and permanent marker all contain a
plastic or wax material within them, pigment ink is just pigments, and
that may not be good enough for a photoresist mask.

20200723/DuckDuckGo print permanent ink inkjet printer  
20200723/DuckDuckGo pigment ink inkjet printer  
20200723/https://laserinkjetlabels.com/pages/pigment-based-inkjet-cartridges/  
20200723/https://en.wikipedia.org/wiki/Permanent_marker
