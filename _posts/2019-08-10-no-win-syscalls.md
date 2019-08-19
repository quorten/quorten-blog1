---
layout: post
title: Windows equivalent of Linux system calls?  No.
date: 2019-08-10 09:45 -0500
author: quorten
categories: [unlipic, windows]
tags: [unlipic, windows]
---

So, it's super slick to use Linux system calls in assembly language
programs, and now I am thinking about extending my re-implementation
of an Apple II style "monitor" program as a means of a operating
system independent machine code type-in.  So, does Windows have an
equivalent to Linux system calls such that I can use it to create
ultra-compact Windows programs?  Unfortunately, no, just as I have
been suspecting.  No, no, you have to link against some Windows
library, and that Windows library will provide the necessary routines
to make the actual system calls by number, which differ by the version
of Windows and are not held constant in any way.

20190810/DuckDuckGo windows assembly language system call  
20190810/https://stackoverflow.com/questions/21074334/windows-system-calls  
20190810/https://stackoverflow.com/questions/2489889/system-calls-in-windows-native-api
