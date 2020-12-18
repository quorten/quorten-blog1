---
layout: post
title: "Convert MBR partitions and legacy BIOS boot to GPT partitions
        and UEFI boot"
date: 2020-12-16 23:02 -0600
author: quorten
categories: [unix, centos]
tags: [unix, centos]
---

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

<!-- more -->

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
yum -y install grub2-pc-modules grub2-efi-x64-modules efibootmgr
# Note that we must specify `--target` explicitly because it defaults
# to `i386-pc`.  Also, we must explicitly specify both targets since
# the `x86_64-efi` target does not install the legacy BIOS boot code.
grub2-install --target=i386-pc /dev/sda
grub2-install --target=x86_64-efi /dev/sda
grub2-mkconfig -o /boot/grub2/grub.cfg

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
