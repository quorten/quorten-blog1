---
layout: post
title: Emulator and virtual machine options, audio CD emulation
author: quorten
date: 2018-11-21 13:20 -0600
categories: [random-software]
tags: [random-software]
---

Okay, some notes on emulators and virtual machine options.  First of
all, QEMU is indeed a pretty good all-around choice if you want to
both virtualize and emulate modern computer architectures where the
binary software being executed is predominantly compiled from C/C++.
It's especially good for operating systems designed on modern Intel
x86, x86-64, PowerPC, SPARC32, SPARC64, MIPS, ARM, and RISC-V
architectures, just to name a few.

20181121/https://en.wikipedia.org/wiki/QEMU

So, you're wondering about Compact Disc Digital Audio access under
virtualization?  How do you pack a virtual disc image to include this
data?  Is this feature even supported?  If so, what virtualization
solutions support it?  This is a must-have feature for virtualizing
some 1990s era game software under modern computer hardware.

Unfortunately, the best I can say for this is that virtual machine
solutions in general don't provide support for this.  The main support
for optical discs that they provide is for _data_ optical discs.  The
primary and most common example of such data discs that are used is
exclusively for booting an operating system installation CD.

<!-- more -->

Now, if you want to run Audio CDs under virtualization, basically your
only option is ATAPI CD drive pass-through.  This is a feature that
was long either sketchy or unsupported under many solutions until
relatively recently.  As for the prospect of running a full virtual CD
system, well you have to use some lateral thinking and a little bit of
custom coding to get that prepped, that's my best understanding.
Let's start out with this idea.  CD drives can also be provided as USB
devices.  You can code up another virtual machine that acts as
software "USB gadget" that plugs into the USB bus of your "host"
virtual machine and exposes itself as a "USB CD drive."  Under this
premise, the USB CD drive can therefore respond to ATAPI commands and
send the digital audio data upon request to the target application.

Still, the question of the file format for storing the data is still
at hand.  Well, the best answer I have to that is this.  Since you'll
need to tool your own software to get anything working, you might as
well start by "ripping" the audio CD data off the physical CD and
storing it in a typical file format for ripped audio CD data, then
take the ISO data CD image and ripped audio files and zip them up into
a single ZIP archive.

TODO: Check real USB CD drives on the market and try to verify if they
actually do support Audio CDs.  If they don't, then the whole strategy
of coding up a virtual solution for this is bummed out.

20181121/DuckDuckGo virtual machine cd digital audio  
20181121/DuckDuckGo virtual machine cd digital audio analog  
20181121/DuckDuckGo virtual machine audio cd  
20181121/https://social.technet.microsoft.com/forums/windowsserver/en-US/f275f383-470d-4176-8fdf-d410e4904f75/cant-rip-a-cd-on-virtual-machine  
20181121/https://discussions.citrix.com/topic/332997-attempting-to-attach-a-cd-to-a-virtual-machine-so-it-sees-audio-cds/

For a while, VirtualBox did not support ATAPI passthrough for Audio
CDs, but now it does.

20181121/https://www.virtualbox.org/ticket/3494

Failed search.

20181121/DuckDuckGo virtual ATAPI audio cd vm device  
20181121/DuckDuckGo usb audio cd drive
