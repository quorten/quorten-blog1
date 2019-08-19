---
layout: post
title: Type-in arbitrary binary files on various operating systems
date: 2019-08-08 16:24 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

How do you "assemble" a type-in program on modern Unix?  How about
some of the older but once popular operating systems?

1. `vi` -- type-in special characters and save.  MS-DOS edit: the
   binary mode might be adequate.

2. `bash` -- write a shell script to convert hex type-in to binary.

3. `perl` -- same method as `bash`, but different language.

4. `python` -- same method as `bash`, but different language.

5. web browser -- similar to `bash` method, but using Javascript.
   Then download the binary file produced, via a data URI.  May not
   work with some old browsers, unless server-side assistance is used.

6. PowerShell -- similar to `bash` method, but using PowerShell.

7. `bat` files, NT `cmd` scripts -- similar to `bash` method, but
   using `bat` or `cmd` files.

8. `vbs` files -- similar to `bash` method, but using Visual Basic
   Script (VBS).

9. MS-DOS `DEBUG` -- as its name suggests, for the sake of debugging,
   you get direct access to a hex byte code editor.  You can type hex
   byte codes into memory and execute the produced program, or you can
   save to a file.  You can even save to direct disk blocks.

<!-- more -->

10. Mac OS Classic?  Almost impossible, but there is a method.

    This method only works for "compact" Macintoshes, i.e. built-in
    black and white monitor and MC68000 CPU.  Get a system boot disk,
    boot up, press the "programmer" key near the back side of the
    computer (need sticks to push through grills, see elsewhere on the
    Internet for more details), and enter the "MicroBug" ROM debugger.
    Note that this is not available on the Macintosh 128K, 512K, and
    XL computers, though.

    Late generation OS 9, impossible.  AppleScript?  Okay, maybe
    that's the saving grace, if we have a way to write resource forks
    so that we can generate an executable application.

How about modern Windows?  That's a bit tougher.  But, never fear, the
web browser method is in business.  Or, for sufficiently new Windows,
PowerShell.  For sufficiently old Windows that doesn't have fancies,
never fear, MS-DOS `DEBUG` is in business.  For some Windows in
between old and new, Visual Basic Script (VBS) is probably
pre-installed and can fit the bill.

Once you have your binary file, you can execute it.  In all cases, the
first thing you're going to want is the standard monitor program that
gives you an easy low-level virtual monitor interface.  A virtual
computer without an MMU tantamounts to pretty much single-process
execution.  Yes, essentially it is similar a traditional 8-bit home
computers.

Please, define that in the strictest, smallest, most limited sense.
Okay, you have a terminal, command-line interface means to read and
write memory as hex byte codes, and you can execute memory as machine
code.  That is the bare minimum.

The most immediate useful extension is to support checksum.  List
memory with checksum display.  Simple XOR checksum is guaranteed to
catch a single error, but two or more errors may be missed.
Probability of misses is reduced by using longer checksum.  A single
swap error is guaranteed to be detected with at least a two-wide
checksum.

Let's discuss some metrics on our simple monitor program design.

    Assume max 40 chars terminal width.
    8 bytes a line, 3 * 8 = 24
    4 chars address + 2 space = 6
    8 chars checksum + 2 space = 10

    8 chars checksum is overkill, 4 chars checksum is adequate

    prob. checksum error on two errors = 1/16 * 1/8 = 1/128 = <1%

So keep a count of number of errors made so far.  Worst case, can't
enter more than 128 lines reliably.  Common case, maybe max 8192 lines
reliably, or 64 KiB.  And that's why we only give the user a 16-bit
address space.

Some immediately useful extensions are to support disassemble,
single-step, and read/write registers.  Assemble is more advanced,
breakpoint is more advanced, and so on.

Tada!  You've got a method to create arbitrary binary files on some of
the most important modern operating systems in the style of type-in
programs.

Natural next step would be to download the rest via serial port
hardware, else you must type in A LOT of code.  Plus, what's the use
of using a computer in the modern era without networking?

So to speak, my environment I am building out is like a modern version
of Forth.

1. Build the "front panel control switch."  On modern systems,
   this is a script to convert hex byte codes to binary.

2. Key in the monitor program.

3. Use the monitor program to key in larger programs.

4. You're in business!
