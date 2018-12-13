---
layout: post
title: Solaris interface stability levels
author: quorten
date: 2018-12-12 13:15 -0600
categories: [random-software]
tags: [random-software]
---

This is interesting.  Solaris has defined interface stability levels
and promises that certain interfaces will be held stable and will not
change.  In hindsight, this is useful and important because
historically, many Unix-like things were automated by parsing shell
command output that was primarily meant only to be human readable
messages.  Then, when the original software developers would go and
make changes to these messages, the updates would break automation
scripts written by third parties that depend on the specific
formatting of those messages.  So, Solaris developers thoughtfully
developed this interface stability promise system.  Alas, it's too bad
that it's all going to have to end now that the future of Solaris has
been practically terminated.

20181212/DuckDuckGo solaris interface stability committed uncommitted  
20181212/https://docs.oracle.com/cd/E86824_01/html/E54776/attributes-5.html  
20181212/http://www.oracle.com/us/products/servers-storage/solaris/solaris-guarantee-program-1426902.pdf
