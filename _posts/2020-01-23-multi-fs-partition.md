---
layout: post
title: Multiple filesystems in the same partition
date: 2020-01-23 12:23 -0600
author: quorten
categories: [twitter, unix]
tags: [twitter, unix]
---

For a long time, I've been wishing to be able to have a partition with
just one filesystem that can be shared by multiple operating systems.
It would make data access on multiboot systems so much easier.  Alas,
for quite a long time, I had to side with a minimum of a dual-machine
setup: one machine is the multiboot machine, the other machine is an
always-on Unix file server.

But, we can in fact do better than that.

But, as it turns out, in spite of the lack of agreement in operating
system developers on a single filesystem where the operating system
itself can be installed, there is another alternative that has truly
come to reality.  What if you could share the data blocks of files but
have two copies of the filesystem metadata in the desired formats of
the separate operating systems?  Although that still would not be
ideal, it would at least allow for a read-only volume accessible from
both operating systems without consuming double the disk space.

Write two or more filesystems in one?  Yes, but read-only except from
Unix.

But wait... don't get over-excited, I was exaggerating a bit.  Aww,
yes, wishful thinking.  But, nevertheless, here is something to at
least spark the imagination: `cursedfs`. a script to create a
partition with both a FAT32 and ext2 filesystem within it.  The two
filesystems don't share file data blocks, unfortunately.

20200123/https://github.com/NieDzejkob/cursedfs
