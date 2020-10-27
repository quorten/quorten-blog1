---
layout: post
title: Warnings on reflow soldering crystal oscillators
date: 2020-10-19 15:02 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Some nice crystal oscillator datasheets I've read has some important
warnings on reflow soldering with quartz crystal oscillators.

20201019/https://abracon.com/Resonators/AB26TRB.pdf  
20201019/https://cfd.citizen.co.jp/english/wp-content/themes/cfd/dist/pdf/datasheet_TF/CFS-206_CFS-145_E.pdf  
20201019/https://abracon.com/Resonators/AB26T.pdf  
20201019/https://ecsxtal.com/store/pdf/ECS-3x8X%202x6X%201X5X.pdf

Not all crystals are created equally.  In particular, crystals with
leads may not be designed to handle the thermal stresses of reflow
soldering.  Doing so may cause the crystal to warp and no longer be
within its rated timing specifications.  For leaded crystals, check
that it is rated as reflowable or has a diagram of a reflow soldering
temperature profile in the datasheet before attempting to assemble via
reflow soldering.  Otherwise, you should hand-solder for safety.

Another note is that even if the crystal is designed for reflow
soldering, you can only subject the crystal to reflow soldering a
limited number of times before it falls out of specification.
Generally this is a small number like 2-3 times.

<!-- more -->

But, that is something to keep in mind.  Sometimes as an inexperienced
hobbyist, I may reflow a board multiple times to fix things up.  But
don't even think about doing this if you don't have to with quartz
crystals, because you can quickly end up ruining your product's
intended purpose.  Another word of warning here comes down to other
specialized use cases such as reflowing already finished boards.  In
my case, this is typically for the purpose of populating pin headers
onto Raspberry Pi Zeroes, but it may also be used for repair of
existing boards.  Keep in mind, in the case of a Raspberry Pi Zero,
there is a 19.2 MHz quartz crystal on the board.  So, be careful about
this!  Basically, assume you only have one shot for reflow soldering.
Also, keep that in mind when working with any other similar
electronics.

Because of this reason, you may want to consider hand-soldering
headers onto Raspberry Pi Zeroes rather than reflow soldering.

Another note comes down to mounting cylindrical crystals to boards.
Because they are sensitive to vibration, you probably don't want to
mount them as "standing cans" as is typical with capacitors.  Rather,
you want to bend the leads 90 degrees and use rubber adhesive to fix
the opposite end of the radial head to the circuit board.  Never
solder the head end, or else you will seriously degrade the timing
characteristics of the product.  What about hot glue?  That might be
okay, but it is still a bit precarious.
