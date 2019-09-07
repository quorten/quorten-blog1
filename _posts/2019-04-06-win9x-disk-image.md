---
layout: post
title: Copy a Windows 9x disk image over the network
date: 2019-04-06 09:48 -0500
author: quorten
categories: [vintage-computing, windows]
tags: [vintage-computing, windows]
---

Now, here's a challenge.  Say you've got an old 1990s PC running
Windows 95, Windows 98, Windows 98 SE, or so on.  How do you copy a
hard disk image from that computer over the network?  The previous
methods that I have given assumed the ability to run GNU/Linux, which
is undisputed in the modern computing world.  But, the 1990s GNU/Linux
world was a world far away from the world of GNU/Linux that we know of
it today.  By far and by large, most people got started by installing
GNU tools on their existing operating system, but before they could
get any further to trying out a full GNU/Linux, their PC was already
obsolete and they were upgrading to a newer one that would have come
pre-installed with Windows XP.  Here, they would have had no fear
doing the risky steps of repartitioning the hard drive on the fresh
install of the new computer, not to mention the later genre of
computers had much more homogeneous hardware and therefore better
driver support by Linux.  But, most importantly, the newer hardware
was _much_ more powerful, so running even modern GNU/Linux
distributions on 2000s era hardware is a breeze.

But, nevertheless, there were still a significant number of people
willing to take the challenge to get Linux installed and working on
1990s era PCs, and when they did get it working, they got it working
quite well and it was useful for a large number of tasks.  So,
challenge ahead of us, how do _you_ get started?

<!-- more -->

For the cautious, first take a look at the next section "Linux kernel
considerations" before you continue.  For the impatient, first head
over to "Your first GNU/Linux boot on the old hardware," then come
back to read "Linux kernel considerations."

### Linux kernel considerations

First of all, and this is important, we want to know this: what
specific hardware does the PC have?  Like I said, there's a lot more
diversity in hardware in 1990s era PCs than 2000s era PCs.  The
easiest way to start here is to boot up Windows 9x and head on over to
the Device Manager.  Take a good careful look at the device names
provided and note down all device names **and** the names of the
driver files used for the devices.

Next, head on to your Linux kernel source code.  Which version?  This
is important.  First of all, we must be punctual in emphasizing this
point.  Newer kernels are generally more bloated: they contain more
lines of code, the compiled kernel images are bigger, and the
operational kernels require more pinned, unswappable RAM.

If your kernel is too big to fit on a boot floppy disk, that's going
to make your life so much harder.  1990s era PC CD drives are _not_
capable of reading CD-RW discs, so if you want to use the CD drive,
you need to burn a CD-R disc, and if you want to make changes to your
burned CD image?  Tough, you need to burn another CD-R disc.  Also, be
weary of network booting Linux on 1990s hardware as may require even
more RAM, not to mention you're going to need to use a boot floppy
disk anyways as your 1990s era PC probably doesn't have network
booting built into its BIOS or network card ROM.  So, remember that
booting 1990s Linux for starters with an existing Windows installation
generally means building a Linux boot floppy or using LOADLIN (covered
later).

More pinned, unswappable RAM may not be that bad of an issue if you're
only inching up a little bit, but past certain point, this causes a
tremendous blow to application performance.  Unmodified 1990s era PCs
are generally already pretty starved on RAM capacity for applications,
so you want a kernel with as small of a pinned RAM footprint as
possible, and even so, you'll be relying on a regular amount of
swapping to get typical applications moving through your 1990s era PC.
Although, I must note, minimalistic GNU/Linux live CDs successfully
sidestep need for swap space.

Finally, there is the driver equation in newer versus older kernels.
In general, newer kernels contain more drivers, but sometimes there
are exceptional circumstances where newer kernels deprecate some
drivers or _a ton_ of drivers.  The transition from kernel 2.4 to
kernel 2.6 resulted in the deprecation of _a lot_ of drivers pertinent
to 1990s hardware, not to mention that kernel 2.6 is twice as bloated
by memory consumption during operation.  However, I must note that for
my particular hardware I was investigating, I happened to find all the
necessary drivers and hardware support available in kernel 2.6.  But,
point in hand, the overriding decision is that kernel 2.4 works best
on 1990s hardware.  If you want to be even more miserly on memory at
the expense of driver support and other complications, you can also
try using the even older kernel versions.

20190405/https://en.wikipedia.org/wiki/Linux_kernel  
20190405/https://en.wikipedia.org/wiki/Debian_version_history  
20190405/https://cdimage.debian.org/mirror/cdimage/archive/

So, now that you've selected your 2.4 kernel (Debian Woody, year 2002,
Debian Sarge, year 2005), unpack the source tree and search around in
it to verify you have drivers for all your essential hardware.  If
you're hardware is like mine, you should be fairly fortunate and find
that you have drivers for the following:

* Intel 386 compatible CPU with 32-bit protected mode, of course!

* IBM PC compatible, DOS compatible MBR boot BIOS, of course!
  Technically this is a bootloader matter and not a kernel matter, but
  your kernel and bootloader must be compatible with each other!

* El Torito CD-ROM boot, i.e. via virtual bootable floppy disk image
  emulation.  Direct bootable CD-ROM images are not supported.

* Standard PC "Super I/O" chipset, of course: keyboard, mouse, floppy
  disk controller, parallel port, serial ports, game port,
  programmable interval timer, real-time clock, and possibly more

