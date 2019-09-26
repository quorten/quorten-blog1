---
layout: post
title: How remote syslog works, and how to use it with Docker
date: 2019-08-04 18:45 -0500
author: quorten
categories: [unlipic, docker]
tags: [unlipic, docker]
---

How does remote `syslog` work?  Here, look at these RFCs.  It really
is pretty simple, just `syslog` text lines over TCP, UDP, TLS, etc.

20190804/DuckDuckGo udp syslog  
20190804/https://tools.ietf.org/html/rfc5426  
20190804/https://tools.ietf.org/html/rfc5424  
20190804/https://en.wikipedia.org/wiki/Syslog

And for my own reference, how do you configure Docker containers to
send their logs via the remote `syslog` protocol?  Easy.
`--log-driver syslog` when starting a container.

20190804/https://docs.docker.com/config/containers/logging/configure/
