---
layout: post
title: Constructors, destructors, compilers, and standard C library
author: quorten
date: 2018-07-06 15:46 -0500
categories: [unlipic, reiterate]
tags: [unlipic, reiterate]
---

Constructors and destructors in C.  Are they necessary?  No, it is
totally possible to write good software by inserting these function
calls manually.  However, automatic discipline can help reduce
programming errors during early development.

That being said, a source-to-source translator that automatically
inserts them or flags an error when they are missing may just as well
be a better idea than trying to extend the C programming language,
which is a solid standard with a lot of inertia.

So, the proposed solution is as follows.

<!-- more -->

* Mark up constructor/destructor variables with compiler extension
  attributes.  When compiling against other compilers, you can easily
  use macros to turn these into no-ops.

* Alternatively, define all types as macros that expand to include the
  attribute.

* Better yet, allow your compiler to mark up types with these
  annotations.

Anyways, one of the most important automatic constructors/destructors
is for garbage collection.  As I have just pointed out, this is fully
possible in C without extensions to the programming language, just the
addition of another "lint" tool at the front-end.

Now, this is really interesting.  Matter of fact, you could design the
lint tool so that it runs the compiler next without any need for code
changes on pass.  How?  Use your macros to define the attributes.  The
front-end defines a macro when it runs, but this is not defined when
the C compiler runs.  That is used to control a conditional macro in
the code on whether the macros expand to the extension or a no-op.

But finally... perhaps the most important thing.  Make sure you design
your low-level infrastructure to plug in with other more popular
high-level programming languages that are massively adopted, such as
C++, Java, BASIC, C#, .NET/Mono, Perl, Python, JavaScript, Golang, and
so on.

----------

Three main classes of standard C library libc functions:

* Advanced machine instructions, not specified in standard C grammar.
    * One of the most important advanced machine instructions: the
      system call.
    * Second category of advanced machine instructions: compound
      compute instructions, things that can otherwise be built out of
      a number of simpler compute instructions.
    * Note that with RISC architectures, there is also a such thing as
      compound compute instructions at the assembler macro level.
* System calls.
* Library functions or "algorithms".  Code that is entirely composed
  out of standard C with procedure calls.

----------

Again, I reiterate, because this is important!

The fundamental requirements for a computer CPU?

* Bit vectors for a "register."
* At least one internal register, visible to the programmer, to
  perform computations on.
* Memory access.
* Treat a register as a number, perform arithmetic operations on it.
* Bit-wise operations on a register.
* Conditional control flow.
