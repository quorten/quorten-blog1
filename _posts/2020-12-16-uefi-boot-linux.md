---
layout: post
title: Philosophical principles of UEFI boot and Linux
date: 2020-12-16 20:01 -0600
author: quorten
categories: [unix, centos]
tags: [unix, centos]
---

UEFI boot... ah, yes, the modern way of booting PCs.  A reasonably
sophisticated and professional boot standard, originating from
Macintosh precursor technology like Extensible Firmware Interface
(EFI) and Apple Partition Map (APM) is now brought to the PC world.
UEFI boot and GUID Partition Table is glorious... or is it?

It's not, unfortunately.  Hindsight is 20/20.  The reason why the
sophisticated and modern boot standards worked so well on the
Macintosh was because there was only one manufacturer of that kind of
computer hardware.  But, in the PC world, when you have many different
manufacturers, each designing their own boot firmware, every little
bit of complexity you add to the boot standard simply adds more margin
of error.  The "U" for "unified" does, in fact, give a head nod that
it might be an oxymoron, and it indeed is!

If you want a sophisticated and complex standard of any kind, there
must be only a single implementor in some sort of way, shape, or form,
especially in the case of boot standards.  Unlike web browsers,
bootloaders are a very unattractive area of software development for
rapid addition of features and enhancements.  Matter of fact, quite
the opposite: stasis is viewed as a feature in pre-operating-system
computer boot.  Traditionally, there was always very little to no
information about bootloaders from third party sources, and UEFI is no
different in that regard.  If you want to learn about the boot
sequence, there is pretty much only a very small number of technical
reference documents that must be read in full.  A search engine will
not afford you any shortcuts here.

<!-- more -->

----------

So, anyways, now that the long introduction is out of the way, let's
delve down into the devil in the details.  The first thing you need to
know about UEFI boot is that it requires a GUID Partition Table (GPT)
on disk as the partitioning scheme, rather than Master Boot Record
(MBR) and Extended Boot Record (EBR).  So, get ready to look at tech
specs.

20201216/https://en.wikipedia.org/wiki/GUID_Partition_Table  
20201216/https://en.wikipedia.org/wiki/Master_boot_record  
20201216/https://en.wikipedia.org/wiki/Extended_boot_record

The primary definition of MBR is simple: The first 512-byte sector is
fetched into RAM from the disk.  The last two bytes (address 0x01fe
and 0x01ff) of the sector are checked if they are the values 0x55 and
0xaa accordingly.  If so, the boot firmware jumps to the first data
byte to start executing it as code.

The first sector is also assumed to contain a partition table with a
maximum of 4 _primary partitions_.  Each such partition definition is
16 bytes long and appears just before the boot signature at the end,
so in practice there is a maximum of 446 bytes of boot code in the
MBR.

A GUID Partition Table includes a protective MBR as the first sector
of the disk.  The partition table contains a single entry that covers
the entire disk (or as much as can represented via MBR) and uses the
partition type 0xee.  The rest of the 446 bytes of boot code may be
used as-is to support legacy BIOS boot in a backwards compatible
manner, even on a GPT disk.

Okay, so that's easy enough to explain how boot works with MBR. what
about GPT.  The general idea is a rather simple one.  A partition is
marked as bootable, which was also a standard procedure in MBR but not
strictly required.  Additionally, it is also tagged as the EFI System
Partition (ESP).  This partition must be formatted with the FAT
filesystem and it contains one or more executable files.  (These are
actually Windows Portable Executable (PE) object code files, complete
with a DOS executable stub attached in front.)  In the case of
multiple boot executables, the UEFI firmware can generate a menu to
allow the user to pick which file (i.e. which operating system) to
boot, just like the Macintosh computers that came before UEFI.

20201210/Google linux efi boot  
20201210/https://www.zdnet.com/article/linux-on-your-laptop-a-closer-look-at-efi-boot-options/

In the PC world, this feature had to be achieved by using the MBR boot
code as a first stage bootloader to present the menu, and
"chainloading" the second stage by simply fetching the first such
sector and executing it, just like the boot firmware did to the MBR.

But, here is where there is the first devil in the details.
Unfortunately, Microsoft, the primary progenitor of the UEFI standard,
did not think through very clearly how it ought to be implemented.
The course of action of the UEFI standard really just followed
whatever quirks the were in the first versions of Microsoft Windows
that supported it.

So, let's start with the first defect in the standard.  Optical discs
are flagged as bootable in a different way than standard disks are
flagged.  Rather than having a protective MBR partition cover as much
of the disk area as possible and specifying the boot partition in the
GPT, the MBR contains the EFI System Partition (ESP) directly using
partition type 0xef.  Wikipedia claims Intel was the progenitor of
this quirk.

