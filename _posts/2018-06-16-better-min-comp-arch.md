---
layout: post
title: Better ideas for tiny computer architectures
author: quorten
date: 2018-06-16 11:49 -0500
categories: [unlipic, important]
tags: [unlipic, important]
---

Important!  So, that one thing you've said earlier?  You need hardware
subroutine support to properly support C calling conventions?  Well,
after careful thought taking into consideration historic programming
tricks, that's not true.

Okay, so here's how it works.  We know the historic idea for rewriting
subroutine return addresses does not work correctly with recursion or
multithreading, for that matter.  So we need a stack in order to do
proper modern subroutines.  However, using the historic programming,
trick, we _can_ in fact clear a subroutine return address from the
stack in the callee.  Here's how.

1. First of all, you need _self-modifying_ code to rewrite addresses
   on jump instructions.

2. To mitigate the issues of code being executed from ROM, initialize
   a _thread local_ "thunk" routine in writable memory (RAM).  This
   routine is effectively your substitute for a hardware subroutine
   return instruction.  The routine in writable memory (RAM) performs
   the following operations:

    1. Pop the first byte off the stack.
    2. Write it to the first byte of the jump instruction's address.
    3. Pop the second byte off of the stack.
    4. Write it to the second byte fo the jump instruction's address.
    5. Execute the jump instruction.

<!-- more -->

3. (optional) If your program needs full support for threads, you will
   need a second helper subroutine to determine the correct thunk
   routine to call, but this one can be in ROM as it does not modify
   itself.  However, this routine is _only_ possible to implement if
   the architecture supports indirect jumps, i.e. self-modifying
   assembly language is not required.  Otherwise, the routine must be
   located in writable memory (RAM) and you must guarantee that
   interrupts will not happen before the routine completes.  (The
   thunk that gets called next must then re-enable interrupts if they
   were disabled.)  It performs the following operations:

    1. Determine the current thread ID.

    2. Index into the current thread's data structures to determine
       the thread's subroutine return thunk.

    3. Jump to the subroutine return thunk to complete the subroutine
       return.

   Actually, there's aother method that works well if your
   architecture does not support indirect/computed jumps.  Before
   writing the address obtain a lock on a "busy" field and write the
   value of it to indicate another thunk is in progress.  Other thunks
   will need to wait for the lock and condition to be cleared before
   continuing.  That being said, you need to have support for locks.
   (Some systems can multitask without locks: there is only support
   for processes, all inter-process communication is mediated through
   the operating system, and the operating system itself is
   synchronized or single-threaded.)

4. Compile your programs to call the proper subroutine return thunk.
   If the thunk in memory needs to be relocatable and it is not
   possible to first call an in-ROM thunk routine that then calls the
   RAM routine, the entire process code will need to be loaded into
   RAM so that relocations can be processed before execution.

So, lucky for you, it turns out that you can spare yourself from the
complexity of a processor design that supports subroutine returns yet
still be able to get the features and functions in executing code, so
long as it supports computed/indirect jumps, namely with the address
inside of registers or on the stack.  Or if your system is only single
core, or if you have proper support locks... you get the idea.  It's
possible on simpler systems, but it requires a bit of cleverness to
create the proper abstractions.

----------

Also, I have additional discussion on that tiny 4-bit instruction
set I've designed.

* The syntax I've been experimenting with for instruction set
  specification?  Unfortunately, I must admit that is "unnecessarily
  esoteric."  The goal of the project was to create simple systems
  that are relatively similar to modern computer systems and are not
  "unnecessarily esoteric."  Hence I am ditching that specification
  for something more traditional.  The idea was the specification
  could be used directly for formal verification... but I think the
  established practice nowadays is more about using a reference
  hardware design and simulations to compare behavior.

* Just write "ZERO AL" instead of "XOR AL, AL".

* Condition codes read/written are indicated with CC().

* MB() is now only used for multi-byte immediates or registers.

* Pointer dereference is simple PD(I1, I2).  No need for MB() for
  multi-byte addresses.

* No need for both arithmetic and logical shift rights.  With only one
  bit shifting, rotate through carry is all that is needed to emulate
  arithmetic and logical shift left and shift right.

So now we have one instruction free.  What do we use it for?  Well, we
have a few competing ideas that we'd like to squash in there.

* XOR instruction
* OR instruction
* JS or JNS instruction
* JO or JNO instruction
* CMPXCHG instruction

