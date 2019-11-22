---
layout: post
title: Alternatives to L293D motor controller?  Info on CMOS.
date: 2017-01-29 21:00 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Oh, come on.  Do I really need to use that L293D controller?  I'd hate
to add an extra chip to my setup.  There's got to be an easier way to
do it with CMOS, isn't there?  Well, there _would_ be, if only your
GPIO pins had the option to be "ground" in addition to "0v" and
"3.3v", but they don't.

UPDATE 2019-11-20: They do, but there is a limit on the voltage and
current they can handle.  Use level shifters, or a cheaper equivalent
such as MOSFETs or buffer circuits.

20170129/https://en.wikipedia.org/wiki/General-purpose_input/output  
20170129/https://en.wikipedia.org/wiki/CMOS  
20170129/https://en.wikipedia.org/wiki/Gate_equivalent  
20170129/https://en.wikipedia.org/wiki/Beyond_CMOS

Advancements in CMOS circuitry?  Oh, this reminds me.  I should go
read IEEE Spectrum to update myself on technology news.

20170129/https://en.wikipedia.org/wiki/10_nanometer  
20170129/https://en.wikipedia.org/wiki/7_nanometer
