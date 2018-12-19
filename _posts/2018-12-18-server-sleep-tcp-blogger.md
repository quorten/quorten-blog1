---
layout: post
title: "Methods for having a server computer go to sleep when unused,
        and a very interesting blog by a blogger covering some of the
        same subjects in my blog too"
date: 2018-12-18 23:01 -0600
author: quorten
categories: [home-network, pentax-k-1-camera, random]
tags: [home-network, pentax-k-1-camera, random]
---

How do you setup a GNU/Linux server so that it will go into standby
(i.e. suspend) after a specific amount of time, unless there has been
recent network traffic on a specific port?  Well, well, this is an
interesting question.  First of all, the default settings for suspend
(via GNOME power manager) only check for mouse and keyboard activity
to determine if the computer is being actively used.  So, if you want
to control suspend using a different metric, you've got to do a bit of
customization.

20181218/DuckDuckGo linux suspend based off of network activity on port  
20181218/DuckDuckGo server power management network activity

In this first StackOverflow article, there is an interesting technique
used to wake a computer up when another computer tries to access it.
Basically, a Raspberry Pi computer runs all the time and listens for
ARP request packets for the computer that went to sleep.  Note that
these request packets will not be sent when the computer is awake.
When one of these packets is detected, the Raspberry Pi sends a
wake-on-LAN magic packet to the target computer, and it will then wake
up.

<!-- more -->

20181218/https://askubuntu.com/questions/43374/power-management-sleep-wake-up-server-when-accessed  
20181218/DuckDuckGo linux server suspend how is idle determined  
20181218/https://askubuntu.com/questions/170307/how-does-ubuntu-determine-inactivity-before-suspending

Well, well, now this was an interesting find.  First of all, this site
was a bit hard to get to.  For whatever reason, it has a rather weird
roaming DNS domain name.  During the years 2015 - 2017, the site was
named `oils-of-life.com`.  Then, for whatever reason, I had to search
aroiund a bit to find the modern DNS domain name in 2018.  I found the
domain name to be `erick.heart-centered-living.org`.  Yet, the site's
internal text still refers to `oils-of-life.com` in some areas, and in
some cases, some of the oils-of-life URLs still work.

Now, this blogger has some hobbies in common with me.  Home server,
Raspberry Pi, electronics circuits, photography, home
monitoring/automation.  Also, this blogger has some hobbies underway
that I have yet to get into, namely blogging on cooking.  This person
makes their own bread on a regular basis?  Wow.

20181218/https://web.archive.org/web/20150215032951/http://oils-of-life.com:80/blog/linux/server/auto-shutdown-and-auto-suspending-a-linux-server/  
20181218/https://web.archive.org/web/20160407065733/http://oils-of-life.com/blog/purpose/  
20181218/https://web.archive.org/web/20160407004143/http://oils-of-life.com/blog/linux/bread-dough-rising-time-lapse-gif/  
20181218/https://web.archive.org/web/20160607010558/http://oils-of-life.com/blog/linux/server/server-hardware-swaps/

Great article here.  You are **not** a software engineer, you are a
software gardener.

20181218/https://web.archive.org/web/20160607013342/http://oils-of-life.com/blog/my-thoughts/you-are-not-a-software-engineer/

WARNING: Contains one swear word.

20181218/http://chrisaitchison.com/2011/05/03/you-are-not-a-software-engineer/

20181218/DuckDuckGo Covering Computers, Food, Fermentation, Timelapse
Photography and more.  

Ah, here we go.  Now, is there a blog article about the domain name
migration?  Unfortunately, I saw no such blog articles detailing such.
However, other blog articles mentioned below do reference a physical
home move... but it appeared to have happened quite some time before
the domain name move in question.

20181218/http://erick.heart-centered-living.org/linux/server/configure-static-ip-and-installing-ntp/  
20181218/http://erick.heart-centered-living.org/purpose/  
20181218/http://erick.heart-centered-living.org/contact/  

Ah, yes, this is a technical article on the subject that I was looking
for.

20181218/http://erick.heart-centered-living.org/linux/server/autoshutdown-code-modded-to-hybrid-sleep-and-allow-required-restarts/

----------

This is an interesting observation.  The most starred Python projects
on GitHub tend to be machine learning projects.  An interactive SVG
graph of the most starred was created, and also another one for the
most starred C projects.

20181218/http://erick.heart-centered-living.org/info-links/most-starred-python-projects-on-github/  
20181218/http://erick.heart-centered-living.org/svg/python_repos.svg  
20181218/http://erick.heart-centered-living.org/svg/c_repos.svg

`libuv`?  That one is curiously unfamiliar to me, though I believe it
must be something I should know since it has a short name.  Ah, it's a
variation of `libev`, mainly by adding support for Windows, which
wasn't supported by `libev`.  Also, it is mainly popular through its
inclusion and use by Node.js.  To remind myself, the similar library
that I became familiar with before through Beej's Guide to Network
Programming is `libevent`.

20181218/DuckDuckGo libuv  
20181218/https://en.wikipedia.org/wiki/Libuv  
20181218/https://en.wikipedia.org/wiki/Libevent

Now, here's another interesting thing, using Raspberry Pi temperature
monitoring to send out an alert if the room temperature drops too low.

20181218/http://erick.heart-centered-living.org/linux/server/ssmtp-installing-and-configuration-and-use-tips/

Now, these are some interesting electronics articles.  Building a
digital clock from 7400 series TTL 5 V logic.  There was an article in
Howstuffworks in the year 2000 that unfortunately disappeared from the
face of the Internet.  Luckily, the author saved a printed copy of
that article that was then digitized and added to the blog.

20181218/http://erick.heart-centered-living.org/projects/7490-clock-article-from-2000/  
20181218/http://erick.heart-centered-living.org/ttl-chip-clock/24-hour-digital-clock-using-ttl-chips/
