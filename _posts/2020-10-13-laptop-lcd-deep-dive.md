---
layout: post
title: Old laptop LCD deep-dive
date: 2020-10-13 01:15 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Can you replace a burnt out CCFL bulb inside an old laptop LCD screen
with an LED bulb?  Theoretically, yes, but the practical technical
considerations to achieve this make it a great challenge.

Let's consider one case example.  I've bought a new LCD screen and
inverter for a Dell Inspiron e1505 laptop because the CCFL bulb inside
the old screen failed from the previous owner disliking display mode
power save timeout after running a screen saver for so long.  They
wanted the screen to stay powered on and show the screen saver running
all the time.  As a consequence, the CCFL bulb failed well before its
expected failure date based off of the intensity of use of the
machine.  But anyways, if I eventually replace the CCFL bulb inside
with a new one, I'll have a spare LCD screen at my disposal.

So, let's get the rundown of the actual parts inside the LCD display.
First of all, the part number of the inverter is LJ97-00680A.  This is
a part that is apparently manufactured by Dell.  But, more interesting
are the parts on the board itself.  There are really only two
integrated circuit packages on the board, the big rectangular one is a
housing for the high-voltage inverter.  The small square one, that is
clearly an integrated circuit package of some sort.  Reading the label
that is visible from my up-close photos, it is pretty similar to the
Maxim MAX8759ETI+, and I was able to find this datasheet online!  The
part itself, however, is obsolete and no longer in production.

My read of the IC package label:

<!-- more -->

```
MAXIM
8759E
TI605
+ NTAK
```

20201012/DuckDuckGo maxim 8759E TI605 NTAK  
20201012/DuckDuckGo maxim 8759ETI605 NTAK  
20201012/DuckDuckGo maxim MAX8759E TI605 NTAK  
20201012/DuckDuckGo maxim MAX8759ETI605 NTAK  
20201012/DuckDuckGo maxim MAX8759ETI 605 NTAK  
20201012/DuckDuckGo DuckDuckGo maxim MAX8759ETI  
20201012/https://datasheets.maximintegrated.com/en/ds/MAX8759.pdf  
20201012/https://www.digikey.com/en/products/filter/pmic-lighting-ballast-controllers/751?s=N4IgTCBcDaILIEEAaAOA7AVgJwgLoF8g  
20201012/https://www.digikey.com/en/products/detail/maxim-integrated/MAX8759ETI/11548192  
20201012/https://4donline.ihs.com/images/VipMasterIC/IC/MAXM/MAXMS19462/MAXMS19462-1.pdf?hkey=EC6BD57738AE6E33B588C5F9AD3CEFA7

This is an LCD inverter controller integrated circuit, complete with
SMBus (I2C) support for dimming control and other advanced features.
Dimming can also be controlled via PWM and an ambient light sensor,
though the original laptop never used the ambient light sensor
support!  One thing I do like about the chip's advanced features are
the safety features, the ability to detect bulb failure and other
similar events, enter a shutdown mode, and set an error condition
register that can be read from SMBus.  Now, if only I knew if my Dell
laptop had hardware support for reading that state info, then it's
just be a matter of getting that software support into Linux.

Second, the part number of the screen is Samsung LTN154X3-L06.  I
found it easy to find the datasheet for LTN154X3-L01, but it was
considerably more challenging to find the datasheet for LTN154X3-L06.
When I did find it, it was marked with "Samsung secret," apparently
originally delivered to Toshiba.  As is typical with these
confidential documents, it was wrought with a number of minor
editorial errors: spelling and grammar issues were caught, minor
technical issues are reasonable to assume.  However, this datasheet is
overall more detailed.  Apparently only laptop manufacturers were
permitted to receive the more detailed information.

20201012/DuckDuckGo LTN154X3-L06  
20201012/DuckDuckGo LTN154X3-L01 datasheet  
20201012/https://pdf1.alldatasheet.com/datasheet-pdf/view/1132231/SAMSUNG/LTN154X3-L01.html  
20201012/DuckDuckGo LTN154X3-L06 datasheet  
20201012/https://datasheet4u.com/datasheet-pdf/Samsung/LTN154X3-L06/pdf.php?id=672537  
20201012/https://datasheet4u.com/datasheet-parts/LTN154X3-L06-datasheet.php?id=672537

One thing I had to remind myself in regard to the wiring of the
inverter and the LCD screen.  The Dell laptop uses a special cable to
attach the separate connectors of both to a single cable, which then
connects to the laptop's motherboard.  The LCD screen itself only has
one cable for data input, and one cable for the CCFL bulb input, there
is no special cable for output from the monitor to data input for the
inverter like I once wrongly thought may be the case.

Good news, I've found one of those clunkly VGA interface boards
specifically designed for this LCD screen.

20201012/http://www.lcdcontrollerdiy.com/2018/12/05/vga-lcd-controller-board-work-for-ltn154x3-l06-ltn154x3-l07-lcd-panel/  
20201012/https://www.ebay.com/itm/VGA-LCD-Controller-Board-Work-for-LTN154X3-L06-LTN154X3-L07-LCD-Panel/182350335880?hash=item2a74ed4f88:g:UnsAAOSwIgNXkxrY

Yeah, that was the old way I've documented on how to use an old laptop
LCD screen with new applications, Raspberry Pi in particular.  But,
the bigger question.  I know what it takes to control the inverter
board.  Can you interface LVDS directly with Raspberry Pi to attach
the entire display more directly?  Indeed you can!  LVDS4PI is the
name of the game, a project that puts an LVDS driver chip onto a
Raspberry Pi HAT, and its successor, LVDS4PI EVO.  I'm not sure how
speedy it can perform on a Raspberry Pi Zero, I'd guess it
unfortunately wouldn't be as good as the original laptop due to the
BCM2835 not supporting LVDS directly in its GPU pipeline.

But, the hints I'm picking up, maybe you can send DSI or DPI to an
LVDS controller and then that would be quite speedy.  However, some
options may require a Raspberry Pi Compute Module rather than a
Raspberry Pi Zero, and that's where the bummer is.

20201012/DuckDuckGo raspberry pi lvds  
20201012/https://www.youtube.com/watch?v=JmE5L34jfi8  
20201012/https://www.raspberrypi.org/forums/viewtopic.php?p=1527642  
20201012/https://www.youtube.com/watch?app=desktop&v=aJ_nn7YlihE
