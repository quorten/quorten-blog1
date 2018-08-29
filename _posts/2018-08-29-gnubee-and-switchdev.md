---
layout: post
title: Info on GnuBee and `switchdev`
author: quorten
date: 2018-08-29 -0500
categories: [home-network]
tags: [home-network]
---

Interesting finds here.  So, the GnuBee?  It turns out that it is not
quite as libre-friendly as would be ideal.

20180829/https://lwn.net/Articles/743609/

Also, this is an interesting article on `switchdev`.  So, I wasn't
quite aware of this: for a long time in the earlier Linux days, there
was no official kernel API support for controlling network switch
hardware.  In the earlier days, so-called "Linux" compatible network
switches actually used proprietary blob drivers to control the
advanced switch hardware's features such as VLANs.  But, the addition
of `switchdev` to Linux has created a standard interface to be able to
do these things without the need for proprietary blobs, so long as the
corresponding Linux drivers are available.

20180829/https://lwn.net/Articles/675826/
