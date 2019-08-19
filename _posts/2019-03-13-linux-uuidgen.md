---
layout: post
title: Generate UUID using Linux procfs
date: 2019-03-13 13:26 -0500
author: quorten
categories: [misc]
tags: [misc]
---

Interesting!  How do you generate a UUID on the Linux command line
without the use of the `uuidgen` program?  Do this:

```
cat /proc/sys/kernel/random/uuid
```

20190313/DuckDuckGo debian generate uuid command  
20190313/https://serverfault.com/questions/103359/how-to-create-a-uuid-in-bash
