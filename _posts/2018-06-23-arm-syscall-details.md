---
layout: post
title: "ARM syscall interface details, more cross compiling, and
        connect NTP to your Raspberry Pi Zero via USB gadgets mode"
author: quorten
date: 2018-06-23 16:14 -0500
categories: [raspberry-pi, unlipic]
tags: [raspberry-pi, unlipic]
---

Okay, now we're moving onto the syscall interface for ARM.  How do you
do it?  First thing to remember, there is the old way (OABI = old ABI)
and the new way (EABI = embedded ABI).

Old old way:

    /* mov dest, src */
    mov a0, arg0
    mov a1, arg1
    mov a2, arg2
    swi #(0x900000 + __NR_write)
    /* Return value in a0 */

Old way:

    /* mov dest, src */
    mov r0, arg0
    mov r1, arg1
    mov r2, arg2
    swi #(0x900000 + __NR_write)
    /* Return value in r0 */

<!-- more -->

New way, 32-bit operands:

    /* mov dest, src */
    mov r0, arg0
    mov r1, arg1
    mov r2, arg2
    mov r7, __NR_write /* syscall number in r7 */
    swi #0
    /* Return value in r0 */

New way, 64-bit operands:

    /* mov dest, src */
    mov r0, arg0
    mov r2, arg1_loword /* skip over r1 */
    mov r3, arg1_hiword
    mov r7, __NR_ftruncate64 /* syscall number in r7 */
    swi #0
    /* Return value in r0 */

Don't use the "old old way" on architectures new enough to matter or
else you will get "illegal instruction."

Note that 64-bit operands must have their first word placed within a
even numbered register.  If it would otherwise go in an odd numbered
register, that register must be skipped over.

Note that `svc` (supervisor call) is the new mnemonic for `swi`
(software interrupt).  Both are the same instruction.

Also note.  `armel` is little endian ARM, `armeb` is big endian ARM,
just like with MIPS.  Likewise, the processor is bi-endian and can be
put into either of those two modes.  Typically the mode is set by the
compiled kernel and must stay that way during runtime.

* Footnote: No, no, it's not like what I use to think.  `armel` is
  _not_ the terminology meant to evoke "it's like an Intel, but built
  with ARM."

20180623/DuckDuckGo arm eabi  
20180623/https://wiki.debian.org/ArmEabiPort  
20180623/https://wiki.debian.org/ArmPorts  
20180623/http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3105/4

So, `crosstool-ng` is what the Raspberry Pi distro developers are
using to build Raspbian.

20180623/DuckDuckGo crosstool  
20180623/https://crosstool-ng.github.io/

Unfortunately I haven't figured out proper return value decoding and
error handling.  I've gotten very basic programs working, but not more
complete ones.

Let's try figuring out the return code processing here.

20180623/DuckDuckGo arm linux syscall swi return  
20180623/https://stackoverflow.com/questions/12946958/what-is-the-interface-for-arm-system-calls-and-where-is-it-defined-in-the-linux

So, here's how to do it.

    if (__r0 >= (unsigned long)-4095)
      { errno = (int)-__r0; result = -1; }
    else
      { errno = 0; result = __r0; }

20180623/https://git.busybox.net/uClibc/tree/libc/sysdeps/linux/arm/syscall.c  
20180623/https://github.com/android/platform_bionic/blob/master/libc/arch-arm/syscalls/write.S  
20180623/https://stackoverflow.com/questions/26381078/how-system-calls-are-handled-in-linux-on-arm-machine

Regarding an assembler error in `crt0.c` for ARM.  This is important
to take note: In ARM, `@` is interpreted as a comment character to the
assembler.  Use `%` instead for a delimiter character.

20180623/DuckDuckGo Error: unrecognized symbol type ""  
20180623/https://stackoverflow.com/questions/36778054/error-unrecognized-symbol-type

Looking at musl libc helps clarify how to correctly use ARM EABI.

20180624/https://www.musl-libc.org/download.html

----------

Using your Raspberry Pi through a USB device on another computer
connected to your network?  Annoyed that without NTP, your Pi always
starts with dates and times of the past?  Want your Raspberry Pi to
get routing to the Internet too?  Here's how.

First of all, continue using the Zeroconf networking between your two
computers over the Raspberry Pi's USB gadgets network device.

Next, configure IP(v4) forwarding on your laptop/PC:

    PIDEV=usb0
    HDEV=eth0
    HIP4ADDR=`ifconfig $HDEV | grep 'inet ' | awk '{ print $2; }' |
      sed -e 's/addr://g'`
    # Configure IPv4 forwarding.
    sudo sh -c 'echo 1 >/proc/sys/net/ipv4/ip_forward'
    # Configure IPv4 source NAT, otherwise our next hop router won't
    # route our packets.  IPv4 source NAT assumes the NAT IP is
    # constant, which is going to be the case when plugging in a Pi
    # for short development sessions.
    sudo iptables -t nat -A POSTROUTING -o $HDEV -s 169.254.0.0/16 -j SNAT \
      --to-source $HIP4ADDR
    sudo iptables -A FORWARD -i $PIDEV -o $HDEV -s 169.254.0.0/16 -j ACCEPT
    sudo iptables -A FORWARD -o $PIDEV -i $HDEV -d 169.254.0.0/16 -j ACCEPT

Now do configuration on your Pi:

    # Add your host as the default gateway, using the Zeroconf address.
    sudo route add default gw 169.254.x.x
    # Add the same nameserver that your host uses into `/etc/resolv.conf'.
    sudo sh -c 'echo nameserver 192.168.1.1 >>/etc/resolv.conf'
    # Restart ntp to pick up the changes.
    sudo service ntp stop
    sudo service ntp start

In my opinion, a nicer option would be to join the broadcast domains
across the two network devices.  Alas, that implies a switch, not a
single host with two network devices.  Or it implies a VPN-like
solution running on the host.

IPv6?  Well, that could be interesting... presumably we still need to
use NAT so that the prefixes will match for our routers.  It is
possible, though, that the router advertisement and discovery
protocols in IPv6 could allow for an easier way, but I haven't yet
tested this.
