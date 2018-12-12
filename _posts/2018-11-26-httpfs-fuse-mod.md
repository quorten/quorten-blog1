---
layout: post
title: "Lazy download a file and access it like a local file, via the
        Linux FUSE module HTTPFS"
author: quorten
date: 2018-11-26 15:35 -0600
categories: [random-software]
tags: [random-software]
---

The big problem with HTTP file downloading I'm having is that there
are many times when I want to peek inside a large archive file or disk
image file without downloading the whole file.  I want to be able to
just read the headers.  But, with conventional HTTP tools and
libraries, you must download a file whole before you can start
processing on it.  Particularly, this was being problematic for me
since I was working with a Python tool for importing OVA templates
into oVirt.  The templates were hosted on an HTTP server, but the tool
needed a local copy of the file so that it could read the TAR headers
and determine the file contents via a standard Python library that
worked with file descriptors.  Alas, the Python HTTP modules did not
allow for any such access pattern where you have a virtual file
descriptor for a remote HTTP file where chunks are downloaded
on-demand.

So, how to solve this problem?  Of course via the traditional method
by this point in time.  If you can't rely on your user-space
applications natively providing some feature or function, see if you
can hack it into the operating system beneath.  Thankfully, Linux FUSE
provides a modular, general purpose method to do exactly that.  Of
course, patching the behavior of the kernel is ideal compared to
patching the behavior of `libc`, since a patched `libc` either
requires dynamic linking, the unlinked object code files, or the
source code so that you can link in your patched library.

So, yes, the solution!

<!-- more -->

How do you access a file over HTTP like it's a local file?  I've
already searched for this many times before, but my previous searches
were unsuccessful.  I found mention of using WebDAV on StackOverflow,
but that is overcomplicated for my purposes, and it's effectively
failed in the market for a more complicated remote home directory
solution.  All I care about is read-only random access to a file over
HTTP, and I want whatever implements that to be fairly simple.

Bingo!  I found what I want: HTTPFS.  Indeed, a simple solution for
read-only chunk-based random access to a file over HTTP.  The trick?
Being more creative in my search terms, even presumptious, and typing
in "HTTPFS" in hopes that it would bring me to what I was looking for.

Unfortunately, this dates from 2006.  Will it still work today?
Indeed, it does.  Additionally, there is a newer version of HTTPFS
named HTTPFS2, dating from 2012.  Additionally, HTTPFS2 is in Debian,
so we know it must work on modern Linux kernel versions.

20181126/https://unix.stackexchange.com/questions/67568/mount-http-server-as-file-system

20181126/DuckDuckGo linux read-only FUSE access http file like local  
20181126/DuckDuckGo linux mount http as FUSE read-only  
20181126/Google linux mount http as FUSE read-only  
20181126/Google linux httpfs  
20181126/http://httpfs.sourceforge.net/  
20181126/http://httpfs.sourceforge.net/fuse_intro.htm  
20181126/http://httpfs.sourceforge.net/techinfo.htm  
20181126/http://httpfs.sourceforge.net/net_boot.htm  
20181126/DuckDuckGo debian httpfs2  
20181126/https://packages.debian.org/jessie/web/httpfs2  
20181126/https://packages.debian.org/source/jessie/httpfs2

Use HTTPFS version 2.06.07.10.  Unfortunately, as it turns out, the
"HTTPFS2" rewrite introduced a bug where it can't work with files
larger than 2 GB.  Yeah, it's probably an easy fix to add in 64-bit
file address support, though.  Also, HTTPFS 2 when run as a regular
user gives an error about not being able to access `/dev/console`.

So, if you do want, here is some useful info on FUSE module use and
FUSE module debugging.

* Unmount a FUSE module without superuser: `fusermount -u DIR`.

* Run FUSE module in foreground: `./httpfs -f ...`

* If a FUSE module aborts or segfaults, you will get an error message
  "Transport endpoint is not connected" when trying to access a FUSE
  file or directory.

20181126/DuckDuckGo Transport endpoint is not connected  
20181126/https://stackoverflow.com/questions/24966676/transport-endpoint-is-not-connected  
20181126/DuckDuckGo linux debug fuse module  
20181126/https://stackoverflow.com/questions/1871830/how-to-debug-fuse-filesystem-crash-in-linux  
20181126/https://www.cs.hmc.edu/~geoff/classes/hmc.cs135.201109/homework/fuse/fuse_doc.html

Wow, when you think about this in the grand scheme of things, the
possibilities are endless.

1. Mount source tarball with HTTPFS.
2. FUSE VFS "extract" source tarball.
3. Mount Copy-on-Write unionfs, writes go to RAM drive.
4. Build package from source.
5. Upload package to a Docker hub.
6. Union mount Docker package files when using, again using HTTPFS,
   FUSE VFS extract, and COW unionfs if necessary.

If starting from `git clone` instead, there is the Git virtual
filesystem instead.

----------

Random software notes.

There is virtue in laziness.  A lazy download rather than an eager
download of a file over HTTP has drastically sped up my workflow for
many types of use cases.  What does Wikipedia have to say about
laziness?  Not much, unfortunately.  It gives some interesting
psychological explanations as to why laziness may happen to cause
people to not pursue more fruitful activities.

20181127/https://en.wikipedia.org/wiki/Lazy  
20181127/https://en.wikipedia.org/wiki/Laziness
