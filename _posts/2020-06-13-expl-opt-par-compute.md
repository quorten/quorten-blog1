---
layout: post
title: Explaining optimized parallel compute primitives
date: 2020-06-13 18:00 -0500
author: quorten
categories: [unlipic, media-prog]
tags: [unlipic, media-prog]
---

Working with my spiffy new abstract math library in development, I got
really deep in the weeds when it came down to implementing fully
generalized parallel execution.  So deep, that I realized I pretty
much need to write a full out blog article of its own to be able to
explain everything that is going on in the code, mere documentation
comments won't do the trick.

That being said, I'll indeed have to actually put together something
more like a "math textbook" in conjunction with the code I am
developing.  But, for now, at least we have a better explanation of
what is going on.

All vector operations can be defined by the following attributes and
their available configurations.

* Input: scalar/vector
* Output: scalar/vector
* Working memory: scalar/vector
* Compute model: sequential/parallel
* Loop programming model: To be discussed later

The three higher-order vector functions are defined solely by how
their inputs and outputs relate in dimension.

* Unfold (like a generator function): scalar input, vector output
* Map: vector input, vector output
* Reduce: vector input, scalar output

<!-- more -->

Now, the trick is to take these simple operations, defined abstractly,
and map them down into efficient computational primitives.  Being
abstractly defined, it is then therefore easy to write concrete
functions based off of these abstract primitives that will then take
on the efficient computational primitives that they embody.

So, that being said, let's dive down into the details about the
different methods by which these higher-order functions can be
implemented.  There are two tough realities that need to be worked
with.

* When it comes down to writing up actual code to implement these
  primitives, there is often times one easiest way to write the code,
  but that one preferential implementation style may be neither
  efficient for sequential nor parallel computation.

* Although it would be ideal to execute the primitives in parallel as
  much as possible, there will always be times where some real-world
  conditions about the particular compute environment make it such
  that sequential computation is most efficient.  Therefore, we must
  also ensure that there are efficient sequential computational
  primitives available.

So now, let's briefly describe how the higher-order vector functions
can be implemented either sequentially or in parallel.

* Sequential Unfold: Given the starting scalar value, loop to
  repeatedly apply the expansion operation the given number of times
  to generate the output sequence.

* Parallel Unfold: Given a previous vector (scalar for starting
  value), apply the expansion operation in parallel across each
  previous scalar to get a set of next scalars.  The result is that
  the sequence is doubled in count.  A logarithmic number of
  sequential steps is required to expand the sequence the given number
  of times.

* Sequential Map: Loop through each scalar and compute the output one
  at a time from the corresponding inputs.

* Parallel Map: Compute all output scalars in parallel from the
  corresponding inputs.

* Sequential Reduce: Combine together the first two scalars, then
  combine each next scalar to the accumulated result, one at a time.

* Parallel Reduce: Combine together each pair of adjacent scalars in
  parallel.  This reduces the scalar count by two.  Keep doing this
  until you are down to one scalar.  A logarithmic number of
  sequential steps is required to reduce down to a single scalar.

Okay, that's nice and easy to abstractly phrase out and understand in
concept, but how do you implement this as actual code?  We need coding
constructs to describe sequential and parallel computation.

Sequential looping: Loops, just like in the C programming language:
`while`, `do-while`, `for`.

Parallel execution: Threads.  Some implementations may encourage
writing a "loop body" that will be used in each parallel thread, but
essentially it is the same thing.

At the machine level, this is, of course, lower level and more
difficult for programmers to understand.

Sequential looping:

* Conditional jump, i.e. "branch" instruction.

Parallel execution:

* SIMD (Single Instruction Multiple Data), a single instruction that
  operates on multiple data items at the same time.

* SIMT (Single Instruction Multiple Thread), multiple threads can
  execute concurrently only when they are sharing the same
  instruction, otherwise they must execute sequentially.  Each thread
  has its own independent scalar registers that can load and store to
  their own memory addresses, without the need for data to conform to
  a specific vector data format, unlike SIMD.

  On the other hand, this can be trivially shown to be almost
  identical to a SIMD architecture that implements gather-scatter
  load-store instructions.  Even with just instructions for load-store
  with strides, almost all parallel execution procedures can be
  implemented.

* MIMD (Multiple Instruction Multiple Data), this is basically another
  way of describing superscalar processor (processor = microprocessor,
  CPU (Central Processing Unit) when it is the main one), or even just
  a multi-core processor.  Instructions are split up into separate
  instruction streams that execute on independent scalar processors.

  For a superscalar processor, a compiler may optimize by performing
  loop unrolling (if necessary).  For a multi-core processor,
  thread-level parallelism is used.

Fortunately, it is trivial for compilers to translate from the
high-level language forms to the low-level machine forms.  For
example, loops can be rewritten so they encompass a branch instruction
at the beginning and the end.

Another example, to take advantage of a SIMD processor, OpenCL uses
the model of thread-level parallelism to describe the logical
computation on one scalar.  When the threads execute their instruction
streams in lock-step, that trivially maps down to a stream of SIMD
instructions.  When there is branching, the code can be transformed so
that nullification operations are computed where the branch values are
false, essentially creating a stream of no-ops where threads would
otherwise diverge.  And, when memory addresses diverge, load-store
with stride instructions and gather-scather load-store instructions
can be used to keep the vector data formats in lock-step by the time
they reach the compute instructions.

By the way, if you are concerned that your compiler is not generating
nullification operations but instead generating divergent threads
executed sequentially, how do you express that nullification operation
in software to guarantee the threads stay in lock-step?  Easy,
basically you can express a conditional move in software by means of
generating AND and OR masks.  Or, alternatively, by multiplying and
adding.

```
/* Conditional move: if (cond) dest = src; */
/* To generate masks, we use negation as a sign extension trick.  This
   means that the value 1 must be strictly used for `true` in
   `cond`.  */
#define CMOV(cond, int_type, dest, src) \
  dest &= -(int_type)(!(cond)); \
  dest |= (-(int_type)(cond)) & (src);

/* Alternative implementation that is compatible with floating point
   arithmetic.  */
#define CMOV(cond, float_type, dest, src) \
  dest *= !(cond); \
  dest += (float_type)(cond) * (src);
```

And actually... we can go both ways.  If we want to generate
conditional code rather than execute a conditional move, we can define
the following macro.

```
/* Helper macro to replace a conditional move with just a C-style
   conditional assign.  */
#define CMOV(cond, int_type, dest, src) \
  if (cond) (dest) = (src);
```

However, the main caveat with this software formulation is that
address bus reads and writes are still generated even when the
condition evaluates to be false.  In the event that this reaches into
addresses prohibited by the MMU (Memory Management Unit) or addresses
mapped to devices, this could cause your program (or even the system!)
to crash.

Finally, another variant, conditional move with an arbitrary code
block that can be completely skipped.

```
/* Actual conditional move.  */
#define CMOV_CODE_BLK(cond, int_type, dest, src, code_block) \
  code_block; \
  CMOV(cond, int_type, dest, src);

/* Replacement that turns into C-style conditional branch.  */
#define CMOV_CODE_BLK(cond, int_type, dest, src, code_block) \
  if (cond) { \
    code_block; \
    (dest) = (src); \
  }
```

----------

### Higher-order vector vector function implementations

So... let's look at different ways of implementing these primitives.
First of all, the easiest, a `map`, sequential compute model.

```
void ABSTRACT_MAP(Scalar *a, Scalar *b, ...) {
  unsigned i;
  for (i = 0; i < VEC_LEN; i++) {
    /* PARALLEL LOOP */
    MAP_OPERS(a[i], i);
  }
}
```

`MAP_OPERS` is a macro expansion that uses two arguments: where to
write the output and what index to use.  It must also conform to the
restrictions of a `map` operation, namely by using the same index
value in all vector operands and not having any dependencies across
iterations.  It can use any other arbitrary inputs specified as
additional function arguments.

Here is a concrete example of `map`: Divide each number by `d`.

```
void div5_each(Scalar *a, Scalar *b, Scalar d) {
  unsigned i;
  for (i = 0; i < VEC_LEN; i++) {
    /* PARALLEL LOOP */
    a[i] = b[i] / d;
  }
}
```

How about the parallel compute model?  Fortunately, we can use the
nifty loop-body trick to express thread-level parallelism for `map`.
So, it is trivially just spawning a thread that calls a function that
contains `MAP_OPERS` commands and passing it the output to write and
the current index.

Since our code must be able to run both sequentially as well as in
parallel, the order of iteration in the sequential compute model does
not matter.  Therefore, we can restructure the loop like this, which
reduces the register burden on the CPU to execute the loop.

```
void ABSTRACT_MAP(Sclar *a, Scalar *b, ...) {
  unsigned i = VEC_LEN;
  while (i > 0) {
    i--;
    MAP_OPERS(a[i], i);
  }
}
```

`reduce` is fairly straightforward to implement in a sequential
compute model... almost.  There are two main variants, the
significance of which we'll get into later.

```
/* Variant #1 */
/* If vector length (dimension) is zero, the result is undefined.  */
Scalar ABSTRACT_REDUCE(Scalar *v) {
  Scalar accum = v[0]; /* Initialize to vector's first scalar.  */
  unsigned i;
  for (i = 1; i < VEC_LEN; i++) {
    accum = COMBINE(accum, v[i]);
  }
  return accum;
}

/* Variant #2 */
Scalar ABSTRACT_REDUCE(Scalar *v) {
  /* Initialize to "identity value."  */
  Scalar accum = IDENT_VAL;
  unsigned i;
  for (i = 0; i < VEC_LEN; i++) {
    accum = COMBINE(accum, v[i]);
  }
  return accum;
}
```

The "identity value" is the value that when combined with any other
value, results in the same other value unchanged.  A few examples:

* `0 + n = n`
* `1 * n = n`
* `min(INT_MAX, n) = n`
* `max(INT_MIN, n) = n`

Here are two concrete examples of `reduce`: `sum` and `product`.

```
Scalar sum(Scalar *v) {
  /* Initialize to "identity value."  */
  Scalar accum = 0;
  unsigned i;
  for (i = 0; i < VEC_LEN; i++) {
    accum = accum + v[i];
  }
  return accum;
}

Scalar product(Scalar *v) {
  /* Initialize to "identity value."  */
  Scalar accum = 1;
  unsigned i;
  for (i = 0; i < VEC_LEN; i++) {
    accum = accum * v[i];
  }
  return accum;
}
```

Now, let's show a sequential compute model `unfold`.  Our
implementation applies one restriction that helps make defining the
parallel compute model easier.

```
/* Unfold to the vector width in-place.  */
void ABSTRACT_UNFOLD(Scalar *v) {
  Scalar accum = BASE;
  unsigned i;
  for (i = 0; i < VEC_LEN; i++) {
    v[i] = accum;
    accum = COMBINE(accum, BASE);
  }
}
```

Now for two concrete examples, list of consecutive integers counting
by `n` and list of consecutive powers of a base `n`.

```
void count_by_n(Scalar *v, Scalar n) {
  Scalar accum = n;
  unsigned i;
  for (i = 0; i < VEC_LEN; i++) {
    v[i] = accum;
    accum = accum + n;
  }
}

void powers_of_n(Scalar *v, Scalar n) {
  Scalar accum = n;
  unsigned i;
  for (i = 0; i < VEC_LEN; i++) {
    v[i] = accum;
    accum = accum * n;
  }
}
```

