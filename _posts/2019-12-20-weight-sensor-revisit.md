---
layout: post
title: Weight sensors revisited
date: 2019-12-20 23:11 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, earlier I've searched around the Internet for information on
electronic weight sensors you can connect directly to a Raspberry Pi.
But apparently, I must have been too disappointed to record my
findings or immediately label them with the "Raspberry Pi" tag.  Well,
here I come back full circle to pretty much the same findings, but
this time, much more straight from the original sources, Sparkfun.
Previously, I've found a third-party blog that had the how-to build,
but not the explanation of why.

Yes, you do need to buy that weird Z-bar-shaped thing and screw it to
platforms for weighing.  Why the Z-bar?  Because by rotating by a
moment, it can sense weight more accurately than a pure compression
button cell.

Please note that you do not need to use _wood_.  Cardboard will also
work, and give you the advantage of a lower tare weight.  Again, feel
free to experiment with other platform materials, you may even try
thin sheet steel as a means of saving weight.  The thing is, not only
do you want a light platform material, you also want a platform
material that will not deform too much under load, because all
deformation is force that is imparted within the material itself and
not transferred to your weight sensor.

20191220/https://learn.sparkfun.com/tutorials/load-cell-amplifier-hx711-breakout-hookup-guide

<!-- more -->

Fortunately, I can get the Sparkfun components from Digi-Key at a
reasonable price, and they have competitive specifications.  500
gram-force load sensor at $11, 24-bit ADC on breakout board module at
$10.

20191220/https://www.digikey.com/product-detail/en/sparkfun-electronics/SEN-14728/1568-1899-ND/9555602  
20191220/https://cdn.sparkfun.com/assets/9/9/a/f/3/TAL221.pdf  
20191220/https://www.digikey.com/product-detail/en/sparkfun-electronics/SEN-13879/1568-1436-ND/6202732

There's also a 100 gram load sensor available, if you want to go even
lighter.  But for papers with a 24-bit ADC, the 500 gram sensor is
plenty good, accuracy at 0.1% Full Scale, not to mention safer against
over-loading which can happen quite easily once you get too good and
fast at scanning.

20191220/https://www.digikey.com/product-detail/en/sparkfun-electronics/SEN-14727/1568-1898-ND/9555601

Sparkfun has some great "getting started" info for using the load
sensor.  The load sensor itself is actually the four resistor
components of a Wheatstone bridge, and you connect these directly to
the amplification and ADC board.  That being said, you want this board
as close as possible to your weight sensor, in case you are
considering placing your Raspberry Pi at a distance.  Use 5 V for the
analog power source, and in the case of Raspberry Pi, 3.3 V for the
digital supply.  This will ensure the serial input/output is at 3.3 V.

20191220/https://media.digikey.com/pdf/Data%20Sheets/Sparkfun%20PDFs/Getting_Started_with_Load_Cells_Web.pdf  
20191220/https://www.sparkfun.com/products/13879

The serial protocol is simple enough in itself.  When data is not
ready, the output is held high, and the clock should be held low.
When there is data available, the output will be held low.  Apply 24
positive pulses to read out the 24 bits, and then apply the 25th pulse
to clear the state and bring the output back to high.  Two more pulses
can be provided to send configuration data to the ADC as follows:

* 25 pulses: Input channel = A, Gain = 128
* 26 pulses: Input channel = B, Gain = 32
* 27 pulses: Input channel = A, Gain = 64

Please note that if the clock input stays high for more than 60
microseconds, the chip will enter power-down state, and when the clock
input goes back low, the chip with power back on and reset.  This
means that for connection to Raspberry Pi, either realtime threads is
a must-have or one-shot pulse timing through the 555 timer chip can be
used as an alternative.  The PWM outputs might also work well.

20191220/https://www.mouser.com/datasheet/2/813/hx711_english-1022875.pdf

Sparkfun also has an ADC breakout board that connects via I2C.  Alas,
this is designed with extra headers that I would prefer not to use,
soldering being my preference for my particular projects.
Nevertheless, the NAU7802 chip is worth taking note of.

20191220/https://www.sparkfun.com/products/15242

----------

Researching more, balsa wood also looks like a good choice for the
scale's platform material.  It is simiarly as light cardboard, but it
can be potentially stronger than it.

20191221/DuckDuckGo balsa wood density  
20191221/http://www.modelaviation.com/balsa  
20191221/https://en.wikipedia.org/wiki/Ochroma

How the strength compare with cardboard?  Corrugated cardboard can
have a good 32 pounds per square inch of compressive strength.  Okay,
so I found this source that gives the compressive strength in
Megapascals, so I will convert the cardboard measurement to that,
approximately.

```
  32 lbs/in^2 = 14.545 kgf/in^2 = 2.255 kgf/cm^2
= 22545.5 kgf/m^2 = 221171.351 N/m^2 = 221171.351 Pa
= 0.221171351 MPa
```

20191221/https://en.wikipedia.org/wiki/Pascal_(unit)

See balsa wood strength specifications here:

20191221/DuckDuckGo balsa wood compressive strength  
20191221/https://www.auszac.com/pdf/Balsa_wood_Properties_Guide.pdf

