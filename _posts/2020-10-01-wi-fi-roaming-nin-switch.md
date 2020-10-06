---
layout: post
title: "Wi-Fi roaming improvements, Nintendo Switch's lack thereof"
date: 2020-10-01 17:17 -0500
author: quorten
categories: [home-network]
tags: [home-network]
---

Observing my home network, I noticed something unusual with Nintendo
Switch.  It wasn't roaming properly between the different access
points!  Instead, it would stick to only the same BSSID that it was
originally associated with?  But, there is a cheap workaround for
this.  Simply disable and re-enable Wi-Fi, and the Nintendo Switch
will pair with the nearest access point.

20201001/DuckDuckGo nintendo switch wi-fi roaming  
20201001/https://en-americas-support.nintendo.com/app/social/questions/detail/qid/66337/~/nintendo-switch-wifi-does-not-roam-to-different%2Fstronger-wireless-extender

Now, this is an interesting tip I'm getting. Fast roaming?  Oh, it's
possible, but it requires special features.  802.11r is the name of
the game, an extended feature to speed up roaming with the otherwise
lengthy WPA2 security process in place.

20201001/https://www.smallnetbuilder.com/basics/wireless-basics/33180-how-to-fix-wi-fi-roaming  
20201001/https://revolutionwifi.blogspot.com/2011/12/wi-fi-roaming-analysis-part-1.html  
20201001/DuckDuckGo openwrt seamless wi-fi roaming  
20201001/https://forum.openwrt.org/t/802-11r-fast-roaming-in-luci/11730
