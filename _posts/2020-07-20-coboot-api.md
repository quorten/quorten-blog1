---
layout: post
title: "Coboot API improvements"
date: 2020-07-20 21:00 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

Ideas for a better Coboot API.

<!-- more -->

Coboot NEW ROUTINES:

* `coboot_create_self()`: Only intended to create a Coboot thread that
  corresponds to the current thread so that the main thread may
  participate in coprocessing just like all the other threads.  If you
  do this, there is no need to call `coboot_exec()`.  It's important
  to implement both styles because not all threading libraries and
  APIs commonly in current use are the same.

  What happens if you call `coboot_create_self()` a second time?
  Well, well... wait for it... you almost implement the analog of a
  `fork()` system call.  We'd need to check if g_cur_coboot_id is
  initialized yet and if it is, we save the old context.

  Wow... that opens a whole can of worms.  And we need a hook for this
  to turn it into a full fork implementation that operates by
  immediately making copies of the stack rather than using
  copy-on-write, unless we have compiler support.

  Okay... here's how it works.  If the current thread is already
  initialized, then you follow this line of actions.  First you call
  `setjmp()` to update the current context.  Then you check the return
  value.  If we're the coming from the set action, then also copy the
  recently saved context to both locations.  Then when we continue
  execution, we correspond to the old current thread ID, i.e. the
  parent of a `fork()` call.  The parent continues executing, the
  child doesn't execute unti we switch explicitly.  We need
  pre-emptive multitasking timer tick interrupts to be cleared during
  this time for the pertinent critical section to function correctly.

  For a `fork()`, we need to know the structure of jmpbuf so that we
  can copy the stack and alter the stack pointer of the child.  This
  is easy if we use our own libc routine and write our own setjmp and
  longjmp implementations.

* What happens if we destroy the thread created by
  `coboot_create_self()`?  There are two cases.

  1. This thread is the last Coboot thread.  In this case, as far as
     Coboot is concerned, we call the destroy hook, and if it does
     nothing special in this case, we simply finish off by destroying
     the object context, then returning to the caller.  It's like
     Coboot never existed after that point.

  2. There are other Coboot threads still running.  In this case, we
     end up destroying the original thread of execution and keep
     running from one of the newer threads.  When the newer threads
     finish, they must exit by destroying themselves.  Finally, when
     the last such thread exists by destroying itself, it will return
     to its execution context where it called `coboot_destroy()`!

  So, we have to understand an important realization.  In the
  principal minimalist implementation, `coboot_destroy()` can fail.
  If it does, execution will return to the caller.  This will
  principally happen if the thread cannot be destroyed because it is
  the sole remaining thread of execution.  Continuing execution
  usually only makes sense if you have converged on the main thread.
  Otherwise, it's better to define hooks so that if this happens in
  general, and we converted the main thread to a Coboot, then we exit
  the process.

Coboot HOOKS:

* `pre_switch()`: Called at the beginning of `coboot_switch_to()` to
  save additional context of the current thread and other related
  actions.

* `post_switch()`: Called at the end of `coboot_switch_to()` to
  restore additional context of the current thread and other related
  actions.

* `get_next(): When `coboot_switch()` is called, this is used to
  determine which thread to run next.

* `coboot_alloc()`: Abstract routine for storage management, find
  memory allocation and return pointer.

* `coboot_free()`: Abstract routine for storage management, free
  memory allocation.

* `coboot_stor_get()`: Abstract routine for storage management, get
  pointer to context structure of indicated Coboot ID.

* `coboot_create_hook()`: Hook function called after a Coboot is
  created.

* `coboot_destroy_hook()`: Hook function called before a Coboot is
  destroyed.  This may extend destroy behavor by, for example, calling
  a per-thread signal handler before executing final destruction,
  cleaning up per-thread dynamic memory allocation resources, etc.

So, how do these hooks get set?  If we're assuming these are big
threads, polymorphism style function pointers is preferred.
Otherwise, for tiny threading implementations, macro code copy and
paste is the alternative approach.

So you might start out with a global hook table... but what if you
want to extend with multiple different derived classes?  In that case,
you need to have a global Coboot context structure that can be
instantiated multiple times.  Not too hard of a change to make, and
derived classes can define a function call form that does not require
passing the structure, for which the derived class defines it
globally.

And actually, a good important point here... cooperative multitasking?
In that case, you don't need to implement an interrupt mechanism.
