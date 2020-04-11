---
layout: post
title: QEMU shared clipboard
date: 2020-04-09 17:40 -0500
author: quorten
categories: [unix]
tags: [unix]
---

How do you get a shared clipboard with QEMU?  It's easy with VMware
and VirtualBox, just install the guest tools?

Here's the trick with QEMU?  There's not just one set of guest tools,
but three in total: QEMU guest tools, oVirt guest tools, and SPICE
guest tools.  If you only installed the first two, you're not going to
get the shared clipboard.  Go download and install the _SPICE_ guest
tools to get the shared clipboard.

20200409/DuckDuckGo qemu windows shared clipboard  
20200409/https://askubuntu.com/questions/858649/how-can-i-copypaste-from-the-host-to-a-kvm-guest  
20200409/https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe  
20200409/https://www.spice-space.org/download/binaries/spice-guest-tools/
