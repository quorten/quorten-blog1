---
layout: post
title: "How to unset \"manually installed\" on an apt package"
date: 2020-02-29 12:07 -0600
author: quorten
categories: [unix]
tags: [unix]
---

So you've done an `apt-get install` on a package that was already
automatically installed.  What if you don't want to uninstall it, but
simply remove the "manually installed" mark?  The solution is simple:

```
apt-mark auto zlib1g-dev
```

20200229/DuckDuckGo dpkg unset manually installed  
20200229/https://serverfault.com/questions/87933/how-to-remove-the-installed-manually-flag-and-revert-to-automatically-install
