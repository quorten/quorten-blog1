---
layout: post
title: "Ensuring systems are remotely accessible with watchdog timers
        and bootloaders"
date: 2020-12-22 21:44 -0600
author: quorten
categories: [home-network, raspberry-pi, reiterate]
tags: [home-network, raspberry-pi, reiterate]
---

I have written many times about watchdog timers, here I want reiterate
all the important points that need to be properly implemented in
regard to watchdog timers to ensure that systems are remotely
accessible.  Again, I reiterate, because this is important!

The idea, the primary goal here is to have a software setup that is
robust enough to eliminate the need to have physical access to the
computer in question in the event that problems occur and need to be
fixed.  Another goal is to be able to do so entirely through software
using the conventional communications stack of a sophisticated booted
operating system, without the need for adding special hardware to
enable a reliable remote admin console.  The practical means to this
end entails the following requirements:

<!-- more -->

* There must be a hardware watchdog timer.  The primary purpose of
  this is to recover from kernel panics, user mode execution time
  starvation caused by excessively busy kernel threads, and general
  system freezes.  The watchdog timer forces a reboot to bring the
  software system back into a known good state.

* Additionally, the watchdog timer must be immediately active at
  reboot.  Namely, it should be configured through setting a hardware
  NVRAM/EEPROM register.  This ensures that even if there is a problem
  that causes a system freeze very early in the boot process, that
  will not prevent the later boot step of enabling the watchdog timer.
  Because if that did happen, the system would be stuck in a halted
  state until a manual, physical power cycle.

  If the system is not capable of immediately enabling the watchdog
  timer via an NVRAM/EEPROM register, the next best thing you can do
  is to immediately enable the watchdog timer from within the
  bootloader.

* The watchdog timer must not be automatically disabled on a device
  halt command.  If an "unclean" halt is issued, the watchdog timer
  should be able to reboot the device into a remotely accessible
  state.  This prevents the issue of a failed operating system boot
  issuing an unintended halt command that renders the device
  accidentally inaccessible.

* The question of device power-down deserves special attention.  If
  persistent remote accessibility is a general requirement, somewhere
  in your network you need a device that is always on, responsive to
  remote commands, and never powers down.  But for other devices, you
  can make a compromise.  So long as the device has a tiny always-on
  microcontroller that can detect and respond to wake-on-LAN packets
  to power on the device, and you have your network configured to
  route wake-on-LAN packets to any device, you are ensured full remote
  control.

  In the case you might want to configure a device to never power-down
  by accident, this is where low-level NVRAM/EEPROM configuration
  registers can help.  You could add a register to disable device
  power-down, any attempt to halt the device is translated to a RESET
  interrupt.  It's important to differentiate between power-down
  versus CPU halting to save energy while idle and waiting for
  interrupts.

* Having a simple watchdog timer at runtime is not enough.  You must
  also have another "watchdog" that monitors a remote administrator
  console connection ping.  In the event that the remote administrator
  console cannot ping the system, this watchdog can request that the
  system be restarted in an orderly manner in an effort to bring this
  capability back.  This watchdog process must be tied to the hardware
  watchdog so that if it crashes, the system will be force-rebooted to
  bring it back.

  Depending on external environmental configuration, this watchdog
  might not be enabled by default, but has to be switched on through
  an initial administrator console command.  This really depends on
  your primary hypothesis on lack of remote access.  If you want your
  system to still operate to the best of its abilities even in the
  event of a network partition between the administrator console ping
  device and the target device, and you think your device is pretty
  reliably remote accessible by default, you would have admin console
  connection ping watchdog disabled by default.  But, if you think it
  is likely that your first boot may result in a system that cannot be
  remote accessed, admin console connection ping watchdog would be
  enabled by default.  More on that later.

