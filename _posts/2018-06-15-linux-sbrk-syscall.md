---
layout: post
title: Linux system calls, sbrk()
author: quorten
date: 2018-06-15 22:52 -0500
categories: [raspberry-pi, unlipic]
tags: [raspberry-pi, unlipic]
---

So, I've thought I'd implement a `brk()` system call really quickly in
my tiny `libc` library, but I've run into complications.  Why?  Short
answer: I read the documentation wrong.  `sbrk()` returns the _old_
address, not the new one!

But anyways, I've learned some other interesting things along the way.
For odd reasons that be, I was testing on Ubuntu 10.04 LTS, which has
this weird bug that under certain conditions like programs being
spawned from `make, memory maps are setup such that `brk()` is stuck
between two other allocations and can't move.  Thus, only `mmap()` can
be used on this particular Linux configuration to get more memory.
That's dumb.  `mmap()` is too complicated to be recommendable for use
in very small, simple, statically-linked Linux programs.

Luckily, however, I was able to get `sbrk()` working even on this
system.

Now it turns out there's an easy way to check a process's memory maps
on Linux:

    cat /proc/$PID/maps

20180615/DuckDuckGo linux kernel sbrk  
20180615/https://elinux.org/images/b/b5/Elc2013_Kobayashi.pdf

20180615/DuckDuckGo ubuntu sbrk fail  
20180615/https://bugs.chromium.org/p/chromium/issues/detail?id=57908  
20180615/https://unix.stackexchange.com/questions/329111/enomem-when-calling-sbrk-for-8gb

20180615/DuckDuckGo linux sbrk security limit object  
20180615/https://stackoverflow.com/questions/997425/how-are-sbrk-brk-implemented-in-linux  
20180615/DuckDuckGo linux sbrk always fails  
20180615/https://stackoverflow.com/questions/6988487/what-does-the-brk-system-call-do  
20180615/http://www.howtobuildsoftware.com/index.php/how-do/NM3/linux-malloc-system-calls-dynamic-memory-allocation-sbrk-why-my-implementation-of-sbrk-system-call-does-not-work

Also, if you're wondering about the special system call instruction
for 64-bit Linux.  It turns out that there is also a variant that only
works on 32-bit systems, `sysenter`/`sysexit` that is used by Windows
XP.  `syscall`/`sysret` is what is used on modern 64-bit systems, but
it _only_ works on pure 64-bit systems, no compatibility modes
enabled.  Also, `sysret` has a silicon bug that causes a security
vulnerability on all known modern architectures.  Ah, that's a real
bummer.

20180615/DuckDuckGo 64 bit linux system instruction  
20180615/https://stackoverflow.com/questions/8510333/x86-64-assembly-linux-system-call-confusion  
20180615/https://wiki.osdev.org/SYSENTER