* Console-mode text, VGA/SVGA Linux framebuffer.

* Advanced Power Management (APM), and perhaps support for additional
  power management controllers (???)

* PCI IDE (a.k.a. "Parallel ATA") hard disk controller, typically from
  widespread PIIX/ICH chipsets support, sometimes from SiS 5513 driver
  or others.

* ATAPI CD-ROM support is similarly widely standard in drivers,
  basically covered by the IDE controller support drivers.

* Ethernet network interface controller (NIC) drivers, _of course_
  Linux has no shortage of these!

* Audio drivers, handled by ALSA.  Many cards are supported, which is
  important as 1990s era audio was heavily nonstandard in hardware
  interface and relied on drivers to make them work across all
  software.

* USB support, basically only two drivers are needed for two massively
  adopted flavors: Intel-based Universal Host Controller Interface
  (UHCI), or the open industry standard Open Host Controller Interface
  (OHCI).  UHCI USB interfaces are slower than OHCI USB interfaces
  because UHCI relies on more software processing for the interface,
  so don't expect too much out of your PC's USB if it says UHCI.

  Of course, with USB, once your interface is working, peripherals are
  all downhill thanks to standardized USB classes and peripheral
  interfaces.

* Display drivers in detail are handled by user-mode programs such as
  Xorg or XFree86, but this is generally something you need not worry
  about getting started since standard VGA/SVGA works on virutally all
  graphics cards.  The main caveat you get for not having the right
  display drivers in Xorg/XFree86 is the inability to use display mode
  power save (DPMS).

* Printer drivers in detail come from user-mode programs such as
  Ghostscript, CUPS, Foomatic, Gimp-Print, Gutenprint, and so on.

* Scanners are handled via standard TWAIN drivers, Scanner Access Now
  Easy (SANE), and so on.  Generally, you should not have problems
  accessing your scanner, although there are some scanners that are
  finicky due to needing custom TWAIN drivers.

Hardware for which drivers in particular tend to be missing:

* Soft modems, i.e. "winmodems," which rely on software signal
  processing drivers that were only ever developed for Windows.

* 3D graphics acceleration?  Well, let's state that you're generally
  not going to have that unless you search really hard and are lucky.
  In general, graphics cards of the time provided a lot more in the
  way of 2D graphics acceleration, and any 3D acceleration was
  relatively rudimentary compared to today's cards, of course.

* Specialized hardware peripherals such as CNC routers, astronomy
  telescopes, assembly line process control, and so on are controlled
  by custom user-mode programs, of course!

So, you're off to a pretty good start in terms of hardware that is
likely to be supported out-of-the-box on a prebuilt Linux kernel image
and `initrd`.  If additional drivers are missing, you can find the
pre-compiled kernel modules and insert them into your `initrd`,
possibly kicking other drivers out that you don't need to keep the
size within bounds.

Let's also quickly discuss filesystems.  `ext2` is the gold stadard
for 1990s era Linux installations.  In general, the newer filesystems
(`ext3`, `ext4`, `xfs`) are more powerful and therefore consume more
kernel resources to operate.  Be careful about _how_ you build an
`ext2` filesystem, though, as newer tools may build the filesystem
using size parameters that are incompatible with the older kernels.
So, start out with `ext2`, and if that works well, you can experiment
with the others.

Now, with all this discussion about kernel, you might want to compile
your own kernel.  Be forewarned that you will also need to use a
"period accurate" toolchain to compile Linux 2.4, namely `gcc` 2.95.3
and `binutils` 2.9.1.0.25.  Why?  The Linux kernel uses GCC
"proprietary" extensions, and compatibility for these was not
maintained between the versions.

I'll let you in on a tip not generally mentioned online: sometimes,
you can use `gcc` up to the latest minor version of the 3.x.x just
fine to compile anything that compiles under `gcc` 2.95.x, with the
minor annoyance of several warnings that certain programming contructs
are flagged as deprecated.  But, as soon as you upgrade to the `gcc`
4.x.x series, these warnings will become errors.  But, in any case, if
you want to build an older version of `gcc`, you proceed via a
"cross-compilation" method of gradually stepping backwards in time,
using one compiler to compile an older compiler not more than one
major version apart.

20190404/DuckDuckGo compile linux 2.4  
20190404/https://stackoverflow.com/questions/45453233/compiling-2-4-20-kernel-in-centos-6-5-2-6-32-kernel

Another thing you'll probably be tempted to do is to use a modern
embedded standard C library in place of an older version of `glibc`.
However, I also have to warn you on this because the modern embedded
standard C libraries, naturally, are built with a more modern set of
assumptions in mind.  Many memory allocation sizes may default to
larger quantities that work just fine on modern embedded systems, but
can be quite a stress for 1990s era PCs.  So, here's my advice.  If
you want to use an embedded C library, do strive to be a bit "period
accurate," although you need not shy away from modern embedded
development techniques where we know better.  I picked a 2008 era
`uClibc` to use, and it worked quite well.  In order to be more modern
in development, instead of rebuilding `gcc` etc against `uClibc`, I
copied and modified the code from musl libc to create a custom `gcc`
specs file (for `gcc` 4.4.3) to use `uClibc` in place of the standard
C library.  Keep in mind that if you are static linking user mode
programs with embedded C libraries, you won't get some fancy things
that are expected on PCs like LDAP/NIS support.

