---
layout: post
title: "My process to migrate a disk image from hard disk drive to
        SSD"
date: 2020-09-19 11:29 -0500
author: quorten
categories: [unix]
tags: [unix]
---

I had one laptop where it was suspected that there may be hardware
issues on the computer.  The laptop still had a spinning disk hard
drive in it that was planned to be replaced with an SSD, but
procrastination pushed that timeline back further than hoped for.
Normally I'd just power on the laptop housing the hard disk drive,
boot to GNU/Linux, and use network copies to assist.  But, finally
getting around to doing this on a late timeline, I had to be extra
cautious compared to normal and take a few extra steps.

So, the plan for archiving the hard disk drive.

I will do a "jukebox copy," copy in four segments at a time, each 190
GiB.

190 * 4 = 760 GiB

That's more than the approximately 640 GiB on the hard disk drive.
Each segment copies to the internal laptop SSD, then we copy to the 6
TB hard drive, accessed via an external USB hard drive enclosure.
That's where we do the final reassembly.  For the sake of safety, each
segment will go to a separate file, then I'll copy to a final combined
file once done.

So, that comes down to using 4 `dd` command lines, as folows.

PLEASE NOTE: Make sure to terminate `gvfs-udisks2-volume-monitor`
while doing source disk copies.  You don't want your disks
auto-mounted and modified when they haven't been completely copied!

<!-- more -->

```
mkdir /media/WORLDIMG/disk_images/hdd/alexia-pc
mkdir ~/virtual/arch-hdd/alexia-pc

HDNAME=/dev/sdb

cd ~/virtual/arch-hdd/alexia-pc

sudo blockdev --getsize64 $HDNAME >sizes.txt

# Switch disks:
killall gvfs-udisks2-volume-monitor
sudo dd conv=sync,noerror iflag=fullblock bs=1M count=194560 skip=0 \
  seek=0 if=$HDNAME of=frag1.img
md5sum frag1.img >>md5sum.txt
# Switch disks:
cp -pi frag1.img /media/WORLDIMG/disk_images/hdd/alexia-pc/
rm -i frag1.img

# Switch disks:
killall gvfs-udisks2-volume-monitor
sudo dd conv=sync,noerror iflag=fullblock bs=1M count=194560 skip=194560 \
  seek=0 if=$HDNAME of=frag2.img
md5sum frag2.img >>md5sum.txt
# Switch disks:
cp -pi frag2.img /media/WORLDIMG/disk_images/hdd/alexia-pc/
rm -i frag2.img

# Switch disks:
killall gvfs-udisks2-volume-monitor
sudo dd conv=sync,noerror iflag=fullblock bs=1M count=194560 skip=389120 \
  seek=0 if=$HDNAME of=frag3.img
md5sum frag3.img >>md5sum.txt
# Switch disks:
cp -pi frag3.img /media/WORLDIMG/disk_images/hdd/alexia-pc/
rm -i frag3.img

# Switch disks:
killall gvfs-udisks2-volume-monitor
sudo dd conv=sync,noerror iflag=fullblock bs=1M skip=583680 \
  seek=0 if=$HDNAME of=frag4.img
md5sum frag4.img >>md5sum.txt
# Switch disks:
cp -pi frag4.img /media/WORLDIMG/disk_images/hdd/alexia-pc/
rm -i frag4.img
```

Use this command to determine progress:

```
kill -s INFO $DD_PID
```

Done!

Now, to reassemble to a single disk image.

```
dd conv=notrunc iflag=fullblock bs=1M seek=0 if=frag1.img of=combine.img
dd conv=notrunc iflag=fullblock bs=1M seek=194560 if=frag2.img of=combine.img
dd conv=notrunc iflag=fullblock bs=1M seek=389120 if=frag3.img of=combine.img
dd conv=notrunc iflag=fullblock bs=1M seek=583680 if=frag4.img of=combine.img
```

UPDATE: Please no, not if you have a slow hard disk drive.  Copying
these big files.  Rather, do a two-part round trip, first copy to your
fast SSD, then copy back again to your HDD.  It will save you so much
heck.  Also note, since no disk switching is required, this can all be
scripted.

