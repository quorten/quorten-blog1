---
layout: post
title: "Review of Macintosh Classic software development tools, and
        also evolution of ROM/BIOS programming"
date: 2019-09-17 11:38 -0500
author: quorten
categories: [mac-classic, unlipic, tour-de-force, reiterate]
tags: [mac-classic, unlipic, tour-de-force, reiterate]
---

Macintosh programming started out with Pascal, and indeed Windows API
functions were made to use Pascal calling conventions.  The transition
from Pascal to C was a gradual one in the PC world.  However, Windows
used C strings and data structures.  Likewise, the PC world transition
to Unix-like operating systems.

1. No ROM, no ROM bootloader, computer hardware only
2. ROM routine library and ROM BASIC
3. ROM routine library, ROM BASIC, ROM bootloader, custom operating system
4. ROM routine library, ROM bootloader, custom operating system
5. ROM/Flash routine library, ROM bootloader, custom operating system
6. ROM/Flash routine library, ROM bootloader, Unix-like operating system
7. ROM/Flash bootloader, Unix-like operating system
8. ROM/Flash bootloader, Linux-based operating system

This is talking about the history of _mainstream computing_.  So, even
though Unix-like operating systems came about earlier when
non-rewritable ROM chips were still being used, it was not in the
purview of mainstream computing at the time.

There is a thing, there is a time where we cut out BASIC and all
interactive ROM prompt interfaces and are left with a brick of a
computer if you can't boot an operating system.  Because there is no
longer a front-panel control switch either, that has been replaced by
the ROM BASIC and ROM monitor program.  Unless you can use an add-in
card to provide one.

<!-- more -->

Again, I reiterate, because this is important!  Here is a review of
classic Macintosh development software, and a good listing at that.

* Lisa Programmer's Workshop, unnecessarily esoteric for modern use
  because (1) it only works on the Apple Lisa and (2) it only supports
  Pascal, not C, as the high-level programming language

* Macintosh Programmer's Workshop (MPW), requires a pretty hefty
  Macintosh

* Metrowerks CodeWarrior, for sure a good tool for development on
  bigger and later machines, not so sure about early and small machine
  development, faster compiles than MPW, wasn't introduced until after
  THINK C

* Symantec THINK C, early versions work well on small machines, newer
  versions require bigger machines, faster compiles than MPW

* Lightspeed C, older version of THINK C

* Megamax C, "it has bugs, notably tail recursion"

Megaroid was the namesake demo software of Megamax C.  Megaroid II by
Mr. Anonymous was recompiled on Lightspeed C.

20190917/https://en.wikipedia.org/wiki/CodeWarrior  
20190917/https://en.wikipedia.org/wiki/THINK_C  
20190917/https://en.wikipedia.org/wiki/Megamax_C  
20190917/https://en.wikipedia.org/w/index.php?title=Megamax_C&oldid=448702256  
20190917/https://en.wikipedia.org/wiki/Macintosh_Programmer%27s_Workshop

Please note in particular that many of the early C compilers are K&R
only.  No support for function prototypes is the main caveat, but it
is livable with careful programming.  In particular, make sure long
constants are cast explicitly, and do not assume the arguments will be
cast to the required types when making function calls, cast them
explicitly if the variable type does not match or you are passing a
constant.  This is the main stumbling point for retro C programming.

THINK C 5 supports ANSI C, but it is too new for running native on
older Macintoshes.  Also, it requires too many floppy disks and the
decompression is too slow on older Macintoshes.  THINK C 3 uses just
two floppy disks and works reasonably well on older Macintoshes.  More
primitive tools, that's for sure, but it's what you can work with.

ResEdit is the standard Macintosh resource editor tool, made by Apple.
Though there are some other tools available, my understanding is that
most Macintosh programmers did not venture out to use them.

20190917/https://en.wikipedia.org/wiki/ResEdit

Finally, a memorandum, development on modern Macs running Mac OS X.
The programming language compiler toolchains are all based off of
either GCC or Clang, and the IDE is Xcode.

How did I learn about all these?  MPW and Xcode, well, I heard about
them essentially "from word of mouth," though only in a metaphorical
sense since this was in effect from passing mentions of online
articles, forum posts, etc.  Megamax C and Lightspeed C, well I
learned of those from the installed game Megaroids 2.0 on my home
Macintosh.  Look in the about box.  CodeWarrior, that kind of showed
up in various searches I believe... lots of paid promotion for that
one.

Really, it was all about following the breadcrumb trail... in the
"board games" folder we've put together on our home Macintosh SE.  The
games that were more hobbyist-developed and therefore more open about
what kinds of development tools were used to produce them.  Or, most
importantly, less exclusively focused on the game itself.

CodeWarrior is better for PowerPC, that is more of its aim and
timeframe of beginning and end.
