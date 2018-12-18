---
layout: post
title: 3D scanner laser rotation motor gearing
author: quorten
date: 2018-11-17 23:50 -0600
categories: [raspberry-pi, 3d-scanning, 3d-scanner]
tags: [raspberry-pi, 3d-scanning, 3d-scanner]
---

Decisions on gearing to apply to the laser rotation motor.

So, I reviewed my Raspberry Pi 3D scanner notes and it looks like I
didn't decide on a final gearing option for the laser rotation motor
after all.  My "final" option for now is to use the Lego MINDSTORMS
kit motor and gears to rotate the laser.  Fair enough, it's good
enough to get me started, but I know I'm going to want something
better for larger scale usage.

So, although I know I looked at this before, I must not have saved the
links to the great website with information on motor gearing and the
energy efficiency of different gearing solutions.  So first I went
searching around to try to find a near analog to that website, which
is also the website I learned about the option of planetary reduction
gears at.

20181117/DuckDuckGo micro motor gear reduction  
20181117/DuckDuckGo electric motor gear reduction  
20181117/DuckDuckGo electric motor gear reduction ratio  
20181117/DuckDuckGo planetary gear for small electric motor

A different website that may be useful for getting supplies.

20181117/https://www.powerelectric.com/electric-planetary-gear-motors/

Wikipedia article for background information indeed confirms that
planetary reduction gears are great for getting high-torque with a
small package.

20181117/https://en.wikipedia.org/wiki/Planetary_gear

<!-- more -->

UPDATE 2018-12-17: I found a very interesting note on the planetary
gear Wikipedia article that is quite pertinent to my 3D scanner
development.

> During World War II, a special variation of epicyclic gearing was
> developed for portable radar gear, where a very high reduction ratio
> in a small package was needed. This had two outer ring gears, each
> half the thickness of the other gears. One of these two ring gears
> was held fixed and had one tooth fewer than did the
> other. Therefore, several turns of the "sun" gear made the "planet"
> gears complete a single revolution, which in turn made the rotating
> ring gear rotate by a single tooth like a Cycloidal drive.[citation
> needed]

20181117/DuckDuckGo small electric motor metal gear planetary efficiency
20181117/DuckDuckGo dc motor metal gear planetary efficiency  

This looks like it must either be the website or a near analog of what
I've found previously.  Last time I visited the website mainly to
confirm that a 1000:1 gear reduction ratio was feasible with
commercially available options.

20181117/https://www.anaheimautomation.com/products/brushless/brushless-gearmotor-item.php?sID=157&pt=i&tID=98&cID=47  
20181117/https://www.anaheimautomation.com/index.php  
20181117/https://www.anaheimautomation.com/products/brush/dc-gearmotor.php?tID=102&pt=t&cID=46  
20181117/https://www.anaheimautomation.com/products/brush/dc-gearmotor-item.php?sID=255&pt=i&tID=102&cID=46  
20181117/https://www.anaheimautomation.com/products/gearbox/spur-gearboxes-list.php?cID=31  
20181117/https://www.anaheimautomation.com/products/gearbox/spur-gearbox.php?tID=146&pt=t&cID=31  
20181117/https://www.anaheimautomation.com/products/gearbox/spur-gearbox-item.php?sID=301&serID=1&pt=i&tID=146&cID=31

Another different website that may be useful for getting supplies.

20181117/http://www.powerjackmotion.com/product-category/gearbox/planetary-gearbox/  

So, now it seems like the verdict is that if I want to get a planetary
reduction gearbox for a DC micro motor, I may need to look around for
perhaps a Chinese vendor of the products.  ZHAOWEI is my current pick
for now.

20181117/DuckDuckGo planetary reduction gear dc motor  
20181117/DuckDuckGo planetary reduction gear box dc motor  
20181117/DuckDuckGo planetary reduction gear box dc  
20181117/https://www.zwgearbox.com/  
20181117/DuckDuckGo zhaowei plastic planetary gearbox  
20181117/http://www.microplanetarygearbox.com/  
20181117/http://www.microplanetarygearbox.com/supplier-63756-micro-planetary-gearbox

Some of their product offerings are about planetary reduction
gearboxes integrated into the DC micro motor package, which is not
what you want if you want to reuse an old existing DC motor.
