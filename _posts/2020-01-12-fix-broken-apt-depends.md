---
layout: post
title: Fixing broken apt dependencies in Raspbian
date: 2020-01-12 20:36 -0600
author: quorten
categories: [unix, raspberry-pi]
tags: [unix, raspberry-pi]
---

So, now I'm really excited for the middle-of-January Raspberry Pi 4
upgrade, and guess what?  It's finally here!  But alas, I cannot
upgrade due to an apt broken dependencies error.  Come on!!!  What
gives?  Okay, okay, apparently this is rather common in Raspbian, but
no worries, the solution is simple.  Just do this with the indicated
broken dependencies package:

```
sudo apt-get install --reinstall vlc-bin
```

And you'll be all set to pull in the updates!

20200112/DuckDuckGo raspberry pi vlc-bin broken packages  
20200112/https://raspberrypi.stackexchange.com/questions/9050/held-broken-packages
