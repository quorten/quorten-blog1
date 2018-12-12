---
layout: post
title: Assign a static IP address on CentOS
author: quorten
date: 2018-01-29
categories: [centos, important]
tags: [centos, important]
---

Important!  RHEL Red Hat CentOS notes.  Assign a static IP address.

20180129/DuckDuckGo ?  
20180129/https://unix.stackexchange.com/questions/52474/setup-static-ip-in-redhat-6#52475

In file:
/etc/sysconfig/network-scripts/ifcfg-eth0:

    DEVICE=eth0
    BOOTPROTO=STATIC
    IPADDR=192.168.0.5
    NETMASK=255.255.255.0
    GATEWAY=192.168.0.1
    ONBOOT=yes

Done!
