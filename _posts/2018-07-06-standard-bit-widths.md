---
layout: post
title: Standard bit widths
date: 2018-07-06 17:46 -0500
categories: [tour-de-force, unlipic, important]
tags: [tour-de-force, unlipic, important]
---

Important!  Bit widths and their uses continued.

6-bit: MIPS instruction set opcode width.

Many RISC architectures were historically designed for fixed-width
32-bit instructions entirely.  Later on, 16-bit instruction width
support was added.  So, if you're wondering what bit-width is required
in an instruction set, that is the place to look.  Importantly, most
useful instructions can be encoded in 16 bits, and only a few
additional instructions require 32 bits.

Additional bit widths are very popular to use in computer graphics,
though not so much character sets or machine architecture.

<!-- more -->

* 5-bit: 15-bit/16-bit RGB color.
* 10-bit: ???
* 12-bit: Higher channel depths.
* 12-bit: "Esoteric" character sets.
* 12-bit: Encryption cipher keys.
* 14-bit: Higher channel depths.
* 15-bit: RGB color.
* 16-bit: RGB color.
* 16-bit: Instruction width.
* 24-bit: RGB color.
* 24-bit: Address bus width.
* 32-bit: RGB/RGBA color.
* 32-bit: Address bus width.
* 32-bit: RISC instruction width.
* 32-bit: IPv4 address width.
* 48-bit: High channel depth RGB color.
* 48-bit: Address bus width.
* 48-bit: MAC ID width.
* 56-bit: Address bus width.
* 64-bit: Virtual address width.
* 128-bit: Message digest width.
* 128-bit: IPv6 address width.

So, let's list the most popular bit widths used, in total.

1, 2, 4, 5, 6, 8, 10, 12, 14, 15, 16, 24, 32, 48, 56, 64, 128

20180706/https://en.wikipedia.org/wiki/MIPS_architecture
