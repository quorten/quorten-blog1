---
layout: post
title: Configure remote syslog over UDP
date: 2020-01-06 20:10 -0600
author: quorten
categories: [unix, home-network, reiterate]
tags: [unix, home-network, reiterate]
---

Again, I reiterate, because this is important!  Remote syslog over UDP
is really easy to setup and configure, look over here for
receiver-side configuration, if you are primarily interested in
receiving log messages from, say, a network switch or access point
device that does not have its own persistent storage for log data.

20200106/https://www.rsyslog.com/receiving-messages-from-a-remote-system/  
20200106/https://www.rsyslog.com/storing-messages-from-a-remote-system-into-a-specific-file/

Look here fore setup on the OpenWRT/LibreCMC side.

20200106/https://www.rsyslog.com/storing-messages-from-a-remote-system-into-a-specific-file/

Nevertheless, I haven't got around to setting up my own system until a
long delay after initial research and learning.
