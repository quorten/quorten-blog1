---
layout: post
title: Better Cirrus Windows drivers for virtual machines
date: 2020-07-05 15:43 -0500
author: quorten
categories: [windows]
tags: [windows]
---

Okay, so the problem with Direct3D not working in Windows XP?  Maybe
I've found a solution... better drivers.  Purportedly, Windows XP only
supports 2D out of the box on the Cirrus 5446 video card, not to
mention that the card is 2D itself.  Proper 3D support simply entails
the inclusion of a software 3D renderer included as part of the video
card's drivers.  As for the Direct3D interface, "device capabilities"
bits will be set to indicate which features and functions are
available, and up to Direct3D is compatible with drivers written for
any older version, back to Direct3D 6 or maybe even Direct3D 5.

20200605/DuckDuckGo qemu cirrus video  
20200605/https://www.claunia.com/qemu/drivers/index.html  
20200605/DuckDuckGo cirrus 5446 direct3d  
20200605/DuckDuckGo cirrus 5446 direct3d windows xp  
20200605/https://en.wikipedia.org/wiki/DirectX  
20200605/https://en.wikipedia.org/wiki/Cirrus_Logic
