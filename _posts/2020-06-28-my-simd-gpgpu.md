---
layout: post
title: "Designing a SIMD processor of my own, reflection on many-core
        communication architectures"
date: 2020-06-28 18:29 -0500
author: quorten
categories: [unlipic, media-prog]
tags: [unlipic, media-prog]
---

Okay... it's official.  I'm now getting ready to design my own GPGPU.
The first step, mastering the design of a SIMD processor.  A simple
GPGPU is simply a collection of SIMD cores, an optimized parallel
memory architecture, and memory stores private to a single SIMD
processor (i.e. "local memory" in OpenCL terminology).  Parallel
memory architecture can be implemented real simply: just use multiple
different RAM banks, this allows for parallel _and_ strided memory
access, and put in front another multiplexer of a sort for shifting
the logical offset of strided memory accesses, and tada!  You've got a
pretty efficient parallel RAM.

So, now for the repertoire of parallel load and store instructions.

* Load index vector: Load an integer vector where the contents of each
  element are the element's index itself.  For example, `{ 0, 1, 2, 3
  }`.  This might be phrased up as a variant of the "zero register"
  load, for example.  Optional, this can be computed via a parallel
  `unfold`.

* Load vector: load a contiguous vector of the designated length into
  the designated vector register.

* Store vector: Reverse of load vector.

* Load strided vector: load a vector of the designated length where
  each element is spaced by the given offset.  That is, the address of
  an element at index `i` is determined by `mem[stride*i]`.

<!-- more -->

* Store strided vector: Reverse of load strided vector.

* Gather load vector: Using a given integer input vector, load a
  vector of the desginated length using the corresponding memory
  addresses given in the integer input vector.  A scalar base address
  may optionally be added to the integer vector.

* Scatter store vector: Reverse of gather load vector.

* Load scalar to vector: Duplicate a scalar memory operand to fill the
  designated vector register.

* Store first scalar from vector: Store only the first scalar in a
  vector to memory.  Optional, actually, this is the same as storing a
  vector of length one.

* Store scalar from vector: Store only the scalar at the given index
  in a vector to memory.  Optional, this instruction could be
  unnecessary in well-optimized code and besides, it can also be
  achieved via conditional store.

Please note that for accessing memory private to a single SIMD
processor, we basically have a flag on each of these instructions to
specify the address space: global or local.  And, sure, you can
support more address spaces from OpenCL like constant memory and the
like.  I guess you can say constant memory is kind of like an explicit
cache load.

Conditional move is particularly important for efficient SIMD
branching, so we need a good set of supporting instructions here too.
So, first of all, computing a condition value and storing the result
in a vector.  Since there will only be a single bit in the result,
boolean vectors can be much smaller.

* Vector "compare" style instructions: less than, less than or equal
  to, greather than, greather than or equal to, not equal to, equal
  to.

* Vector "bit test" style instructions: zero, not zero, AND and zero,
  AND and not zero.

Note that it is possible to design an architecture with less
conditional instructions, but the impact is that more wide temporary
vector registers will be required for condition computation.

All of the previous instructions computed conditions only independenly
on each scalar.  One thing special about condition vectors after they
are computed is that they can pretty much be treated as scalars.
Think about it, if your SIMD is 32 or 64 lanes wide, just stow the
result away in a 32 or 64-bit scalar register, and feel free to use
any scalar instruction on it like "zero" or "not zero" testing.  This
is mainly of interest for looping, which we'll discuss later.

Now, after we compute are conditions, we can use a few special.

* Conditional move: copy only the designated vector element to the
  destination vector register if the corresponding condition is
  one/true.

* Conditional load: load only the designated vector element if the
  corresponding condition is one/true.

* Conditional store: store only the designated vector element if the
  corresponding condition is one/true.

You might argue that conditional load/store are not strictly needed,
but in a general-purpose hardware architecture, they actually are.
Why?  Memory mapped hardware devices do not necessarily need treat
loads and stores to the same memory address the same.  If you read a
value from a memory mapped hardware device and then write the same
value to the same address, that may result in issuing a device command
rather than acting as a no-op.  Hence the need for conditional load
and store.

For efficient implementation of a ternary conditional move and the
like, you may also want to add conditional move/load/store variants
that only act on a zero/false condition.  Actually, this is optional
and unnecessary because you can implement ternary in registers via a
single conditional move.

Now, for looping.  Most of the time, looping is handled with a scalar
variable.  However, it is also possible, for example, to setup a loop
so that it runs until all items in a vector are zero, for example.
But, as we have mentioned previously, this is trivial to support using
a good repertoire of scalar instructions once you've computed the
condition vector.  In any case, we need to ensure we have just enough
scalar instructions in our SIMD processor to efficiently support
looping.

* A dedicated scalar register file of a certain size is required, of
  course.  It should be separate from the vector register file rather
  than a special case subset of it since it will primarily be used for
  loop control.  However, it can be shared in common as boolean vector
  registers due to previous discussion.

* Load/store scalar register.

* Copy scalar register from first element of vector register.

* Optional, maybe even unnecessary: Copy scalar register from given
  index of vector register.

* Increment/decrement scalar register.

* Add/subtract scalar registers.

* Bit-testing on scalar register: zero, not zero.

* Comparison on scalar register: less than, less than or equal to,
  greather than, greather than or equal to, not equal to, equal to.

* Conditional branch.

As you can see, I defined a very limited repertoire of scalar
instructions since the strict intent of them is solely for loop
control.  In theory, well-optimized code to be refactored into this
form when the sole purpose is for loop control.  But, if you want to
provide additional programmer convenience, you may include a larger
repertoire of scalar instructions.

On the other hand... maybe it is a good idea to provide as many scalar
instructions as you have vector instructions.  Think about it.  It's
not that hard for an OpenCL compiler.  When you have threads with
identical compute code at the start, typically when they are setting
up loop variables, the compiler can determine that not only are all
threads executing identical instructions, but they are also executing
on identical inputs and will therefore produce identical outputs.
Hence, scalar registers can be used in place of vector registers.  The
primary emphasis of this is that you can save registers, secondarily
you might also save energy during compute.

Otherwise, if you're really staunch on "vector only," then you can
just define a few more "move" instructions for data format conversions
and the conditional jump instructions for looping only use the first
vector element.  That other alternative, its main advantage is that it
saves instructions to encode, especially if you only allow computing
on a single vector width.  That makes sense... only setup load and
store for variable width, maybe even rely on the conditional form for
this behavior.

Really, thinking about this... I'm definitely leaning more toward the
pure vector side.  Quite literally, such a setup can share a whole lot
of opcodes in common with a scalar processor, you just need to add a
few extensions for vector load-store, conditions, and branching.  Same
compute opcodes, just that they compute on a full vector width rather
than a single scalar.

Finally, we just need a few more instructions for subroutine support
and the like.

* Unconditional jump.

* Branch to subroutine.

* Return from subroutine.

* HALT instruction, called when requested work is complete, etc.

What about special instructions like interrupt handling?  Come on,
this isn't a CPU for supporting an operating system... if we need
similar behavior, the CPU just halts the SIMD processors, controls
"hardware registers" via memory mapped regions, does a RESET, and so
on.  And, likewise, we don't need "compare ans swap" or "load linked"
thread synchronization primitives.

Now, I did not completely discuss what vector compute operations need
to be implemented.  Beyond the basic assumption of a good repertoire
of basic arithmetic and logical instructions worthy of inclusion on
virtually all scalar processors, a few key notes are worth
emphasizing.

* Integer multiply **must** be implemented, there are just too many
  parallel compute algorithms that cannot be efficiently implemented
  without a hardware multiply instruction.

* Count leading zeros **must** be implemented (or equivalent such as
  find last set), again for the same reason.

* Because of the nature of many parallel compute algorithms, it is
  often times very important to have a good repertoire of advanced
  math instructions like divide, square root, inverse square root, and
  so on.

* A `popcount` instruction should also be provided.

----------

Now, I didn't fully detail how the CPU controls the SIMD processor.
Here's how I envision this to work out nicely.  First of all, there is
the Unified Memory Architecture (UMA) design versus Non-Uniform Memory
Access (NUMA).  If NUMA is used, global device memory will need to be
mapped to the address bus so that the CPU can initialize GPGPU
instructions and data.

Second, there are a variety memory-mapped hardware registers that the
CPU can control.

* RESET control latch.

* Program Counter (PC) control register.  Optional, not necessary in a
  NUMA design, but very useful in a UMA design.  Basically, this
  allows you to start program execution from an arbitrary address
  after RESET.  You might opt for a system design where this can only
  be read/written when the system is HALTed.

* HALT control latch.  Optional, but very useful from a general
  coprocessor system design standpoint, when you want to save energy
  from an Operating System control standpoint, etc.  Essentially, even
  if the processor does not implement hardware interrupt support, this
  and the PC control register can be effectively used to implement
  software-defined interrupts.

  The HALT control latch can also be used to read the HALT status, and
  a systetm can be configured so that the CPU gets an interrupt once
  the GPGPU HALTs.

* HALT sends CPU interrupt latch.  Optional, configure whether HALT
  will send a CPU interrupt, so you can switch this off if the CPU is
  causing a HALT.

* IRQ and NMI control latches.  Optional, only necessary if interrupts
  are supported.

* As an optional extension, read/write access to all processor
  registers can be provided.

Now, that's a nice high-level interface to describe and all, but what
about the pin-out?  Building an SoC model, you'd simply use as many
pins as you like, separate pins for exposing the hardware registers as
"device" memory and for the coprocessor to access its own memory.
But, if you're building a physical chip and want to minimize the
pin-out, you might use this strategy.

* Both "device memory" (hardware register access from CPU) and the
  coprocessor's own memory are accessed through the same address
  lines.  The coprocessor must be in HALT mode to access device
  hardware registers since otherwise it would be busy accessing the
  coprocessor's own memory.  The address lines to the coprocessor
  memory is also put in high-impedance to prevent interfering with
  "device memory" hardware register access.

* There is a HALT input line and a HALT STATUS output line.  When a
  HALT pin input is issued, the coprocessor finishes up its current
  memory accesses and then sets the HALT STATUS when it's ready to
  process device memory commands.  The processor may optionally empty
  the pipeline before indicating that it is ready.

* When the coprocessor is HALTed, the system board (via some address
  decoding) can switch the coprocessor's address lines to high
  impedance and the coprocessor memory to low impedance for the host
  CPU to read and write coprocessor memory.

Wow, that's the lowdown on how you would configure a coprocessor
inside a system with an existing CPU.  Another point in hand: think
about taking a CPU, giving it its own dedicated memory, and put it on
a board to expose it as a coprocessor.  It actually isn't that hard to
craft such a setup.  It's just a matter of putting supporting logic on
the coprocessor board to control the impedance of the address lines
and clock signal to the coprocessor to effect a HALT controlled via
the CPU.  And, likewise, to send interrupts to the coprocessor or
receive a HALT interrupt from the coprocessor.  Technically, with
interrupts supported, you can read and write processor registers
through an interrupt mechanism to push and pull the registers to and
from memory.

The thing about coprocessor HALTs and interrupts... yeah what it comes
down to is essentially the same tenets as the ability to multitask.
Quite literally, you can send an interrupt, switch out the register
contents, and return from interrupt to switch to a new task's
coprocessor data.  Of course, this is where things get sticky with
GPGPUs since you have per-core private memory that also needs to be
context-switched, and that can be a rather expensive operation.  That
being said... context switching only needs be a thing on a scalar
coprocessor.  When you have multiple coprocessor cores, especially
with GPGPUs, it is far more common to schedule tasks to different
cores exclusively.

Sure... on one hand, if you want to replicate a GPGPU that can run
OpenCL, your requirements are simplified.  On the other hand, if you
want to create a somewhat clever and novel architecture, you might
really want the ability for each SIMD processor core to be able to
handle interrupts.  You can argue that interrupt processing is
effectively an efficient means of message passing: the notification of
a message send is the interrupt request, and the data packet contents
are found in memory.  And if you have support for interrupts and
effective backwards compatible support for scalar instruction
execution, you've got yourself a SIMD processor core that can function
in the role of the CPU.  Now all that is needed is a bootloader, since
the coprocessor board itself is designed to come up HALTed and have a
CPU load the initial program before execution.  On board-level RESET,
a tiny microcontroller is configured to come up first while every
other coprocessor core is halted, its sole responsibility is to copy
from ROM the initial boot code for each processor core to its own
coprocessor memory, then signal all the cores to execute.  Typical
system ROMs will, naturally, configure every core except for one to
HALT first thing, and the last non-halted core will execute the
remainder of the operating system bootloader.  Then again... you could
wire your address bus and coprocessors so they start executing in the
special "pre-boot address space" that gets routed to each
coprocessor's own ROM.

How do you route interrupts without a CPU?  Instead of a CPU, there is
an interrupt controller, all incoming interrupts go to it, and it then
figures where to routes interrupts to subscribers, a coprocessor
subscribes to receive interrupts from particular devices.  Arguably
even in a system design with a CPU, you can argue that the CPU isn't
truly the central locus of control, but it is the system board through
the prospects of the interrupt controller.  Because, after all, the
CPU can sleep, but the interrupt and RESET controller must never stop
until power is removed.  Okay, but fine... interrupts are hard.  You
don't always want to send an interrupt to "anyone who subscribed" but
may want to send an interrupt to onl a specific coprocessor or group
of such.  So, that's a special communication to be made to a more
complex interrupt controller compared to a CPU design.

In an ideal world, there is no hierarchy in addressing and interrupt
routing.  It's all n-dimensional.  In the real world, however, you
cannot physically wire such interconnects in any reasonable manner, so
hierarchy is often introduced to extend past a certain size, that size
being defined by the technological limits of the current available
technology.

Okay, let's think about it.  How are arbitrary communication patterned
handled with conventional computer architectures.  Let's look to the
commercial world.  The commercial world is defined as a cluster of
CPU-based machines with network interface devices that are connected
to a TCP/IP packet-switching network.  The CPU and network interface
device are connected in a master-slave arrangement, the CPU gets
interrupts on an incoming communication packet and the like.  Then
these packets go through a hierarchical switching and routing network.
Application specific integerated circuits are used for much of the
decisions about where to forward a packet next.  So, as you can see,
it's basically like we have a super duper complicated system to copy
data from one processor core to another then signal an interrupt that
the data has arrived.  All the complexity is externalized in a
convenient manner that obviates the need for an individual computer
designer to fully model it.

So, what was the system design problem that I was encountering?  The
problem was that I was trying to internalize all that complexity to
define a more general-purpose many-core system.  The whole idea of a
heterogeneous CPU-GPGPU design is that you _do not_ attempt to
internalize that interrupt controller routing complexity but you do
take advantage of being able to route task completion interrupts from
many cores to a single central processor, the CPU.  Simply put, this
allows you to run a variety of useful parallel applications with a
slimmed down, simpler interrupt controller.  Otherwise, you have to
layer in all kinds of interrupt controller complexity, switching
network complexity, and maybe even data forwarding complexity.  And,
this is also the advantage of GPGPU-style programming that does not
need synchronization directly between GPGPU cores, only between GPGPU
jobs as a whole and the CPU.  Conversely, that's the price you pay for
containerized or virtual machine network service clusters that
absolutely must communicate via a paradigm, **and** execute via a
scalar CPU paradigm.