Now as you can see, I am unfortunately trying to cram one of 5 (or 7)
things into a single slot.  If I was really hard-pressed on this
issue, I would claim in favor of picking CMPXCHG as it does something
that you can't otherwise do with software emulation.

Wow, so there you have it.  The decision has been made.

Unfortunately, I now don't want to add it as it requires for memory
intermediates since it uses two memory addresses.  No way, too
complicated for this simple processor.

Okay, so I guess that just leaves us with one instruction free for
now.

Wow, but a further simplification is here:

* Since the programmer always must know what the decimal mode is set
  to in their program, CLD and SED can effectively be used as no-op
  instructions.

Yet another instruction code is free for use.

* _Not_ yet adding CAR and BOW instruction.  Oh, yes, definitely!
  Those instructions are amazing for programming tiny 8-bit systems.
  Alas, they only work well if you can load operands without modifying
  the carry bit, which you unfortunately cannot do on this 8-bit
  system where you must do an add to do a load.

* Rename SBC to SBB to follow Intel naming convention rather than 6502
  naming convention.  Flag set/clear instructions still follow the
  6502 convention.  Load and store instructions follow the 6502/MIPS
  convention rather than the Intel convention.

* Note that there's the Intel alternative to a BCD mode flag: a
  "decimal adjust after addition" instruction, and a "decimal adjust
  after subtraction" instruction.

* Dropping the ZERO instruction: the key reason being that it doesn't
  play well with CAR and BOW.  Now I can replace ZERO with LD and add
  CAR and BOW.  The lack of a "set carry" (SEC) instruction may seem
  like a disadvantage in light of CAR and BOW, but it turns out that
  "CLC" plus "ADC" immediate is almost as efficient.  Still not as
  efficient as an INC and DEC, though.

* Dropping ADC I1 instruction: Yes, in general, it's a nice
  instruction to have, but weighing it with the alternatives, it seems
  a bit odd compared to the other arithmetic and logical instructions,
  plus it's nice to have space for a SEC instruction.  This means that
  adding a constant costs one more byte in instruction encoding space,
  but incrementing and decrementing isn't as expensive.

----------

4-bit:

Based off of the EDSAC, but modified to be more consistent to modern
computer architectures.  An asterisk ("*") indicates which
instructions are radically different than the EDSAC's original
instructions.  Including a NOT instruction is particularly useful for
excess-3 negation (add three to the normal BCD value to get excess-3).

With 4-bit bank switching, a maximum of 12 address bits can be used.
Alternatively, the same instructions can be used with 8-bit registers
and 8-bit immediates, giving a maximum of 24 address bits with 8-bit
bank switching.  Another viable configuration is to use 8-bit bytes
for the accumulator and memory, but 4-bit groupings for the
instruction stream.

Recommended use: This pure, simplistic, 4-bit instruction encoding is
probably most useful only as a means to implement the core of a more
complicated CPU in a serial instruction-based manner.  Another
practical use is a very simple calculator.  For those purposes, 256
bytes of non-bank-switched memory is plenty.  Most sophisticated,
modern software at the very least requires a 16-bit stack pointer, for
which this architecture doesn't even provide any stack pointer.

    Condition Codes: CC
    Zero: Z
    Negative: N
    Carry: C
    Overflow: V
    BCD mode: D

    AL: Accumulator register

    I1: Immediate byte 1
    I2: Immediate byte 2

    Instructions:

     * NOT AL => CC(Z, N), AL
       AND AL, PD(I1, I2) => CC(Z, N), AL
     * CAR CC(D, C), AL => CC(Z, N, C, V), AL
     * BOW CC(D, C), AL => CC(Z, N, C, V), AL
       ADC CC(D, C), AL, PD(I1, I2) => CC(Z, N, C, V), AL
       SBB CC(D, C), AL, PD(I1, I2) => CC(Z, N, C, V), AL
       RCL CC(C), AL, 1 => CC(Z, N, C, V), AL
       RCR CC(C), AL, 1 => CC(Z, N, C, V), AL
     * LD AL, PD(I1, I2) => AL
       ST AL, PD(I1, I2) => PD(I1, I2)
       JNZ MB(I1, I2) => MUX(Z, NIL, MB(PL, PH))
     * CLC => CC(C)
     * SEC => CC(C)
     * CLD => CC(D)
     * SED => CC(D)
       HLT => !

       Excluded:

     * XOR AL, PD(I1, I2) => CC(Z, N), AL
     * OR AL, PD(I1, I2) => CC(Z, N), AL

     * INC CC(D), AL => CC(Z, N, C, V), AL
     * DEC CC(D), AL => CC(Z, N, C, V), AL

     * ADC CC(D, C), AL, I1 => CC(Z, N, C, V), AL

     * XCHG

     * TEST
     * CMP

     * JZ
     * JS
     * JNS
     * JO
     * JNO
     * JC
     * JNC

     * JL
     * JG
     * JLE
     * JGE

     * CLI
     * CLV
     * SEI

     * BRK
     * CMPXCHG

