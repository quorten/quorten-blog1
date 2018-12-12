---
layout: post
title: Interesting details about the MIPS architecture
author: quorten
date: 2018-06-24 23:40 -0500
categories: [raspberry-pi, unlipic]
tags: [raspberry-pi, unlipic]
---

The MIPS architecture is quite a curious architecture indeed.  In
particular, I must note these aspects that make it different from the
x86 architecture:

* All instructions in MIPS are 32 bits wide.  Therefore computing the
  address of the next instruction early in an instruction execution
  pipeline is a breeze.  Well, principally, unless more advanced modes
  are toggled to enable 16-bit instructions or otherwise wider ones.

* There is no explicit instruction to load immediates.  Likewise, due
  to the fixed width of the instructions at 32 bits with a 16-bit
  immediate, 32-bit immediates cannot be loaded with a single
  instruction.  Instead, a pair of instructions must be used to load a
  32-bit immediate, 16 bits at a time.

* There is no explicit stack register, nor are there explicit push and
  pop stack instructions.  The use of a stack is totally a
  discretionary decision by the compiler and/or programmer.  In
  practice, this means pairs of instructions are required to push and
  pop to the stack.

* In place of a call instruction, there is a "jump and link"
  instruction that stores the return address inside a register.
  Should this be destined to go on the stack, the compiler/programmer
  must push it on within the subroutine.  Likewise, there is no return
  instruction.  Instead, there is a "jump register" instruction.

* Unlike ARM, MIPS does not maintain a conventional flags store
  containing the zero, sign, carry, and overflow bits.  Rather, an
  instruction must be called to do the comparison and set the result
  in a register.  Well, I guess... this could save energy, as the flag
  computation logic otherwise continuously consumes energy even when
  it isn't being used.  However, loading extra instructions also
  consumes more energy, so I'm not sure if this trade-off is really
  worth it.  For sure a power simulation could determine this with the
  two alternatives available.

<!-- more -->

* "Pseudo-instructions" are graciously defined to be used by
  assemblers, in light of the shortage of direct instructions to
  perform common tasks.  The compiler may emit these common
  instructions directly, which are then converted to pairs of
  instructions, in the typical case.  Sometimes the alias is only a
  single resulting instruction.

    * Interestingly, the MIPS architecture doesn't even have a NOT
      instruction.

    * The "move" instruction is an alias for an ADD instruction with a
      register and zero.

* Likewise, given the totally general purpose register design of the
  MIPS CPU, the compiler defines many register aliases between the
  typical register (if you will) of special purpose registers that are
  mapped down to the numeric general-purpose registers available.

* MIPS has an interesting approach to standby mode: the `WAIT`
  instruction enters low-power state similar to `HLT` and similar on
  x86.  However, the twist here is how resumes are processed.  Now
  unfortunately I haven't quite figured out how full interrupt
  processing on the MIPS CPU works, but in the common case, an
  interrupt will simply resume processing to the next instruction that
  follows `WAIT`.

20180624/DuckDuckGo gcc mips assembler registers instructions  
20180624/DuckDuckGo binutils mips assembler registers instructions  
20180624/https://github.com/MIPT-ILab/mipt-mips/wiki/MIPS-pseudo-instructions

----------

So, back to your minimalistic computer architecture.  What were you
saying about a stack register?  Not true, you don't need a stack
register if you follow the example of MIPS.  Again, this is also a
MIPS thing, but as previously noted, if you have a lot of registers,
it makes sense to use a pipeline that executes before accessing
memory, hence making it a load-store pipeline.  However, there's
another key design decision at work here: the assumption that memory
is _significantly_ slower than registers, which historically wasn't
the case with older CPUs: memory was well-matched with the speed of
the CPU, sometimes capable of running even faster than the CPU itself.
