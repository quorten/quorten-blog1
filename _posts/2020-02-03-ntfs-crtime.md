---
layout: post
title: Read NTFS creation date from GNU/Linux
date: 2020-02-03 04:41 -0600
author: quorten
categories: [windows, unix, important]
tags: [windows, unix, important]
---

Important!  How do you read NTFS file creation dates from GNU/Linux?
Assuming your running on an old Linux kernel version, the only way to
do this is to use the `ntfsinfo` NTFS attribute read utility program.

```
sudo ntfsinfo -f -F "your/full/path/name.txt" /dev/loop0
```

Then you look for the "File Creation Time" attribute.

20200203/DuckDuckGo linux get ntfs file creation date  
20200203/https://unix.stackexchange.com/questions/87265/how-do-i-get-the-creation-date-of-a-file-on-an-ntfs-logical-volume

If you are using a newer version of ntfs-3g, you can use `getfattr` to
get the extended attribute that is set for creation time.  And if you
are using a really new Linux kernel version and all, maybe you can
even get this information directly from an `ls` listing, asking for
creation times to be displayed.