Instruction execution pipeline:

1. Fetch and decode
    1. Fetch opcode
    2. Instruction decode
    3. (optional) Fetch immediate 1
    4. (optional) Fetch immediate 2
2. Memory
3. Execute
4. Write-back

Given that there can be up to 4 memory access cycles per instruction,.
the "pipeline" doesn't necessarily imply that this design can be
easily pipelined.  The implementation of a prefetch instruction queue
and multi-byte fetches can streamline the pipeline process.

Actually... yes, an important observation here.  You can't do any
pipelining until you've fetched the entire instruction, including all
immediate bytes, otherwise the next fetch pipeline stages will need to
be invalidated.  Okay, so I have to admit that I really never worked
all that much in processor design, I only took a few classes where we
implemented the simplest of RISC processors as an assignment.

----------

### CISC (Complex Instruction Set Computer) Pipeline

Related.  What does the pipeline look like for a more complicated
microprocessor that allows address computation in load and store
instructions?  Suffice it to say, you add one more execute stage
before the memory stage.  This also facilitates other complex
instructions like instructions that require two execute stages or
compute instructions that store their result directly to memory.

Instruction execution pipeline:

1. Fetch and decode
    1. Fetch opcode (refill prefetch instruction queue)
    2. Instruction decode, compute instruction length and increment PC
    3. (optional) Fetch immediate 1
    4. (optional) Fetch immediate 2
2. Execute
3. Memory
4. Execute
5. Write-back

Yeah, it's complicated.

    T0  T1  T2  T3  T4  T5  T6  T7  T8  T9  T10 T11 T12 T13 T14 T15

    FO  ID  FI1 FI2 EX1 MEM EX2 WB
                    FO  ID  FI1 FI2 EX1 MEM EX2 WB
                                    FO  ID  FI1 FI2 EX1 MEM EX2 WB

And, as you can see, the pipeline is quite shallow due to the
complexity of the fetch system.  Actually, we can tighten up the
pipeline with a bit more computation in the decode stage to compute
the next instruction address and save the addresses of the immediates
into pipeline registers.  Note that unlike the case of a simple MIPS
processor with fixed-width instructions, we cannot increment PC
(Program Counter) at the fetch stage as we do not yet know the full
length of the instruction.

    T0  T1  T2  T3  T4  T5  T6  T7  T8  T9  T10 T11 T12 T13 T14 T15

    FO  ID  FI1 FI2 EX1 MEM EX2 WB
            FO  ID  FI1 FI2 EX1 MEM EX2 WB
                    FO  ID  FI1 FI2 EX1 MEM EX2 WB
                            FO  ID  FI1 FI2 EX1 MEM EX2 WB
                                    FO  ID  FI1 FI2 EX1 MEM EX2 WB

From two instructions in flight at a time to four instructions in
flight at a time.  Sure this is faster, but does this use more
hardware and energy to get there?  Actually, no.  You're just
relocating the adder units from the immediate fetch stages to all
happen in parallel in the decode stage.  Only in a non-pipelined
design can you otherwise share those adder units.  Also, we're looking
pretty good in terms of concurrent memory access: only two memory
accesses can happen in parallel.  That additional EX1 stage actually
really helps us in that regard.  Okay. about energy consumption.  Only
acceptable if you can show that total energy costs are decreased
elsewhere by, say, not needing to supply main power to as many
parallel systems.  Actually, I must say, this is pretty good compared
to ideal simple MIPS with a 5-stage pipeline and fixed width
instructions.  Plus, you get that much more compatibility with
existing software and old processors.  Well... okay, not quite.  I was
comparing the wrong metric.  The difference is half an instruction per
clock cycle versus one instruction per clock cycle.  So, let's look
into closer detail about what we can do to speed this up: the prefetch
instruction queue.

### Prefetch Instruction Queue (PIQ)

With a prefetch instruction queue, it is technically not necessary for
an instruction to have a separate "fetch" stage: only "prefetches" are
needed.  Hence, the prefetch can be done in parallel with the decode,
hence eliminating that extra stage and bringing us back to one
instruction per clock cycle, even with variable-length instructions.

