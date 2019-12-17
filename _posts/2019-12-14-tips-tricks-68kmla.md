---
layout: post
title: Many useful tips and tricks from 68kMLA
date: 2019-12-14 23:21 -0600
author: quorten
categories: [vintage-computing, mac-classic]
tags: [vintage-computing, mac-classic]
---

Here is a collection of many useful things I learned from my visit
to 68kMLA.

First of all, this video on discharging a CRT.  Of particular note, it
is a good idea to wear safety glasses whenever working on a classic
Macintosh, due to the exposed CRT tube posing a risk of implosion if
it is damaged.  Another useful point of discussion is the question of
using a bleeder resistor in the discharge cable.  Initially, Apple
officially used a bleeder resister in the discharge cable, but due to
technician feedback that they preferred to use without a bleeder
resistor so that they could hear the audible crackle from the spark,
their later design did not feature a bleeder resistor.

But, my opinion, if you hear the audible crack, that can also cause
oxidation on the connector ends, and maybe that is wear and tear that
you would prefer to do without.

Also, good news, that later Macintosh models such as the Macintosh SE
have a bleeder resistor connected to the CRT to discharge it when the
system is powered off.  Nevertheless, sometimes that bleeder resistor
can fail, in which case it is safer to practice the CRT discharge
technique regardless.

20191214/https://68kmla.org/forums/index.php?/topic/58417-discharging-a-crt-video/

<!-- more -->

This is an awesome post on a Macintosh SE restoration.  Very
insightful for me who is less experienced with taking apart the
Macintosh SE.  In particular, this is what I need to know for a
SCSI2SD upgrade.  In order to get at the drives, you must remove both
the motherboard and the analog board.  Then you can unscrew the drive
assembly and remove that.  No need to remove the rear chassis
component or the CRT monitor, but of course be careful around the CRT
monitor.  Weight balance or clamping permitting, you might wnat to
stand up the disassembled Macintosh SE upright when removing the
drives so that they cannot fall forward into the CRT and damage it.
Then you want to slide out the assembly from the side of the analog
board, and it's out!  Also, during these stages, it may be a best
practice to remove the circuit board from the back of the CRT so that
you don't risk breaking it's neck if you bump into it.

20191214/https://68kmla.org/forums/index.php?/topic/58262-macintosh-se-restoration/

Cool method for adding Wi-Fi to a Macintosh SE.  How is it done here?
An existing vintage Ethernet card is used, and a tiny microcontroller
bridges from Ethernet to Wi-Fi.  Then, for the finishing touches, a
custom PDS face plate is made buy buying sheet aluminum, cutting it,
and bending it into shape.  The old PDS ports are mounted on one end,
the new Wi-Fi antenna comes out the other end.

20191214/https://68kmla.org/forums/index.php?/topic/31078-adding-wi-fi-to-my-mac-se30/

Also, that's good advice if you want to make your own PDS face plate
to cover the hole when removing an existing PDS card.

Wishing for a modern Ethernet solution for your Macintosh SE?  Maybe
something that goes through SCSI?  Well, the possibility has been left
open by the designer of SCSI2SD for V6, by adding a pin header that
can be used for expansion, and also adding USB support.  Oh, about the
pin header for expansion, that also leaves open the possibility of
adding another unit to generate vintage-style hard drive noises, which
of course are markedly lacking from the original SCSI2SD.

Also, there is a version of "noisy disk" aimed at the emulation of
5.25 floppy disk noises.  Sort of, a simple relay is used to generate
the noise.

20191214/https://68kmla.org/forums/index.php?/topic/56914-ethernet-via-scsi2sd-v6/  
20191214/https://68kmla.org/forums/index.php?/topic/30598-how-about-this-old-hard-drive-sounds-emulator/  
20191214/https://www.bigmessowires.com/2019/06/25/introducing-noisy-disk/

Here is a better article on configuring serial Internet on modern
Unix-like systems, especially Raspberry Pi.  There are a few peculiar
hoops that you must jump through to get things working that was not
mentioned in some of the older articles.

20191214/https://68kmla.org/forums/index.php?/topic/54013-connecting-old-macintosh-to-the-net-using-serial/&
