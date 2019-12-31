---
layout: post
title: Loop mount a partition from a full disk image
date: 2019-04-17 22:47 -0500
author: quorten
categories: [unix]
tags: [unix]
---

There were a few times when I previously only archived the partition
of a disk because I immediately knew how to do loop mounts from just a
partition image.  But, with the added boot sector info, I was at lost
as to how to mount that.  Alas, it is fairly easy to loop mount one
partition of a disk image, here's how.  (For sure this works with MBR
partitioning, additional methods might be needed for GPT
partitioning.)

```
fdisk -lu sda.img
sudo losetup -ro `echo $SIZE \* 512 | bc` /dev/loop0 sda.img
sudo mount -o ro /dev/loop0 /mnt/view/
```

20190417/loop mount partition from full disk image  
20190417/https://askubuntu.com/questions/69363/mount-single-partition-from-image-of-entire-disk-device  
20190417/https://askubuntu.com/questions/22743/how-do-i-install-guest-additions-in-a-virtualbox-vm
