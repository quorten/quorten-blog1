---
layout: post
title: "Using `gparted` on a loop device disk image file"
date: 2020-09-19 10:20 -0500
author: quorten
categories: [unix]
tags: [unix]
---

So, you have a disk image file, and you want to make some partition
modifications to prep it before copying to a new hard drive or SSD of
a similar but slightly different size.  How do you do that?  It's
actually very easy, if I just give your the commands.

```
sudo losetup -P /dev/loop0 disk1.img
sudo gparted /dev/loop0
```

So, what does this mean?  First of all, `gparted` can take a device
file, so even though it won't iterate loop device files by default,
you can ask it to operate on loop device files specifically.  Second,
you can specify the `-P` option to force the kernel to create
partition device files for each partition in the loop-mounted disk
image.  I should have known this one earlier, this is a much easier
way to loop-mount partitions from a disk image file.

`partprobe` can be used to refresh the partition table and partition
device files for physical drives, but it doesn't work for loop
devices.

<!-- more -->

20200918/DuckDuckGo gparted loop device  
20200918/https://superuser.com/questions/103508/do-ntfsresize-and-gparted-work-on-a-disk-image-mounted-through-the-loop-device#103544  
20200918/DuckDuckGo mknod loop device  
20200918/https://unix.stackexchange.com/questions/98742/how-to-add-more-dev-loop-devices-on-fedora-19#198637  
20200918/https://stackoverflow.com/questions/1419489/how-to-mount-one-partition-from-an-image-file-that-contains-multiple-partitions  
20200918/DuckDuckGo make disk image file appear as multiple partitions  
20200918/DuckDuckGo linux make disk image file appear as multiple partitions  
20200918/https://unix.stackexchange.com/questions/342463/how-to-mount-multiple-partitions-from-disk-image-simultaneously  
20200918/DuckDuckGo kernel rescan partition table loop device  
20200918/https://www.cyberciti.biz/tips/re-read-the-partition-table-without-rebooting-linux-system.html
