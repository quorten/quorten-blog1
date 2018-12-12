---
layout: post
title: Discussion on interrupts for I/O
author: quorten
date: 2018-06-22 10:04 -0500
categories: [unlipic, important]
tags: [unlipic, important]
---

Important!  Earlier I've said that interrupts for I/O don't make sense
in a multitasking operating system unless the processor is sleeping.
Yes, that is true.  The primary reason for this is because one process
doesn't know what I/O is being done by another process, and it doesn't
make sense for other processes to be interrupted on behalf of the I/O
of one process.  Hence the use of _polling_ by the timer tick and
operating system kernel when multitasking is active.

But what about single tasking?  Here, it is perfectly fine to use
interrupts to notify the single task that I/O is complete.  However,
we must be clear that this should only be done should the programmer
desire it.  If the program is entering a real-time loop, then it makes
sense to disable interrupts until the real-time loop is exited.

That being said, about real-time and timing loops on multitasking
operating systems.  Generally, a multitasking operating system only
guarantees timing accuracy (1) within a scheduled time slice and (2)
between scheduled time slices.  Macro-timing for between scheduled
time slices, micro-timing for within scheduled time slices.  The crux
here is that the interval of time between these two limits cannot be
assumed to be timed accurately on a multitasking operating system,
unless the system is also multiprocessor and can arrange for tasks on
processors in such a way that a variable scheduler is supported on one
processor.

Specifically, only integer multiples of the macro time slice can be
supported.  The fractional part of the macro time slice may be
variable.
