---
layout: post
title: Bootloaders and Device Tree
date: 2017-11-21 21:00 -0600
author: quorten
categories: [unix, raspberry-pi]
tags: [unix, raspberry-pi]
---

Bootloaders.  Okay, so let me try to organize.

First of all, let's talk features.

* The lowest level of manipulating a computer is a "front-panel
  control switch" or similar.  In the case of more complicated
  microcomputers, this is typically a "monitor program" that provides
  serial console access to a command-line based user interface to do
  the most important things that you can do from a front-panel control
  switch.  Namely, reading memory locations, writing memory locations,
  and executing memory locations.

* Next up is the availability of a _built-in programming language_.
  This is typically a very simple programming language such as BASIC
  or FORTH.  A built-in programming language provides an easier
  alternative to programming a computer than typing in hex bytecodes
  of machine instructions.

* Next up is an interface to load programs from disks or network
  interfaces.  Strictly speaking, this can be called a "bootloader."

* Next up is a software program that can configure hardware settings
  that would traditionally be set via physical hardware jumpers.  This
  historically called "BIOS configuration."

<!-- more -->

So, how does this all fit together?  It's complicated.  In the end,
there are many different ways you can start up a computer.  However,
one thing is for sure: with so many choices, a _menu system_ is
imperative to aid in discoverability.  This may be as simple as
printing a list of choices and prompting the user to type the number
of one on a command line, or it can be more elaborite with a 2D
terminal user interface with keyboard navigation or even a graphical
user interface with mouse and keyboard support.  (Additional graphical
pointing devices can also be supported.)

* Vestigial
    * Apple II:
        * "Boot loader": Apple II Monitor
        * Boot language: BASIC

* PC
    * Lowest level: Coreboot.  Payloads:
        * BIOS routines: SeaBIOS
        * "Monitor" program: U-boot
        * Boot language: OpenFirmware (Forth)
        * UEFI
        * PC BIOS configuration program
            * PC BIOS boot selection

* Embedded
    * RedBoot
    * U-boot

Yeah, something like that.  It can be quite complicated.  It's hard to
keep things sorted out when there are so many new ways of adding
complexity.

Oh yes, and you can install U-boot for the Raspberry Pi.  Of course
this is a much needed addition when you need an alternative to PXE
boot not being supported.

20171121/DuckDuckGo raspberry pi uboot  
20171121/https://elinux.org/RPi_U-Boot  
20171121/https://en.wikipedia.org/wiki/Das_U-Boot

Device Tree?  Support for this is mandatory on all new ARM boards.
That is good to know.  What is not good to know is that Raspberry Pi
uses a non-standard boot mechanism regardless.

20171121/https://en.wikipedia.org/wiki/Device_tree

This comparison of bootloaders is not as fruitful as I would have
thought it to be.

20171121/https://en.wikipedia.org/wiki/Comparison_of_boot_loaders  
20171121/https://en.wikipedia.org/wiki/Barebox

Yes, indeed, U-boot can be used to support PXE boot.

20171121/DuckDuckGo u-boot pxe boot  
20171121/https://github.com/lentinj/u-boot/blob/master/doc/README.pxe

Oh, yeah, and don't forget that "matchbox" boot thing.

20171121/https://coreos.com/matchbox/docs/latest/

So what exactly is `matchbox`?  Basically, it is a PXE server with
provisions to match machines to images.  Yeah, so a PXE server that
puts image selection on the server side rather than the client side as
with menu selection systems.

* Okay, great!  That's just what we needed to simplify network booting
  on a multi-arch network.
