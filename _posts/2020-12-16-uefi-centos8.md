---
layout: post
title: Boot CentOS 8 installer ISO with UEFI to install GPT partitions
date: 2020-12-16 23:01 -0600
author: quorten
categories: [unix, centos]
tags: [unix, centos]
---

The CentOS 8 installer will not allow you to create GUID Partition
Tables unless it is UEFI booted.  By default, it is indicated as UEFI
bootable via an MBR with an ESP, which means it must be written to an
optical disc for UEFI boot.  Although there is also a GPT, it does not
properly indicate the ESP partition.  And besides, most GPT tools
expect the protective copy of the GPT to be at the end of the disk,
not some other random location.

Fortunately, conversion to a bootable USB stick is easy.

<!-- more -->

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
the CentOS installer to leave that partition be.

```
parted /dev/sda mkpart bios-boot fat32 1MB 2MB
```

GRUB only needs ESP to be 1 MB, since it is just a stub that loads the
rest.  BIOS boot partition only needs 32 KiB, but make it 1 MB for
good measure.

Note that `grub2-install` will **not** automatically identify and
initialize that partition with boot code, unlike what one of my online
sources said.  Only `grub2-install --target=i386-pc` will initialize
the BIOS boot code, and it will (essentially) fail if the BIOS boot
partition is not present on a GPT disk.  So if you want to support
both UEFI boot and BIOS boot, you must run two `grub2-install`
commands as follows.

```
grub2-install --target=i386-pc $TARGETDISK
grub2-install --target=x86_64-efi $TARGETDISK
grub2-mkconfig -o /boot/grub2/grub.cfg
```

One peculiarity that I have to look further into is that the CentOS 8
installer's UEFI boot is really weird and customized, it's not like
what you get from `grub2-install --target=x86_64-efi`.  Looking
further into sources for this, looks like the additional files come
from a package named `shim` or the like, which is primarily designed
to support Secure Boot but also packs in some fixes for several UEFI
annoyances.

20201217/DuckDuckGo fallback.efi centos  
20201217/https://www.rodsbooks.com/efi-bootloaders/fallback.html
