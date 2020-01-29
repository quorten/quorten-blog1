---
layout: post
title: Improving graphics performance in oVirt and QEMU
date: 2020-01-27 20:30 -0600
author: quorten
categories: [random-software]
tags: [random-software]
---

QXL is a long-established and old way to get reasonably good graphics
performance in QEMU, but what if that is not good enough?  How do you
get better performance?  In newer versions of QEMU, 2.6+, `virtio-gpu`
is a higher performance option available.  Functionality is excellent
on Linux; however, Windows support is still sparsely documented and in
an unknown state.  Nevertheless, even if you select `virtio` video on
a Windows VM and start it up, you'll notice you get better 2D graphics
performance with the Windows generic drivers, at the expense of screen
tearing.

20200127/DuckDuckGo virtio 3d acceleration not supported  
20200127/DuckDuckGo virt-viewer screen tearing  
20200127/DuckDuckGo virtio display driver  
20200127/DuckDuckGo kvm qxl versus virtio video  
20200127/DuckDuckGo qxl or virtio video  
20200127/https://wiki.archlinux.org/index.php/QEMU/Guest_graphics_acceleration
