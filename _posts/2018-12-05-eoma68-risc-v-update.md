---
layout: post
title: Updates on EOMA68 Earth Friendly Computing Device and RISC-V
author: quorten
date: 2018-12-05 18:07 -0600
categories: [misc, raspberry-pi]
tags: [misc, raspberry-pi]
---

Are there any updates on EOMA Earth friendly computing devices?
Yes!!!  Now, this is quite the interesting update.

First of all, the PCBs have been printed.

20181205/https://www.crowdsupply.com/eoma68/micro-desktop/updates/what-do-1-000-eoma68-a20-pcbs-look-like

Second, in this past update, it has been pointed out that manual
assembly of the PCB and the casework by the backers _may_ be
considered.  The casework part, I'd be okay on that.  The PCB?  Well,
you're definitely right about it not being very hard, but needing to
be done _very carefully_.

20181205/https://www.crowdsupply.com/eoma68/micro-desktop/updates/pcbs-and-components-have-been-ordered

Third, now this is very interesting.  The Crowdsupply campaign for the
RISC-V design is being put up with some initial updates.  The actual
campaign is not underway yet, but the development updates and status
are being posted.  And indeed, this is quite an ambitious project.
Basic hardware accelerated 3D graphics rendering will be included,
through the means of some RISC-V extensions and a Vulkan-based
software graphics system called Kazan, written in Rust.  Despite the
complexity of such a proposal, it is actually made quite simple
because of a variety of means.  First of all, the architectural
constraints of Vulkan effectively guide you toward creating a
successful implementation.  Second, some notable figures of the chip
and 3D industry of times past are chipping in and providing guidance
on this project, one of the benefits of it being done out in the open.

Indeed, some of the skepticism opinion is useful.  It would be nice to
see where the EOMA68 project lands when it's finally complete.
However, that seems to be doing pretty well, and if it does end on a
relatively high note, I think we can say we have high hopes for this
project doing better than we might expect at first glance.

20181205/https://www.crowdsupply.com/libre-risc-v/m-class  
20181205/https://www.crowdsupply.com/libre-risc-v/m-class/updates/why-make-a-quad-core-64-bit-soc-surely-there-are-enough-already  
20181205/https://www.crowdsupply.com/libre-risc-v/m-class/updates/comments-on-recent-phoronix-articles  
20181205/https://www.phoronix.com/scan.php?page=news_item&px=Libre-GPU-RISC-V-Vulkan  
20181205/https://www.phoronix.com/scan.php?page=news_item&px=Kazan-Vulkan-Rust  
20181205/https://www.phoronix.com/scan.php?page=news_item&px=Quad-Core-Libre-SoC-Proposal