Finally, a kernel discussion is never complete without a user-mode
discussion.  Thankfully, the Linux kernel has strived to maintain a
compatible system call interface over the decades, so most user-mode
programs should work out-of-the-box, so long as they are compiled to
be compatible with your specific CPU and ELF object file format.
Statically linked binaries are as easy as that!  If there are shared
libraries involved, then you need to make sure that all shared
libraries are available and compatible, but honestly that is not a
matter between the kernel and user-mode programming interface.

----------

### Your first GNU/Linux boot on the old hardware

So, that was a lot of useful background information, but how do you
get started with ease?  Just as was the case with 2000s era PCs,
Knoppix is your go-to live, bootable CD distribution to get started
with GNU/Linux.  However, we need to throw in a twist to fit into the
smaller, cramped memory space available on the older PCs.  For this,
there is an old stripped down version of Knoppix called Damn Small
Linux, or DSL for short.  The fate of DSL has been the fate of many
small-time early Linux projects: discontinuation.  Nevertheless, it is
still a useful tool for our purposes.

Download the DSL ISO image here, courtesy of Wikipedia:

20190405/https://en.wikipedia.org/wiki/Damn_Small_Linux  
20190405/https://archive.org/download/damn-small/damnsmall-0.4.10.iso  
20190405/https://web.archive.org/web/20080101215039/http://www.damnsmalllinux.org/

To ensure that your optical disc is readable by the vintage CD-ROM
drive, make sure you burn this image onto a **CD-R** disc, not a CD-RW
disc or any other newer technology.  There's a reason why the newer
technologies are not compatible with the older ones!

If you are of a different kind of impatient and don't have a blank
CD-R disc and CD-R burner drive on hand, you can do this nifty trick
instead.  Unpack the DSL ISO image.  You will see this file hierarchy:

    CD_ROOT/:
      autorun.bat
      autorun.inf
      index.html
      KNOPPIX/:
        boot.cat
        boot.img
        KNOPPIX
        mkfloppy.bat

Copy the KNOPPIX folder to your FAT32 Windows 9x hard drive so that it
looks something like this:

    C:\:
      KNOPPIX/:
        boot.cat
        boot.img
        KNOPPIX
        mkfloppy.bat

Now, copy `boot.img` to a 1.44 MB floppy disk:

```
diskcopy boot.img A:\
```

Use your 1.44 MB floppy disk as your Linux boot floppy.  DSL will scan
the available drives and pick up your hard drive installation just as
if it were the "CD-ROM" drive.  This is known as "poor man's install."
Congratulations, you're booted!

20190405/https://web.archive.org/web/20071230022535/http://www.damnsmalllinux.org/notes.html  
20190405/https://web.archive.org/web/20071231203448/http://www.damnsmalllinux.org/wiki/index.php/Main_Page  
20190405/https://web.archive.org/web/20071226044231/http://www.damnsmalllinux.org/wiki/index.php/Local_Startup_Documentation  
20190405/https://en.wikipedia.org/wiki/Knoppix  
20190405/http://knoppix.net/  
20190405/http://knoppix.net/wiki/Main_Page  
20190405/http://knoppix.net/wiki/Cheat_Codes  
20190405/http://knoppix.net/wiki/Category:Hard_drive_Installation#Poor_man.27s_install

Finally, if you don't have a floppy disk on hand, you can use LOADLIN
from MS-DOS.

20190404/https://en.wikipedia.org/wiki/Loadlin  
20190404/http://tldp.org/HOWTO/Loadlin+Win95-98-ME.html  
20190404/https://web.archive.org/web/20011201203302/http://elserv.ffm.fgan.de/~lermen/  
20190404/https://web.archive.org/web/20011030002638if_/http://elserv.ffm.fgan.de:80/~lermen/manual.txt

First download yourself a copy of the latest version of LOADLIN to
ensure it works with 2.4 kernels.

20190406/http://youpibouh.thefreecat.org/loadlin/loadlin-1.6f.tgz

Historic reference can be found here:

20190406/http://www.ibiblio.org/pub/Linux/system/boot/dualboot/lodlin16.tgz

Next, perform the following steps.

* Unpack `loadlin-1.6f.tgz` to the `C:\KNOPPIX\loadlin-1.6f` directory.

* Unpack the contents of `boot.img` to the `C:\KNOPPIX\boot` directory.

* Copy loadlin.exe to `C:\KNOPPIX\boot\loadlin.exe`.

* When creating the following text files, be careful to make sure that
  lines are terminated with carriage-return linefeed pairs, otherwise
  LOADLIN can have funny problems reading the argument response file.

* Create a command-line response file named
  `C:\KNOPPIX\boot\knoppix.txt` that looks like this.

```
vmlinuz /dev/ram rw lang=us ramdisk_size=100000 init=/etc/init apm=power-off hda=scsi hdb=scsi hdc=scsi hdd=scsi hde=scsi hdf=scsi hdg=scsi hdh=scsi vga=791 initrd=miniroot.gz nomce quiet BOOT_IMAGE=knoppix
```

This has been copied out of the `knoppix` menu entry in `SYSLINUX.CFG`
inside of `boot.img`.  If you would like to mimic one of the other
boot menu options, you can copy the corresponding command-line
instead.

Create a batch file named `knoppix.bat` that looks like this:

```
loadlin @knoppix.txt
```

