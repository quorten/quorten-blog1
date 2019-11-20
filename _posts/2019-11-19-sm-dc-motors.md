---
layout: post
title: "Smaller DC motors, computing motor power, and brief review of
        vehicle steering"
date: 2019-11-19 23:18 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

I've previously searched for DC motors and found no shortage of
"1-inch" motors.  However, those are rather large for my intended use
as a tiny Raspberry Pi Zero machine, and besides, I've seen smaller
motors than that in a 90's era Minolta compact automatic film camera,
1 cm diameter to be exact.  So, now I go searching for smaller DC
motors.  And indeed, "10 mm" is the key search term to include.

20191119/DuckDuckGo 10 mm dc micro motor  
20191119/https://nfpshop.com/product/10mm-vibration-motor-15mm-type-model-nfp-110-003

There's plenty of choices on Digi-Key around the 10 mm size range.
Most of them are 5-6 V DC motors.

<!-- more -->

20191119/https://www.digikey.com/products/en/motors-solenoids-driver-boards-modules/motors-ac-dc/178?FV=-8%7C178%2C46%7C393585%2C46%7C393589%2C46%7C393591%2C46%7C393593%2C46%7C393606%2C46%7C393610%2C46%7C393611%2C46%7C393612%2C46%7C393628%2C46%7C393633%2C46%7C393644%2C46%7C393645%2C46%7C393646%2C46%7C393685%2C46%7C393714%2C46%7C393715%2C46%7C393738%2C46%7C393779%2C46%7C393808%2C46%7C393816%2C46%7C393821%2C46%7C393824%2C46%7C393826%2C46%7C393844%2C46%7C397585%2C46%7C397586%2C46%7C397589%2C46%7C397593%2C46%7C397594%2C46%7C397595%2C46%7C397597%2C46%7C397602%2C46%7C397603%2C46%7C397609%2C46%7C397623%2C46%7C397628%2C46%7C397637%2C46%7C397638%2C46%7C397640%2C46%7C397644%2C46%7C397650%2C46%7C397651%2C46%7C397662%2C46%7C397683%2C46%7C397706%2C46%7C397712%2C46%7C397721%2C46%7C397723%2C46%7C397729%2C46%7C397741%2C46%7C406679%2C46%7C406711%2C46%7C406724%2C46%7C406726%2C46%7C406741%2C46%7C406745%2C46%7C406755%2C46%7C406768%2C46%7C406769%2C46%7C406787&quantity=0&ColumnSort=46&page=2&pageSize=25

Here are a select few choices for example.

20191119/https://www.digikey.com/product-detail/en/dfrobot/FIT0482/1738-1262-ND/7087159  
20191119/https://www.digikey.com/product-detail/en/pimoroni-ltd/COM0806/1778-1127-ND/6873670

How do you know how much torque you can get out of a DC motor?
Compute the power from the voltage and current draw ratings, then
convert to torque using the following example, also using the RPM
rating.

```
T = (POWER in Watts) * 9.549 / (SPEED in RPM)
T = (750 W) * 9.549 / (2000 rpm)
  = 3.6 (Nm)
```

You get the resulting torque in Newton-meters, which you can convert
to pound-inches if you'd prefer.

```
1 newton meters = 8.85075 inch pounds
```

20191119/DuckDuckGo dc motor compute strength  
20191119/https://www.engineeringtoolbox.com/electrical-motors-hp-torque-rpm-d_1503.html

Some really tiny motors are marked up as "ERM vibration motors."
Essentially, these are motors designed solely to generate vibrations
inside of pagers, cell phones, smartphones, and other such mass market
mobile communications devices.

20191119/DuckDuckGo ERM vibration motor  
20191119/https://www.precisionmicrodrives.com/content/ab-004-understanding-erm-vibration-motor-characteristics/  
20191119/https://www.precisionmicrodrives.com/vibration-motors/eccentric-rotating-mass-vibration-motors-erms/

Now, what about steering mechanisms for small car-style devices?  Two
main styles.  For maximum maneuverability, there is "skid-steer" where
you have one motor to control left-side wheels and one motor to
control right-side wheels.  For example, "skid-steer loader Bobcat"
machines.  For maximum straight-line speed/torque on a finite power
budget, there is one large main motor for driving the forward wheels
and a second smaller motor for controlling tilt-style wheel steering.
For example, conventional on-road motor vehicle cars.

20191119/https://en.wikipedia.org/wiki/Skid-steer_loader  
20191119/https://en.wikipedia.org/wiki/Differential_steering

Finally, the simplest case of vehicle steering worth mentioning, lest
the moderner forget, requires only a single motor whatsoever: on-track
"railroad-style" navigation.  The vehicle only has a single motor for
forward and reverse, and all steering guidance is performed by the
tracks themselves.