Now, for the parallel compute models.  `reduce` and `unfold` are
trickier because they require both sequential and parallel loops.  The
sequential loop iterations must be delineated by "barrier"
synchronization primitives, so that if the threads are being executed
sequentially on a scalar processor, they are all guaranteed to be
lock-step before the next loop iteration.  On a vector processor, this
turns into a no-op when all threads fit the width of a single hardware
SIMD/SIMT vector unit.

First, let's start with parallel `reduce`.  Here, the goal is to
combine adjacent scalars together in parallel as much as possible.  A
logarithmic number of sequential steps is required to reduce down to a
single scalar.  A simple diagram for the concrete case of summing a
list of integers illustrates this succinctly.

```
1 2 3 4 5 6 7 8
1+2 3+4 5+6 7+8
1+2+3+4 5+6+7+8
1+2+3+4+5+6+7+8
```

Now, for the code to implement this in general.

```
/* Reduce a vector in-place, the result of the reduction is stored in
   the first element of the vector.

   PLEASE NOTE: We rewrite the vector in place as our working memory,
   so pass a copy!  */
void ABSTRACT_REDUCE(Scalar *v) {
  unsigned stride = 2;
  unsigned stride_log2 = 1;
  unsigned sd_half = 1; /* Half stride */
  unsigned sub_len;

  /* sub_len computation is reformulation of the following:
     while (stride * i + sd_half < VEC_LEN) { ... }  */
     -> reorganize with correct rounding ->
     while ((sub_len = ((VEC_LEN - sd_half) + (stride - 1)) / stride) > 0)
       { ... }
     ->
     while ((sub_len = (VEC_LEN + sd_half - 1) / stride) > 0) { ... }

     N.B. Since we divide strictly by powers of two, this can be
     simplified to bit-shifting.  Very important!  */
  while ((sub_len = (VEC_LEN + sd_half - 1) >> stride_log2) > 0) {
    unsigned i;
    for (i = 0; i < VEC_LEN; i++) {
      /* PARALLEL LOOP */
      CMOV((i < sub_len), Scalar, \
        v[stride*i], COMBINE(v[stride*i], v[stride*i+sd_half]));
    }
    /* OpenCL barrier ensures that all threads are synced in execution
       and local memory consistency state by this point, for the sake
       of the sequential outer loop.  */
    barrier(CLK_LOCAL_MEM_FENCE);

    stride *= 2;
    stride_log2++;
    sd_half *= 2;
  }
}
```

A few considerations are worth mentioning in relation to running
`reduce` on a GPU via OpenCL.  First of all, GPU memory architecture
allows a fixed size group of threads to have access to a chunk of
common memory called local memory in OpenCL and "shared memory" in
CUDA terminology.  The fixed size group of threads generally
corresponds to the width of the hardware SIMD/SIMT vector units.
Other threads outside of one thread group do not have access to the
local memory of other thread groups.  To implement an arbitrary reduce
on a GPU, you need to first do a reduce on each individual block of
data, in local memory, then you need to coalesce the results into a
single contiguous block of OpenCL global memory for a second
iteration.  It must be _global_ memory because multiple different
work-groups will be accessing it to coalesce the results.  Finally, in
OpenCL, a synchronization is required between these outer iterations
by completing one work-group and scheduling another work-group that
waits on the completion event of the previous work-group.  This
(ideally) causes global memory to be consistent across different
work-groups, though admittedly we're fudging on the limits of OpenCL a
little with respect to the limits of global memory consistency.
Please note that the OpenCL 1.0 specification has a `reduce` example
that does exactly this, so it's probably kosher.

Also, as this memory coalescing operation has a rather high cost
compared to typical GPU memory access patterns, it might not even make
sense to execute on the GPU.  In that case, a CPU subroutine can
perform the coalescing instead.  In the end, what it really comes down
to is the system architecture.  For a desktop GPU that is connected to
the CPU via a PCI-E bus interface, GPU coalescing is probably more
efficient, even with the high overhead to do it on the GPU.  But, for
embedded systems where the GPU has DMA to the CPU main memory on the
same chip, CPU coalescing may be more efficient.  Also, another
obvious advantage of CPU coalescing is that we don't need to fudge on
OpenCL's global memory consistency model.

Now, let's introduce parallel `unfold`.  Thanks to our particular
restriction that the `BASE` value must be used as the second operand
to the binary `COMBINE` operator, this can trivially be almost the
reverse of a parallel `reduce`.

```
/* Unfold to the vector width in-place.
   VEC_LEN must be a power of two.  */
void ABSTRACT_UNFOLD(Scalar *v)
{
  unsigned sub_len;
  v[0] = BASE; /* BASE VALUE */
  sub_len = 1;
  while (sub_len < VEC_LEN) {
    /* BEGIN MAP */
    unsigned i;
    unsigned accum = v[sub_len-1];
    for (i = 0; i < sub_len; i++) {
      /* PARALLEL LOOP */
      v[i+sub_len] = COMBINE(v[i], accum);
    }
    /* END MAP */
    /* OpenCL barrier ensures that all threads are synced in execution
       and local memory consistency state by this point, for the sake
       of the sequential outer loop.  */
    barrier(CLK_LOCAL_MEM_FENCE);
    sub_len += sub_len;
  }
}
```

The idea here, similar to parallel reduce, is that we only unfold to
the width of the hardware SIMD/SIMT vector units.  But, once we do
that, there's a different, more efficient, trick up our sleeves that
we can play here, unlike the case of `reduce`.  Again, this hinges on
some restrictions we imposed on `unfold`, otherwise it would be more
similar to a reverse parallel `reduce`.  Each block can then be
unfolded totally independently without the need to scatter the results
of the previous `unfold`.

But wait, before we get into that trick, there's yet another clever
trick we can play here, in relation to OpenCL GPU computing.  Do we
really have to do an unfold in OpenCL to get a list of consecutive
integers?  Absolutely not.  Since we get thread IDs for indices, we
can just use that smack right as our seed value.  Then in one fell
swoop we generate our list of consecutive integers.  Like the other
unfold, this routine is confined to a single block, once a single
block is initialized you can use the multi-block routine.

Technically, that means our inner loop is not a "map," strictly
speaking, but we seriously need to take advantage of this low-level
optimization!

```
void gpu_unfold_n(int *v)
{
  unsigned i;
  for (i = 0; i < VEC_LEN; i++) {
    /* PARALLEL LOOP */
    v[i] = i + 1;
  }
}
```

Now, back to the block-wise expansion trick for `unfold`.

```
void ABSTRACT_UNFOLD_NEXT(int *v, unsigned add_idx, Scalar accum)
{
  /* BEGIN MAP */
  unsigned i;
  for (i = 0; i < VEC_LEN; i++) {
    /* PARALLEL LOOP */
    v[i+add_idx] = COMBINE(v[i], accum);
  }
  /* END MAP */
}
```

Here, you can simply see that we take an existing block and combine it
with an accumulator value to get the new block.  The final trick we
need to play here is that we need to be able to compute the
accumulator values in parallel in advance to have a fully parallel
block-wise generator.  When this is not possible, it is still possible
to get efficiency gains by using a modified variant of the `unfold`
for the first block: a little bit more code can be used to generalize
it to a block-wise power-of-two `unfold`.

----------

### Beyond single higher-order vector functions

Having higher-order vector functions is very useful in getting started
writing efficient parallel code.  However, many useful subroutines are
not just a single higher-order vector function, but a combination of
two or more.  The most common combination is map-reduce.  This is
trivial to express in optimal form on a vector processor, but a scalar
processor?  This is where things get complicated.

A `map` can be expressed as an ordinary loop on all the elements.  But
a `reduce`?  We need that special first-case element handling, and
that breaks up our otherwise nice loop format with either requiring a
conditional to special-case the first iteration or loop-unraveling the
first iteration.  Fortunately, if there is an "identity value" defined
for the combinator, that is, combining any scalar with the identity
value results in the same scalar value itself, then we can eliminate
the special case first iteration by initializing the accumulator to
the identity value.

As for unfolds, that can be replaced by a generator function that
simply yields the next value.  So, unfold-map-reduce can be
implemented efficiently.

Now this allows us to write two identical loops to process the
map-reduce.  Why not merge them into one?  This is the most efficient
means to implement this on a scalar processor.  The problem that
becomes, here, is this: How will we take advantage of this
optimization and still be able to write fully general code?

The answer is that we need to make a few different definitions and
classifications of looping constructs.  That was the final attribute
of "loop programming model" that we've hinted at right in the
beginning of our definitions.

Let's take a look at two different ways of implementing a map-reduce,
sequential compute model.  The first method:

```
Scalar ABSTRACT_MAP_REDUCE(Sclar *a, Scalar *b, ...) {
  Scalar work[VEC_LEN];
  /* Initialize to "identity value."  */
  Scalar accum = IDENT_VAL;
  unsigned i;
  /* BEGIN MAP */
  for (i = 0; i < VEC_LEN; i++) {
    /* PARALLEL LOOP */
    MAP_OPERS(work[i], i);
    /* Result: `work[i]` is written.  */
  }
  /* END MAP */
  /* BEGIN REDUCE */
  for (i = 0; i < VEC_LEN; i++) {
    accum = COMBINE(accum, work[i]);
  }
  return accum;
  /* END REDUCE */
}
```

The second method:

```
Scalar ABSTRACT_MAP_REDUCE(Sclar *a, Scalar *b, ...) {
  Scalar work;
  /* Initialize to "identity value."  */
  Scalar accum = IDENT_VAL;
  unsigned i;
  for (i = 0; i < VEC_LEN; i++) {
    /* BEGIN MAP */
    MAP_OPERS(work, i);
    /* Result: `work` is written.  */
    /* END MAP */
    /* BEGIN REDUCE */
    accum = COMBINE(accum, work);
    /* END REDUCE */
  }
  return accum;
}
```

In the first implementation, we basically just pasted a `map` and a
`reduce` together to create the map-reduce higher-order vector
function.  But in the second, we built off of the general structure of
the first implementation to make an optimization in both sequential
compute time and memory consumption: we combined the two identical
loop control structures into one, and we used a scalar for `work`
rather than a vector.  Another optimization that we could make, but do
not strictly need to make, is to move `work` to the inside of the loop
body since it does not need to persist between loop iterations.

One important property about `map` and `reduce` (under our
restrictions) is that their iterations are "commutative."  That means
we can also restructure the loop to count to zero, reducing the
register burden of the loop control structure.

```
Scalar ABSTRACT_MAP_REDUCE(Sclar *a, Scalar *b, ...) {
  /* Initialize to "identity value."  */
  Scalar accum = IDENT_VAL;
  unsigned i = VEC_LEN;
  while (i > 0) {
    Scalar work;
    i--;
    /* BEGIN MAP */
    MAP_OPERS(work, i);
    /* Result: `work` is written.  */
    /* END MAP */
    /* BEGIN REDUCE */
    accum = COMBINE(accum, work);
    /* END REDUCE */
  }
  return accum;
}
```