At this point, you can try booting into MS-DOS.  Hold down the (left)
Control key during the early boot of Windows, and you will get a boot
prompt menu.  Select "Safe mode command prompt only" and you will
proceed to boot to a DOS prompt, with minimal drivers loaded and
maximum memory available.  If there are extra drivers loaded or
insufficient memory available, LOADLIN may fail to properly boot
Linux.  Now you can execute the LOADLIN batch file to continue booting
into DSL.

For fancier boot menu configuration, you can take a look at the more
detailed documentation on LOADLIN and the TLDP HOWTO.

----------

### Building a minimalistic `netcat`

By now, you should be able to boot your old PC into Linux, verify that
you have the necessary disk drivers and network drivers loaded, and
ultimately verify that you can access the hard disk device directly
and the network.  But, you'll note that the `netcat` command is
missing from your DSL installation!  Oh no, how much effort do you
have to put in to bring this into the old world?  No worries, the
process is actually rather easy, I'll show you how.

First of all, let's state the environment, our requirements, our
objectives, and how we'll move forward on them.

* We want a way to easily set up a build environment for building new
  programs to run on the old hardware.  For this, we will borrow
  techniques from the modern embedded software development world to effect a
  cross-compile of compatible binaries to the older hardware.

* If your modern PC is of an x86 or x86-64 CPU architecture, there is
  no need to rebuild `gcc`.  Alternatively, if you already have an
  existing x86 or x86-64 `gcc` cross compiler, you can simply reuse
  that.  Thanks to our modern embedded software development knowledge,
  we know that you only need to build `gcc` once per _major_ processor
  architecture.  Additional differentiation (such as little endian
  versus big endian, 32-bit versus 64-bit, glibc versus musl libc,
  etc.) can be obtained simply by specifying flags in a `gcc` specs
  file.

* As we have discussed earlier, thankfully, the Linux system call
  interface has been extremely stable over the decades, so in general,
  there is no need to worry about cross-compiling targeting a specific
  Linux version.  If it's any Linux version, it's all Linux versions!

* For maximum ease of cross-compile, we will be targeting statically
  linked binaries.  In order to save as much space as possible with
  this requirement, we will be using an embedded C library.  In order
  to be as period accurate as possible and in order to save RAM, we
  will use an older embedded C library.  Namely, I picked uClibc
  version 0.9.30 from 2008.

  20190405/https://uclibc.org/  
  20190405/https://uclibc.org/downloads/uClibc-0.9.30.tar.gz

* We will be using small amounts of code from musl libc 1.1.10 (year
  2015) to help us put together a `gcc` specs file and a `gcc-uclibc`
  command.  This will allow us to easily call `gcc` and use our
  "period accurate" uClibc library when we want to compile software
  for our old computers.

  20190405/https://www.musl-libc.org/  
  20190405/https://www.musl-libc.org/download.html  
  20190405/https://www.musl-libc.org/oldversions.html  
  20190405/https://www.musl-libc.org/releases/musl-1.1.10.tar.gz

* There are two main versions of `netcat`: `netcat-openbsd`, a much
  more modern and more powerful version of `netcat`, and
  `netcat-traditional`, the original and simple version of `netcat`.
  For the obvious stated reasons of striving for simplicity and
  compactness, we will work with `netcat-traditional`.  Simply
  download the unmodified `netcat` 1.10 tarball from SourceForge.net.
  (Despite the name `nc110.tgz`, it is actually a XZ-compressed
  tarball.)

  20190405/http://netcat.sourceforge.net/  
  20190405/http://downloads.sourceforge.net/project/netcat/netcat/0.7.1/netcat-0.7.1.tar.gz  
  20190405/http://nc110.sourceforge.net/  
  20190405/http://sourceforge.net/projects/nc110/files/latest/download

So, with all that in place, let's get rolling.

First, download all the pertinent software previously referenced.

```
curl -L -O https://uclibc.org/downloads/uClibc-0.9.30.tar.gz
curl -L -O https://www.musl-libc.org/releases/musl-1.1.10.tar.gz
curl -L -O http://downloads.sourceforge.net/project/netcat/netcat/0.7.1/netcat-0.7.1.tar.gz
curl -L -o nc110.tar.xz http://sourceforge.net/projects/nc110/files/latest/download
mkdir build
```

Now we will build uClibc.  As a minor technicality, I found that I had
to patch up the process like follows.

```
cd build
tar -zxf ../uClibc-0.9.30.tar.gz
cd uClibc-0.9.30/

# Make sure at least a blank `.config' exists before starting.
touch .config

# Change `getline()` to `ucgetline()` to avoid a name collision with
# `glibc`.  Also define `_ASM_X86_POSIX_TYPES_32_H` in
# `libc/sysdeps/linux/i386/bits/kernel_types.h` so that we don't get
# erroneous redefinitions when the equivalent system headers are
# included.  Also, there's another weird change that I don't fully
# understand that is required to assemble with newer Binutils.  Watch
# the tabs in this patch!

patch -p1 <<EOF
diff -Nurp uClibc-0.9.30.orig/extra/scripts/unifdef.c uClibc-0.9.30/extra/scripts/unifdef.c
--- uClibc-0.9.30.orig/extra/scripts/unifdef.c	2008-04-27 18:10:00.000000000 -0500
+++ uClibc-0.9.30/extra/scripts/unifdef.c	2019-04-05 23:39:55.952344119 -0500
@@ -206,7 +206,7 @@ static void             done(void);
 static void             error(const char *);
 static int              findsym(const char *);
 static void             flushline(bool);
