---
layout: post
title: Simple 8-bit CPU revisited
date: 2020-04-13 16:13 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

In light of it being practical to eliminate of carry flags and shift
instructions from a CPU architecture, how woiuld my simple 8-bit CPU
instruction set architecture look like with similar modifications?
This is it.

```
8-bit registers
Registers: A, B, BH (page #), PL, PH
Load-store architecture
Addressing modes: immediate, 16-bit memory, 8-bit memory from page #,
8-bit register indirect from page #
```

<!-- more -->

```
LD A, IMM
LD A, [IMM, IMM]
LD A, [IMM, BH]
LD A, [B, BH]
LD B, IMM
LD B, [IMM, IMM]
LD B, [IMM, BH]
LD B, [B, BH]
LD BH, IMM
LD BH, [IMM, BH]
ST A, [IMM, IMM]
ST A, [IMM, BH]
ST A, [B, BH]
ST B, [IMM, IMM]
ST B, [IMM, BH]
ST B, [B, BH]
ST BH, [IMM, BH]
XCHG A, B
XCHG A, BH
XCHG B, BH

NOT A
AND A, B
OR A, B
XOR A, B

INC A
DEC A
ADD A, B
SUB A, B

BZ A, [IMM, IMM]
BZ A, [IMM, BH]
BZ A, [B, BH]
BNZ A, [IMM, IMM]
BNZ A, [IMM, BH]
BNZ A, [B, BH]

JMP [IMM, IMM]
JMP [IMM, BH]
JMP [B, BH]

* NO flags
* NO interrupts
```

N.B. If we don't have a bit-wise NOT instruction but we have subtract,
we can generate it as follows.

```
NOT A = 0 - A - 1
```

I really liked the carry and borrow instructions of my previous
designs, but yeah, I'll admit.  If you omit the feature of the carry
flag, it does make the hardware design simpler, at the expense of more
complex software design.

As always, when you have a CPU architecture this simple, generally the
first thing you have to do is implement a VCPU on top of it that is
reasonably sophisticated.

When the sole purpose is to implement a VCPU, you can probably forgo
the 16-bit immediate memory addressing mode and get the following:

```
8-bit registers
Registers: A, B, BH (page #), PL, PH
Load-store architecture
Addressing modes: immediate, 8-bit memory from page #,
8-bit register indirect from page #

LD A, IMM
LD A, [IMM, BH]
LD A, [B, BH]
LD B, IMM
LD B, [IMM, BH]
LD B, [B, BH]
LD BH, IMM
LD BH, [IMM, BH]
ST A, [IMM, BH]
ST A, [B, BH]
ST B, [IMM, BH]
ST B, [B, BH]
ST BH, [IMM, BH]
XCHG A, B
XCHG A, BH
XCHG B, BH

NOT A
AND A, B
OR A, B
XOR A, B

INC A
DEC A
ADD A, B
SUB A, B

BZ A, [IMM, BH]
BZ A, [B, BH]
BNZ A, [IMM, BH]
BNZ A, [B, BH]

JMP [IMM, BH]
JMP [B, BH]

* NO flags
* NO interrupts
```

Indeed, as we are already omitting a NEG instruction, if we're
targeting the purpose of using this to implement a VCPU, we can also
eliminate SUB, OR, and XOR just fine.

To be honest, elimination of hardware shift instructions does make for
a simpler design challenge of implementing multi-bit multii-word shift
instructions.  No longer am I considering the tradeoffs of blocked
shifting chunks.