* If you are making operating system changes where it is possible that
  you could end up getting locked out of remote access to your device
  by a bad configuration... you have a backup plan through a variety
  of fail-safe techniques.

    * The hardware watchdog timer must be enabled by default, and it
      must also remain active on unclean halts.

    * Your destination boot operating system must have a remote admin
      console connection ping watchdog enabled by default.  In the
      simplest case, this is a scheduled reboot that must be disabled
      from the remote admin console.

    * You must have a bootloader and a dual-boot configuration that
      can be used to revert to a known-good operating system
      configuration.

  The trick here is that you set your known good operating system as
  the "default" bootloader entry, but you can also set another
  "BootNext" entry that will only be booted into once on the next
  reboot.  After that, subsequent reboots will pick the default
  bootloader entry.  So, with this setup, you can perform more risky
  OS reimaging tests that may render your system remotely
  inaccessible.  But that's okay, all you have to do is wait until the
  watchdog timeout expires and your system will reboot into the known
  good configuration.  Then you can login, tweak the experimental
  configuration, and try again.  When you have a target configuration
  that you like and is reliable, then you can update the default boot
  entry to your new configuration.

Okay, that last set of ideas sounds really good, but... what if you
have a tiny little wireless router device that doesn't have the space
to store two copies of its operating system boot image?  Well,
assuming you have a network with another, reliable computer with a
static IP, you can still readily implement the backup plan.  On boot
failure, when you need to load the known good operating system
configuration, the bootloader automatically consults the server
computer to fetch a copy of the "good" boot configuration.  It
downloads that into its local flash memory, then reboots into that.

But still... that being said, sometimes in the grand scheme of things,
it truly does pay to build your system to have enough storage space
for a backup boot configuration.

Also, that being said, another ultimate point in hand is that network
boot is extremely important for remote device management.  Usually the
first thing you want your devices to do is to check with a PXE network
boot server (or equivalent) to see if they should perform any special
alternate boot.  If not, they continue booting locally.

But what if you're in the middle of a corporate network and don't have
permissions to setup PXE network boot?  No worries, there's actually a
quite workable solution if your system has enough local storage space
to spare.  Just use the dual boot methodology and remote admin console
connection ping watchdog assurances.  The idea is that when you want
to perform a special administrative boot, you remotely login to your
system, write your boot image to the secondary boot area, and
configure "BootNext" in your bootloader.  This could actually be a
network boot payload, with modifications to hard-code your own server
to contact rather than relying on DHCP for this info.  This buys you
the equivalent of PXE boot, but without the need for admin privileges
over the network.

What if you want to do some risky bootloader updates?  Almost
unilaterally, bootloader update failures require physical access.  For
PCs, usually this just means connecting a different bootable disk,
except in the case of firmware updates.  But for small wireless
routers, it's always the straight firmware update.  If a firmware
update to the bootloader fails, your device is "bricked" and needs to
be opened up to connect a memory programmer directly to the
EEPROM/flash chip.

The simple solution for this is to use the same dual-booting feature
for the boot firmware.  You have a very tiny stub that never changes
at the very front of the boot firmware.  This is responsible solely
for providing the dual boot with safe fallback feature.  There's also
another tiny parameter block that follows where the firmware updater
sets the "BootNext" information, it must be a separate flash memory
block.  In the event this gets corrupted by a failed firmware update,
the stub will see there is a checksum failure and respond
intelligently.

In order for the stub to never need to change, the two boot partitions
are fixed in size and address.  So if you need to expand, you need to
program another stub that can jump to variable-sized blocks.  But the
important point here is that you must be able to install a new
firmware image without even touching the old one in any way.

Another thing to consider.  You don't always know in advance which
operating system may be more "risky" to boot, so how do you cope with
this?  Have a successfully booted operating system that received
remote commands successfully communicate back with the bootloader.  If
it fails to communicate back, you automatically try the alternate
operating system, provided that it is a "low risk" option.  If even
this is not true, yes, you are stuck.  So this is actually a situation
that demonstrates it is a smart idea to have three boot options
available.  Two are designated as the "fail-safe" options, with one as
backup in case the other gets corrupted, and one is available for the
"risky" boot option.