```
cd ~/virtual/archi-hdd/alexia-pc
cp -p /media/andrew/WORLDIMG/disk_images/hdd/alexia-pc/frag1.img .
dd conv=notrunc iflag=fullblock bs=1M seek=0 if=frag1.img \
  of=/media/andrew/WORLDIMG/disk_images/hdd/alexia-pc/combine.img
rm frag1.img
cp -p /media/andrew/WORLDIMG/disk_images/hdd/alexia-pc/frag2.img .
dd conv=notrunc iflag=fullblock bs=1M seek=194560 if=frag2.img \
  of=/media/andrew/WORLDIMG/disk_images/hdd/alexia-pc/combine.img
rm frag2.img
cp -p /media/andrew/WORLDIMG/disk_images/hdd/alexia-pc/frag3.img .
dd conv=notrunc iflag=fullblock bs=1M seek=389120 if=frag3.img \
  of=/media/andrew/WORLDIMG/disk_images/hdd/alexia-pc/combine.img
rm frag3.img
cp -p /media/andrew/WORLDIMG/disk_images/hdd/alexia-pc/frag4.img .
dd conv=notrunc iflag=fullblock bs=1M seek=583680 if=frag4.img \
  of=/media/andrew/WORLDIMG/disk_images/hdd/alexia-pc/combine.img
rm frag4.img
```

Now that that's finally done, we can loop-mount this disk image, using
the `-P` option to create device files for each partition, and use
`gparted` to resize the partitions so that the result can fit on our
new, slightly smaller SSD.  After all, we didn't pack this to maximum
capacity.

```
sudo losetup -P /dev/loop0 \
  /media/andrew/WORLDIMG/disk_images/hdd/alexia-pc/combine.img
sudo gparted
sudo losetup -d /dev/loop0
```

Actually, small change of plan, see the following discussion.

Disk image size: 640135725056.  Now this is too big, we need to drop
down to 500 GB... base 1000 is the measure used to rate the SSD at 500
GB, minus 10 GiB more again to be on the safe side.

Number of bytes we need to shrink, add 10 GiB to shrink to be on the
safe side.

150873143296

Size to shrink in base 1024 mebibytes (MiB), like the Windows disk
manager likes it:

143883.841797

Round up to be on the safe side:

143884

And it's a pass!  We have enough free space on the main partition, and
the Windows disk manager allows me to shrink by this size without
issue of unmovable files.  We used the Windows 10 disk manager just to
make sure there isn't anything funny going on that would get messed up
by using GNU/Linux tools, especially older versions therein.

Now, for the final copy to the new SSD.  In this case, we will
complete the copy over the network using the new SSD from within
`alexia-pc`.  `netcat` is used to manage the network copying on the
software side.  So, this is how it's done.

First, plug in an Ethernet cable and PXE network boot `alexia-pc` into
a Knoppix or Ubuntu "live CD."  This assumes you already have a PXE
network boot servver setup on your network, and unfortunately they are
not as easy to setup as they could or should be.  If you don't, you
can use a Ubuntu live USB stick boot instead.

Next, run this command on `alexia-pc`:

```
sudo su
nc -l 4444 | dd iflag=fullblock conv=sync,noerror bs=1M of=/dev/sda
```

Determine `<DESTINATION IPv4>` by running `ip addr` on `alexia-pc`.
Then, look for the IP address of the Ethernet interface, it's
typically a device named `enpXXX` or something like that.

Now, run this command on your computer hosting the hard disk image.

```
cd /media/andrew/WORLDIMG/disk_images/hdd/alexia-pc
dd iflag=fullblock conv=sync,noerror bs=1M combine.img if=combine.img | \
  nc <DESTINATION IPv4> 4444
```

Since this laptop only had 100 Mbps Ethernet, not Gigabit, the
transfer speed was 12 MB/sec, so this ended up taking about 11 hours
to complete.  But, after that, the system booted just fine into
Windows 10 on the new SSD and it was all ready to go!
