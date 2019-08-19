---
layout: post
title: Get information about area in program where signal occurred
date: 2019-07-24 09:15 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

So, I've built simple cothreading routines using `setjmp` in C that I
can use for multitasking.  Cool.  As it stands, it is limited to
cooperative multitasking, but if I could invoke it from an ALARM
signal set on a periodic timer, and get information about where the
program was interrupted, I could implement pre-emptive multitasking.
So, is it possible to get information about the area that a program
was interrupted to invoke the signal handler?  Yes, but it is somewhat
nonstandard and implementation-specific.  Use `sigaction()` with
SA_SIGINFO to request `ucontext_t`, which is where you retrieve this
information.

20190724/DuckDuckGo unix get information about area in program where
  signal occurred  
20190724/DuckDuckGo linux how to get instruction where signal
  interrupted  
20190724/https://stackoverflow.com/questions/34989829/linux-signal-handling-how-to-get-address-of-interrupted-instruction

Basically, I'm reinventing "green threads," but with the goal of doing
so in a tiny, minimalistic implementation.
