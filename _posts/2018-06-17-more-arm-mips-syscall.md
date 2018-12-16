---
layout: post
title: "More ARM/MIPS Linux syscall programming notes, and more on
        cross-compiling"
author: quorten
date: 2018-06-17 23:10 -0500
categories: [raspberry-pi, unlipic, important]
tags: [raspberry-pi, unlipic, important]
---

So, now I've got into the lowdown of cross-compiling for MIPS...
somewhat.  I already had a MIPS cross-compile toolchain packaged in
advance for my newer LibreCMC router, so I just used that to compile a
simple "Hello World!" program, copy it to the router, and run it.
Works alright.  Then I went to the older router, figured out how to
copy it over, which was harder because I needed to use Busybox
`ftp`/`tftp` (I used `tftp`), and ran that... and it didn't work.  It
tried to assume it was a shell script.  Sure, first thing to check is
if the object file formats are even compatible, so I copied a binary
from the router back using `tftp`, and sure enough, the object code
format was different.  The difference between `elf32-tradbigmips`
(new) and `elf32-tradlittlemips` (old).  So, then I checked the
pre-compiled object code files for the libraries... sure enough,
they're all `elf32-tradbigmips`.  So I have to back-trace and make
sure to compile those correctly before trying to run on the old
router.  Yeah, this is why having the ultra-minimalistic `libc` is
really handy: it makes recompiling a breeze, especially when you're
trying to test some very simple cross-compiled software.

<!-- more -->

20180617/https://busybox.net/downloads/BusyBox.html  
20180617/DuckDuckGo elf32-tradlittlemips  
20180617/DuckDuckGo elf32-tradlittlemips elf32-tradbigmips  
20180617/https://stackoverflow.com/questions/46896258/how-do-you-update-the-gnu-linker-for-an-android-ndk

Yep, again.  linux-mips.org wiki is the place to go.  Very interesting
and unfortunate history going on here with MIPS ABI.  And I thought
the MIPS ABI would be better than that for ARM!  Nope, just because
it's older and better tested doesn't mean it's better.  Still, Linux
i386 ABI is by far the best developed ABI for Linux.

20180617/https://www.linux-mips.org/wiki/ELF  
20180617/https://www.linux-mips.org/wiki/MIPS_ABI_History  

Now I'm checking to see if there is a really easy way to take an
existing GCC and recompile it with.  Well, looking in my own
compiler/linker scripts, pass `-EL` to the linker.  `ld -V` is also
helpful.  But, the crux is this.  You must have a compiler that is
capable of generating the correct object code files, and I don't think
you can control that with a linker option, can you?

20180617/DuckDuckGo gcc binutils specify object output format  
20180617/https://stackoverflow.com/questions/7182409/how-to-correctly-use-a-simple-linker-script-executable-gets-sigkill-when-run

----------

UPDATE: The old router is 4KEc, more specifically, not just plain 4Kc.

20180618/https://www.linux-mips.org/wiki/AR7  
20180618/https://www.linux-mips.org/wiki/4K

    # cat /proc/cpuinfo
    processor               : 0
    cpu model               : MIPS 4KEc V4.8
    BogoMIPS                : 149.91
    wait instruction        : no
    microsecond timers      : yes
    extra interrupt vector  : yes
    hardware watchpoint     : yes
    VCED exceptions         : not available
    VCEI exceptions         : not available

Note: I've found some more information on this router.  Notably, a
simple C program to put the router into recovery mode by sending it a
magic packet.  Cool.

20180618/DuckDuckGo MIPS 4KEc V4.8  
20180618/https://web.archive.org/web/20151001203302/https://www.nettwerked.net/actiontec.html

Here's the magic packet program.

