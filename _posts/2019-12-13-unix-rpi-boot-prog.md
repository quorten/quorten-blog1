---
layout: post
title: "Different ways to start a program on Unix and Raspberry Pi
        bootup"
date: 2019-12-13 23:43 -0600
author: quorten
categories: [unix, raspberry-pi]
tags: [unix, raspberry-pi]
---

Have a Raspberry Pi and want to start a GUI emulator program or
similar directly on bootup?

This is a good article about two easy and common ways to set up
autostarting a GUI user program on a Raspberry Pi on bootup.  First,
set up auto-login, then on the auto-login account, set autostart
either in your .bashrc file or in an lxsession autostart file.

20191213/DuckDuckGo raspberry pi freedesktop autostart  
20191213/https://blog.startingelectronics.com/auto-start-a-desktop-application-on-the-rapberry-pi/

A third, more advanced method of my own?  Add your program to
"/etc/shells", then use "chsh" on the auto-login account to set your
program as its "shell".

Also, yet another method which I recommend more for GPIO software than
for GUI software is ot start your user program from a `systemd` unit
file.  See my [older blog article]({{ site.baseurl
}}/blog/2019/11/09/systemd-rc-local) related to this subject for more info.
