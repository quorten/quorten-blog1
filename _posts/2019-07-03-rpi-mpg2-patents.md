---
layout: post
title: Updates on MPEG-2 hardware decoding on Raspberry Pi
date: 2019-07-03 12:07 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, I'm wondering.  Are there any updates on the whether you still
need to buy the license key to decode MPEG-2 on Raspberry Pi?  Ah,
yes, I found a veritable explanation.  Raspberry Pi is not going to
make any changes to their licensing until the last patent expires in
2025.  Because Raspberry Pi is sold internationally, and because
Raspberry Pi does not have region locking like DVD players, they have
no way of guaranteeing that a Raspberry Pi will not be used in the
last areas of the world where there are still patents in force.  And
by the license terms of Raspberry Pi with MPEG LA, they do not want to
risk an extremely high penalty fee of the license royalty for _every_
Raspberry Pi sold, whether or not it was ever used with hardware
MPEG-2 decoding.

So, that's that.  Also, please note that there is no noticeable
slowdown for software decoding of standard definition MPEG-2 on the
newer Raspberry Pis with faster clock speeds.  Only the original clock
speed comes with a noticeable slowdown.

20190703/DuckDuckGo raspberry pi mpeg-2  
20190703/https://raspberrypi.stackexchange.com/questions/83237/do-i-still-need-to-purchase-an-mpeg-2-and-vc-1-license-keys-for-the-raspberry-pi  
20190703/https://www.raspberrypi.org/forums/viewtopic.php?t=201449  

This old Raspberry Pi Foundation blog post explains why hardware video
codecs were an afterthought on the Raspberry Pi.  Raspberry Pi was
originally designed with a narrow goal for education, but later on it
turned out that many of the purchasers of Raspberry Pi were using it
for their media center computer.

20190703/https://www.raspberrypi.org/blog/new-video-features/