```
/* test prog for actiontec router hack 
 * by: omin0us
 * help from Sub.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <string.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define PORT 5035 
#define DEST_IP "192.168.0.255"

int main()
{

	int sockfd;
	struct sockaddr_in actiontec_addr;
	int bytes_sent;
	char packet_data[] = 
	     		   "\x00\x00\x16\x02\x02\x00\x00\x00"
					"\x01\x00\xa8\xc0\x00\x00\x00\x00";

					if((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) == -1)
					{
						fprintf(stderr, "Error: could not establish socket\n");
								exit(1);
								}

								actiontec_addr.sin_family = AF_INET;
								actiontec_addr.sin_port = htons(PORT);
								actiontec_addr.sin_addr.s_addr = inet_addr(DEST_IP);
								memset(&(actiontec_addr.sin_zero), '\0', 8);

								if((bytes_sent = sendto(sockfd, packet_data, strlen(packet_data), 0,
									       (struct sockaddr *)&actiontec;_addr, sizeof(struct sockaddr))) == -1)
									       {
										fprintf(stderr,"error: could not send data\n");
												       exit(1);
												       }

												       printf("sent %d bytes\n", bytes_sent);
												       close(sockfd);
												       
												       return(0);
}
```

Here's a sniffed recovery session.

```
UDP broadcast port 5035: (16 bytes) 0x00 0x00 0x16 0x02 0x01 0x00 0x00 0x00 0xc0 0xa8 0x00 0x01 0x00 0x00 0x00 0x00
UDP response from modem to port 5035: (16 bytes) 0x00 0x00 0x16 0x02 0x02 0x00 0x00 0x00 0x01 0x00 0xa8 0xc0 0x00 0x00 0x00 0x00
220 ADAM2 FTP Server ready.
USER adam2
331 Password required for adam2.
PASS adam2
230 User adam2 successfully logged in.
TYPE I
200 Type set to I.
MEDIA FLSH
200 Media set to FLSH.
PORT 192,168,0,102,130,11
200 Port command successful.
STOR nsp.ar7wrd.squashfs.img mtd0
150 Opening BINARY mode data connection for file transfer.
226 Transfer complete.
TYPE I
200 Type set to I.
MEDIA FLSH
200 Media set to FLSH.
PORT 192,168,0,102,130,12
200 Port command successful.
STOR ram_zimage_pad.ar7wrd.nsp.squashfs.bin mtd1
150 Opening BINARY mode data connection for file transfer.
226 Transfer complete.
TYPE I
200 Type set to I.
MEDIA FLSH
200 Media set to FLSH.
PORT 192,168,0,102,130,13
200 Port command successful.
STOR config.xml mtd3
150 Opening BINARY mode data connection for file transfer.
226 Transfer complete.
REBOOT
221-Thank you for using the FTP service on ADAM2.
221 Goodbye.
QUIT
```

----------

Important!

So, I was making progress on the old router.  Although I've succeeded
in compiling a correct cross compiler for the CPU architecture, the
old 2.4 dated kernel refused to load the MIPS32 architecture object
files.  Maybe the kernel wasn't even correctly compiled to use the
maximum available features of the hardware.  Analyzing the headers,
existing executables are flagged MIPS 1.  So, I had to backtrace to go
all the way back to MIPS1, recompile that, and try again.  The other
alternative is to monkey patch the mode byte to masquerade as MIPS1 so
that the kernel will load it, even though it contains MIPS32
instructions.  In either case, I've consistently got the executable to
run and get a segmentation fault before "Hello World" prints.  Well,
that's progress.  The segfault is probably happening in musl libc
code, so I'd have to continue with writing and linking against my own
super-minimalistic system calls C library.

F.Y.I. Look at the `binutils` source code to determine the values of
the MIPS architecture flags.

20180618/https://www.linux-mips.org/wiki/R2000  
20180618/DuckDuckGo linux 2.4 mips elf header r3000 isa32  
20180618/http://refspecs.linuxbase.org/elf/gabi4+/ch4.eheader.html

----------

Important!

