---
layout: post
title: Looking for laser rangefinder modules, getting more specific
author: quorten
date: 2018-11-05 21:28 -0600
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, let's keep searching for laser rangefinder modules, this time
being more specific.

20181105/DuckDuckGo digikey laser phase shift rangefinder  

This is an interesting paper describing a high-speed phase shift laser
rangefinder design.  It states that previously, laser rangefinder
designs that were accurate had to compromise on speed.  So, yeah,
that's something to look for.  What are the features and capabilities
of your laser rangefinder module?

20181105/www.ismtii2011.org/article/xml/sub/file_download.kin?main_no=92&mode=pdf

This is another interesting research article about different laser
measurement techniques.  From the year 2001!

20181105/https://utdallas.edu/~aiken/LASERCLASS/laserprinlipels.pdf

If you're in the mood for do-it-yourself on the _rangefinder module_,
there is a PDF on Digikey with a HOWTO for buying parts from them to
do just that.

20181105/https://media.digikey.com/pdf/Data%20Sheets/Osram%20PDFs/SPL%20PL90_3_RangeFinder.pdf

And, just when I was about to give up and start a new search query!
Bingo, I found a laser module for purchase!

20181105/https://www.acuitylaser.com/products/item/ar1000-laser-distance-sensor

Now, this find brings up some interesting questions to answer.  30
meters to 3mm?  Is that a distance that you'd reasonably want?  Indeed
it is, looking at the 3D model of the house.  RS-232 interface, rugged
washable enclosure.  Okay, those are features I definitely do not
need, not to mention the box itself may be too big and heavy for my
application.

But, now we know the search terms to use.  _Laser Distance Sensor_.
And indeed, that brings up many more relevant results!

<!-- more -->

20181105/DuckDuckGo laser distance sensor

Looks nice, but it turns out to be too short of a distance for my use.
It works with Raspberry Pi, indeed.

20181105/https://www.amazon.com/Waveshare-Laser-Receiver-Sensor-Transmitter/dp/B00NJNYQ9G

Also looks nice, but still too short of a range.  I suppose you need
to look for physically larger modules for better range.

20181105/https://www.amazon.com/MakerFocus-Single-Point-Ranging-Pixhawk-Compatible/dp/B075V5TZRY

Nice connectors.  What type of connectors are on those cables,
exactly?

Q: What type of connectors are on the cable?

A: Dear, one terminal of the connectors is GH1.25-4P, connecting with
TFmini. And the other terminal is 1.25-4p, it's similar to
Molex510210. Hope our answer can help you. Many thanks!

20181105/https://www.amazon.com/0-3-12m-Indoors-Single-Point-Detectors-Raspberry/dp/B07BM1RMYN

Although, yes, I do concede.  12m measurement distance is pretty good
if I am only measuring indoor quantities within the house.  Outside
the house, for sure it is no good.

1% accuracy for less than 6 meters?  That's like 1 cm uncertainty.
That's junk!

So this one looks like it's actually somewhat useful.  1 mm resolution
2 m limit.

20181105/https://www.amazon.com/Parallax-Inc-28041-LaserPING-Rangefinder/dp/B0794XGBS9

Now if you want to go with the traditional purpose-specific device,
yeah you get better range and accuracy.  Well, assuming that is not
false advertising.

20181105/https://www.amazon.com/Measure-Electronic-Distance-Batteries-Included/dp/B07FF546YB

Good range at 40m, compact modular unit, lower precision at 2.5cm,
high price at $128.

20181105/https://www.amazon.com/dp/B01MG3Z3PE

Granted, this is just talking the module.  And there were full human
interface units selling cheaper for that, not to mention purportedly
more accurate.

Look at that, only $15 for a full human interface unit for a infrared
temperature remote sensing gun.  Those segmented LCD human interface
electronics sure can be cheap when manufactured at scale.

20181105/https://www.amazon.com/Etekcity-Lasergrip-774-Non-contact-Thermometer/dp/B00837ZGRY

If you really want a good traditionally designed system, go for the
Leica brand name in the space of laser rangefinders.  But that's just
the thing.  I don't want to be pairing with a separate device over
Blutooth!  And running a smartphone with an energy-hungry full
graphics display.

Laser detection device specifically designed for determining level
construction paths without tilt.

20181105/https://www.amazon.com/AdirPro-Universal-Rotary-Receiver-Detector/dp/B00YNTC4CQ

Now, this is interesting.  Industrial laser rangefinder module, RS-232
interface, excellent specifications.  2mm accuracy, 60m max range.
Major caveat is the large board size and the RS-232 interface, rather
than a CMOS serial interface.

20181105/https://www.amazon.com/Distance-Serial-Sensor-Finder-Module/dp/B07G4F14RR

This is the Leica one.

20181105/https://www.amazon.com/Leica-E7500i-Distance-Measurer-Bluetooth/dp/B00DH7HADS

Well, that's the end of trying to search on Amazon.  The first sight
was overly promising.

Okay, now something that is becoming more obvious when looking at
other supplier sites.  All of the high-end laser rangefinders are
relatively large units.  Matter of fact, when you look at them, you
really want to say that they use "DSLR camera optics" from the way
they are designed, their physical size, and their weight.

20181105/https://www.micro-epsilon.com/displacement-position-sensors/laser-distance-sensor/  
20181105/https://www.micro-epsilon.com/displacement-position-sensors/laser-distance-sensor/optoNCDT_ILR_1181_1182_1183/  
20181105/https://www.micro-epsilon.com/download/products/cat-optoncdt-ilr/dax--optoNCDT-ILR-118x--en-us.html#page=2&zoom=Fit  
20181105/https://www.pepperl-fuchs.com/global/en/2274_entfernungsmessger_te_distanzsensoren.htm

More industrial suppliers.

20181105/https://www.automationdirect.com/adc/overview/catalog/sensors_-z-_encoders/laser_sensors  
20181105/https://www.jenoptik.com/products/metrology/laser-distance-sensors

Ah!  Well, here you go.  The Digikey part listing for the sensors
you're looking for.

20181105/https://www.digikey.com/products/en/sensors-transducers/optical-sensors-distance-measuring/542

20181105/https://www.sick.com/us/en/distance-sensors/displacement-measurement-sensors/c/g150251

Indeed!  It looks like all of the ultra-portable laser rangefinders
are ultimately designed for the interests of drones.  No more than 10
cm of accuracy is required for a drone to navigate the world, hence
that is the limit of many of the smaller portable sensors.

20181105/https://hackaday.com/2014/07/01/pew-pew-an-arduino-based-laser-rangefinder/  
20181105/http://www.berryjam.eu/2014/06/oslrf-01/  
20181105/https://lightware.co.za/

Another industrial supplier.

20181105/http://trelectronic.com/product-family/laser-distance-sensors
