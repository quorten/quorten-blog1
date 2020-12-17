---
layout: post
title: Lowdown on UEFI boot and Linux
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
administering and configuring UEFI with a Linux-based system.

First of all, let's discuss installer images.  The CentOS 8 installer
will not allow you to create GUID Partition Tables unless it is UEFI
booted.  By default, it is indicated as UEFI bootable via an MBR with
an ESP, which means it must be written to an optical disc for UEFI
boot.  Although there is also a GPT, it does not properly indicate the
ESP partition.  And besides, most GPT tools expect the protective copy
of the GPT to be at the end of the disk, not some other random
location.

Fortunately, conversion to a bootable USB stick is easy.

1. Copy the ISO image to the USB stick via `dd`.  Make sure you save
   another copy of the first 512 byte sector for future reference.

   ```
   USBSTICK=/dev/sdb
   sudo dd bs=1M if=CentOS-8-boot.iso of=$USBSTICK
   dd bs=512 count=1 if=CentOS-8-boot.iso of=mbr.img
   ```

2. Open the disk image with `gdisk` and instruct it to convert the MBR
   to the GPT, ignoring the existing GPT.  `gdisk` is an interactive
   command-line utility, follow the prompts, then type `w` to write
   the changes to disk and answer "yes" that you are sure.

3. Copy the 446 bytes of boot code from the old MBR back to the new
   protective MBR.

   ```
   sudo dd bs=512 count=1 if=$USBSTICK of=new.img
   dd conv=notrunc bs=1 count=446 if=mbr.img of=new.img
   dd bs=512 count=1 if=new.img of=$USBSTICK
   # Cleanup:
   rm new.img mbr.img
   ```

Now you're destination USB stick should be bootable both with legacy
BIOS boot and UEFI boot.  This will make installing partitioning
either as MBR or GPT a breeze: simply change how you boot the CentOS
installer.

----------

Unfortuantely, CentOS 7 and CentOS 8 have a defect after you finish
installing from UEFI boot: the GRUB x86-64 EFI boot modules are
missing from the installation.  Install them manually as follows:

```
sudo yum -y install grub2-efi-x64-modules efibootmgr
```

20201210/Google error: /usr/lib/grub/x86_64-efi/modinfo.sh doesn't exist.  
20201210/Google EFI variables are not supported on this system.  
20201210/https://unix.stackexchange.com/questions/574170/grub2-install-error-modinfo-sh-missing-common-solutions-attempted

Note, also, that the CentOS 8 installer has a defect that it doesn't
allow you to create a BIOS boot partition to support legacy BIOS boot
on GPT.  You can create this manually in the `parted` command line.
Keep in mind, however, that due to GRUB limitations, you must create
this partition reasonably close to the beginning of the disk or else
it will not work.  For this reason, it is easiest to use `parted` to
create the partition before you install CentOS, and simply instruct
the CentOS installer to leave that partition be.  When the GRUB
bootloader is installed, `grub2-install` will automatically identify
and initialize that partition with boot code to support legacy BIOS
boot.  Here's an example command line:

```
parted /dev/sda mkpart bios-boot fat32 1MB 2MB
```

GRUB only needs ESP to be 1 MB, since it is just a stub that loads the
rest.  BIOS boot partition only needs 32 KiB, but make it 1 MB for
good measure.

----------

It is also possible to convert an MBR disk to GPT in-place and install
the GRUB EFI bootloader after-the-fact.  Be forewarned, however, that
this is very tricky.

20201210/Google convert mbr to gpt  
20201210/Google linux convert mbr to gpt in-place  
20201210/https://serverfault.com/questions/963178/how-do-i-convert-my-linux-disk-from-mbr-to-gpt-with-uefi

20201210/Google grub install gpt partition  
20201210/https://superuser.com/questions/903112/grub2-install-this-gpt-partition-lavel-contains-no-bios-boot-partition  
20201210/Google grub install efi boot  
20201210/https://askubuntu.com/questions/831216/how-can-i-reinstall-grub-to-the-efi-partition