20201210/Google grub install uefi  
20201210/Google grub install uefi partition  
20201210/https://en.wikipedia.org/wiki/EFI_system_partition  
20201216/https://en.wikipedia.org/wiki/Partition_type#PID_EEh

One of the major boons of the old boot standards, MBR, ISO 9660, and
El Torito, was that they had compatible "key holes."  ISO 9660 was
specified not to use the first 32,768 bytes of the disc, so these
bytes could be used to store an MBR bootloader.  An El Torito floppy
disk image could also be stored inside the ISO 9660 filesystem.
Together, this allowed GNU/Linux distributors to create a single
bootable image that worked however you cared to boot your computer:
from a floppy disk, from an optical disc, or from a hard disk drive.
And thanks to the simplicity of PC BIOS for hardware abstraction,
booting simply "just worked," life was good, and life was great.

20201216/https://en.wikipedia.org/wiki/ISO_9660

So, to this very day, GNU/Linux distributors strive to build their
installer disk images to follow a similer vein, though without El
Torito support.

But, UEFI throws a huge monkey wrench in that otherwise beautiful
picture.  With that one tiny wrinkle, the way in which you specify a
disk to be bootable, you must have two different images for
installers, not one "universal" image.

* For installing via optical disc, there must be an MBR with an ESP
  partition.  The GPT, if present, is insignificant because it is
  ignored.  Hence, although GNU/Linux distributions tend to include a
  GPT, it typically has errors.

* For installing via USB flash drive or other standard disk drive, the
  protective MBR and GPT must follow the standard specifications.  If
  there is any deviation from a single protective MBR partition, the
  disk will not be bootable.

The second defect to the standard is the handling of the UEFI boot
menu.  Some manufacturers provide a boot menu that allows selecting
any of the available boot executables, but some of the big, key, main
manufacturers do not.  What did I say about the multiple manufacturers
issue?  The "standard" way out of the UEFI boot menu issue is to
assign to a special name to your boot executable that will be executed
by default, without the need for boot menu selection.  Alas, there
wasn't a firm standard established for this filename either, so it
varies from one manufacturer to the next.  The standard way out of
that issue is to copy your boot executable to every imaginable
"default" filename.  And yes, you must make copies since the FAT
filesystem doesn't support symlinks.

20201210/Bing efibootmgr efi variables not supported  
20201210/https://wiki.archlinux.org/index.php/GRUB/EFI_examples  
20201210/https://wiki.archlinux.org/index.php/Grub#Default/fallback_boot_path

Fortunately, however, in recent years, the main manufacturers have
standardized 64-bit boot to `/EFI/BOOT/BOOTX64.EFI`, case insensitive.

The final defect with the UEFI standard is, again, how boot menus are
handled.  In UEFI, the boot menu must be stored in NVRAM.  It is the
responsiblity of the operating system to manipulate the EFI variables
to add a boot menu entry for itself.  To make matters worse, EFI
variables may not be accessible unless the OS has successfully booted
via UEFI.  And this methodology makes no sense whatsoever for
removable media, such disks must rely on the default boot filenames.

Though this may appear to only be a minor annoyance for operating
system installation, the issue extends further than that.  Typically,
when you want to reimage a computer clean, you just wipe the disk,
right?  Now with UEFI boot, you can't just think about wiping the
disk, you also have to think about wiping the EFI variables in NVRAM.
In classic Macintosh computers, only the selected boot device was
stored in PRAM, the actual boot menu would be generated dynamically by
the boot firmware.  (In later Macintosh computers, this would only be
the default boot selection, and you could use hotkeys at boot to
override this.)

----------

Now, after all that introductory discussion is out of the way, let's
get the final technical rundown of everything you need to know when
administering and configuring UEFI with a Linux-based system.  For the
convenience of those who do not care to read the philosophical
introduction, we will link to separate blog articles.

* [Boot CentOS 8 installer ISO with UEFI to install GPT partitions]({{
  site.baseurl }}/blog/2020/12/17/uefi-centos8)

* [Convert MBR partitions and legacy BIOS boot to GPT partitions and
  UEFI boot]({{ site.baseurl }}/blog/2020/12/17/cvt-mbr-gpt-uefi)

----------

Finally, a few more miscellaneous links.

20201210/Google parted unix bios boot flags  
20201210/https://unix.stackexchange.com/questions/325886/bios-gpt-do-we-need-a-boot-flag
20201210/https://bbs.archlinux.org/viewtopic.php?id=168580
