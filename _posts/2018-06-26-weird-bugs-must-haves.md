---
layout: post
title: Weird Unix things, software bugs, and programming "must-haves"
author: quorten
date: 2018-06-26 10:00 -0500
categories: [unlipic]
tags: [unlipic]
---

Weird things you can do on Unix:

* `rm /dev/null`
* modify argv
* Unix permissions
    * Directories: remove read permission but keep execute permission
* Delete a file starting with a `-`

<!-- more -->

My list:

* Unix permissions
    * Remove all permissions (mode zero)
* Delete a file while it is still in use
* Change process ulimit higher, can't login because start
  with lower ulimit

Early system implementation bugs:

* Interrupting system calls or continue, "Worse is better"
* Run out of environment space, need to clean up environment variables
* Apple II: control characters in file names
* Adam2 bootloader: control characters in environment variables

Early system deliberate limitations:

* Backspace doesn't work
* File name and path length limits
* No way for user processes to get notification events when the
  filesystem gets altered.
* No filesystem change journal for backup software to read differences
  out of.
    * But really, you've got to ask yourself the question.  Where
      outside of backup software is a change journal useful?
      Antivirus software?  No, that uses filesystem notifications.
      So, the point is, if you support native "snapshotting" (possibly
      irreversible) as a built-in delta backup solution, why support
      something that is only used by a minority of backup software and
      not used by more general application software?

Unix Hater's Handbook:

* NFS (Nightmare File System)
* Shell command-line globbing

----------

Okay, so my commentary on deleting a file in use.  Normally a _stream_
behaves like a "UART", essentially it is nothing but a fixed size
buffer of at least one character.  A _file_, by contrast, can accrue a
considerable size that needs to be accounted for, and
truncated/deleted upon desire.

Then again, if you have a billion streams, you can also run into a
similar problem.  Purportedly the limit on open streams/files would be
reached first before disk space issues emerge.

So, the question.  Disk space consumption, how do you manage it in a
concurrent system?

So, another option to consider.  You can limit the total buffer size
that active processes can consume.  Then the problem of managing disk
space is as simple as this: stored data + total process buffer size <
total disk space.  Matter of fact, this must be accounted for as
processes can consume swap space too.

So, let's put it this way.  Processes need to also have a virtual
filesystem that exposes their buffers.  Here a sysadmin can list the
sizes of those buffers and truncate them, delete them, or put a quota
on a process or part of it.  Of course, doing so will likely cause the
process to crash.

Process memory and swap space?  This is managed mainly by the
operating system denying to give more than a certain limit to the
process.

----------

Another idea.  What about filesystem notification events?  Graphical
user interfaces already need this off the start, so why not implement
it early in the filesystem and share the code implementation while
implementing a graphical user interface?

Now, for some even better ideas.  You know the virtual filesystem that
exposes open file handles for processes?  Why not extend that to also
include graphical user interface widgets?  This provides not only a
straightforward way to automate graphical user interface control, but
to also record graphical user interface events during a session.

----------

Cool new features that are a "must have" for every new programming
system, typically associated as "programming languages" nowadays that
include a standard toolchain bundled.  Drawing off of Golang for
inspiration:

1. Strong typing
2. Simple, easy to learn grammar, largely drawing off of algebraic
   syntax and bulleted lists.  Likewise, having a grammar that is very
   similar to the very popular C programming language and derivatives
   "like Java" and JavaScript.
3. Compile-time workflow, the ability to quickly scan or "lint" code
   for errors in advance of actually attempting to execute it.
4. Interactive interpreter capabilities
5. Unit testing features, code coverage
6. A documentation generation system
7. A standard library of simple and common routines: "standard" (UART)
   I/O, system calls, algorithmic, mathematical.
8. Great support for concurrency and parallelism
9. Dynamic memory allocation
10. Garbage collection, for dynamically allocated memory
11. A package manager, as a practical means to "expand" the standard
    library with third-party libraries that are not yet necessarily
    "standard".
12. An expanded standard library of more advanced I/O routines,
    algorithms, etc.

"More":

* Not only "algorithms" are important for library instructions, but
  often times "algorithms" also encompasses "special instructions"
  available on some processor architectures.  These, anything beyond
  the basics are typically best exposed by C functions that are called
  by the programmer, like `memcpy`, `memmove`, `strlen`, etc.

* For library functions, it's particularly important that worst-case
  runtime is documented and that fixed runtime functions are
  available.  Particularly from a performance standpoint, fixed
  runtime functions are very intuitive.  In practice, to make a
  function fixed runtime means that the quantity of data it can work
  with is fixed at a static upper limit.

* The second best alternative to fixed runtime is documenting the
  runtime growth curve parameters and allowing functions to work with
  a variable amount of memory.  Of course, this means that any
  function that uses a variable runtime subroutine must be a variable
  runtime function itself.

* Perhaps most importantly, you can determine at compile-time whether
  a function is fixed runtime or variable runtime if the run length
  limit constants are baked in at compile time.  A trickier
  alternative to work with is setting the constants at the start of
  runtime but otherwise keeping them the same: the compiler can only
  see these as "variable runtime."

* A compile-time configuration system, like `autoconf` or
  `menuconfig`.  You could argue that it's tough to draw the line
  between this and an all-out "package manager."

  Suffice it to say, this means that there must be a package manager
  and that package manager must have some sort of "menu system" in its
  user interface, not just the command line interface.

Curiously missing from the equation is dynamic linking.  The viability
of this can be disputed in light of modern development practices of
building "immutable" containers: with that kind of workflow, there is
no need for "dynamic" linking as all the linking can be done
ahead-of-time, statically during container build time.  Yep, not
dissimilar to the traditional approach with embedded systems where
only static linking is used.
