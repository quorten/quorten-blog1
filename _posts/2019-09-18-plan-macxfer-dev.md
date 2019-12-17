---
layout: post
title: "Plans on developing my classic Macintosh serial disk imager
        software"
date: 2019-09-18 23:37 -0600
author: quorten
categories: [mac-classic]
tags: [mac-classic]
---

Okay, so after review and working with some of my test code for my
classic Macintosh serial disk imager, this is the verdict on how I
should build things out.  In the end, I might as well go pretty all
out on the Macintosh GUI side of things, as the options for my
software are quite native and well suited to the provisions of the
Macintosh GUI.

We need a main text window display.

First, we list all of the available information on the disk hardware,
and display a window that we are ready for the user to configure
choices.  We also display default or actively configured choices: disk
drive, serial configuration, source device, destination device.

We should also support source and destination files, changing type
codes, and selecting data versus resource forks.

The menu actions:

* Select source device for reading.
* Select destination device for writing.
* Configure offset and data size for copying.
* Configure serial settings.
* Set RAM buffer size.

<!-- more -->

* Read test block.
* Display test block.
* Write test block.
* ADVANCED: Type-in or edit data in the buffer.
* ADVANCED: Asynchronous read, copy, write.
* Interactive serial test mode.
* Dumb serial terminal mode, exit with escape character.
* Open server listen for serial remote control.
* Close server listen for serial remote control.
* Definitely need to support a "setsize" command for copy over serail.
* Two serial copy commands, one without size header, one with it.
  4 bytes little endian endian header.
* In addition to hex editor, provide text editor too, of course.  A
  few modes, "binary style" of fixed width display, special characters
  as dots, line-by-line display, and word wrap.

But alas, to get things started up and running quickly, the
user-friendly concepts can be readily implemented via an interactive
command-line prompting interface that always provides for a list of
choices along the way.

----------

Nevertheless, let's entertain a few plans for a more advanced
interface.

* Compromises in implementing text editor.  Ease of allocation (code
  size) versus speed versus memory efficiency.  Easiest allocator is
  entirely slice-based, and data structures are all linked lists.
  Like a FAT, block index, next index, and is-newline bit.  Then you
  have one additional linked list that is an index of all lines.

  Each slice is 16 characters because that is what is reasonably
  efficient for storing assembly language as text.  With exclusive
  7-bit ASCII text editor, high bit can be set to indicate end of
  string/line.

  The binary style is in-place with a line index data structure for
  the sake of display.  I effectively already have working code
  developed for this.

* It would be mighty nice to support upload/download as MacBinary and
  BinHex.  In addition, to support copying and converting between disk
  files for MacBinary and BinHex.  Just in case you want to use a
  third party file transfer program.

* The only thing we're missing now, is full support for terminal
  emulation and full support for modem file transfer protocols.  And
  full support for SLIP, PPP, TCP/IP, FTP, and we can get totally
  carried away in all of that.

* Make sure to use appropriate caution dialogs for disk writes.  This
  will erase the data on the destination disk <name> and cannot be
  undone.  Are you should you want to continue?

* Why not support initializing disks in the software too?

* Also, while we're at it, zeroing disks... secure erase for those who
  want it.  Of course, not without severe and dire warnings ahead of
  time.

  But what I'm doing in practice is probably the safest of all.
  Design your program so that it only has one option and one mode:
  read from disks, write to serial.  This ensures that it is totally
  lossless on your vintage computer system, without the risk of data
  loss due to user error.

* Okay, here's another option.  Force safe mode.  Before overwriting a
  disk, compute its checksum... or just send the full disk image to
  the server for checksum computation and comparison.  If there is a
  database match, then it is perfectly safe to overwrite the disk, no
  more questions asked.  But, if the match fails, then we refuse to
  overwrite the disk.  Or alternatively, if we've sent the whole disk
  image over for comparison, then we simply save the disk on the
  server-side and continue with the commanded overwrite.  In the event
  of a software disk with some user files saved on it, inter-disk
  compression will be greatly helpful, not to mention a good means of
  automatically identifying what the source software is.

  Wow, the wonders of easily having big powerful computers at your
  disposal when doing vintage computing.  A concept that would have
  been unthinkably expensive in the true olden days.  Okay, not
  quite... you can, for example, save a disk checksum database on a
  single floppy disk.  Then you either request the user to load that
  disk for searching and comparison or you pre-load it into RAM.  How
  many disks did people typically have, 100?  Well, that's not too
  bad, less than a kilobyte of checksums.  The same checks can be
  enforced, but here, it is that the user must always have matching
  pair floppy disks.  Yes, backup is important, and this was how it
  was done in the old days.  We can keep track of an instance count on
  the database.

* Calculator and hex/decimal converters!  Oh, of course that was
  something I've been leaving missing.

Okay, great!  This actually allows us to get multiple things done at
once.  Macintosh disk transfer, Macintosh disk copy, a basic monitor
and hex edit program.  It also allows copying a disk using only a
single disk drive, even if the disk is larger than the system RAM.  A
convenience mode can be provided to support this, rather than needing
to code all the commands yourself.

The point is, we have a wizard mode for sending the size over a remote
serial connection.

We also need a means to compute checksums on data for verification.