A final point worth remembering too.  Often times situations that
cause boot failures are pretty well known and clearly understood.
It's easy to predict these in advance through simulation.  So if you
really must have a system where it is impossible to reconfigure it to
eliminate boot failures that can cause a system to be remotely
inaccessible, then your next best option is to use simulation.
Capture the disk image, try out the changes in a simulation, then if
they work, you can go and do likewise on the physical system.

----------

Some pro-tips on implementing the admin console connection ping
watchdog.

* Ensure that this is implemented using the entire protocol stack for
  a remote admin connection.  Like, if you will SSH and run local
  commands for remote admin, the ping command should also use that to
  send the message.

* In the event that remote ping times out, you can start by just
  attempting to restart the networking services stack in your
  operating system.  Many trivial issues can be solved by doing this.
  If this is a router or the like, it would also be worth checking if
  other communications are still being served and operational as a
  decision factor against doing so.

* If that still doesn't work to bring back system connectivity, then
  you can request an orderly system shutdown.

* When requesting an orderly system shutdown, you want to set the
  watchdog timer to still be enabled but you stop pinging it.  This
  ensures that the shutdown process cannot hang indefinitely, which
  does happen under poor system configurations.  Of course, you're
  going to want to extend the watchdog timeout to the time limit that
  you are willing to wait for a system shutdown.

  From a software development standpoint, if a shutdown is logged as
  started gracefully but did not finish gracefully, probably due to a
  watchdog timer expiration, this is something to investigate and
  repair.

* It's a good idea to setup two device to watch over each other,
  rather than solely having a master and slave arrangement where the
  master is assumed to be perfectly reliable.  Sometimes pings fail
  because the device sending them is recovering from a failure of its
  own.  In this case, you should be able to detect this event and
  disable your own watchdog.  You want to wait until the remote device
  finished rebooting before attempting to reboot yourself to resolve a
  communication failure.

  However, sometimes you do have a machine configuration where the
  master is so reliable it might as well be considered perfect.
  Obviously this needs to be decided on a case-by-case basis.  But the
  best technique is to have data monitoring to dynamically adapt
  should that perfection record suddenly be broken.

----------

So you want to make a stock GNU/Linux system have fail-safe remote
control programming?  That's a tough proposition.  But, here's the
main thing you need to know.  Over time, Linux, and operating systems
in general, have added more and more stages to the boot process.
But. here is the way it works in 2020 for PC distributions.

1. Your computer's boot firmware.

2. The GRUB bootloader.  PLEASE NOTE: The GRUB bootloader itself also
   has something like an `initrd` attached onto the end of itself
   where preloaded modules are stored.  The preloaded modules are
   essential for the filesystem drivers that are needed to access the
   Linux kernel image and `initrd`.  I learned the hard way, if you
   change out GRUB's root filesystem type without updating the
   preloaded drivers in GRUB, you will brick your bootloader and have
   to rerun the `grub2-install` commands fresh.

3. The Linux kernel with the iniital RAM disk.  The initial RAM disk
   is, by all practical[ means, a mini GNU/Linux distribution that
   needs to be managed.

4. Your fully booted GNU/Linux system.

Embedded distributions are much simpler.

1. The boot firmware is one-in-the-same with the Linux bootloader.

2. The fully booted embedded Linux system.

The big point to remember with the PC distribution is that every stage
has its own possibility of failure where it will cop out to a
emergency shell that can only be accessed locally.  By default, it
will then wait for operator input indefinitely.  So, how can you
reconfigure such systems so that they will not wait for input
indefinitely in the case of an error?  Can you do this on systems
without a watchdog timer?  Let's see.

* The fully booted system has a scheduled reboot that must be disabled
  remotely.

* The initial RAM disk has a scheduled reboot to prevent waiting
  indefinitely on failures.

* The GRUB bootloader?  Now that's a tough one.  This might require
  source code modifications so that there is similarly a scheduled
  reboot with a hard time limit.

* The computer's boot firmware, you know the drill.  Just do your best
  to configure it so that boot failures will not happen there, always
  have some bootable disks online.

So as you can see, with conventional PCs, it is challenging to get a
fail-safe remote access setup.
