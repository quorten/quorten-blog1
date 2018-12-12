---
layout: post
title: Weird things with `/dev/null`
author: quorten
date: 2018-11-02 12:10 -0500
categories: [random-software]
tags: [random-software]
---

Weird things that can happen with `/dev/null`.  One thing that
apparently happened quite often in the history of Unix is `/dev/null`
getting deleted or replaced with a regular file.  So, what are some
ways that this could have ended up happening by accident, beyond
deleting and messing around with `/dev/null` directly?  Well, here's
one interesting thing that I've found out.  If you set your Bash
history to `/dev/null` and run as root, and execute more than
`$HISTFILESIZE` commands, then Bash will end up moving `/dev/null`
somewhere else and replacing it with a regular file.  Ha, now that is
an interesting way that problem can get caused.

20181102/DuckDuckGo /dev/null got replaced by regular file  
20181102/https://serverfault.com/questions/551628/dev-null-file-became-regular-file/551644  
20181102/https://serverfault.com/questions/551628/dev-null-file-became-regular-file/663642#663642
