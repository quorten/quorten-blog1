---
layout: post
title: "Plans on constructing a simple pipe implementation, and other
        ideas for a simple operating system"
date: 2019-07-24 20:39 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

How to make a pipe.

`pipe()` system call does what?

* Creates a buffer.
* Creates two file descriptors, input and output.

And why is this essential to implement so early in a new operating
system development?  It allows you to write a multi-stage compiler
with ease.  You can develop and test components separately, then run
them altogether via pipelining.

So point in hand, for this use we are primarily interested in
contiguous memory buffers in RAM.  Why?  Because that is the only
thing that will work for the results of running an assembler, code
that you want to jump to in a pre-boot environment.

Okay, okay, so that is word.  Pre-boot file descriptor is as follows.

<!-- more -->

```
struct FileHeader_tag
{
  unsigned char *d;
  unsigned long len;
};
typedef struct FileHeader_tag FileHeader;

struct PBFD_tag
{
  FileHeader *file;
  unsigned long cur_pos;
  unsigned char ref_count;
};
typedef struct PBFD_tag PBFD;

EA_TYPE(PBFD);

PBFD_array user_fds;
```

Okay, now that is good enough for contiguous memory buffers, which are
the only thing that matter in a pre-boot environment.

Now that we have a clear definition of file descriptors, it is pretty
easy to build up Unix file routines.  Without a filesystem!  We don't
need hierarchy in a pre-boot environment, just enough operating system
so that we can run a compiler pipeline to produce executable machine
code to boot the rest of our world.

Blocking I/O?  The essential concept to implement before cothreading.
Okay, so first we implement the lowest level routines as asynchronous
I/O.  `EWOULDBLOCK` is a status that may be returned.  Layered on top
of this is synchronous I/O extensions.  With Coboot, this means
polling with request to switch threads on insufficient I/O.

Tada!  We have a full Unix pipeline in the making.  Well, what I mean,
enough to implement a pre-boot compiler toolchain.

Pre-boot line-based text editor?  Now, here's the key.  We do not need
support load and save routines simply due to the fact that they do
double-trouble on RAM.  Either we are full edit-in-place or we retool
the rest of our pre-boot toolchain to be able to compile a linked list
of source code lines.  Traditionally it was the latter.

Here we go, actually we go further than that and pre-tokenize the
source code before storing it.

20190724/https://en.wikipedia.org/wiki/MBASIC  
20190724/https://en.wikipedia.org/wiki/Type-in_program

As for the pre-boot pipeline wiring, well as I was saying earlier,
that you write a small program to wire together the memory buffers.
No need for a fancy shell in the pre-boot environment.

What is crucial is a way to configure standard input and standard
output, though.  Custom is easy, pass descriptor numbers and pointers
to memory addresses.  The Unix-way to do this is via fork and exec.
The bootstrap way?

I was quibbling about a procedure to configure everything.  But how?
Okay, so two main ways.

One is to pass arguments via a function call for main.

The other is to setup procesess to have global variables for their
standard input and output.  Yes, essentially fixed memory locations
where the values are stored.  You change the values in those fixed
memory locations, and it all comes together just like that.

I think, for my sake of bootstrapping, I like that method the best,
though it does of course come with its own disadvantages, namely it is
tougher to multi-instance.

But, come on!  In the pre-boot environment, we have only one goal, to
build a high-level programming language from which the rest of the
system source code is developed.