When the prefetch instruction queue gets flushed and totally emptied,
it is permissible for the fetch opcode stage to take multiple cycles
and stall the pipeline until it is ready in a regular state.  Of
course, this causes a corresponding increase in the time delay and a
performance hit of a pipeline flush from jumping.

With a sophisticated enough prefetch instruction queue (PIQ), it is
possible to eliminate the "fetch immediate" pipeline stages, as the
pertinent memory accesses would have been done during refilling the
prefetch instruction queue, so the decode stage could simply transfer
those prefetched values to pipeline registers.  Alternatively, you
might argue that eliminating these stages and delegating them entirely
to the prefetch instruction queue degrades performance, as the burden
on refilling the prefetch instruction queue on flushes is increased:
not only does the opcode need to be filled into the prefetch
instruction queue, but any potential immediates need to be filled in
too, increasing the number of memory accesses in advance and pipeline
stalls on a PIQ flush.  Yet still, on the other hand, shortening the
pipeline leads to less opportunities for data hazards and stalls to
occur, which should in theory improve performance.  Shorter pipelines
also mean that pipeline flushes have less performance impact.

Now, it turns out there are ways to optimize the prefetch instruction
queue beyond a naive implementation.  First of all, the prefetch
instruction queue can fetch from fast instruction cache memory rather
than main memory.  This has the very obvious advantage of not needing
to worry about dual-port access: of course you can design your own
on-chip cache memory to have as many ports as you want.  The cache is
simply loaded from main memory in big blocks, and thus most memory
stalls are limited to those instances.  Second, with a nice fast
instruction cache and a very fast parallel prefetch instruction queue
that can prefetch faster than instruction execution, you can load
multiple entries in parallel and implement _simultaneous branch
prefetch_: for every branch instruction, instructions along both
branch paths are prefetched in parallel.  This limits branching
overhead quite a bit, to only that of pipeline stalling.  It is very
important, however, that advanced prefetches never stall the pipeline:
there is no instruction that needs it yet, so why cause waits?  Only
when a prefetch is immediately needed should a prefetch stall the
pipeline.  Additionally, in the case of simultaneous memory access, it
might even make sense to add pipeline circuitry to prioritize memory
fetches on behalf of instructions in preference to instruction
prefetch.

What about the energy cost of branch prefetch?  You're consuming
energy to prefetch entries that ultimately aren't used, is that
acceptable?  Okay, good point.  This deserves careful analysis, as
faster in time may not mean better in terms of energy cost.

Of course, you also have to know where your branch instructions are
and where their destinations lead to in order to do this.  Yes, branch
prediction.  The easiest way to do this is to add a branch instruction
to a cache _after_ it executes.  Wouldn't it be faster if you scanned
in advance and added it before?  Well, maybe, but then you have to pay
the price of the overhead of decoding instructions in advance.  Sure
sounds a lot like speculative execution, and if you do that, similar
to my previous discussion, you must be especially careful that
speculative execution does not cause stalls that noticeably alters the
behavior of earlier code, else you'll be haunted by the Meltdown and
Spectre vulnerabilities as we all know very well today.  So, let's
avoid speculative execution for that reason.  As we will discuss, it's
actually not necessary on our architecture.

You can do "forwarding" on branch instructions too: after the execute
stage determines the address of the next instruction, this can be
forwarded to the decode stage of the next instruction, which can then
immediately process the already prefetched instruction.  Matter of
fact, with a separate fetch stage eliminated, the pipeline flushing
can be limited to only one cycle: the decode stage of the very next
instruction that gets invalidated.  Effectively, this functions more
like a stall than a flush.

For the reason of having a very efficient prefetch instruction queue,
speculative execution provides very little performance benefit.
Out-of-order execution?  Don't need it.  With such short pipelines, it
doesn't make a big difference.  For sure, out-of-order execution is
something more pertinent to complex instruction set computers with
long pipelines and many complex instructions.

### Improved CISC Pipeline

Improved instruction execution pipeline:

1. Refill prefetch instruction queue in parallel, instruction decode,
   compute instruction length and increment PC
2. Execute
3. Memory
4. Execute
5. Write-back

    T0  T1  T2  T3  T4  T5  T6  T7  T8  T9  T10 T11 T12 T13 T14 T15

    ID  EX1 MEM EX2 WB
        ID  EX1 MEM EX2 WB
            ID  EX1 MEM EX2 WB
                ID  EX1 MEM EX2 WB
                    ID  EX1 MEM EX2 WB
                        ID  EX1 MEM EX2 WB
                            ID  EX1 MEM EX2 WB
                                ID  EX1 MEM EX2 WB
                                    ID  EX1 MEM EX2 WB
                                        ID  EX1 MEM EX2 WB
                                            ID  EX1 MEM EX2 WB
                                                ID  EX1 MEM EX2 WB

