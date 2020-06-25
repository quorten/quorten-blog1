---
layout: post
title: Reflection on parallel compute methods
date: 2020-06-23 22:35 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

I've defined the high-level concepts behind a powerful, generalized
parallel compute library, designed to make it easy to take advantage
of GPU parallel compute capabilities.

But, how much does GPU parallel compute capabilities actually buy you?
In the process of writing complex software, typically you will
start...  by just having a ton of programmers write a ton of code, in
whatever programming language that is convenient for them to write the
code as quickly as possible to get working code, regardless of the
speed or efficiency of the code.  Typically, this means the ability to
take advantage of GPU parallel compute capabilities is completely
thrown out the window, with the exception of areas in the code where
the programmers decided to use someone else's library whole for
high-level operations.

So, really, if you have any random software like this and you go about
asking the question, how far can you go with GPU parallel compute
optimization?

<!-- more -->

At the outset, as I see it, GPU paralell compute's prime limitation
is, by its nature, the GPU parallel compute model: parallel threads
executing identical instruction streams in lock-step.  So, really,
convince me.  `map` is easy to extend to more complex code, but what
can you do with a GPU `reduce`?  In all of my examples given thus far,
I have only defined the `reduce` combinator to pretty much map down
directly to a single GPU instruction.  How would this fare with a more
complicated combinator?  Well, upon a bit of thought, I guess I have
to say that it can still perform fairly well with a more complicated
combinator and data items.  The main consideration, of course, is that
all of the ideal-sized working memory can fit within GPU local memory
as needed.  Define your higher-order data structures and go to town
with parallel compute.

Also, another question worth asking.  How do you know when the
SIMD/SIMT parallel compute model is clearly advantageous over the
multi-core parallel compute model?  Well, this is rather funny, I am
metaphorically giggling in my own head upon this question because the
answer is so obvious to me, but it may not be obvious to the
uninitiated.  Well, obviously, you want to use the SIMD/SIMT parallel
compute model at every opportunity you have available where it works!
The simple fact of the matter is that when you have parallel threads
executing identical instruction streams in lock-step, you can control
the entire group with only a single instruction decoder unit, and that
means less physical energy consumption is required to support the
computation.  The main, primary, and only reason why you would ever
want to do otherwise is when it is essentially inevitable.  If you had
to write your code such that in order to get parallel threads
execution identical instruction streams in lock-step, you'd end up
crafting code such that _all_ parallel threads except one are not
doing any useful work most of the time, then you know you need more
scalar cores.  That is the prime reason.

Now... wait for it.  You might be conjuring up a secondary reason:
scalar cores are better because they present a simpler memory model.
To be punctually honest, that actually isn't really the case.  There's
no logical reason why a scalar core _must_ provide a transparent
caching model.  In fact, some scalar cores require explicit cache
memory management, making them somewhat similar to the need to do
explicit memory management with GPUs.  In my opinion, if the
difficulty of memory management is a concern, that can be worked
around with a smarter compiler.  The primary purpose of the hardware
memory architecture should be one that optimizes performance, and that
is indeed what GPU memory architectures do.

So, to be honest, the conclusion is clear.  From a computational
efficiency standpoint, you should always frame up as much of your code
as possible to be able to parallel compute at a low level, such that
it may be possible to phrase up the parallel computation as parallel
threads executing identical instruction streams in lock-step.  When
this is possible at the lowest level, your application gets to reap
the energy saving benefits of GPU execution by virtue of computing
with less instruction decoder units.  When it is not possible, at
least your code will still be able to run in parallel via a multi-core
method.  Historically, multi-core scalar processor architectures did
not have very efficient provisions for memory that shared across
cores, but this may be improving.  The lack of this ability meant that
historically, multi-core computing was only efficient when the
parallel tasks shared little to no data in common during the main
course of their computations.
