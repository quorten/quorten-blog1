---
layout: post
title: Workaround for minor issues in CentOS network installer
date: 2020-12-16 20:12 -0600
author: quorten
categories: [unix, centos]
tags: [unix, centos]
---

Weirdly, the CentOS 8 network installer does not detect mirrors
automatically.  No worries, you can just specify it manually in the
installer and everything will "just work" after that.

```
http://mirror.centos.org/centos/8/BaseOS/x86_64/os/
```

Oh, another thing.  When selecting a destination disk to write to,
every disk with installer files/partitions are detected on are removed
from the available destination disks.  So if you have an old installer
on the destination disk, you need to wipe or else it won't show up as
an available option.