syscall notes.  So you do need that "li $v0" instruction that precedes
the syscall instruction.  Why?  Pre 2.6 kernels (read: 2.4 that you
are using) retry a system call from the instruction before assuming
this is what is being done.  So for later kernels, no you don't need
it, but definitely for earlier kernels.

20180628/https://www.linux-mips.org/wiki/Special:AllPages  
20180620/https://www.linux-mips.org/wiki/Syscall

Other interesting hardware that has MIPS and can potentially run MIPS
Linux: PS1, Nintendo 64, PSP.  No signs of where to get working code.

20180620/https://www.linux-mips.org/wiki/PS1  
20180620/https://www.linux-mips.org/wiki/PSP  
20180620/https://www.linux-mips.org/wiki/Nintendo_64  
20180620/https://web.archive.org/web/20071228024824/http://www.heise.de:80/ix/artikel/E/1997/04/036/

Darn it!  RouterTech firmware is behind a registration wall.  A letter
to the admins is on its way and being drafted to get this removed.

Latest releases:

20180620/https://www.routertech.org/viewtopic.php?f=23&t=4183  
20180620/https://www.routertech.org/viewtopic.php?f=23&t=5202

Hey, there actually _is_ some modern activity going on at this site.

20180620/https://www.routertech.org/viewtopic.php?f=3&t=6331  
20180620/https://www.routertech.org/viewtopic.php?f=16&t=6343

So, this is what you use for contact.

20180620/https://www.routertech.org/memberlist.php?mode=contactadmin

----------

GCC accepts an `-EL` MIPS option that can be used to generate little
endian code.  Use `-EB` to generate big endian code.

20180618/DuckDuckGo gcc mips -EL  
20180618/https://gcc.gnu.org/onlinedocs/gcc/MIPS-Options.html

So, real lesson learned here.  Make sure you install your toolchain
cross compilers with access to the documentation, and read your
architecture-specific documentation.  Yeah, that is common sense...
just like making sure to download the architecture instruction set
manuals for your architecture.  So, that means setting INFOPATH to
your cross toolchain root/staging area.

But alas, these are things that an impatient programmer is willing to
skip during cross software development.  That being said, another
reason why the C programming language and the standard C library
reigns as the supreme standard.  Linux ABI, well... I'm not so sure
after reading about the problems of the MIPS ABI.

Okay, so next I need to figure out toolchain the OpenWRT/LEDE
toolchain operation so that I can rebuild musl libc properly.

----------

Wow, that MIPS cross-compiling seems like a really good idea.  Now
I want to setup something similar for doing ARM cross compiles
to Raspberry Pi.  Yeah, using the same OpenWRT/LEDE build system.

Why Gentoo Emerge?  That's a pretty good system for cross software
development.  Well... okay.  I'll be punctual on this point.  The
reason why Gentoo Emerge did not become popular is because it did not
focus on embedded applications.  Or, at least not _popular_ embedded
applications.  The important point to measure here is not the number
of devices, but the popularity among purchasing customers.  How many
individual humans were involved to individually make the decision to
purchase that device?  If this is something that effectively billions
of people decided to purchase, then you know for sure it is pretty
important.  We know that to be the case with ARM-based tablets and
smartphones and MIPS-based wireless routers, to connect all those
tablets and smartphones to the Internet.

So, the OpenWRT build system has a strong foothold.  I guess it's
unfortunate that they did not try to reuse the already existing Gentoo
Emerge build system... but I understand their motivations very
clearly: When starting out the project, they wanted to use something
small and simple, so the obvious approach was to build their own
system from scratch.  Only later do more features and functions get
progressively, interatively added to the point that it would have made
more sense to adopt an already existing, tried-and true, proven
successful solution.  The same can be said about the Android
development toolchain.  So, that's the crux of how important, core
technologies tend to get reinvented.  Only in hindsight bias can you
say that of course, the newer technology to come along later would
become far more popular than the past technology that preceded it.
