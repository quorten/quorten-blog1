---
layout: post
title: What exactly is the stack?
author: quorten
date: 2018-06-02 17:53 -0500
categories: [unlipic]
tags: [tour-de-force, unlipic]
---

What exactly is meant by the "stack"?  Well, when writing computer
programs, a "stack" is a useful data structure to use in general.
However, for modern compilers and hardware architectures, the
_hardware stack_ has a special use and meaning.

The _hardware stack_ should only be used for the following:

* Storing subroutine return addresses

* Storing local variables for the particular subroutine

* Passing in variables and returning variables from subroutines

* Handling interrupts and exceptions

For any other memory allocation pattern that does not meet these
constraints, the data must instead be placed elsewhere in memory.
Typically, all other such memory allocations are handled by a memory
allocation manager called the _heap_.

In conventional programming languages, the stack is at the highest
memory address and the heap is at the lowest memory address.  (That
is, the highest and lowest addresses available for user code, not
reserved by the operating system.)  The stack grows down toward lower
memory addresses, and the goal of a heap memory manager is to keep the
whole collection relatively contiguous and grow upward toward higher
memory addresses.  In theory, this allows for the most optimal use of
available memory by any program.  In practice, the stack has an
arbitrary limit set in advance such that it cannot grow all the way to
the limit of the heap.

* Footnote: Although it is possible to allocate variable-sized data on
  the stack, this is strongly discouraged in modern-day computer
  architectures.  Why?  When only fixed-sized variables are allocated
  on the stack, it is possible to compute the address of any stack
  local variable by adding a constant to the address of the top of the
  stack.  But, if those items are of variable-size, you need to keep
  track of another variable, the _base pointer_, in order to locate
  variables on the stack.  Finally, the variable-sized data has a
  fixed-size pointer that is stored near the top of the stack.  The
  point is that with allowing a variable-sized stack, you get one less
  CPU register to work with, which slows down code in the common case.
