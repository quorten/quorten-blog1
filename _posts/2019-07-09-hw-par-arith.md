---
layout: post
title: Discussion on implementing hardware parallel arithmetic
date: 2019-07-09 18:00:00-0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

Parallel increment is easy.  Use a binary tree to determine whether a
particular bit should be inverted.  If all less significant bits are
1, then the current bit should be inverted.  Otherwise, it stays the
same.

Here's how to do parallel add.  All individual digits can be added in
parallel, of course.  The trick is to do the carry propagation using a
parallel binary tree.  Simply understand a carry propagation as an
"increment" instruction with a carry input bit that determines whether
or not to perform the increment.

Here is an example with 32 words.

1. add 32 words, compute carry for each word
2. carry propagation for 16/32 words, 16 "larger" words remaining to carry
3. carry propagation for 8/16 words, 8 "larger" words remaining to carry
4. carry propagation for 4/8 words, 4 "larger" words remaining to carry
5. carry propagation on 2/4 words, 2 "larger" words remaining to carry
6. carry propagation on 1/2 words, final "large" word with carry

Parallel multiply is easy.  Just compute all the partials in parallel,
then do a parallel binary tree add.

Parallel exponent is easy.  Just do the sub-multiplies in a parallel
binary tree.

Parallel divide???  Use a lookup table on the divisor to effect a
parallel binary search.  Now I barely even know what I'm talking
about.

<!-- more -->

Okay, here's what I'm talking about.  A memory address is like a
binary search solution.  Each bit tells you whether to go left or
right at a certain level.  Now you can design a memory so that these
switches can be programmed independently.  If so, rather than waiting
for programming the first switch to complete before you can set the
next switch (sequential binary search), you can just set all possible
later switches in parallel, and you only need to wait one switch
setting cycle to arrive at the solution.