What about combining `unfold` with other higher-order vector
functions?  At the outset, this is pretty much just the same as
`reduce`.  Unfortunately, our principal definition of `unfold` is not
associative: you cannot rearrange the parenthetical groupings in any
way other than left associativity.  In essence, a sequential compute
model `unfold` is, in fact, a generator function.  So, unless we do
slighly esoteric programming such as using negative indices from the
end of a vector, we must use the for-loop style loop control.  For
illustrative purposes, let's show an unfold-map-reduce.

```
Scalar ABSTRACT_UNFOLD_MAP_REDUCE(...) {
  Scalar unfold_accum = BASE;
  /* Initialize to "identity value."  */
  Scalar accum = IDENT_VAL;
  unsigned i;
  for (i = 0; i < VEC_LEN; i++) {
    Scalar work;
    /* BEGIN UNFOLD */
    work = unfold_accum;
    unfold_accum = COMBINE(unfold_accum, BASE);
    /* END UNFOLD */
    /* BEGIN MAP */
    MAP_OPERS(work, i);
    /* Result: `work` is written.  */
    /* END MAP */
    /* BEGIN REDUCE */
    accum = COMBINE(accum, work);
    /* END REDUCE */
  }
  return accum;
}
```

One thing that becomes apparent is that there are many times when you
may want to write the inner body of a loop, but not necessarily pack
it into a loop right away.  Keep this in mind, we are going to define
a formal method to define subroutines that are just the body of a
loop, which can then be combined with other subroutines and packed
into a loop by a higher-level calling subroutine.

That pretty much completes the survey of different ways to implement
the higher-order vector functions.  Again, let's review the key
considerations that we may want to optimize.

* Easiest, most intuitive code to program.
* Best performance in parallel compute model.
* Best performance in sequential compute model.

The resulting implementation decisions can be split into two main
categories.

* The calling conventions of a subroutine.
* How a subroutine computes its results.

Subroutine calling conventions:

* Vector (`vec`), compute all vector components by the end of the
  subroutine.  The subroutine itself may use a parallel compute model.

* Scalar (`s`), stateless computation of a single vector component,
  i.e. the order in which you request the components is not important.
  The subroutine can readily be called in parallel to compute all
  components in parallel.

* Ordered scalar (`seq`), stateful computation of a vector component,
  you must request computation of vector components strictly in
  ascending index order, without skipping any index.  Essentially,
  this is a generator function or iterator.  The subroutine **cannot**
  be used in a parallel.

* Synchronized scalar (`sync`), another form of stateful computation
  of a vector component.  This indicates a `barrier()` synchronization
  primitive is used somewhere in the computation of a single vector
  component.  Therefore, execution must be treated as synchronized
  threads, which basically amounts to a `vec` calling convention from
  a data flow standpoint since you cannot separate one scalar result
  from the rest.

  To get the `vec` calling convention results, pass this subroutine to
  a thread job executor subroutine.  This subroutine is also useful
  for building higher-level thread subroutines.

  Because of the required use of threads, the subroutine can readily
  be called in parallel to compute all components in parallel.

Methods for a subroutine to compute its results:

* Sequential compute model (seq)
* Parallel compute model (par).  Use threads.

So, how does ease of programming fit in here?  There is one
combination of calling convention and compute model that results in
the greatest ease of programming: `vec` and `seq`.  Any vector method
you use, it operates on a whole vector before returning.  And,
individual `map`, `reduce`, and `unfold` higher-order vector functions
are implemented in a sequential compute model.  This combination
choice means that when you combine higher-order vector functions
together, it really is the same as mere aggregation.  No special
optimizations are taken advantage of anywhere.  Of course, that is the
problem from an compute efficiency standpoint.