-static Linetype         getline(void);
+static Linetype         ucgetline(void);
 static Linetype         ifeval(const char **);
 static void             ignoreoff(void);
 static void             ignoreon(void);
@@ -512,7 +512,7 @@ process(void)
 
 	for (;;) {
 		linenum++;
-		lineval = getline();
+		lineval = ucgetline();
 		trans_table[ifstate[depth]][lineval]();
 		debug("process %s -> %s depth %d",
 		    linetype_name[lineval],
@@ -526,7 +526,7 @@ process(void)
  * help from skipcomment().
  */
 static Linetype
-getline(void)
+ucgetline(void)
 {
 	const char *cp;
 	int cursym;
diff -Nurp uClibc-0.9.30.orig/libc/sysdeps/linux/i386/bits/kernel_types.h uClibc-0.9.30/libc/sysdeps/linux/i386/bits/kernel_types.h
--- uClibc-0.9.30.orig/libc/sysdeps/linux/i386/bits/kernel_types.h	2008-07-23 06:23:36.000000000 -0500
+++ uClibc-0.9.30/libc/sysdeps/linux/i386/bits/kernel_types.h	2019-04-05 23:31:04.449902687 -0500
@@ -10,6 +10,7 @@
 #if !defined(__ARCH_I386_POSIX_TYPES_H) && !defined(_ASM_X86_64_POSIX_TYPES_H)
 #define _ASM_X86_64_POSIX_TYPES_H
 #define __ARCH_I386_POSIX_TYPES_H
+#define _ASM_X86_POSIX_TYPES_32_H
 
 typedef unsigned short	__kernel_dev_t;
 typedef unsigned long	__kernel_ino_t;
diff -Nurp uClibc-0.9.30.orig/libc/sysdeps/linux/i386/crtn.S uClibc-0.9.30/libc/sysdeps/linux/i386/crtn.S
--- uClibc-0.9.30.orig/libc/sysdeps/linux/i386/crtn.S	2005-07-06 17:22:22.000000000 -0500
+++ uClibc-0.9.30/libc/sysdeps/linux/i386/crtn.S	2019-05-27 12:33:01.546066659 -0500
@@ -2,21 +2,23 @@
 
 .section .init
 .global _init
+_ucl_init:
 .type   _init,%function
 	popl	%ebx
 	popl	%ebp
 	ret
-.size _init,.-_init
+.size _init,.-_ucl_init
 
 
 
 .section .fini
 .global _fini
+_ucl_fini:
 .type   _fini,%function
 	popl	%ebx
 	popl	%ebp
 	ret
-.size _fini,.-_fini
+.size _fini,.-_ucl_fini
 
 
 
EOF
```

Note that I was executing the compile on an Ubuntu 10.04 LTS
distribution, so you may need to make further modifications.  If on
Ubuntu 16.04 LTS, you do not have `gcc-multilib` installed, no
worries, you can simply symlink the `/usr/include/asm` directory as
follows:

```
sudo ln -s /usr/include/x86_64-linux-gnu/asm /usr/include/asm
sudo ln -s /usr/include/x86_64-linux-gnu/bits /usr/include/bits
sudo ln -si /usr/include/x86_64-linux-gnu/sys/* /usr/include/sys
```

Now configure uClibc.  The main things you want to adjust is
architecture, included features, security, and PIC.  For our sake, do
not exclusively build PIC, but also build position-dependent code.
Basically what this means is that object code locations are determined
at link time and then fixed at runtime (or relocatable by the means of
a relocations table), which is good enough for us.  When we compile it
all as statically linked, this really doesn't matter for us, but it
makes things easier.

```
make menuconfig
```

For reference, these are the differences in the config file I used
compared to all default selections.

```
# TARGET_alpha is not set
TARGET_i386=y
TARGET_ARCH="i386"
CONFIG_GENERIC_386=y
DO_C99_MATH=y
UCLIBC_HAS_FENV=y
UCLIBC_HAS_LONG_DOUBLE_MATH=y
# DOPIC is not set
# HAVE_SHARED is not set
UCLIBC_HAS_BSD_RES_CLOSE=y
```

Now build it.  The process should run smoothly to completion.

```
make -j`getconf _NPROCESSORS_ONLN`
```

Install it to your desired installation prefix as follows.

```
make install PREFIX=$HOME/dsl/build/tools
```

Now, using the referencec in musl libc, build your `gcc` specs file
and launcher as follows.

```
PREFIX=$HOME/dsl/build/tools/usr/i386-linux-uclibc
UPREFIX=$PREFIX/usr
sh musl-1.1.10/tools/musl-gcc.specs.sh \
  $UPREFIX/include $UPREFIX/lib \
  $PREFIX/lib/ld-uClibc-0.9.30.so | \
  sed -e 's/-nostdinc //g' \
    -e 's/^-dyn/-m elf_i386 -dyn/g' \
    -e 's/ %{shared|pie:crtbeginS.o%s;:crtbegin.o%s}$//g' \
    -e 's/^%{shared|pie:crtendS.o%s;:crtend.o%s} //g' > \
  $UPREFIX/lib/uclibc-gcc.specs
mkdir -p $UPREFIX/bin
cat <<EOF >$UPREFIX/bin/uclibc-gcc
#!/bin/sh
exec "gcc" "\$@" -specs "$UPREFIX/lib/uclibc-gcc.specs" \
  -march=i686 -mtune=generic -m32 -fno-stack-protector
EOF
chmod +x $UPREFIX/bin/uclibc-gcc
```

`-fno-stack-protector` is used since we won't have the necessary libs
to link against.  Add `-march=i686 -mtune=generic -m32` as necessary.
At the very least, you need to at least be compatible with Pentium II,
if not older.  uClibc defaults to i686, but set to i486 to be on the
safe side, as that is what DSL also supports.

Compile a simple Hello world and verify that it runs on your native
Linux kernel.

```
PREFIX=$HOME/dsl/build/tools/usr/i386-linux-uclibc/usr
echo 'main() { puts("Hello world!"); }' >hello.c
$PREFIX/bin/uclibc-gcc -static hello.c -o hello
./hello
```

Congratulations!  You've built yourself a vintage-ready "cross"
compilation environment.  Feel free to use the specs file with your
native `gcc` compiler, even if it is version 5.x.x or newer, for
compiling software, so long as the source code can build without
error.  In particular, for the sake of building `netcat-traditional`,
there is nothing you need to worry about in terms of `gcc` version.

So, that being said, let's get to that.  First, you make a few minor
modifications.

```
PREFIX=$HOME/dsl/build/tools/usr/i386-linux-uclibc/usr
cd netcat-1.10.orig/
sed -i -e "s|^CC = cc|CC = $PREFIX/bin/uclibc-gcc|g" Makefile

# This patch is ONLY necessary if you are building off of the Ubuntu
# 10.04 LTS (or equivalent Debian) `netcat-traditional`, WITHOUT
# Debian patches.  The latest upstream nc110 incorporates this fix.
# Unfortunately, the latest upstream nc110 also requires IPv6, and
# that can cause problems when compiling against an old libc.

# Watch the tabs in this patch!
patch -p1 <<EOF
diff -Nurp netcat-1.10.orig/netcat.c netcat-1.10/netcat.c
--- netcat-1.10.orig/netcat.c	1996-03-20 18:38:04.000000000 -0600
+++ netcat-1.10/netcat.c	2019-04-06 00:01:00.453900191 -0500
@@ -28,6 +28,8 @@
 
 #include "generic.h"		/* same as with L5, skey, etc */
 
+#include <resolv.h>
+
 /* conditional includes -- a very messy section which you may have to dink
    for your own architecture [and please send diffs...]: */
 /* #undef _POSIX_SOURCE		/* might need this for something? */
EOF
```

Now you just type `make linux`.

Now you have yourself the statically linked binary that you were
looking for!  Simply copy this to your KNOPPIX directory, and you will
be able to execute the binary after you've booted Knoppix.  Enjoy the
ease and comfort of sending hard disk images over the network using
virtually the same tools you are familiar with working in a more
modern environment.  But, there are two main caveats.

* You will have to use `gzip` for compression as DSL does not have
  `bzip2` inmstalled.  You can build yourself a `bzip2` if you really
  want it.  Or, better yet, avoid using compression because on old,
  slow computers, it slows down network transfers rather than speeding
  them up (unless your network is a dialup connection).

* When using netcat traditional, you must use the `-w 1` option on the
  sender to get behavior similar to the `netcat-openbsd` version.
  That is, the program will terminate once all data has been sent, and
  both sides will close the connection.

----------

Is the transfer running slow?  Wonder why?  Unfortunately, in
practice, on these old vintage computers, compression is more likely
to slow down the transfer, rather than speed it up.  Simply prefer to
do a transfer without compression.

Networking is probably the bottleneck, not disk speed.  Despite the
claim your computer may have about 100 Mbps Ethernet, real world
performance is probably going to be lower than this.

Use `mii-tool` to check the negotiated Ethernet link speed, which is
installed in DSL.

20190407/DuckDuckGo linux procfs ethernet speed  
20190407/https://serverfault.com/questions/207474/how-do-i-verify-the-speed-of-my-nic

----------

Let's step it up a notch.  Now we want to also build GNU Screen.  Of
course, we choose GNU Screen in preference of `tmux` because GNU
Screen is older, and hence better tested in these environments.  But
first, you need to compile `ncurses`, just as is required for any
fancy terminal program.

I've grabbed the sources from my Ubuntu distribution, using the
following versions:

* ncurses-5.7+20090803
* screen-4.0.3

However, I did not apply any of the distro-specific patches for my
builds.

In either case, download and unpack your sources, then build them
easily like so:

```
cd ncurses-5.7+20090803/
PREFIX=$HOME/dsl/build/tools/usr/i386-linux-uclibc/usr
./configure --without-gpm --without-cxx-binding --without-ada \
  CC=$PREFIX/bin/uclibc-gcc CFLAGS=-static \
  --prefix=$PREFIX \
  --with-terminfo-dirs=/usr/share/terminfo \
  --with-default-terminfo-dir=/usr/share/terminfo
make -j`getconf _NPROCESSORS_ONLN`
# Install is weird when we're trying to say that our target system
# already has a terminfo database, so don't bother building one.
make install
rm -rf ~/.terminfo
```

That was easy.  But for GNU Screen, we have to throw in a few tricks.
First, we must fix a bug of a sort in the naming within uClibc causing
a name collision.

```
PREFIX=$HOME/dsl/build/tools/usr/i386-linux-uclibc/usr
mv -i $PREFIX/include/sched.h $PREFIX/include/psched.h
sed -i -e 's/sched.h/psched.h/g' $PREFIX/include/pthread.h
```

We also have to define some compatibility functions that are not
defined in uClibc.  Simply add them onto the tail of `screen.c`.

```
cat <<EOF >>screen-4.0.3/screen.c

/* COMPATIBILITY FUNCTIONS */
char *
index(string, c)
char * string;
int c;
{
  return strchr(string, c);
}

char *
rindex(string, c)
char * string;
int c;
{
  return strrchr(string, c);
}

void
bzero(block, size)
char * block;
int size;
{
  memset(block, 0, size);
}

int
bcmp(a1, a2, size)
char * a1;
char * a2;
int size;
{
  memcmp(a1, a2, size);
}
EOF
```

Now we can build like normal:

```
PREFIX=$HOME/dsl/build/tools/usr/i386-linux-uclibc/usr
cd screen-4.0.3/
./configure --disable-pam \
  CC=$PREFIX/bin/uclibc-gcc CFLAGS=-static \
  LDFLAGS=-static --prefix=$PREFIX
make -j`getconf _NPROCESSORS_ONLN`
```

`--disable-pam` is only effective if you include Debian patches, but
it doesn't hurt to include it in either case.  Reduces dependencies to
make cross development easier.

Copy a nice `.screenrc` to your target machine for your convenience
and you're all set!

Now, some peculiar notes on running GNU Screen.  In old Linux such as
DSL or other bespoke distributions you add regular user write-access
to `/dev/ptmx`, because we compile `screen` to use `/dev/ptmx` (SYSV
PTY control file) because uClibc doesn't provide access to the
`openpty()` syscall.

```
sudo chmod go+w /dev/ptmx
```

When running as root, you'll get this other error of something like
"Cannot write to /var/run/utmp: Invalid argument", but that can be
ignored and you'll still be able to start just fine.

But it works!  And it is a reasonably small executable, the statically
linked uClibc and ncurses libraries doesn't put too much overhead in
there.

----------

Okay, now time for the ne ultra experiment.

Do a test drive in a virtual machine as follows.

Using VirtualBox?  Setting up the serial port isn't as nice, but it's
doable.  Enable the serial port, point it to a Unix domain socket file
(a.k.a. "pipe"), and enable creating it if it does not exist.  Attach
to it on your host side as follows:

```
( stty raw -echo && nc -u /tmp/vboxcom )
```

QEMU is easy, just attach GNU Screen to the PTY file, or even easier
if you are using `virt-manager`.

Now, in DSL, you can attach to it as follows:

```
sudo su -
screen /dev/ttyS0 9600
```

But wait!  In DSL, there is a more "native" way available for doing
likewise.  Use `microcom` as follows.

```
stty -F /dev/ttyS0 9600
microcom -D/dev/ttyS0
```

Alas, be forewarned that you cannot escape the `~` character when
using `microcom`.  This is the special command character for
`microcom`.

F.Y.I. Find the `microcom` source code here.  The software has since
vanished from its original location.

20190519/DuckDuckGo microcom software  
20190519/https://github.com/Oliviers-OSS/microcom  
20190519/https://web.archive.org/web/20061217082008/http://microcom.port5.com/m102.tar.gz

For ultimate fun, open `getty` on it.  Now, correctly running `getty`
from the command line is tricky because you must not have any terminal
allocated from the context that you are running `getty` from, or else
you will have strange problems like Bash complaining that you don't
have job control and `curses` terminal programs like `less` behaving
wonky.  But, you can do this as follows.

```
sudo passwd damnsmall
# Set a known password so you can SSH.
ssh -T damnsmall@localhost sudo getty /dev/ttyS0 9600 vt100
```

Congratulations!  Now you can login to UNIX over a serial terminal.
Enjoy the retro pleasure of being able to dial into UNIX just as you
would have in the 1980s, but without the large telephone bills from
operating a real period-accurate modem at that time.

----------

So far, so good.  Let's step it up a notch.  As an aside from another
project, I happened to get a null modem serial connection between a
Macintosh SE and a 1998 PC running DSL.  Next on the radar is getting
Kermit and ZMODEM file transfers between those two computers working,
which means that I need to get those software programs compiled so
that they are running in the right place.  Easy, I just extend my
cross-compile process to also build a statically linked binary of
those programs, right?  Not so fast.  C-Kermit, unfortunately, is very
badly rigged for cross compiling.  I took a look at the build system
in the `ckermit` Debian package and it was one that came before the
cross compiling era.

By contrast, the Unix ZMODEM package, `lrzsz`, had an autoconf-based
build system, so although I wasn't quite able to use my preferred
cross-compiling configuration for the DSL projects, I was still able
to get something up and running nonetheless.  Here's what I did.

First, I was building off of an Ubuntu/Debian package as follows.

```
cd build
dpkg-source -x ../debsrc/lrzsz_0.12.21-10~build0.16.04.1.dsc
cd lrzsz-0.12.21/
```

If you want to cut down on **a lot** of the size of the executable,
compile with a "null" `gettext` implementation rather than the
included `gettext` by removing the `--with-included-gettext` option
from the configure command line and by applying this patch:

```
# Note that we simply added these functions into an arbitrary file
that is linked into both `lsz' and `lrz'.
cat <<EOF >>src/zperr.c

char *bindtextdomain(const char *domainname, const char *dirname)
{
}

char *textdomain(const char *domainname)
{
}

#ifndef gettext
char *gettext(const char *src_str)
{
  return src_str;
}
#endif

char *dcgettext(const char *domainname, const char *src_str, int category)
{
  return src_str;
}
EOF
```

Now we can configure and make, but first we have to do something funky
to get past some sort of bug in the autotools build system that looks
to be caused from feature deprecation and version incompatibility.
(Note that we run the same commands that are used in debian/rules to
mitigate this.)

```
PREFIX=$HOME/dsl/build/tools/usr/i386-linux-uclibc/usr
CC=$PREFIX/bin/uclibc-gcc CFLAGS=-static \
  ./configure --with-included-gettext --prefix=$PREFIX
touch stamp-h.in # to stop autoheader from running
touch -d yesterday aclocal.m4 # to stop automake from running
make CC=$PREFIX/bin/uclibc-gcc CFLAGS=-static -j`getconf _NPROCESSORS_ONLN`
```

Now we can simply copy out the `src/lsz` and `src/lrz` executables to
our target system.  Easy build, right?  Enjoy!

What about Kermit?  Sorry... in the time that it was taking me to
investigate how to cross-compile Kermit, I figured working with ZMODEM
would be more than good enough for my uses, and besides, many more
hobbyists worked with ZMODEM than Kermit, so its more "authentic" for
my target vintage environment of a home computer user, and it appeared
as a consequence, the available software was better maintained
anyways, so why mess around with Kermit if I don't need it for now?

Sure, I'll eventually find a reason for why I need to use Kermit in
DSL, but not today.

----------

### Other miscellaneous notes

* `tomsrtbt` is another great, but older and more feature limited,
  option for a minimal boot image on early PC systems.

* Alternative to blockdev in `tomsrtbt`:

  # Hard drive C:
  cat /proc/ide/ide0/hda/capacity
  # Hard drive D:
  cat /proc/ide/ide0/hdb/capacity
  # CD-ROM drive E:
  cat /proc/ide/ide1/hdc/capacity

  You'll get the drive size in 512-byte blocks.  So, divide by 2
  (multiply by 512, divide by 1024) to get size in KiB.

  # Only works for hard drives:
  cat /proc/partitions

  You'll get the size in KiB.

* Link to the excellent old `dd` resource I found a while back.

  20141230/http://www.noah.org/wiki/Dd_-_Destroyer_of_Disks

* `tomsrtbt` does have a video blanking timer configured in the
  kernel, so that will save your screen during long transfers.

* Likewise with DSL, it will save your screen during long transfers.

### Boot time considerations

* Kernel 2.2? versus kernel 2.6?  Faster boot?  It actually does not
  boot that much faster.  Less RAM?  It actually requires
  approximately the same amount of RAM.  Look to `tomsrtbt`.  Requires
  a 1.722 MB floppy in the easy case.  Reformat a 1.44 MB floppy disk
  to this size.  Of course you need Windows 9x for this, not those
  newer Windows XP or the like.  Or you could use Linux, but then
  there is a chicken-and-egg problem.  (If you want to play with
  different format densities, you generally need a real internal
  floppy disk drive, not a USB floppy disk drive.)  Otherwise, you can
  jury-rig this to also boot via LOADLIN from a FAT32 hard drive.
  Show us how!

  ```
  loadlin bz2bzi~1 root=/dev/ram rw initrd=initrd.bz2
  ```

  20190406/https://en.wikipedia.org/wiki/Tomsrtbt  
  20190406/http://www.ibiblio.org/pub/Linux/system/recovery/tomsrtbt-2.0.103.ElTorito.288.img.bz2

  Also, although `nc` is included, `blockdev` is missing.  `dd` is
  heavily reduced, no conversion options, so use if you are confident
  you have no bad sectors.

* Eliminating decompression would help speed up booting.  But then you
  will need to crunch down to even smaller images for floppy disk
  boot.  Speeding up hardware probing, probably by reducing the number
  of drivers available, also helps reduce kernel image size.  Then the
  last major time sinks are inevitable: basic kernel initialization
  and DHCP configuration.

### Comparison of memory requirements

* DSL works well in 16 MB of RAM.  Theoretically its capable of
  running in 8 MB, but doing so comes at a performance cost.

* `tomsrtbt` also works well in 16 MB of RAM.  To run in 8 MB, you may
  need to restructure to run off of a root filesystem on disk rather
  than in RAM, and maybe even crunch down the kernel by compiling a
  custom version.

* 4 MB is the bare minimum memory required to run Windows 95.  8 MB is
  preferred for reasonable performance.  386 is the bare minimum
  supported CPU, but 486 is strongly preferred due to the 32-bit I/O
  bus and other performance improvements.

* You can try crunching Linux kernel 2.2 down to 4 MB of RAM, but if
  that doesn't work, you may need to work with an older kernel
  version.

----------

### My reflection

Working with has been an interesitng experience for a computer
moderner who wasn't able to be exposed to early generation Linux when
it was modern at that time.  My reflection?  Newer is not better, it's
just different.  Despite the difference, there is a compatibility
range.  But, most importantly: The main reason why the new ways cannot
be done on the old hardware is because the memory requirements are too
bloated.  CPU speed is largely not an issue, except in areas where
compression is used more extensively in the newer software.
