---
layout: post
title: In-browser terminal emulator
author: quorten
date: 2018-06-04 14:44 -0500
categories: [random-software]
tags: [random-software]
---

Looking for terminal emulator frameworks that run in a browser?
Indeed, Xterm.js is well-used and featureful.

20180604/https://github.com/xtermjs/xterm.js

Again, I reiterate, because this is important!  Xterm.js provides a
great example of what I was writing about earlier.  A great piece of
software is one that establishes a "standard" form of abstract
symbolism, meaning that single component supports a large number of
back-end technologies (like low-level hardware) and is used by a large
number of higher level software.  Xterm.js provides a great example by
linking to many projects that use it.

And indeed, some of these are quite interesting.  Namely, the
in-browser SSH clients.  What is the main development hurdle and
caveat of these?  They require a WebSocket to TCP socket proxy server.

20180604/https://github.com/billchurch/WebSSH2  
20180604/https://github.com/stuicey/SSHy  
20180604/https://github.com/stuicey/wsproxy

These are some other interesting software that use Xterm.js.

20180604/https://github.com/yudai/gotty  
20180604/https://cloudcmd.io/