Wow, balsa wood is pretty strong compared to corrugated cardboard.
And I thought that was already fairly strong for the sake of working
with paper!

Well, I guess I have my word, then.  If cardboard is strong enough and
light enough, I can just work with that.  Besides, it's more abundant
and cheaper, too, so why not?  If I don't have a real need for balsa
wood, yeah although it may be nice to play with, it is more practical
and looks better on my bill of materials to specify cardboard for
projects.

----------

Okay, mounting this sensor is a bit tricky because only two of the
four screw holes are tapped, and I want to use cardboard as the
platform material.  But, with proper care, this is feasible.

First of all, I need to have 3 mm standoffs, of course, in order to
get proper Z-bar mounting.  I can use unthreaded standoffs at the
threaded screw holes, but I probably want to use threaded standoffs
for the unthreaded screw holes to give me more that the screws can
hang onto.  Then comes the question of screwing into base versus
platform.  Sure, I _can_ use a heavier base than platform, but if I
do, I have to be careful not to make it too heavy, because otherwise
if you pick up and set down your scale upside down, you could damage
the sensor from overforce.  So, although I might screw in the platform
screws heads up, I might also want to screw in the base screws heads
up.  Plus, if I end up using the unthreaded screws for the base, which
I likely will, I may also need to use additional standoffs if the base
screws are too long and can't go all the way down.

Finally, there is another problem with screwing to cardboard.  How is
that ever going to work, won't the screws put too much pressure on too
small of a space and never work reliably?  If they are used directly,
yes, but there are again ways around this issue.  First and foremost
is to buy _washers_ to spread out the force exerted by the screw.
This way, you won't have as much risk of cardboard crushing, flexing,
and things like that from overforce.  Then, if you are using
corrugated cardboard, you can use "pressed" cardboard sheets
(i.e. from cereal boxes) to spread out the force even further to avoid
deforming the corrugated cardboard.  These two methods together should
provide a pretty good foothold between your screws, your sensor, and
your cardboard platform.

Since we want to make a precision scale, you're also going to want to
opt to use metal screws, standoffs, and washers for the sake of
precision measurement.  Yeah, nylon can be nice, but maybe this is not
a game for nylon to play.  This way, you also have a backup plan: if
the cardboard platform turns out to be a failure, you can always
switch to also using a metal platform too.

Alas, regarding the washers, looks like the metal washers have only
limited choices, so I may concede with using a nylon washer here
simply for the sake of getting a larger spread connection.  The
primary purpose was to avoid crushing and compressing cardboard,
although this may come at a bit of expense of compressing nylon.
Also, the nylon washers are generally thicker than the metal washers.

So, let's review my choices:

3 mm unthreaded aluminum standoffs:

20191221/https://www.digikey.com/product-detail/en/harwin-inc/R30-6200314/952-2365-ND/3906352

3.61 mm threaded steel standoffs:

20191221/https://www.digikey.com/product-detail/en/w-rth-elektronik/9775026360R/732-10909-1-ND/6644315

Runner up: 9.53 mm nylon washer:

20191221/https://www.digikey.com/product-detail/en/keystone-electronics/3158/36-3158-ND/59626

Runner up: 7.95 mm stainless steel washer:

20191221/https://www.digikey.com/product-detail/en/b-f-fastener-supply/FWSS-004/H734-ND/274945

Unfortunately, it turns out I can't use any washers!  It won't work,
it's too big, the screws are too close together, 6 mm center-to-center
distance.  With 5.4 mm screw head diameters, that leaves only 0.6 mm
spacing between the two screw heads.  Use pressed cardboard in place
of washers.

EXCEPT, I can use washers **only** for the bottom side of the
cardboard that meeets with the standoffs.  And I only need it for the
unthreaded standoffs because the threaded standoffs have a "washer" of
their own.

20191222/https://www.digikey.com/product-detail/en/keystone-electronics/7235-1/36-7235-1-ND/4499421

Now, for screws.  Runner up is "self-sealing" and thus has an
additional gasket near the top of the screw.

20191221/https://www.digikey.com/product-detail/en/apm-hexseal/RM3X12MM-2701/335-1157-ND/2063201

Runner-up, I was considering a deeper screw, but no, I'm not going to
have a 6 mm deep base, I'll buy more screws later if I really need to
reconsider.

20191221/https://www.digikey.com/product-detail/en/keystone-electronics/29316/36-29316-ND/1532210

Now, my screw pick.  They satisfy my desired material and length, but
they are slotted rather than Phillips heads.  Two of each, one 12 mm
length shaft, the other 16 mm length shaft.  The longer one is extra
length just in case I want more than 3 mm mounting on the other board
side, i.e.  for a thicker base board.  In case I don't need a thicker
base board, I can switch things around and they'll work okay because
of the standoffs.

20191221/https://www.digikey.com/product-detail/en/keystone-electronics/29314/36-29314-ND/1532209

Good info on metric screw sizes:

20191221/DuckDuckGo M3 screw diameter  
20191221/https://www.engineersedge.com/hardware/_metric_socket_head_cap_screws_14054.htm  
20191221/https://en.wikipedia.org/wiki/ISO_metric_screw_thread
