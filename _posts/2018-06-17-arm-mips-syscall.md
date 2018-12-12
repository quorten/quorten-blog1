---
layout: post
title: "ARM/MIPS Linux syscall programming notes, and cross-compile
        information"
author: quorten
date: 2018-06-17 20:07 -0500
categories: [raspberry-pi, unlipic, home-network, reiterate]
tags: [raspberry-pi, unlipic, home-network, reiterate]
---

So, you're wondering, it can't be that hard to write Linux syscalls
for ARM and MIPS Linux from scratch, can it?  For sure, it is easy,
once you find out what you need to know.  So here it is.  We'll start
with MIPS first because it became popular first for embedded systems,
relatively speaking.  That being said, make sure you look at newer
source code sources if you are looking for examples that work on your
modern ARM Linux systems such as Raspberry Pi.

A MIPS syscall in assembler is as follows.

    Reference source:
    eglibc-2.11.1/ports/sysdeps/unix/sysv/linux/mips/mips64/syscall.S

    syscall:
            /* The mips move instruction is destination, source.  */
            move v0, a0                /* Syscall number -> v0 */
            move a0, a1                /* shift arg1 - arg7.  */
            move a1, a2
            move a2, a3
            move a3, a4
            move a4, a5
            move a5, a6
            move a6, a7
            .set noreorder             /* ??? Sometimes necessary.  */
            syscall                    /* Do the system call.  */
            .set reorder
            bne a3, zero, error
            ret
    error:
            /* call __syscall_error */

Subroutine calls pass in arguments in order from register a0 to a7.

<!-- more -->

If you are using GCC inline assembler constraints, these are the
mappings between constraint values and registers.

    Reference source:
    eglibc-2.11.1/ports/sysdeps/mips/regdef.h

    #define zero    $0      /* wired zero */
    #define AT      $1      /* assembler temp  - uppercase because of ".set at" */
    #define v0      $2      /* return value */
    #define v1      $3
    #define a0      $4      /* argument registers */
    #define a1      $5
    #define a2      $6
    #define a3      $7
    #if _MIPS_SIM != _ABIO32
    #define a4      $8
    #define a5      $9
    #define a6      $10
    #define a7      $11
    #define t0      $12
    #define t1      $13
    #define t2      $14
    #define t3      $15
    /* ... */
    #define t8      $24     /* caller saved */
    #define t9      $25

    Reference source:
    eglibc-2.11.1/ports/sysdeps/unix/sysv/linux/mips/mips64/n32/sysdep.h
    register long long __v0 asm("$2") ncs_init;
    register long long __a0 asm("$4") = ARGIFY (arg1);
    register long long __a1 asm("$5") = ARGIFY (arg2);
    register long long __a2 asm("$6") = ARGIFY (arg3);
    register long long __a3 asm("$7") = ARGIFY (arg4);
    register long long __a4 asm("$8") = ARGIFY (arg5);
    register long long __a5 asm("$9") = ARGIFY (arg6);

    #define __SYSCALL_CLOBBERS "$1", "$3", "$10", "$11", "$12", "$13", \
        "$14", "$15", "$24", "$25", "hi", "lo", "memory"

Do a GCC inline assembler syscall something like this:

    Reference source:
    eglibc-2.11.1/ports/sysdeps/unix/sysv/linux/mips/brk.c

    {
      register long int res __asm__ ("$2");

      asm ("move\t$4,%2\n\t"
           "li\t%0,%1\n\t"
           "syscall"              /* Perform the system call.  */
           : "=r" (res)
           : "I" (SYS_ify (brk)), "r" (addr)
           : "$4", "$7", __SYSCALL_CLOBBERS);
      newbrk = (void *) res;
    }

Also, see
`eglibc-2.11.1/ports/sysdeps/unix/sysv/linux/mips/mips32/sysdep.h`.
"$4" and "$7" are not used over there in the register clobber
arguments, so that use appears to be particular to the `brk.c`
implementation.

So you're wondering about what models of SoC contain which MIPS cores?
Basically, all modern SoC MIPS devices use MIPS32 or MIPS64.  The
treasure trove of MIPS information is linux-mips.org.

20180617/https://en.wikipedia.org/wiki/MIPS_architecture#MIPS32/MIPS64  
20180617/https://en.wikipedia.org/wiki/Texas_Instruments_AR7  
20180617/DuckDuckGo ar71xx SoC  
20180617/https://elinux.org/Ar71xx.cfg  
20180617/DuckDuckGo mips_m4k  
20180617/DuckDuckGo MIPS 24Kc

"Fastest" in this article means as of 2006.

20180617/https://www.linux-mips.org/wiki/24K  
20180617/https://www.linux-mips.org/wiki/Atheros_SOC  
20180617/https://www.linux-mips.org/wiki/4K

Finally, if you're wondering about what those instructions
mean... well, some of them like `li` might be compiler aliases.
Otherwise, you can find some other documentation in these manuals.

20180617/DuckDuckGo mips32 instruction set architecture reference  
20180617/https://www.cs.cornell.edu/courses/cs3410/2008fa/MIPS_Vol2.pdf  
20180617/DuckDuckGo mips architecture volume i  
20180617/https://www.cs.cornell.edu/courses/cs3410/2015sp/MIPS_Vol1.pdf

Bingo!  So you want to compile  MIPS little endian?  Big endian is the
default for most "MIPS"  architectures.  To get little endian, specify
`mipsel`.

20180617/DuckDuckGo gcc mips little endian  
20180617/https://stackoverflow.com/questions/7281366/mips-compilation-lsb-msb  
20180617/DuckDuckGo gcc mipsel  
20180617/https://gcc.gnu.org/ml/gcc-help/2006-11/msg00043.html  
20180617/https://packages.debian.org/sid/gcc-mipsel-linux-gnu

UPDATE: Alternatively, if you are building your own standard C library
from scratch, you actually don't need to specify big endian versus
little endian at compile-time of your compiler toolchain.  You can
simply pass an option to GCC to instruct it which endian it should
compile with.  Use the `-EL` option for little endian and the `-EB`
option for big endian.  For additional details, see [my next article
on the subject]({{ site.baseurl }}/blog/2018/06/18/more-arm-mips-syscall).

----------

Again, I reiterate, because this is important!  This is the article
about experimenting on a NETGEAR GS108T smart switch to see if OpenWRT
can be installed on it.

20180617/DuckDuckGo netgear gs108tv2 openwrt bricked redboot  
20180617/DuckDuckGo netgear gs108t openwrt bricked redboot

Yeah, that OpenWRT forum is still botched, unfortunately.

20180617/https://forum.openwrt.org/viewtopic.php?id=51882

Worthy of note is that there is a different bootloader here, CFE
actually.  Or, CFE before Redboot.  No, RedBoot is officially not
used.

20180617/DuckDuckGo netgear gs108t redboot  
20180617/http://sourceware-org.1504.n7.nabble.com/Netgear-managed-switch-GS108T-open-source-friendly-td193954.html

Plus, I've found another interesting/useful article.  I thought I once
saw a web page where someone opened up the router, photographed it,
and described its stock internal chips.  No, maybe that was only on a
different product, the USB host-to-host device.

Anyways, the point in hand here is that for NETGEAR smart switches,
you might need to lift the heat sink in order to get at the CMOS
console port.  Also, _thermal glue_ is a thing that you need to put
the heat sink back down.

20180617/DuckDuckGo netgear gs108t inside mips  
20180617/https://web.archive.org/web/20130921201747/http://blog.catsheavy.com:80/2013/06/05/netgear-gs108t-hacking/
