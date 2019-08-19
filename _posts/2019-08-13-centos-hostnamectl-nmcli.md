---
layout: post
title: CentOS hostnamectl and NetworkManager static IP
date: 2019-08-13 19:51 -0500
author: quorten
categories: [unix, centos]
tags: [unix, centos]
---

In recent versions of CentOS, there are new command line tools to
perform old sysadmin tasks.  Do you want to change the hostname of a
machine?  Rather than using the `hostname` command, the `hostnamectl`
command is the new preferred way to do this.

Do you want to assign a machine a static IP?  The semi-old way was to
disable NetworkManager so that you could set the static IP the classic
way via `/etc/sysconfig/network-scripts/...`, but nowadays you can
also configure static IPs via NetworkManager, thus obviating the need
to disable NetworkManager to perform this configuration.  Use `nmcli`
to perform command-line configuration of NetworkManager.

20190725/DuckDuckGo hostnamectl  
20190725/https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec_configuring_host_names_using_hostnamectl

20190725/DuckDuckGo nmcli set domain name  
20190725/DuckDuckGo nmcli connection modify search domain  
20190725/https://unix.stackexchange.com/questions/336727/centos7-network-manager-is-using-wrong-search-domain#336730

20190802/DuckDuckGo networkmanager assign static ip  
20190802/https://askubuntu.com/questions/246077/how-to-setup-a-static-ip-for-network-manager-in-virtual-box-on-ubuntu-server
