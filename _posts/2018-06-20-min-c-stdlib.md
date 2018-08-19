---
layout: post
title: More notes on a minimal C standard library
author: quorten
date: 2018-06-20 12:00 -0500
categories: [unlipic]
tags: [unlipic]
---

Each "core" can come in multiple levels: level 1, level 2, level 3,
etc.  Level 1 is the "minimal, most basic required", whereas the
higher levels add nice-to-have features in that area.

Furthermore, there are two major areas of division.

* System calls
* Library code

<!-- more -->

System calls are _essential_: they are interface to the operating
system, which is the only practical way to interface with the vast
multitude of modern hardware.  The advent of a larger number of
smaller mobile devices and embedded applications has brought with it a
vast number of different ways to interface with hardware that achieves
essentially the same purpose.  Only on PC platforms (desktop and
server) is it viable to program against the hardware directly.
Although the simplest of embedded systems can be interfaced with
directly, the sheer number of different embedded systems is what makes
it impractical for a modern programmer to learn and program against
all of them.

The Linux kernel has broken tremendous ground in becoming the _de
facto_ standard operating system across the largest possible range of
general purpose hardware.  For more specialized hardware like GPUs,
there is still quite a bit of room for improvement.  Virtually the
only difference between Linux syscalls across hardware architectures
is the instruction used, the means by which the arguments are packed,
and the means by which the return values are unpacked.  Even this has
become vastly more standardized: nowadays the standard is to pass
arguments and return values in registers, and use the `syscall`
instruction to make the system call.  MIPS and ARM use consecutively
numbered registers starting at some "number zero" register, but x86-64
uses a more arbitrary selection of registers.

System calls:

* UART core
    * Level 1 (read, write)
    * Level 2 (tcattr, fcntl, etc.)
* Process core
    * Level 1 (exit)
    * Level 2, (fork, vfork, exec, spawn, etc.)
* Time core
    * Level 1 (time)
* Dynamic memory allocation core
    * Level 1 (brk, sbrk)
* Network sockets core
    * Level 1 (listen, connect, etc.)
    * Level 2 (send, recv, etc.)
    * Level 3 (sendfile, etc.)
* File core (CRUD only)
* File management core (rename, chmod, etc.)

* Shared/virtual memory core
    * Level 1 (mmap)
    * Level 2 (mlock, mprotect, etc.)
* Kernel thread core

* Local users core

* ??? environment variables?
* ??? auxiliary vector?
* ??? signal handling

* Inter-process communication core
    * Level 1 (pipe)
    * Level 2 (mkfifo, etc.)

* System core
    * Level 1 (syslog)
    * Level 2 (resource limitation, process groups?)
    * Level 3 (??? other system configuration)

Library code:

* String/memory routines
* Conversions, number to ASCII, iconv, locale support, etc.
* Standard I/O
* ncurses
* Time and date functions
* Heap manager
* DNS support, i.e. getaddrinfo

* ??? environment variables?
* ??? auxiliary vector?
* ??? debugging functions

* Threads & locking
** Level 1 (setjmp/longjmp)
** Level 2 (user-mode threads)
** Level 3 (kernel threads)

* Algorithms and data structures
** Level 1 (rand)
** Level 2 (qsort, bsearch)
** Level 3 (math functions)
** Level 4 (expandable arrays)
** Level 5 (all that)

* Cryptographic functions

Now, here's the trick question.  How many useful programs can you
write with how few syscalls or library functions?  How large is the
specific code of those programs?  And, how frequently are those
programs used?  Loop iterations?  Number of users?

Matter of fact, that's the whole point why I wrote up multiple levels
of cores.  From practical experience, the problem with compiled code
languages is that cross compiling a very basic program is much too
complicated with the existing practice.  It would be far better if you
could select in advance only what you need out of the standard C
library and compile that.  So, I wrote up these plans.

You could argue the concept extends further and includes the cross
compiler itself: you should only need to compile a very basic compiler
if you are compiling a very basic program.  Yes, I'm looking into that
too.  Current practice partially implements this approach, but we
could be going further.