Whoopee!  See?  Right there, more than twice as fast.  Also, our
pipeline is still limited to a maximum of two memory accesses in
parallel.

How much faster do we get with only 4 pipeline stages, with the
execute stage before the memory stage in the modern MIPS style?

1. Refill prefetch instruction queue in parallel, instruction decode,
   compute instruction length and increment PC
2. Execute
3. Memory
4. Write-back

    T0  T1  T2  T3  T4  T5  T6  T7  T8  T9  T10 T11 T12 T13 T14 T15

    ID  EX  MEM WB
        ID  EX  MEM WB
            ID  EX  MEM WB
                ID  EX  MEM WB
                    ID  EX  MEM WB
                        ID  EX  MEM WB
                            ID  EX  MEM WB
                                ID  EX  MEM WB
                                    ID  EX  MEM WB
                                        ID  EX  MEM WB
                                            ID  EX  MEM WB
                                                ID  EX  MEM WB
                                                    ID  EX  MEM WB

Yeah, as it turns out, only one instruction faster over the same time
period, due to less pipeline latency.  Not a big improvement.  The
biggest improvement came from optimizing the fetch/decode stages.
However, the biggest speedup not measured here is the performance
improvement under pipeline flushes, which of course is always better
with shorter pipelines.

Why is the MIPS-style pipeline preferred?  That is, when you execute
before memory, rather than doing memory before execute?  Good
question.  On one hand, I would be tempted to say that it is more
efficient with pipelining.  But a closer inspection doesn't seem to
state that is always the case.  Suffice it to say, if you have a lot
of registers, the MIPS style pipeline can work very well.  With only
one execute stage, either you pay the price in needing a separate
instruction to compute the load-effective address before loading
memory, or you pay the price in needing a separate instruction to load
your operand before computing.  Intuitively, it seems ideal to have
two execute stages for this reason, but that comes with the
disadvantage of a longer pipeline, which means jumping is more
expensive.  In either case, using only one execute stage limits your
choice of instructions, so the remainder of the answer/preference
comes from compiling and benchmarking code.

### Energy costs

If one thing can be evident from the previous discussions, clever
tricks to speed up a pipeline also increase energy consumption at the
same time.  What are the major tradeoffs here?

* Prefetch instruction queue.  Any implementation of a prefetch
  instruction queue increases energy cost as you may be prefetching an
  instruction that never gets used, in effect wasting energy.  So, it
  turns out that explicit fetch stages are what MIPS does well to save
  energy.

  However, by limiting the prefetch to the very next instruction, you
  minimize the amount of energy you're wasting.  Also, you could argue
  that branch prefetch only saves one cycle, so you could disable that
  in the interest of saving energy.  The other option besides branch
  prefetch is _explicitly disabling_ prefetch when you predict a
  branch instruction is coming.  This way, you never waste the energy
  from doing a wrong prefetch at a branch instruction.

  Yet, on the other hand, you still have to weigh this with the fact
  that adding branch prediction circuitry consumes more energy.  Is
  that energy cost really worth the energy savings of avoiding excess
  prefetches?  Actually, I don't think so.  Unless you have super-long
  instructions, it might be worth it.  Well, let's take this into
  mind.  The most performance-critical code in most sofrware is within
  "tight inner loops."  So, if you can optimize the energy efficiency
  of the looping, that effects an overall more energy efficient
  processor.

  Okay, here's what I think for loop optimization.  There's a better
  way, somewhat more related to the instruction cache memory.  Not
  only do you maintain a "prefetch," but you also maintain a
  "post-fetch" of previously fetched instructions.  A loop, naturally,
  jumps back to an already fetched instruction, so the idea is that
  you can just save that and do a quick look-up on the past
  instruction stream.  For sure, that reduces the energy needed to
  copy data, which is purportedly greater than the energy increases
  needed to maintain a larger fast prefetch cache.  Okay, yeah, I
  think that might be more viable than full branch prediction: simply
  record branch targets after they are executed so that you can
  maintain a post-fetch there for a while.

