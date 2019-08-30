---
layout: post
title: "The story behind `tuxcall` in Linux?"
date: 2019-06-28 19:06 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

So, you're wondering, what exactly is the `tuxcall` unsupported
syscalls in Linux?  It was actually that Red Hat implemented a web
server in-kernel to beat Microsoft in a contest!  Later, when Linux
improved its threading support by adding NPTL, and also adding the
`sendfile` system call, this virtually closed the entire gap between
the in-kernel web server and a userspace one.

20190629/DuckDuckGo tux api  
20190629/DuckDuckGo tux syscall  
https://cloudatomiclab.com/antisyscall  
20190629/DuckDuckGo tuxcall  
20190629/https://unix.stackexchange.com/questions/446502/what-did-the-system-call-tuxcall-do  
20190629/https://en.wikipedia.org/wiki/NPTL
