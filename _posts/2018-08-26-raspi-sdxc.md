---
layout: post
title: Raspberry Pi B+ with SDXC cards?
author: quorten
date: 2018-08-26 12:45 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Can you use SDXC cards with Raspberry Pi B+?  Indeed, you can.  Now,
here's the lowdown on the situation.  SDHC and SDXC apparently only
differ by the recommended filesystem used to format the card.  So,
there is no hardware reason why SDXC cards wouldn't work with the
Raspberry Pi B+.

However, the boot firmware of Raspberry Pi B+ only works with the
FAT32 filesystem.  So, this means you have a little bit of a more
complicated time setting up the install image, but that's it.  Make
sure there is a FAT32 partition on your SDXC card when copying boot
files for NOOBS, and NOOBS can handle the rest.

Now, the next step after this is to build SDXC cards without NOOBS,
using your own OS image.  I have yet to try that out, but the point in
hand is that I can buy the hardware without worrying about not being
able to use my extended storage.

20180826/DuckDuckGo raspberry pi b+ sdxc  
20180826/https://www.reddit.com/r/raspberry_pi/comments/1yutlz/can_we_use_the_new_sandisk_ultra_128gb_with_the/  
20180826/DuckDuckGo raspberry pi supported sd cards

Bingo!  This is the documentation you were looking for.

20180826/https://www.raspberrypi.org/documentation/installation/sd-cards.md  
20180826/https://www.raspberrypi.org/documentation/installation/sdxc_formatting.md
