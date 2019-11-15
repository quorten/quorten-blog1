---
layout: post
title: "`systemd` replacement for rc.local"
date: 2019-11-08 20:58 -0600
author: quorten
categories: [unix]
tags: [unix]
---

One of the big problems in `systemd` for many simple use cases is the
claimed obsolescence of `rc.local`, yet many times there is a real
need to just run some simple shell commands at startup.  So, how do
you do it in the modern world?  You write an additional `systemd` unit
file that will call your own rc.local script, or in the case of a
single command, call your command directly.

Place in `/etc/systemd/system/rclocal.service`:

```
[Unit]
Description=Run rc.local shell commands
[Service]
ExecStart=/usr/local/bin/rclocal.sh
[Install]
WantedBy=multi-user.target
```

20191108/DuckDuckGo systemd run shell commands at boot  
20191108/DuckDuckGo systemd run shell commands rc.local  
20191108/https://www.redhat.com/sysadmin/replacing-rclocal-systemd
