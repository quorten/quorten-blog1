---
layout: post
title: RTC chip showdown
date: 2020-11-12 21:56 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Raspberry Pi real-time clocks?  Now, this is an area that is near and
dear to my heart... mainly because I created an AVR firmware that
replicates the functionality of the original Macintosh RTC chip.  It
provides both the clock function and memory.  So, why can't you do the
same with Raspberry Pi?  If you are designing a Raspberry Pi HAT, you
should also be able to use just a single chip connected to a serial
bus that provides for both clock and data.  Namely, in the case of
HATs, the ID EEPROM is connected to an I2C serial bus.  Why not also
expose your RTC function over the same I2C bus?

Sure, I'd want to reuse my firmware that I've already written, but
alas, in case that idea is touted as "too hacky" in a larger group
project, I need some alternatives.  Okay, let's go looking.  Is there
a good I2C RTC chip that also includes an embedded EEPROM function?
There is... but not in the exact format that is expected by Raspberry
Pi.  These chips use I2C major address `0b1010`, subaddress `0b111`.
Raspberry Pi expects `0b000`.  So, they are no-can-do without
Raspberry Pi bootloader modifications, alas that's proprietary code
territory right in there, and I'm not seeing hints in the Device Tree
blob used at boot.

The first chip option only has 150 bytes of EEPROM, the second has 512
bytes of EEPROM.  Alas, the first is much cheaper, more available, and
better supported by Raspberry Pi Device Tree Overlays, the second has
a Linux driver but not Raspberry Pi Device Tree Overlays.

<!-- more -->

20201112/https://www.digikey.com/en/products/detail/microchip-technology/MCP79410T-I-SN/2486436  
20201112/https://www.digikey.com/en/products/detail/renesas-electronics-america-inc/ISL12026AIBZ/2000523

Searching around further, here is another lead.  DS3231 or MCP79400?
DS3231 ended up being preferred for one product because it has
superior accuracy.  However, looking on Digi-Key, it also has superior
cost and inferior stocking/availability.

20201112/https://www.switchdoc.com/ds3231-real-time-clock-module/

I'd say the MCP794* series products are the all-around winner and best
choice.

So, that's the lowdown on Raspberry Pi RTC chip options.  That being
said, if you do decide to go the AVR route, the MCP794* series would
be an excellent interface to emulate, yeah I do have my Apple RTC
firmware but that would possibly require writing new Linux drivers.
The biggest thing I'd change about the MCP794* series, of course,
would be to make its EEPROM 100% compatible with Raspberry Pi HAT
loading expectations.

----------

Related to this conundrum, stacking HATs?  Ah, interesting, some HATs
are explicitly designed for this, but if you do this with a HAT that
has an EEPROM, your Pi will freeze at the rainbow boot screen.  Why?
The conflicting EEPROM chips are to blame, but the issue is that when
the Raspberry Pi bootloader encounters this, it's not smart enough to
recover, so it just locks up.

20201112/DuckDuckGo when does id eeprom get probed boot raspberry pi  
20201112/https://spellfoundry.com/2020/09/19/raspberry-pi-rainbow-screen-of-death-how-to-stack-multiple-hats-and-avoid-disaster/

Well, point in hand, at least it looks like there's some buy-in for
the Raspberry Pi Foundation to change the rules of HATs so they are
not confined to a single ID EEPROM address.  If that buy-in did
surface, then the combined RTC and ID EEPROM design could be a
reality, without needing to invoke an AVR to fit the Raspberry Pi's
hacks.