Let's classify the sequential and parallel higher-order vector
function variants by the calling conventions.  In particular,
analyzing the loop bodies, the interior of the loop.  (After all,
they're all `vec` on the outside.)

* `map`: `s`
* `reduce`: N/A, intermediate computation via `s` or `sync`
* `unfold`: `s, seq, sync`

These calling conventions of the loop body determine how many
different ways we can compose higher-level subroutines that call one
of these subroutines.  In particular for `reduce`, there is only one
possible calling convention, `vec`, since the inner loop only computes
an intermediate.  By extension, this means that there is also only one
calling convention for any map-reduce operation, `vec`.  It is only in
the case of `map` and `unfold` where it may make sense to support more
than one calling convention.  In total:

* `map`: `vec, s`
* `reduce`: `vec`, intermediate computation via `s` or `sync`
* `unfold`: `vec, s, seq, sync`

Depending on the properties of the combinator, not all calling
conventions may be possible for `unfold`.

The different calling conventions determine the range of different
ways they can be combined together, out of which some ways are the
most efficient composite computational operations.

We can declare a single optimization goal for both sequential and
parallel compute models:

* Sequential compute model: Compute on only a single component for as
  long as possible.

* Parallel compute model: Compute on only a single thread for as long
  as possible.

In the case of `map`, there is no distinction between threads and
components, so that makes `map` easy.  `reduce` is a terminal
operation on a component or thread group.  `unfold` spawns components
or threads.

So, we can understand this as the following consideration: subroutines
that derive from `map`, `unfold`, or both need to provide a
per-component calling convention.  If `reduce` is used, it is special:
the `s` or `sync` calling conventions can partially compute the
result, but the final result is only available from the `vec` calling
convention.  So, in both cases for `reduce`, we define a special
subroutine (or macro) that only computes part of the result, and it is
up to the user to include that as the last fragment and close up the
loop or thread primitive to complete the computation.

However, we can apply a special case optimization in the event that a
parallel `reduce` fits the width of the hardware SIMD/SIMT vector
units.  In this case, we can simply combine the `reduce` fragment into
a thread subroutine, and subsequent thread execution can reference the
computed value.

Okay, now that's all quite a mouthful to describe.  We need code
examples to make this clear.  First, let's define the abstract
building blocks that we need as macros.  **However**, for ease of
comprehension, we will not actually define them as C macros, but as C
functions representing the abstract operations.  It should be fairly
straightforward to see how these could be transformed into macros that
generate the respective concrete functions.

```
/* Here's the general idea.  Any time you use a `map` followed by a
   `reduce`, you must structure your code so that you generate a
   map-reduce subroutine.  You then call that map-reduce subroutine
   from your higher-level code.

   For simplicity, let's start by only working out map-reduce.  We'll
   work out unfold later.  N.B. If unfold after the first block can be
   implemented as a fully parallel map, that trivially also applies
   here.  */

/* Easiest case to implement, already described previously.
   Sequential compute model, abstract map-reduce.  */
#define CONCRETE_MAP_REDUCE(NAME, MAP_OPERS, IDENT_VAL, COMBINE) \
  void NAME(Sclar *a, Scalar *b, ...) { ... }

/* Now, the tricky part to implement is, of course, the parallel
   subroutine.  We actually need a whole host of generic supporting
   subroutines.  */

/* Notes on special ALL CAPITALS variables:

   * `BLOCK_LEN`: Width of an OpenCL work-group, i.e. width of the
     hardware SIMD/SIMT vector units.

   * `VEC_LEN`: Total allocated storage in a vector.  Accessing
     elements at indices greater than or equal to this is undefined.
     Typically, this will be padded out to be a multiple of
     `BLOCK_LEN` so that OpenCL parallel compute jobs can be scheduled
     to operate on the vector.

   * `REAL_LEN`: The unpadded length of the actual data contained
     within the vector.  Elements at indices greater than or equal to
     `REAL_LEN` are strictly padding and do not correspond to the
     original data.  */

/* Thread subroutine: Coalesce `in` data spaced by `stride` to be
   packed in `out` data.  */
void coalesce_stride_thsubr(THCtx *ctx,
                            Scalar *out, scalar *in,
                            unsigned REAL_LEN, unsigned stride)
{
  unsigned i = GET_GLOBAL_TH_IDX(ctx);
  /* Depends on mode whether we make this check, if it is possible
     that we are not aligned to the block size.  */
  CMOV((i < REAL_LEN), Scalar, out[i], in[stride*i]);
}

/* Thread subroutine: Run one thread of the parallel `reduce`
   subroutine to reduce in-place.  Only each individual block is
   reduced.  You must then use a thread job executor to reduce these
   results down to a single scalar.

   The result of the reduction depends on mode, either it is stored in
   the first element of each block of the vector OR it is stored
   contiguously at the first elements of the vector.

   PLEASE NOTE: We rewrite the vector in place as our working memory,
   so pass a copy!

   BLOCK_LEN must be a power of two.  */
void ABSTRACT_REDUCE_BLOCK_THSUBR(THCtx *ctx, Scalar *work,
                                  unsigned REAL_LEN) {
  unsigned stride = 2;
  unsigned stride_log2 = 1;
  unsigned sd_half = 1; /* Half stride */
  unsigned sub_len;
  unsigned i = GET_GLOBAL_TH_IDX(ctx);
  unsigned my_blk_len = BLOCK_LEN;

  /* Depends on mode whether we do this at all.  If reduce operates on
     non-power-of-two input.  */
  CMOV((i >= (REAL_LEN & ~(BLOCK_LEN - 1))), unsigned, \
    my_blk_len, REAL_LEN & (BLOCK_LEN - 1));

  /* sub_len computation is reformulation of the following:
     while (stride * i + sd_half < my_blk_len) { ... }  */
     -> reorganize with correct rounding ->
     while ((sub_len = ((my_blk_len - sd_half) + (stride - 1)) / stride) > 0)
       { ... }
     ->
     while ((sub_len = (my_blk_len + sd_half - 1) / stride) > 0) { ... }

     N.B. Since we divide strictly by powers of two, this can be
     simplified to bit-shifting.  Very important!  */
  while ((sub_len = (my_blk_len + sd_half - 1) >> stride_log2) > 0) {
    CMOV((i < sub_len), Scalar, \
      work[stride*i], COMBINE(work[stride*i], work[stride*i+sd_half]));

    /* OpenCL barrier ensures that all threads are synced in execution
       and local memory consistency state by this point, for the sake
       of the sequential outer loop.  */
    barrier(CLK_LOCAL_MEM_FENCE);

    stride *= 2;
    stride_log2++;
    sd_half *= 2;
  }

  /* Depends on mode whether we do this here.  Coalesce the results.  */
  CMOV((GET_LOCAL_TH_IDX(ctx) == 0), Scalar, \
    work[GET_GROUP_IDX(ctx)], work[i]);
}

/* Thread subroutine: `map` one element, then run one thread of the
   parallel `reduce` subroutine.  You must use a thread job executor
   to map-reduce an entire vector.  The entire vector is mapped, but
   only each individual block is reduced.  You must then use a thread
   job executor to reduce these results down to a single scalar.

   The result of each block-wise reduction is stored in the first
   scalar of each `BLOCK_LEN` block of `out`.  The rest of each
   `BLOCK_LEN` in `out` is used as working scratch space.  */
void ABSTRACT_MAP_REDUCE_BLOCK_THSUBR(THCtx *ctx, Scalar *out,
                                      unsigned REAL_LEN, ...) {
  /* BEGIN MAP */
  unsigned i = GET_GLOBAL_TH_IDX(ctx);
  /* Code structure here depends on mode.  */
  Scalar temp;
  CMOV_CODE_BLK((i < REAL_LEN), Scalar, out[i], temp,
    MAP_OPERS(temp, i));
  /* NOTE: If `reduce` only operates on power-of-two input, then `map`
     will write out `IDENT_VAL` padding to ensure the `out` vector is
     filled respectively.  */
  CMOV((i >= REAL_LEN), Scalar, out[i], IDENT_VAL);
  /* Result: `out` is written.  */
  /* END MAP */

  /* OpenCL barrier ensures that all threads are synced in execution
     and local memory consistency state by this point, so that the
     following `reduce` is consistent.  */
  barrier(CLK_LOCAL_MEM_FENCE);

  /* return */ ABSTRACT_REDUCE_BLOCK_THSUBR(ctx, out, REAL_LEN);
}

/* Thread subroutine: Generate a vector with a length (dimension)
   aligned to a multiple of `BLOCK_LEN` by padding out remainder items
   with the given value.  */
void pad_align_thsubr(THCtx *ctx,
                      Scalar *work, unsigned REAL_LEN, Scalar pad_value)
{
  unsigned i = GET_GLOBAL_TH_IDX(ctx);
  CMOV((i >= REAL_LEN), Scalar, work[i], pad_value);
}

/* Sequential compute model alternative.  Take a direct pointer and
   length and write the padding directly.  */
void pad_align_seq(Scalar *work, unsigned pad_len, Scalar pad_value)
{
  while (pad_len > 0) {
    pad_len--;
    *work++ = pad_value;
  }
}

/* CALLING CONVENTION of `sched_th_job()` EXAMPLE:

unsigned roundup_len = (REAL_LEN + BLOCK_LEN - 1) & ~(BLOCK_LEN - 1);

int err_val = sched_th_job(
  roundup_len, /* Total thread count (global_work_size) */
  BLOCK_LEN, /* Work-group block size (local_work_size) */
  0, NULL, /* List of events to wait for completion before starting.  */
  NULL, /* Pointer to store resulting event object */
  coalesce_stride_thsubr, /* Function pointer to subroutine */
  ... /* Function arguments, not including thread context */
);

*/

/* PLEASE NOTE: We use some this OpenCL API convention for
   convenience.  OpenCL does provide adequate garbage collection
   features on event objects.  Here's how it works.

   1. Save your event wait outputs before creating your new event.

   2. Create your new event with the wait list, save the new event.

   3. Call `clReleaseEvent()` on all events in the wait list.  The
      reference count will drop, but the events objects will not be
      freed until the event itself has completed and any events
      waiting on this event no longer require a reference, i.e. they
      have already issued execution.

   And, that's actually how OpenCL does the memory management of event
   objects, via reference counts.  Which work, by the way, because
   circular dependencies are strictly verboten.  */

/* Thread job executor for finish `reduce`, thread job executor on the
   `reduce` concrete thread subroutine multiple times until there is
   only one element remaining.

   BLOCK_LEN must be a power of two so that BLOCK_LEN_LOG2 can be used
   for fast divide by shift right.

   The final result is in `work[0]`.  */
void ABSTRACT_REDUCE_ALL(unsigned wait_list_len, cl_event *wait_list,
                         cl_event *out_event,
                         Scalar *work, unsigned REAL_LEN)
{
  cl_event wait_event, old_wait_event;
  unsigned sub_len = REAL_LEN >> BLOCK_LEN_LOG2;

  while (sub_len > 1) {
    unsigned align_len = (sub_len + BLOCK_LEN - 1) & ~(BLOCK_LEN - 1);
    /* Depends on mode whether we do this here.  */
    sched_th_job(align_len, BLOCK_LEN,
      wait_list_len, wait_list, &wait_event,
      coalesce_stride_thsubr, work, work, sub_len, BLOCK_LEN);
    while (wait_list_len > 0) {
      wait_list_len--;
      clReleaseEvent(*wait_list++);
    }
    old_wait_event = wait_event;
    /* Check if we need to add padding to fill `BLOCK_LEN`.  */
    if (sub_len != align_len) {
      /* unsigned rem = sub_len & (BLOCK_LEN - 1);
      unsigned frag = sub_len - rem; */
      /* Ideally we'd compute on only the subset
         `work[frag...frag+rem]`.  But OpenCL 1.0 doesn't have
         convenient syntax to support that, so just compute on
         everything.  PLEASE NOTE: OpenCL 1.1 added support for
         sub-buffer objects, clCreateSubBuffer().  */
      /* N.B.: This could possibly be faster on the CPU in a Unified
         Memory Architecture but slower on non-unified architectures.
         So it depends on mode whether we execute on the GPU.  */
      sched_th_job(align_len, BLOCK_LEN, 1, &old_wait_event, &wait_event,
        pad_align_thsubr, work, sub_len, IDENT_VAL);
      clReleaseEvent(old_wait_event);
      old_wait_event = wait_event;
    }
    sched_th_job(align_len, BLOCK_LEN, 1, &old_wait_event, &wait_event,
      ABSTRACT_REDUCE_BLOCK_THSUBR, work, sub_len);
    clReleaseEvent(old_wait_event);
    old_wait_event = wait_event;
    sub_len >>= BLOCK_LEN_LOG2;
  }
  *out_event = old_wait_event;
}

/* MAP-REDUCE TOP-LEVEL CONTROL SUBROUTINE.  Result is returned in
   `out[0]`, the remainder is used as working scratch space.  */
void ABSTRACT_MAP_REDUCE(unsigned wait_list_len, cl_event *wait_list,
                         cl_event *out_event,
                         Scalar *out, unsigned REAL_LEN, ...)
{
  cl_event wait_event, old_wait_event;
  /* NOTE: Calculating `align_len` depends on mode, otherwise we just
     copy `REAL_LEN` as they are one in the same.  */
  unsigned align_len = (REAL_LEN + BLOCK_LEN - 1) & ~(BLOCK_LEN - 1);
  /* Check if we need to add padding to fill `BLOCK_LEN`.  Depends on
     mode.  */
  if (REAL_LEN != align_len) {
    /* NOTE: We will need to run pad jobs for each array input
       argument.  Here, for example, we assume there is at least one
       named `b`.  */
    sched_th_job(align_len, BLOCK_LEN,
      wait_list_len, wait_list, &wait_event,
      pad_align_thsubr, b, REAL_LEN, IDENT_VAL);
    while (wait_list_len > 0) {
      wait_list_len--;
      clReleaseEvent(*wait_list++);
    }
    old_wait_event = wait_event;
    /* And so on ... */
    /* Then we finish off doing this so that the rest of the code runs
       cleanly.  */
    wait_list_len = 1;
    wait_list = &old_wait_event;
  }
  sched_th_job(align_len, BLOCK_LEN,
    wait_list_len, wait_list, &wait_event,
    ABSTRACT_MAP_REDUCE_BLOCK_THSUBR, out, REAL_LEN, ...);
  while (wait_list_len > 0) {
    wait_list_len--;
    clReleaseEvent(*wait_list++);
  }
  old_wait_event = wait_event;
  if (REAL_LEN > BLOCK_LEN) {
    ABSTRACT_REDUCE_ALL(1, &old_wait_event, &wait_event, out, REAL_LEN);
    old_wait_event = wait_event;
  }
  *out_event = old_wait_event;
}

/* Okay, so now here's the trick.  When `REAL_LEN` is less than
   `BLOCK_LEN`, we can take advantage of an optimization trick.  We
   can build higher-order thread subroutines by dropping the initial
   `ABSTRACT_MAP_REDUCE_BLOCK_THSUBR()` right in place.  But we also
   want to be flexible so that the same higher-level code also
   flexibly handles the case where `REAL_LEN > BLOCK_LEN`.  And, to
   keep the whole code compact, we also want the sequential compute
   model to be handled the same.

   So, here's how it works.  At the base level, there is a "maybe
   thread job executor" that will run the thread subroutine as-is if
   `REAL_LEN <= BLOCK_LEN`, otherwise it will use the thread job
   executors to complete the computation.

   The next higher level is the "maybe thread subroutine."  If the
   lower level was in fact generated as a thread subroutine, then this
   higher-level subroutine is also a thread subroutine.  Otherwise,
   this is a host subroutine that is in fact a thread job executor by
   virtue of the thread job execution of the subroutines.

   So, with the "maybe thread subroutine" (MTS) and "maybe thread job
   executor" (MTJE).  Mapping out mddes and restrictions.

         seq         (REAL_LEN <= BLOCK_LEN)  (REAL_LEN > BLOCK_LEN)
   MTJE  loop close  thsubr                   host subr, sched_th_job
   MTS   vec         thsubr                   host subr, sched_th_job

   Okay... so, really, it is the same, `loop close` also results in a
   `vec` calling convention.  That makes it all pretty easy.  The
   sequential case basically maps out to the same treatment as
   `REAL_LEN > BLOCK_LEN` from a calling convention standpoint.

*/

void ABSTRACT_MAP_REDUCE_MAYBE_SCTHJ(THCtx *ctx, Scalar *out,
                                     unsigned REAL_LEN, ...)
{
  if (REAL_LEN <= BLOCK_LEN)
    ABSTRACT_MAP_REDUCE_BLOCK_THSUBR(ctx, out, REAL_LEN, ...);
  else
    ABSTRACT_MAP_REDUCE(out, REAL_LEN, ...);
}

/* Above the "maybe thread subroutine", of course we need another
   "maybe thread job executor".  */
void ABSTRACT_MAYBE_SCTHJ(THCtx *ctx,
                          unsigned wait_list_len, cl_event *wait_list,
                          cl_event *out_event,
                          void (*maybe_thsubr)(), ...)
{
  cl_event wait_event, old_wait_event;
  if (REAL_LEN <= BLOCK_LEN) {
    unsigned align_len = (REAL_LEN + BLOCK_LEN - 1) & ~(BLOCK_LEN - 1);
    /* Check if we need to add padding to fill `BLOCK_LEN`.  Depends
       on mode.  */
    if (REAL_LEN != align_len) {
      /* NOTE: We will need to run pad jobs for each array input
         argument.  Here, for example, we assume there is at least one
         named `b`.  */
      sched_th_job(align_len, BLOCK_LEN,
        wait_list_len, wait_list, &wait_event,
        pad_align_thsubr, b, REAL_LEN, IDENT_VAL);
      while (wait_list_len > 0) {
        wait_list_len--;
        clReleaseEvent(*wait_list++);
      }
      old_wait_event = wait_event;
      /* And so on ... */
      /* Then we finish off doing this so that the rest of the code runs
         cleanly.  */
      wait_list_len = 1;
      wait_list = &old_wait_event;
    }
    sched_th_job(align_len, BLOCK_LEN,
      wait_list_len, wait_list, &wait_event,
      maybe_thsubr, ...);
    while (wait_list_len > 0) {
      wait_list_len--;
      clReleaseEvent(*wait_list++);
    }
    old_wait_event = wait_event;
    *out_event = old_wait_event;
  }
  else
    maybe_thsubr(...);
}

/* And you can see this is now a general pattern.  We have two
   subroutines, the thread subroutine itself for special cases and the
   thread job executor for everything else.  At each level, we have a
   decision point about which one to call.  Even if REAL_LEN is not
   fixed at compile-time, we can still gracefully handle both cases at
   run-time.  We expose two subroutines when declaring, we always use
   the dispatcher when calling.

   Sequential compute model is obviously special.  Since we only
   support one case (`vec` calling convention), the dispatcher
   subroutine disappears and it **is** the same as the underlying
   subroutine.  Additionally, any calls to the "maybe thread
   subroutine" call a single iteration of the loop (i.e. compute a
   single component), so the outer "maybe thread subroutine" is
   likewise not a thread subroutine.  This will be more clearly
   demonstrated in a later example.  */
```

Now, that was a heck-lot of complex code to take in.  Yeah, it's
definitely all in the complexity and sophistication of the ideas
involved, not so much the length of the code itself.  But, that's the
point.  The point is to present a simplified example that, though
incomplete from an implementation standpoint, is easier to
conceptually understand.  Once you are familiar with this code, it
should be a lot easier to understand the real implementation code and
its motivations.  Though the real implementation code is not that much
different in structure, arguably it is different enough to confuse a
novice not familiar with the concepts and structure.

Now, let's consider the higher-level.  Once you define all those
higher-order vector functions generically as a lower level, what does
that make higher-level programming look like?  It absolutely works
wonders.  Now, you can suddenly leverage the computational power of
GPU parallel computing with a programming model that doesn't look too
much different from your familiar programming primitives available in
other high-level programming languages with simple functional
programming constructs, such as Python for example.

```
/* NOTE: We have a little bit of pseudo-code here, an actual
   implementation would need an elegant way to specify additional
   arguments.  Maybe the most portable way is to just pass a data
   structure with the remaining arguments?  Wrapper functions can then
   be defined that expose the specific number of additional arguments.
   No, actually probably the best way is to user-define the whole
   function prototype, structures won't work well with OpenCL.
   Another thing we need to do, we need the ability to specify the
   `work` temporary scalar/vector should be declared as a Bool rather
   than a Scalar.

   Maybe the easiest way is to define a special set of code generators
   that are stated to be Bool type intermediates?

   Also note, in these generated map-reduce subroutines, In parallel
   compute models, `out` is not just a pointer to write the output
   result, but it is also a pointer to a sufficiently large scratch
   space vector to use during intermediate computations.  This is a
   technicality of the underlying code implementation, more work could
   probably be done to make a nicer high-level programmer interface
   while still preserving efficiency and generality.  */

/* For simplicity, define booleans to be one byte wide, although it is
   most efficient to define then as 1-bit bit-fields.  */
typedef unsigned char Bool;

/* Also, PLEASE NOTE: I totally forgot about passing around the thread
   context object (`ctx`) as a function argument, that's okay.  For
   the sake of simplicity of presenting the high-level coding ideas
   here, it is generally not necessary.  */

/* Test if all components are equal to zero.  Map-reduce
   implementation.  */
#define IS_ZERO_MAP(work, i) (work) = (b[i] == 0);
#define IS_ZERO_COMBINE(b, c) (b && c)
CONCRETE_MAP_REDUCE_BOOL(is_zero, IS_ZERO_MAP, 1, IS_ZERO_COMBINE);
#undef IS_ZERO_MAP
#undef IS_ZERO_COMBINE
/* Generated function prototypes: */
void is_zero_maybe_thsubr(Bool *out, Scalar *b);
void is_zero(Bool *out, Scalar *b);

/* Test if all components are equal to the `NOSOL` magic number,
   indicating that there is no solution when attempting to solve a
   particular system of equations.  Map-reduce implementation.  */
#define IS_NOSOL_MAP(work, i) work = (b[i] == NOSOL);
#define IS_NOSOL_COMBINE(b, c) (b && c)
CONCRETE_MAP_REDUCE_BOOL(is_nosol, IS_NOSOL_MAP, 1, IS_NOSOL_COMBINE);
#undef IS_NOSOL_MAP
#undef IS_NOSOL_COMBINE
/* Generated function prototypes: */
void is_nosol_maybe_thsubr(Bool *out, Scalar *b);
void is_nosol(Bool *out, Scalar *b);

/* Test if two vectors are equal  Map-reduce implementation..  */
#define IS_EQUAL_MAP(work, i) work = (b[i] == c[i])
#define IS_EQUAL_COMBINE(b, c) (b && c)
CONCRETE_MAP_REDUCE_BOOL(is_equal, IS_EQUAL_MAP, 1, IS_EQUAL_COMBINE);
#undef IS_EQUAL_MAP
#undef IS_EQUAL_COMBINE
/* Generated function prototypes: */
void is_equal_maybe_thsubr(Bool *out, Scalar *b, Scalar *c);
void is_equal(Bool *out, Scalar *b, Scalar *c);

/* Arithmetic mean.  Map-reduce implementation, requires
   floating point concrete type for Scalar, doing divide as a `map`
   step mainly for illustrative purposes, though arguably it is more
   efficient to do after `reduce`.  */
#define ARMEAN_MAP(work, i) work = b[i] / REAL_LEN
#define ARMEAN_COMBINE(b, c) (b + c)
CONCRETE_MAP_REDUCE(armean, ARMEAN_MAP, 0, ARMEAN_COMBINE);
#undef ARMEAN_MAP
#undef ARMEAN_COMBINE
/* Generated function prototypes: */
void armean_maybe_thsubr(Scalar *out, Scalar *b);
void armean(Scalar *out, Scalar *b);

/* Dot product.  Map-reduce implementation, requires floating point
   concrete type for Scalar.  If we wanted to support integer
   arithmetic, the implementation details would be somewhat similar to
   what we need to do for Bool: use a double-width integer type for
   working scratch space and the final result.  */
#define DOT_MAP(work, i) work = b[i] * c[i]
#define DOT_COMBINE(b, c) (b + c)
CONCRETE_MAP_REDUCE(dot, DOT_MAP, 0, DOT_COMBINE);
#undef DOT_MAP
#undef DOT_COMBINE
/* Generated function prototypes: */
void dot_maybe_thsubr(Scalar *out, Scalar *b, Scalar *c);
void dot(Scalar *out, Scalar *b, Scalar *c);

/********************************************************************/
/* Okay, that was a good number of easy examples, let's go beyond the
   basics.  Now, let's consider the implementation of higher-order
   composite subroutines, one where a map-reduce is only but part of
   the overall operation.  Specifically, we'll just start by taking a
   loop at map-reduce-map subroutines since they are illustrative of
   the general principle that is just repeated for even higher-order
   subroutines.  */

/* Simplified macro definition: CONCRETE_MAP */
#define CONCRETE_MAP(NAME, MAP_OPERS)
/* Generated function prototypes (example): */
void NAME_thsubr(Scalar *out, ...);
void NAME(Scalar *out, ...);

/* Depends on mode, cast a vector `reduce` result to a scalar in
   vector mode, else just pass through the scalar.  */
#define RR_SCALAR(v) (*(v))
/* Sequential compute model (i.e. "Scalar" mode): */
/* #define RR_SCALAR(v) (v) */

/* The reverse conversion of `RR_SCALAR()`.  */#
define RR_VECTOR(V) (v)
/* Sequential compute model (i.e. "Scalar" mode): */
/* #define RR_VECTOR(v) (&(v)) */

/* Depends on mode, perform the indicated operation only on the
   `reduce` result if possible (i.e. operating in sequential compute
   model), but if that's not possible, we don't care if the
   computation is repeated across all vector components.  */
#define RR_CONCRETE_MAP(NAME, MAP_OPERS) \
  void NAME##_maybe_thsubr(Scalar *out, ...) \
    { unsigned i = GET_GLOBAL_TH_IDX(ctx); \
      MAP_OPERS(out[i], i); } \
  void NAME(Scalar *out, ...) \
    { unsigned i = GET_GLOBAL_TH_IDX(ctx); \
      MAP_OPERS(out[0], 0); }
/* Sequential compute model */
/* #define RR_CONCRETE_MAP(NAME, MAP_OPERS) \
     void NAME##_maybe_thsubr(Scalar *out, ...) \
       { MAP_OPERS(out[0], 0); } \
     void NAME#(Scalar *out, ...) \
       { MAP_OPERS(out[0], 0); } */

/* Map only: Conditionally set all vector components to `val`.  */
#define SCALAR_CMOV_MAP(work, i) CMOV(cond, Scalar, work, val);
CONCRETE_MAP(scalar_cmov, SCALAR_CMOV_MAP);
#undef SCALAR_CMOV_MAP
/* Generated function prototypes: */
void scalar_cmov_thsubr(Scalar *out, Bool cond, Scalar val);
void scalar_cmov(Scalar *out, Bool cond, Scalar val);

/* Map only: Multiply-divide floating point scalars only, due to
   previous mentioned technicalities with the dot product..  */
#define MULDIV_MAP(work, i) work = b[i] * c / d
CONCRETE_MAP(muldiv, MULDIV_MAP);
#undef MULDIV_MAP
/* Generated function prototypes: */
void muldiv_thsubr(Scalar *out, Scalar *b, Scalar c, Scalar d);
void muldiv(Scalar *out, Scalar *b, Scalar c, Scalar d);

/* Map only: Subtract vectors.  */
#define SUB_VEC_MAP(work, i) work = b[i] - c[i]
CONCRETE_MAP(sub_vec, SUB_VEC_MAP);
#undef SUB_VEC_MAP
/* Generated function prototypes: */
void sub_vec_thsubr(Scalar *out, Scalar *b, Scalar *c);
void sub_vec(Scalar *out, Scalar *b, Scalar *c);

#define SQRT_RR_MAP(work, i) work = sqrt(b[i])
RR_CONCRETE_MAP(sqrt_rr, SQRT_VEC_MAP);
#undef SQRT_RR_MAP
/* Generated function prototypes: */
void sqrt_rr_maybe_thsubr(Scalar *out, Scalar *b);
void sqrt_rr(Scalar *out, Scalar *b);

#define SCALAR_RR_CMOV_MAP(work, i) CMOV(cond, Scalar, work, val)
RR_CONCRETE_MAP(scalar_rr_cmov, SCALAR_RR_CMOV_MAP);
#undef SCALAR_RR_CMOV_MAP
/* Generated function prototypes: */
void scalar_rr_cmov_maybe_thsubr(Scalar *out, Bool cond, Scalar var);
void scalar_rr_cmov(Scalar *out, Bool cond, Scalar var);

#define SCALAR_SUB_RR_MAP(work, i) work = b[i] - c
RR_CONCRETE_MAP(scalar_sub_rr, SCALAR_SUB_RR_MAP);
#undef SCALAR_SUB_RR_MAP
/* Generated function prototypes: */
void scalar_sub_rr_maybe_thsubr(Scalar *out, Scalar *b, Scalar c);
void scalar_sub_rr(Scalar *out, Scalar *b, Scalar c);

/* Compute vector magnitude squared.  */
void magn2q_maybe_thsubr(Scalar *out, Scalar *b)
{
  dot_maybe_thsubr(RR_VECTOR(out), b, b);
}

/* Explained in depth later.  */
THSUBR_EXECUTOR(magn2q, magn2q_maybe_thsubr);

/* Compute vector magnitude.  */
void magnitude_maybe_thsubr(Scalar *out, Scalar *b)
{
  magn2q_maybe_thsubr(RR_VECTOR(out), b);
  sqrt_rr_maybe_thsubr(RR_VECTOR(out), RR_VECTOR(out));
}

/* Explained in depth later.  */
THSUBR_EXECUTOR(magnitude, magnitude_maybe_thsubr);

/* Project a point onto a vector.  Only works for floating point
   scalars, due to previous mentioned technicalities with the dot
   product.

   proj_a_on_b(A, B) = B * dot_product(A, B) / magnitude(B)

   If there is no solution, the resulting point's coordinates are all
   set to NOSOL.

   Scratch space `n` and `d` must be pre-allocated to `VEC_LEN` if
   they are vectors.  Otherwise, they may simply be scalars.

   N.B. For efficient general-case computation, we use conditional
   moves and redundant computation for the special cases where there
   is no solution.
*/
void proj_a_on_b_maybe_thsubr(Scalar *out, Scalar *b, Scalar *c,
  MAYBE_VEC n, MAYBE_VEC d)
{
  Bool out_nosol;
  magnitude_maybe_thsubr(RR_VECTOR(d), c);
  out_nosol = (RR_SCALAR(d) == 0);
  /* Avoid divide by zero.  */
  scalar_rr_cmov_maybe_thsubr(RR_VECTOR(d), out_nosol, 1);
  dot_maybe_thsubr(RR_VECTOR(n), b, c);
  SEQ_LOOP_BEGIN {
    muldiv_thsubr(out, c, RR_SCALAR(n), RR_SCALAR(d));
    /* Nullify output if there is in fact no solution.  */
    scalar_cmov_thsubr(out, out_nosol, NOSOL);
  } SEQ_LOOP_END;
}

/* Essentially, our `maybe_thsubr` we've defined is the inner loop of
   a map, but this time because we're working with more lines of code,
   we've used a different syntax.  Also, the fact that `maybe_thsubr`
   subroutines are included means this needs to be treated
   differently.  Nevertheless, a macro is used to generate the thread
   job executor or subroutine alias, which one is applicable depends
   on mode.

   Unfortunately, to maintain our compatibility with OpenCL, our
   working scratch space variable handling has become a bit clumbsy,
   but we'll figure out the right syntax and implementation.

   Also note the use of `SEQ_LOOP_BEGIN { ... } SEQ_LOOP_END`.  We
   need this construct due to our mixing of `reduce` and `map`.  In
   the sequential compute model, normally a `map_maybe_thsubr` goes
   straight to computing only a single component, so we run that in a
   loop to compute all components.  But if we use `reduce` in the
   middle, we don't want to run that in a loop because that will be
   redundant and even inaccurate if variables are being reused.  So we
   need to explicitly specify which computations should be looped, and
   it is permissible to use more than one such loop construct in a
   "maybe thread subroutine".  In the parallel compute model, there is
   no need dfor distinction because it is perfectly fine if we compute
   identical values multiple times in parallel across different
   threads, and that is typically what we will prefer to do when there
   are such scalar variables that are identical across threads.  */
THSUBR_EXECUTOR(proj_a_on_b, proj_a_on_b_maybe_thsubr);

/* Project a point to a plane along the perpendicular:

   Let L = location vector of point,
       A = plane surface normal vector,
       d = plane offset from origin
       plane equation = Ax - d = 0

   L - A * dist_point_to_plane(L, A, d) / magnitude(A)

   Because we are dividing by magnitude twice, the division quantity
   is squared so we therefore can avoid computing the square root and
   simplify as follows:

   L - A * (dot_product(L, A) - d) / magnitude^2(A)

   If there is no solution, the resulting point's coordinates are all
   set to NOSOL.
*/
void proj_pt_plane_maybe_thsubr(Scalar *out, Scalar *b,
                                Scalar *c, Scalar offset,
				MAYBE_VEC n, MAYBE_VEC d, MAYBE_VEC t)
{
  Bool out_nosol;
  magn2q_maybe_thsubr(d, c);
  out_nosol = (RR_SCALAR(d) == 0);
  /* Avoid divide by zero.  */
  scalar_rr_cmov_maybe_thsubr(RR_VECTOR(d), out_nosol, 1);
  dot_maybe_thsubr(RR_VECTOR(n), b, c);
  scalar_sub_rr_maybe_thsubr(RR_VECTOR(n), RR_VECTOR(n), offset);
  SEQ_LOOP_BEGIN {
    muldiv_thsubr(t, c, RR_SCALAR(n), RR_SCALAR(d));
    sub_vec_thsubr(out, b, t);
    /* Nullify output if there is in fact no solution.  */
    scalar_cmov_thsubr(out, out_nosol, NOSOL);
  } SEQ_LOOP_END
}

THSUBR_EXECUTOR(proj_pt_plane, proj_pt_plane_maybe_thsubr);

/* Please note: In some places in our previous subroutine, there were
   areas where the thread subroutines were so simple they could have
   been inlined with the direct C math operator syntax.  However, we
   used the functional form for the purpose of better demonstrating
   the generality of the code structuring.  */
```

Whoah!  Now that is really a powerful programming experience, feels
like flying high at 20,000 feet, cruising at Mach 0.8.  Yet still,
there is room for improvement.

----------

### Code generation remarks

Some other remarks on parallel vector compute are worth mentioning.
Does it always make sense to compute in parallel on vector data
structures at any given opportunity?  Sure, it is always possible, but
that does not mean it is always ideal.  The prime problem with
parallel `reduce` is that it does not keep all parallel worker threads
busy at all times.  The first iteration has all threads busy, but then
as the parallel stages decrease, the number of effectively idle
threads increase.  With SIMD/SIMT architecture, since identical
instruction streams must be executed in lock-step, you can't really
schedule these threads to do anything else.  Now, if there were
matching binary tree parallel `unfold` operations to be done, that
could potentially balance everything out, but `reduce` operations are
so much more common than `unfold` that this simply can't be the case.

Additionally... some very simple GPU architectures like VideoCore IV
on the Raspberry Pi can't really do a parallel reduce efficiently due
to the lack of adequate features and functions for memory access.

So, here's the point to consider.  If you have algorithms with reduce
stages in the middle, consider configuring code generation of the
"inner loop" entirely using the sequential compute model.  Often
times, vector code has a higher level outer loop that is effectively a
simple map of all the complex operations inside.  So, the point here
is to define only the top-level as parallel threads, and ensure that
all lower-level operations are structured so that the parallel threads
can execute identical instruction streams in lock-step.  Namely, this
can be easily achieved by the use of conditional moves instead of
conditional branches and structuring loops to use identical iteration
counts across threads, again using conditional move nullification if
any need to diverge arises.  This allows the threads to be
auto-vectorized into SIMD/SIMT instructions to run efficiently on the
GPU.

The main caveat to watch out for here is the fact that GPUs use
simplified architectures that make them less opportune for the
sequential compute model.  For example, a GPU typically has
pipelining, but it may have not have out-of-order execution, branch
prediction, and speculative execution.  So, small loops (and `reduce`
operations on small vectors) may be most efficiently executed when
they are unrolled (ideally done automatically by the compiler), and
you want your sequential computations to be structured to minimize
pipeline hazards as much as possible.  Namely, by avoiding dependent
computations in rapid sequence and trying to structure your code so
that it is possible for many non-dependent computations to be computed
in close proximity to each other.  In the end, these code generation
considerations might come down to benchmarking to determine which
structure of code generation is better tuned to a particular GPU.  It
is my goal to make my library flexible enough to support optimal code
generation via parametric tuning.

### Parallel power series computation example

Let's consider an even more complex example of `unfold`, compute a
sequence of factorials.  Once we implement this last operation, we
have all the pieces of the puzzle necessary to show a very useful and
impressive example: computing a power series in parallel.  The
strength of power series computations is their generality and
familiarity, they can be used to evaluate a large range of
single-variable differentiable functions and is therefore common
knowledge to anyone who has studied single-variable Calculus.  The
fact that we can run this computation in parallel means that we can
present a familiar interface to mathematical programmers who will be
confident that parallel acceleration will be provided to run it at
maximum speed.

The alternative of programming cleverness to creatively refactoring
computations to run in parallel is much less attractive.  For example,
rather than computing pi via a power series, you can compute pi via a
statistical area process of generating random points and testing
whether they are in the circle or not.  You can then compute the
weighted average to determine the area in the circle, and compute pi
via a few simple arithmetic conversions on that number.  But, alas, I
digress, historically relying on programming cleverness has been far
more common among the few programmers who have optimized our parallel
compute algorithms that are used in the mass market for video
compression codecs and the like.

So, the last key computational piece that we need to compute a power
series?  Compute a sequence of consecutive factorials.  Computing a
single factorial is obvious: do an `unfold` of consecutive integers,
then a `reduce` to determine the product of all those integers.

```
1 2 3 4 5 6 7 8
1*2 3*4 5*6 7*8
1*2*3*4 5*6*7*8
1*2*3*4*5*6*7*8
```

But computing a sequence of consecutive factorials is special: in a
sequential compute model, normally you'd just multiply the nth next
integer in a step-wise fashion, but how do you do this in parallel?
The key is in considering what happens to the scratch space when we
normally compute just a single factorial in parallel.  Let's take a
look.

```
1, 2, 3, 4, 5, 6, 7, 8
1*2, 2, 3*4, 4, 5*6, 6, 7*8, 8
1*2*3*4, 2, 3*4, 4, 5*6*7*8, 6, 7*8, 8
1*2*3*4*5*6*7*8, 2, 3*4, 4, 5*6*7*8, 6, 7*8, 8
```

Now, here's the idea.  In the working scratch space, we have space to
store partials.  We just need to select which partials we keep and get
rid of in such a way that we have enough partials to efficiently
compute any factorial in the sequence.  As it turns out, if we change
our strategy to overwriting the last element in a parallel slice
rather than the first one, we can have all the partials we need to
efficiently compute any factorial.

```
1, 2, 3, 4, 5, 6, 7, 8
1, 1*2, 3, 3*4, 5, 5*6, 7, 7*8
1, 1*2, 3, 1*2*3*4, 5, 5*6, 7, 5*6*7*8
1, 1*2, 3, 1*2*3*4, 5, 5*6, 7, 1*2*3*4*5*6*7*8
```

Now, you can see that we can compute `1!` to `8!` efficiently using
these partials.

```
1! = 1
2! = 1*2
3! = 1*2 * 3
4! = 1*2*3*4
5! = 1*2*3*4 * 5
6! = 1*2*3*4 * 5*6
7! = 1*2*3*4 * 5*6 * 7
8! = 1*2*3*4*5*6*7*8
```

And in fact, if you look at what is going on carefully, you can
actually decode any binary number into a set of partials that need to
be multiplied together to compute `n!`.  Here's what's going on.

```
1! -> 0b0001 -> 0b0001 -> a[1]
2! -> 0b0010 -> 0b0010 -> a[2]
3! -> 0b0011 -> 0b0010, 0b0011 -> a[2] * a[3]
4! -> 0b0100 -> 0b0100 -> a[4]
5! -> 0b0101 -> 0b0100, 0b0101 -> a[4] * a[5]
6! -> 0b0110 -> 0b0100, 0b0110 -> a[4] * a[6]
7! -> 0b0111 -> 0b0100, 0b0110, 0b0111 -> a[4] * a[6] * a[7]
8! -> 0b1000 -> 0b1000 -> a[8]
```

So, you see what's going on?  You start with all bits masked out to
zero, then you progressively reduce the number of bits you have masked
out from most significant bit to least significant bit.  If a new
number is revealed, you have a new factor to multiply, which is simply
the index of your number.  (Ideally you start your array with `0!`.)
You stop once you have unmasked all bits.

This method can obviously be extended to parallel, namely by asserting
a factor if the bit just unmasked is nonzero, else there is no factor
to consider.  A binary decision list to pick or not pick factors is
then created, and this can be trivially converted to a list of factors
via a parallel `map`, followed by a parallel `reduce` to get the final
result.  The maximum number of factors is, of course, the maximum
number of bits in the factorial source number, or `log_2(n)` for `n!`.

In parallel with "unlimited width," the total number of sequential
steps is `O(log_2(n) + log_2(log_2(n))) = O(log_2(n * log_2(n)))`, so
this is still pretty efficient.  When the hardware parallel width
limit is reached, subsequent computations are completed sequentially,
and runtime then eventually diminishes to `O(n / c)`, where `c` is the
initial speedup constant related to the limited parts that can be
computed in parallel.

Now, let's put it all together in pseudo-code.  Basically, the main
new additional higher-order primitive we need here is a modified
parallel reduce, designed to "preserve partials."  This is fairly easy
to code up since what it comes down to is just an increment and a
decrement in the index computation.

```
/* Thread subroutine: Run one thread of the parallel `reduce`
   subroutine to reduce in-place, writing the `reduce` result to the
   end of the parallel block rather than the beginning.  Only each
   individual block is reduced.  You must then use a thread job
   executor to reduce these results down to a single scalar.

   The result of the reduction is stored in the last element of each
   block of the vector.

   PLEASE NOTE: We rewrite the vector in place as our working memory,
   so pass a copy!

   BLOCK_LEN must be a power of two.  */
void ABSTRACT_REDUCE_END_BLOCK_THSUBR(THCtx *ctx, Scalar *work,
                                     unsigned REAL_LEN) {
  unsigned stride_1 = 1; /* stride - 1 */
  unsigned stride_log2 = 1;
  unsigned sd_half = 1; /* Half stride */
  unsigned sub_len;
  unsigned i = GET_GLOBAL_TH_IDX(ctx);
  unsigned my_blk_len = BLOCK_LEN;

  /* Depends on mode whether we do this at all.  If reduce operates on
     non-power-of-two input.  */
  CMOV((i >= (REAL_LEN & ~(BLOCK_LEN - 1))), unsigned, \
    my_blk_len, REAL_LEN & (BLOCK_LEN - 1));

  /* sub_len computation is reformulation of the following:
     while (stride * (i + 1) - 1 < my_blk_len) { ... }  */
     -> reorganize with correct rounding ->
     while ((sub_len = ((my_blk_len + 1 - stride) +
                        (stride - 1)) / stride) > 0)
       { ... }
     ->
     while ((sub_len = my_blk_len / stride) > 0) { ... }

     N.B. Since we divide strictly by powers of two, this can be
     simplified to bit-shifting.  Very important!  */
  while ((sub_len = my_blk_len >> stride_log2) > 0) {
    CMOV((i < sub_len), Scalar, \
      work[stride*i+stride_1], \
      COMBINE(work[stride*i+stride_1], work[stride*i+sd_half]));

    /* OpenCL barrier ensures that all threads are synced in execution
       and local memory consistency state by this point, for the sake
       of the sequential outer loop.  */
    barrier(CLK_LOCAL_MEM_FENCE);

    stride_1 = stride_1 * 2 + 1; /* = (stride_1 + 1) * 2 - 1 */
    stride_log2++;
    sd_half *= 2;
  }
}

/* Now, for the `REDUCE_ALL` subroutine.  Unfortunately, due to
   needing to keep partials, this must be a bit more complicated.  We
   need to gather the block-wise reduce results for higher-order
   computation, then scatter them to store them.  So this means that
   we also need more local memory to handle this.

   Fortunately, however, we can still make an optimization.  We
   actually only need to scatter to store partial results, but we can
   still coalesce in place just like we do with the conventional
   parallel `REDUCE_ALL`.  */

void scatter_store_end_thsubr(THCtx *ctx, Scalar *out, Scalar *work,
                              unsigned REAL_LEN, unsigned stride)
{
  unsigned i = GET_GLOBAL_TH_IDX(ctx);
  /* Depends on mode whether we make this check, if it is possible
     that we are not aligned to the block size.  */
  CMOV((i < REAL_LEN), Scalar, out[stride*i], work[i]);
}

/* Thread job executor for finish `reduce`, thread job executor on the
   `reduce_end` concrete thread subroutine multiple times until there
   is only one element remaining.  Each time we `reduce_end`, we
   scatter-store the partials to the destination memory.

   BLOCK_LEN must be a power of two so that BLOCK_LEN_LOG2 can be used
   for fast divide by shift right.  */
void ABSTRACT_REDUCE_END_ALL(unsigned wait_list_len, cl_event *wait_list,
                             cl_event *out_event,
                             Scalar *out, Scalar *work, unsigned REAL_LEN)
{
  cl_event wait_event, old_wait_event;
  unsigned sub_len = REAL_LEN >> BLOCK_LEN_LOG2;
  unsigned scatter_stride = BLOCK_LEN;

  while (sub_len > 1) {
    unsigned align_len = (sub_len + BLOCK_LEN - 1) & ~(BLOCK_LEN - 1);
    sched_th_job(align_len, BLOCK_LEN,
      wait_list_len, wait_list, &wait_event,
      coalesce_stride_thsubr, work, work, sub_len, BLOCK_LEN);
    while (wait_list_len > 0) {
      wait_list_len--;
      clReleaseEvent(*wait_list++);
    }
    old_wait_event = wait_event;
    /* Check if we need to add padding to fill `BLOCK_LEN`.  */
    if (sub_len != align_len) {
      /* unsigned rem = sub_len & (BLOCK_LEN - 1);
      unsigned frag = sub_len - rem; */
      /* Ideally we'd compute on only the subset
         `work[frag...frag+rem]`.  But OpenCL 1.0 doesn't have
         convenient syntax to support that, so just compute on
         everything.  PLEASE NOTE: OpenCL 1.1 added support for
         sub-buffer objects, clCreateSubBuffer().  */
      /* N.B.: This could possibly be faster on the CPU in a Unified
         Memory Architecture but slower on non-unified architectures.
         So it depends on mode whether we execute on the GPU.  */
      sched_th_job(align_len, BLOCK_LEN, 1, &old_wait_event, &wait_event,
        pad_align_thsubr, work, sub_len, IDENT_VAL);
      clReleaseEvent(old_wait_event);
      old_wait_event = wait_event;
    }
    sched_th_job(align_len, BLOCK_LEN, 1, &old_wait_event, &wait_event,
      ABSTRACT_REDUCE_END_BLOCK_THSUBR, work, sub_len);
    clReleaseEvent(old_wait_event);
    old_wait_event = wait_event;
    /* Now scatter-store the partials to `out`.  */
    sched_th_job(align_len, BLOCK_LEN, 1, &old_wait_event, &wait_event,
      scatter_store_end_thsubr, out, work, sub_len, scatter_stride);
    clReleaseEvent(old_wait_event);
    old_wait_event = wait_event;
    sub_len >>= BLOCK_LEN_LOG2;
    scatter_stride <<= BLOCK_LEN_LOG2;
  }
  *out_event = old_wait_event;
}
```

The abstract map-reduce routine above `ABSTRACT_REDUCE_END_ALL()` is
almost exactly the same as in the conventional case.  Basically, you
need to make sure you also allocate additional local memory scratch
space for `work` and initialize it to be a copy of `out`.  The
scatter-store output goes straight to `out`.  For brevity, we will not
show it with the changes.  Likewise, the changes for
`ABSTRACT_MAP_REDUCE_END_BLOCK_THSUBR()` are extremely trivial: just
use `ABSTRACT_REDUCE_END_BLOCK_THSUBR()` instead of
`ABSTRACT_REDUCE_BLOCK_THSUBR()`.

Now, following the computation of partials via `reduce_end`, we can
implement the map-reduce subroutine for computing the final sequence
of factorials.

```
/* Stage 2 is trivial, technically we have already showed the code for
   it so we will not repeat it here.  Generate a list of consecutive
   integers, we can do this using the optimized `gpu_unfold_n()`
   subroutine.  */

/* Now, the final stage, stage 3.  For one factorial input number,
   collect all partial factors and multiply them together.  These jobs
   must be executed for each consecutive input integer in the
   sequence, and, of course, as each job is independent, they can be
   issued in parallel.  */
#define FACTRAL_MAP(work, i) \
  ((num & (1 << i))) ? partials[num & ~((1 << i) - 1)] : 1
#define FACTRAL_COMBINE(b, c) (b * c)
CONCRETE_MAP_REDUCE(factral_stage3, FACTRAL_MAP, 1, FACTRAL_COMBINE);
#undef FACTRAL_MAP
#undef FACTRAL_COMBINE
/* Generated function prototypes: */
void factral_stage3_maybe_thsubr(Scalar *out, unsigned num);
void factral_stage3(Scalar *out, unsigned num);
```

Now... the stage 2 and stage 3 is indeed a bit weird, I must admit.
The unfortunate fact is, thatthe code that schedules all these
parallel jobs must run on the CPU, so you have a sequential bottleneck
that probably far outweighs the gains from being able to reduce in
parallel.  Since we are, after all, working with partials, we have
exponentially less factors to multiply together, so it might make more
sense to use the sequential compute model formulation to multiply
together the partials, then use GPU thread-level parallelism to
process all such numbers in parallel.  This also better ensures that
the parallel threads are kept as busy as possible.  Let's show the
code for that since the implementation is rather specialized.

```
/* Combine partials to generate a sequence of consecutive unfold
   values, i.e. generat3e a factorial sequence from computed partials.

   For the sake that this needs a bit of specialized optimization,
   while at the same time it is fairly general for other types of
   unfolds, we will define the thread subroutine straight for
   combining partials computed from a parallel `map-reduce*`
   (i.e. preserves partials).

   What's going on here in higher-order vector functions?
   Technically, this is an `unfold-unfold-map-reduce`.  Since we are
   using GPU optimization for unfolding consecutive integers, it looks
   like a `map-map-reduce`.  Since we run the interior
   `unfold-map-reduce` sequentially, as a whole it looks like a `map`.
   So in the end, it seemed simpler to just write the straight code
   without using the higher-order code generation, except for the use
   of defining the reduce generically by way of `IDENT_VAL` and
   `COMBINE()`.

   PLEASE NOTE: `partials` must be zero-based, i.e. the first result
   of an `unfold` would be found at index 1 rather than index zero.
   The item at index zero is the identity value defined for the
   particular combinator.  So, for example, `unfold` count by one
   would be `{ 0, 1, 2, 3, ... }` and `unfold` power series of three
   would be `{ 1, 3, 9, 27, ... }`.  */
void combine_parts_thsubr(THCtx *ctx, Scalar *out, Scalar *partials,
                          unsigned REAL_LEN, unsigned bits_len)
{
  unsigned i = GET_GLOBAL_TH_IDX(ctx);
  unsigned j = bits_len;
  /* Sequential compute model map-reduce inlined right here, run in
     parallel for the width of `out`.  */
  Scalar accum = IDENT_VAL;

  while (j > 0) {
    unsigned bt; /* bit test */
    j--;
    bt = 1 << j;
    Scalar part =
      ((i & bt)) ? partials[i & ~(bt - 1)] : 1;
    accum = COMBINE(accum, part);
  }
  /* Depends on mode whether we make this check, if it is possible
     that we are not aligned to the block size.  */
  CMOV((i < REAL_LEN), Scalar, out[i], accum);
}
```

Now that we have the factorial sequence figured out, let's work on the
big picture.  The Taylor power series is defined as follows:

```
sum_{n = 0}^oo f^(n)(a) * (x - a)^n / n!
```

`f^(n)(a)` is my notation for the nth derivative of function `f(x)`,
evaluated at the value `a`.  When `a = 0`, the simplified form is
called the Maclaurin series.

With all the pieces of the puzzle in place, we can now implement the
power series computation kernel.  This can be outlined in the
following stages:

* Compute the derivative sequence
* Compute the power sequence (`unfold`)
* Compute the sequence of factorials (`unfold-map-reduce*,
  unfold-map-reduce`)
* Multiply-divide to combine these three factors (`map`)
* Sum up the terms (`reduce`)

For computing the derivative sequence, the function `f(x) = e^x` is an
easy special case because `f'(x) = e^x`.  So, computing the derivative
sequence is trivial: `e^0 = 1`.  Likewise, sine and cosine are easy
because their derivatives at angle zero cycle between zero and one.
So that can be computed in parallel using the following equation:
`((-1)^n + 1) / 2`.  Since this is readily a power sequence followed
by a map, a parallel `unfold` can be used.  Or... well if you're a
programmer, this other alternative is obvious: `n % 2 == n & 1`.
Using low-level GPU optimization magic, that can be computed fully in
parallel.

So, all that being said, let's pick the easiest concrete example to
compute, `e^x`.  This makes the step to compute the derivative
sequence drop out completely since we compute as a Maclaurin series on
`e^x`, which will be `e^0 = 1` every single time.  What we've
developed in bits and pieces, we can now put it all together and see
how it works as a whole.

```
#define MAX(b, c) (((b) > (c)) ? (b) : (c))

#define FACTRAL_MAP(work, i) work = MAX(1, i)
#define FACTRAL_COMBINE(b, c) (b * c)
CONCRETE_MAP_REDUCE_END(factral_gen_parts, FACTRAL_MAP, 1, FACTRAL_COMBINE);
CONCRETE_COMBINE_PARTIALS(factral_combine_parts, 1, FACTRAL_COMBINE);
#undef FACTRAL_MAP
#undef FACTRAL_COMBINE
/* Generated function prototypes: */
void factral_gen_parts_maybe_thsubr(Scalar *out, unsigned REAL_LEN);
void factral_gen_parts(Scalar *out, unsigned REAL_LEN);
void factral_combine_parts_maybe_thsubr(Scalar *out, Scalar *partials,
                                        unsigned REAL_LEN, unsigned bits_len);
void factral_combine_parts(Scalar *out, Scalar *partials,
                           unsigned REAL_LEN,  unsigned bits_len);

/* For posterity, a quick definition: Find the bit index of the most
   significant bit, or (unsigned)-1 if the input is zero.  Count
   leading zeroes (`clz()` subroutine), then subtract the result from
   the width in bits minus one.  Essentially, this computes the base 2
   logarithm of positive unsigned integers.  */
unsigned char msbidx(unsigned b)
{
  return 8 * sizeof(unsigned) - 1 - clz(b);
}

/* Now with all this code generation, it's a breeze to craft our
   subroutine to generate a factorial sequence, starting at `0!` and
   including `n!`.  Results are returned in `out`, which must be
   sufficiently allocated.  */
void gen_factral_list_n(Scalar *out, unsigned n)
{
  unsigned REAL_LEN = n + 1;
  unsigned VEC_LEN = (REAL_LEN + BLOCK_LEN - 1) & ~(BLOCK_LEN - 1);
  unsigned bit_len = msbidx(REAL_LEN) + 1;
  /* OpenCL ALLOCATE GLOBAL MEMORY.  `xmalloc()` used only for
     simplicity of demonstration.  */
  Scalar *work = (Scalar*)xmalloc(sizeof(Scalar) * VEC_LEN);
  factral_gen_parts(work, REAL_LEN);
  factral_combine_parts(out, work, REAL_LEN, bit_len);
  /* OpenCL FREE GLOBAL MEMORY.  */
  xfree(work);
}

/* We can generate a power sequence in parallel with ease, thanks to
   our `unfold` code generators.  */

/* Parameterize the base value to a variable.  */
#define GEN_POW_LIST_NZ_BASE base
#define GEN_POW_LIST_NZ_COMBINE(b, c) (b * c)
CONCRETE_UNFOLD(gen_pow_list_nz, \
  GEN_POW_LIST_NZ_BASE, gen_pow_list_nz_COMBINE);
#undef GEN_POW_LIST_NZ_BASE
#undef GEN_POW_LIST_NZ_COMBINE
/* Generated function prototypes: */
void gen_pow_list_nz_blkone(Scalar *out, Scalar base);
void gen_pow_list_nz_maybe_thsubr(Scalar *out, Scalar *blkone,
                                  unsigned REAL_LEN, Scalar base);
void gen_pow_list_nz(Scalar *out, Scalar *blkone, unsigned REAL_LEN,
                                  Scalar base);

/* We just need one little helper subroutine to correctly set up a
   zero-based array.  And, well, to provide a fully high-level
   programmer interface.  Compute a power sequence of base, starting
   at `base^0` and including `base^n`.  Results are returned in `out`,
   which must be sufficiently allocated.  */
void gen_pow_list(Scalar *out, Scalar base, unsigned n)
{
  unsigned REAL_LEN = n + 1;
  /* OpenCL ALLOCATE GLOBAL MEMORY.  `xmalloc()` used only for
     simplicity of demonstration.  */
  Scalar *blkone = (Scalar*)xmalloc(sizeof(Scalar) * BLOCK_LEN);
  gen_pow_list_nz_blkone(blkone, base);
  /* N.B.: Use OpenCL 1.1 `clCreateSubBuffer()` as necessary.  */
  gen_pow_list_nz(&out[1], blkone, REAL_LEN, base);
  /* Initialize out[0] as `base^0 = 1`.  */
  out[0] = 1;
  /* OpenCL FREE GLOBAL MEMORY.  */
  xfree(blkone);
}

/* Finally, the last stage of the computation of `e^x` can be
   implemented as a simple `map-reduce`.  */
#define DIVSUM_MAP(work, i) work = b[i] / c[i]
#define DIVSUM_REDUCE(b, c) (b + c)
CONCRETE_MAP_REDUCE(divsum, DIVSUM_MAP, 0, DIVSUM_REDUCE);
#undef DIVSUM_MAP
#undef DIVSUM_REDUCE
/* Generated function prototypes: */
void divsum_maybe_thsubr(Scalar *out, Scalar *b, Scalar *c);
void divsum(Scalar *out, Scalar *b, Scalar *c);

/* Now for a little helper function to put it all together.  Compute
   `e^x` using `n + 1` power series iterations.  */

Scalar pow_e_x(Scalar x, unsigned n)
{
  Scalar result;
  unsigned REAL_LEN = n + 1;
  unsigned VEC_LEN = (REAL_LEN + BLOCK_LEN - 1) & ~(BLOCK_LEN - 1);
  /* OpenCL ALLOCATE GLOBAL MEMORY.  `xmalloc()` used only for
     simplicity of demonstration.  */
  Scalar *pow_list = (Scalar*)xmalloc(sizeof(Scalar) * VEC_LEN);
  Scalar *factral_list = (Scalar*)xmalloc(sizeof(Scalar) * VEC_LEN);
  Scalar *work = (Scalar*)xmalloc(sizeof(Scalar) * VEC_LEN);

  gen_pow_list(pow_list, x, n);
  gen_factral_list_n(factral_list, n);
  divsum(work, pow_list, factral_list);
  /* OpenCL READ GLOBAL MEMORY BUFFER.  */
  result = work[0];

  /* OpenCL FREE GLOBAL MEMORY.  */
  xfree(pow_list);
  xfree(factral_list);
  xfree(work);

  return result;
}
```

----------

### Conclusion

An important observation of the path to implementing code is worth
reflecting on.  The full optimization of combined operations
introduces a certain degree of complexity to the programmer, both for
sequential **and** parallel computation, _especially_ when GPU memory
access constraints and optimizations also have to be considered.
Subroutines that behave as if they compute all scalars in parallel are
easiest to program with.  However, in the case of `unfold` and
`reduce`, it is easier to program the actual body code of a sequential
compute model.  This ease-of-programming fact is not to be
underestimated if you are writing new algorithms!  Likewise, the
reason why much existing math code was written specialized to
assumptions that only work well for a particular application is
obvious: there are simply less things you need to keep simultaneously
track of in your head when implementing specialized code at the bottom
layer, and if the goal is to develop only a single application, why
bother generalizing?

It's very easy to write a sequential compute model `unfold` (generator
function), but rather challenging to write a parallel compute model
`unfold`.  But, in the end, it is very rewarding, because this is the
last piece of the puzzle you need to be able to get a reasonably fast
generalized parallel power series computation.  That allows you to
evaluate many arbitrary functions with ease, to a high number of bits
of precision.  Applying a few restrictions on what can be done by a
generator function and how the code is to be structured is likewise
very helpful for implementing parallel `unfold` operations.

