---
layout: post
title: Relearning the XDG standard for dot-files
date: 2019-02-05 12:38 -0600
author: quorten
categories: [twitter, random-software]
tags: [twitter, random-software]
---

The XDG Free Desktop standard for dot-files and various other
application data?  Unfortunately, I've learned that this knowledge is
still not very widely diffused throughout the Unix developer
community, and it still takes quite a bit of effort amongst community
members to continue to diffuse the knowledge.  So, there is some
redundancy among new blog authors writing new blog articles to educate
others on the subject, and at least it appears to be gaining some
momentum.

In Python, the cross-platform module to use is `appdirs`.  Golang also
has an `appdirs` module.  Mac OS X's equivalent of the XDG dot-files
storage location is `~/Library`.

20190205/https://0x46.net/thoughts/2019/02/01/dotfile-madness/  
20190205/https://pypi.org/project/appdirs/  
20190205/https://github.com/ProtonMail/go-appdir  
20190205/https://stackoverflow.com/questions/3373948/equivalents-of-xdg-config-home-and-xdg-data-home-on-mac-os-x/5084892#5084892
