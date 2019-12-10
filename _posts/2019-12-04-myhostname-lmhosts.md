---
layout: post
title: "`myhostname` and `lmhosts`"
date: 2019-12-04 21:56 -0600
author: quorten
categories: [unix, windows]
tags: [unix, windows]
---

Recently I learned about `myhostname`.  What is it?  "myhostname" is
glibc default configuration for namespace resolution of `localhost`
and `_gateway`.  It exists entirely in userspace, and although I heard
it can do other interesting things like dynamically add custom
hostname resolution in userspace, I have not found any information on
that.

20191205/DuckDuckGo myhostname  
20191205/https://www.freedesktop.org/software/systemd/man/nss-myhostname.html

Likewise, there's the Lmhosts file on Windows, the name of local
configuration file in system directory, so no-go on that.  Although,
again, I purportedly heard there was some sort of userspace
configuration for this too.

20191205/DuckDuckGo windows lmhost  
20191205/https://support.microsoft.com/en-us/help/923947/you-cannot-modify-the-hosts-file-or-the-lmhosts-file-in-windows-vista
