---
layout: post
title: EFI Boot Manager tricks
date: 2020-12-22 21:15 -0600
author: quorten
categories: [unix, centos]
tags: [unix, centos]
---

Want to be able to remotely, non-interactively reboot a computer from
an operating system installed on one disk or partition to another?
With legacy BIOS boot, GRUB, and chainloading, this is easy: simply
set the GRUB as your universal boot decision point, and you can change
which menu entry is the default for boot.  Yeah, sure, this works if
you want to permanently make a change... but what if you only want to
temporarily boot into one operating system, and on next boot after,
boot to your main operating system?  Well, there must be a way using
grubenv and scripting, but that is a tricker proposition.

The latter case is especially useful if you think you might boot into
an operating system in a potentially bad configuration, then need to
use a watchdog timer to force a reboot into your known good operating
system.

But, that is only partially to the main point of this blog article.
How do you do this with UEFI?  At first sight, UEFI looks to throw a
monkey wrench in the way of the old standard, it's much trickier to do
bootloader chainloading with EFI boot.  It's actually quite simple
once you look into the details.  EFI has primitives to support
everything you could want here directly.  Because you can edit EFI
variables from within the booted operating system, you do not need
physical access to the machine to mess around in the "BIOS
configuration" screens.

<!-- more -->

If you want to make a permanent change to which operating system is
booted by default, you edit the BootOrder variable to place your
preferred operating system (or bootloader, for that matter) in front.
But, if you want the case where you only want to try booting into a
different operating system for one boot, then automatically switch
back to the default operating system for subsequent boots, you set the
BootNext variable.

So, if you were getting cold feet about chainloading in UEFI boot,
rest assured, it is easy enough to accomplish exactly what you want
with EFI directly.

The `efibootmgr` command is the name of the game.  Check out its man
page for details.

Ah, yes, returning to the question about how to do BootNext it with
GRUB.  Edit your `grub.cfg` to set `GRUB_DEFAULT=saved`, then use the
command `grub-reboot $1` to set your default GRUB boot entry for the
next boot only.  Other items of interest: the setting
`GRUB_SAVEDEFAULT=false` and the command `grub-set-default`.  Another
name is `grub2-once`.

20201223/DuckDuckGo grub set temporarily next boot  
20201223/https://askubuntu.com/questions/574295/how-can-i-get-grub2-to-boot-a-different-option-only-on-the-next-boot  
20201223/https://wiki.debian.org/GrubReboot