* Interrupts in a pipelined processor.  In a pipelined processor, an
  interrupt causes a pipeline flush, which later needs to be refilled
  on return from interrupt.  Effectively, this corresponds with wasted
  energy.  Again, the negative effects of this can be mitigated
  through the use of shorter pipelines.

  Matter of fact, the pipeline overhead from an interrupt is much
  higher than the pipeline overhead of jumping: an interrupt can
  happen when the pipeline is completely filled up, but a jump only
  causes a partially filled pipeline to get flushed.

    * However, I must also note that this phenomenon is not limited to
      scalar processors: parallel processors running many threads
      simultaneously, even if they do not have pipelining, respond
      similarly.  The lesson learned here: Very fast compute
      processors do not handle interrupts well.  However, the simplest
      of non-pipelined processors handle interrupts very well.  So, if
      you want to create the simplest processor necessary to support a
      modern operating system and respond to user input/output, you
      better go with a non-pipelined design.

      However, I must note even with a very fast compute processor, if
      you follow my recommendations for using an APIC efficiently with
      strict time slicing scheduling, then actually interrupts can be
      limited to the known timer tick interval and when the processor
      is otherwise idle and completely halted.

      Finally, of course if your pipelined design is much faster than
      a non-pipelined design, you get the performance advantages
      during tight inner loops, and during interrupt-driven code, you
      still get the same performance as you would with a non-pipelined
      processor.

      Well, speed-wise.  But yes, energy-wise, pipelined and
      vector/parallel processors should not be interrupted, except at
      timer-tick intervals.  Interrupts should instead be routed to a
      non-pipelined processor.

        * Hey, good idea!  Well, if the timer-tick interval is known,
	  the processor can plan in advance to not fill up the
	  pipeline as the timer tick is nearing, correct?  Indeed,
	  that is correct.  The processor can have its own timer tick
	  functionality, and that function can be integrated with the
	  pipeline for energy efficiency.  Now you can save energy
	  **and** have a fast core for your main central processor.

### More complex instruction tricks

So, what about looping instructions, like the memory block
instructions of the Z80 and the string instructions of x86 CPUs?
Well, there's a simple solution for that.  The looping instruction
proceeds through the fetch-decode stages, then when it gets to the
execute and memory stages, each loop iteration enters the same stage,
effectively creating a pipeline stall.  However, this is going to
happen in such a way that the very next instruction after it has been
fetched and decoded, so when the loop iterations end, it can
immediately kick off and begin executing.  So, the pipeline still
works even in this case.  As a practical matter, it may as well be a
good idea to use longer opcodes for these looping instructions, since
they pay out savings from their many iterations anyways.

Finallly, once you've mentioned that nifty trick, you can also use the
Nvidia Single Instruction, Multiple Thread (SIMT) trick to execute
many threads in parallel that use the same instruction.  Those
instructions themselves can be looping-style to effectively eliminate
instruction fetch and decode overhead in tight inner loops, not to
mention adding speed from parallel execution.  Sure simultaneous
execution is easy, but simultaneous memory access... that's where
things get tough.  The practical solution to this problem is to limit
memory access of the lowest-level parallel threads to small, local,
shared blocks.  A progressively smaller number of higher level threads
of control have access to more memory, up until you have the general
purpose CPU with full memory access.  Otherwise, your main problem in
implementing the system is designing memory systems that have
thousands of ports for thousands of simultaneous accesses.  The higher
level threads transfer memory in large blocks at a time, with no
special scatter-gather behavior.

----------

Other worthy notes about microprocessors.  You know the idea of having
every instruction on a processor available as a conditional?  Well, it
turns out that is a reality with ARM CPUs.  So indeed, using _lots_ of
conditionals is up for grabs as a practical means to avoid pipeline
flushes.

How do you know when a section of code is large enough such that using
all conditional instructions would be slower than using a jump
instruction?  Effectively, each single jump sets you back one
pipeline's worth of instructions.  So, if you have a run of
instructions significantly longer than the length of the processor's
pipeline (i.e. twice as long), you know it makes more sense to use a
conditional jump rather than a run of conditional instructions, from a
performance standpoint.  What about instruction encoding efficiency?
Basically, it turns out to be about the same argument: the percent of
space wasted becomes increasingly smaller as your body of conditional
code grows longer.

Finally, we must always remember this very important point in hand.
Why didn't earlier processors have conditional instructions?  The
primary limitation on earlier processors was instruction encoding
limits.  With so few opcode bits to begin with, adding just a few more
options implies a significant overhead.  It simply isn't worth it when
building the simplest of systems, compared to adding the least number
of opcodes necessary to get your system up and running.
