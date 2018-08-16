---
layout: post
title: Tweaking getaddrinfo to prefer IPv4 over IPv6
author: quorten
date: 2018-06-07 17:10 -0500
categories: [misc]
tags: [misc]
---

Interesting.  Want to reconfigure your system to resolve IPv4
addresses before IPv6?  This may be necessary due to firewall rules to
avoid slowness from IPv6 timeouts.  Here's how.

    cat >/etc/gai.conf <<EOF
    label       ::1/128        0
    label       ::/0           1
    label       2002::/16      2
    label       ::/96          3
    label       ::ffff:0:0/96  4
    precedence  ::1/128        50
    precedence  ::/0           40
    precedence  2002::/16      30
    precedence  ::/96          20
    precedence  ::ffff:0:0/96  100
    EOF

20180608/DuckDuckGo red hat resolv ipv4 address in preference of ipv6  
20180608/DuckDuckGo centos resolv ipv4 address in preference of ipv6  
20180608/https://askubuntu.com/questions/32298/prefer-a-ipv4-dns-lookups-before-aaaaipv6-lookups  
20180608/https://wiki.vpsget.com/index.php/Prefer_IPv4_over_ipv6_._How_to_set_ipv4_precedence