Now, the ad ultimum question: How does the performance compare against
a sequential compute model alternative?  Now, that is a question to
answer for a different time.  I have only thus yet presented the core
concepts here in pseudo-code, there are tiny little changes I need to
make all over to turn this into real, working code.  But, the main
idea of this discussion was to set the stage with some good ideas that
would work well as guidance during my process of implementing the
actual working code.  And, might I mention this other idea, it would
be great to venture into the world of Fourier series as that is
extremely common in multimedia processing.

Obviously, simply putting together an ideal math subroutines library
is not enough.  Without connecting it with some baseline practical
applications, it will never gain popularity on its own for other
people to consider implementing other software on top of it.  This is
the prime reason why so much software does not use very good math
libraries and implementation.  Essentially, at least for a long time
until recently, modern software development is a "race to the bottom":
whoever develops some crude software that showcases some function
first wins.  This is in total disregard to how much those short-term
decisions may slow down long term future development.  But because of
the pressures of the historic software profession of dumping the
software bloat problem onto the brute force increases of sequential
compute speed in computer hardware to solve, it worked pretty well for
a good 15 years.

That being said, the reason why quality software development is making
a comeback is obvious.  The brute force methodology of throwing more
sequential compute speed at otherwise broken software has come to an
end over a decade ago.  In the meantime, it has become more than
obvious that the incumbent players were failing to improve their
software, and that has opened up ample opportunity for quality-focused
competitors to take the stage.  Not just to break even with the old
software was a race to slap together, but to go further much faster
and eclipse it in features and functions.
