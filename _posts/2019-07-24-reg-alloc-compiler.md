---
layout: post
title: Register allocation considerations in a compiler
date: 2019-07-24 20:46 -0600
author: quorten
categories: [unlipic]
tags: [unlipic]
---

Register allocation considerations in a compiler.  There is more than
one way to do register allocation in a compiler, but the simplest way
is to lazily leave a variable allocated to a register until there are
not enough available, then do a least-recently-used (LRU) eviction,
using the number of instructions since allocation as a reference for
the LRU clock.  This provides pretty good performance for the common
case: You have a section of code that needs to operate on a variable a
few times in rapid succession, then once you are past that section,
you don't need to use the variable for a long while.  The idea of
"pinning" a variable to a register and leaving it there until it goes
out of scope is a more obscure one, and it also subtracts from your
supply of registers that can be used for LRU management.

The extreme opposite end, loading a variable into a register for one
use, computing, and storing it back to memory, is the easiest and most
orthogonal to compile, but also the least efficient computation
technique.

