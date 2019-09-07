---
layout: post
title: Copy a disk image over the network
date: 2019-04-04 15:11 -0500
author: quorten
categories: [unix]
tags: [unix]
---

Suppose you want to make a hard drive image of some particular
computer and send that image over the network to another computer.
How do you do this in GNU/Linux?  Surely, the easiest way to make disk
images is through the `dd` command, but the destination of a `dd`
command must be a file, correct?  Incorrect.  Actually, the `dd`
command in its default mode reads from standard input and writes to
standard output.  If you don't specify an input or output file, the
defaults will be used.  So, you can rest assured that it is easy to
route the output or input from `dd` to network streaming commands.

Matter of fact, perhaps the easiest way to use `dd` to send and
receive disk images over the network is with this nifty trick
involving `netcat` (a.k.a. `nc`).  Insert some `bzip2` commands into
the chain to compress before sending across the network and you've got
yourself a pretty good system.

First, on the receiver, type the following commands.  You can set the
output to either a file, a physical partition, or a physical drive.
If you are storing the image to a file, you may want to skip
decompression and start by just storing the compressed disk image.

```
# Before `netcat' version 1.84-10
nc -p 2222 -l | bzip2 -cd | dd bs=16M of=/dev/sdb
# `netcat' version 1.84-10 and later
nc -l 2222 | bzip2 -cd | dd bs=16M of=/dev/sdb
```

<!-- more -->

Second, on the sender, type the following commands.

```
dd iflag=fullblock conv=sync,noerror bs=16M if=/dev/sda | \
  bzip2 -c | nc hostA 2222
```

If your dd is too old to support the `iflag=fullblock` option, then
simply omit it and the behavior will be practically the same.  On
newer `dd` versions, you should not omit the option or else if there
are any read errors detected, the read may get stuck on the error
block and fail to advance.

To optimize performance, choose the largest possible block size that
fits well in the CPU data cache and RAM.  This may cause extra data to
be written to pad out to the selected block size, but that can be
corrected via the `truncate` command.  Add `conv=sync,noerror` so that
you can continue copying disk images even if read errors occur.  Note
that if you choose a large block size, this may also cause extra
padding at the end of the image.  Use `blockdev --getbsz` and
`blockdev --getss` to get the device's block size (i.e. sector size)
in bytes and `blockdev --getsize64` to get the number of bytes on the
device.

20190404/DuckDuckGo linux copy disk image over network  
20190404/https://www.cyberciti.biz/tips/howto-copy-compressed-drive-image-over-network.html

A note on copying disk images of CD-ROMs.  Some CD-ROMs, especially
home-made CD-Rs authored using cheap commodity user-friendly CD
authoring software, format the CD such that a naive copy of all blocks
in the CD may run into some unreadable blocks that were not formatted.
Typically in commercial stamped CDs, these blocks are exclusively
found as padding "run-out" sectors at the end of the CD.  In this
case, this means that the reported size of the disk via `blockdev
--getsize64` will be larger than the actual number of readable blocks.
However, `isosize /dev/sr0` should report a number that is within the
span of readable blocks.  Home authored CD-Rs, however, can commonly
have unreadable blocks in the middle of the image, caused due to the
software allowing the author to delete and edit files before
"finalizing" the disc.

Finally, another problem that I've encountered with CD-ROMs.  When I
run `dd` without a block count to copy a disk image of a CD-ROM, this
normally works just fine, running to completion and stopping with no
errors.  But sometimes, I get a "runaway" copy that stops on error and
keeps sending null blocks forever.  For this, when I don't specify a
size, I must check up on the progress to see if I'm past the logical
limit on CD size (700 MB) and stop the process manually if it keeps
going on an error null block copy loop.

Once you store the disk image somewhere, you can use either
`VBoxManage` (from VirtualBox), `qemu-img` (from QEMU), or `virt-v2v`
(from oVirt) to convert it to your desired virtualization format.
Sometimes it may actually be easiest to boot a virtual GNU/Linux
operating system and stream to a "physical" disk in the virtual
machine to write out the data in your desired virtual disk format.

20190404/DuckDuckGo qemu-image convert from standard input  
20190404/https://serverfault.com/questions/765603/qemu-img-could-not-open-dev-stdin-could-not-refresh-total-sector-count-ope

Link to the excellent old `dd` resource I found a while back.  Despite
this being an old article, it is very much still relevant, not to
mention more comprehensive than my treatment of the subject.

20141230/http://www.noah.org/wiki/Dd_-_Destroyer_of_Disks