Run all these commands as root.

```
# First, we assume the existing disk layout looks something like this:
# 1 1074MB /boot  ext4
# 2 8.5GB  /      ext4
# 3 8GB    /home  ext4
# 5 4GB    swap

# Note that LVM is not in use, this will make your life so much
# easier.  If you are using LVM, that makes things more complicated.

# Convert from MBR to GPT.
sgdisk -g /dev/sda
# PLEASE NOTE: Until you reinstall the bootloader, your system is
# unbootable!

# Shrink /boot filesystem to 940 MiB, as measured in 4KiB blocks.
resize2fs /dev/sda1 $((940 * 1024 / 4))
# Shrink /boot partition to 1GB.
parted /dev/sda resizepart 1 1000MB
# Create the 1MB BIOS boot and 16MB EFI boot partitions.
parted /dev/sda mkpart bios-boot fat32 1002MB 1003MB
parted /dev/sda toggle 4 bios_grub
parted /dev/sda mkpart efiboot fat32 1004MB 1020MB
parted /dev/sda toggle 6 boot
partprobe

# Cleanup any files erroneously in `/boot/efi`, format, update
# `/etc/fstab`, mount the efiboot partition.
rm -rf /boot/efi
mkdir -p /boot/efi
mkfs -t vfat /dev/sda6
echo /dev/disk/by-partlabel/efiboot /boot/efi vfat defaults 0 2 >>/etc/fstab
mount /boot/efi

# Important!  Make sure you regenerate your `initramfs` after all this
# partition manipulation, especially if you're using LVM, or else you
# could easily end up with a partially unbootable system!
dracut --regenerate-all --force

# Install required packages and update the bootloader.
yum -y install grub2-efi-x64-modules efibootmgr
# Note that we must specify `--target` explicitly because it defaults
# to `i386-pc`.
grub2-install --target=x86_64-efi /dev/sda
grub2-mkconfig >/boot/grub2/grub.cfg

# PLEASE NOTE: You will get warnings and not be able to update EFI
# vars at this point because we did not boot with EFI yet.

# Copy to default EFI boot filename so that we can boot with EFI for
# the first time.
mkdir -p /boot/efi/EFI/BOOT
cp -p /boot/efi/EFI/centos/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI

echo Double check your configuration and reboot.
echo Within EFI, you must run the bootloader install command again
echo so that EFI vars can be set to update the EFI boot menu.
echo
echo grub2-install --target=x86_64-efi /dev/sda
```

Regarding LVM.  If you almost brick...

If you get stuck at the recovery console before switch_root, do
something like this:

```
mount /dev/dm-3 /sysroot
^D
```

Then in CentOS semi-booted recovery console, first run:

```
vgscan --mknodes
```

Now, immediately regenerate your `initramfs` to prevent this from
happening again.

```
dracut --regenerate-all --force
```

Other random web notes say...

```
vgchange -a y vgname...
```

----------

One last helpful tip, if you are cloning ext2/3/4 partitions but need
them to have unique UUIDs for the sake of finding the right ones at
boot, that is an easy fix:

```
tune2fs /dev/sda1 -U `cat /proc/sys/kernel/random/uuid`
```

To create more loop devices if you need them on CentOS/Fedora:

```
# To create /dev/loop4:
mknod -m 0660 /dev/loop4 b 7 4
```

20201210/Google losetup create new loop device as needed  
20201210/https://unix.stackexchange.com/questions/98742/how-to-add-more-dev-loop-devices-on-fedora-19

----------

Finally, a few more miscellaneous links.

20201210/Google parted unix bios boot flags  
20201210/https://unix.stackexchange.com/questions/325886/bios-gpt-do-we-need-a-boot-flag
20201210/https://bbs.archlinux.org/viewtopic.php?id=168580
