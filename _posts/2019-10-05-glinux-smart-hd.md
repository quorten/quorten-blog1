---
layout: post
title: "Get hard disk metadata on GNU/Linux"
date: 2019-10-05 11:30 -0500
author: quorten
categories: [unix]
tags: [unix]
---

After playing around with SCSI `INQUIRY` on a classic Macintosh, I
became aware of an important omission of mine when doing backups and
hardware inventories on newer PCs.  Who was the hard disk drive
vendor?  What was the model number, serial number, and other SMART
metadata associated with the _drive_ itself, rather than just the disk
controller?  Ah, yes, surely GNU/Linux systems have some easy commands
for retreiving this information, and indeed they do.

```
sudo hdparm -I
sudo lshw -class disk -class storage
sudo smartctl -d ata -a -i /dev/sda
```

Please note that `smartd`/`smartctl` is not installed by default on
many modern Debian/Ubuntu-based systems.  Which means likewise, you
may have trouble finding that utility on historic systems too.

```
sudo apt-get install smartmontools
```

20191005/DuckDuckGo linux show hard disk info  
20191005/https://www.cyberciti.biz/faq/find-hard-disk-hardware-specs-on-linux/  
20191006/https://www.cyberciti.biz/tips/monitoring-hard-disk-health-with-smartd-under-linux-or-unix-operating-systems.html
