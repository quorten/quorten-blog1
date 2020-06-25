---
layout: post
title: "Transparently handle both machine integers and bignums in C
        programming"
date: 2020-06-24 11:36 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

C++ operator overloading makes it really easy to write generalized
math code.  Just change the type declarations on your variables, and
tada!  You can go from using machine integers to bugnums.  But simpler
programming languages like C do not have operator overloading.
Besides implementing a parser front-end to rewrite your code, how else
can you achieve similar effects in C?

The solution is simple though mundane.  Rewrite all your math code so
that it looks like it's working with bignums all the time.  Rather
than using infix notation with arithmetic operators, you use function
call notation everywhere.  Here's a simple example.

```
a = b + c;
#define ADD2_NUM(b, c) ((b) + (c))
#define ADD3_NUM(a, b, c) ((a) = ADD2((b), (c)))
```

Since we otherwise would have two identical macro names for the two
variants, we add a number to the name indicating how many arguments
the macro takes.  The two-argument form passes the result as a return
value, the other writes its output to an argument, _and_ also makes it
available as a return value.  If `b` and `c` are passed by value, `a`
is also passed by value.  The rule is that all arguments are either
passed by value or passed by reference for consistency.

<!-- more -->

The two-argument form is provided for convenience, but it is generally
not optimal in code working with higher-order objects because it
requires the subroutine to always allocate a new object for passing
the return value, rather than using an object pre-allocated by the
caller that may be reused in multiple loop iterations.  So, in your
body code, you should always use "three argument form" for full
generality.  This allows arbitrary precision functions to be
transparently substituted without needing to rewrite your code.  And,
it allows doing so in the most efficient manner possible.

Of course, this abstraction is not enough for arbitrary precision
arithmetic.  Bignums also require initialization and destruction
routines.  So you must also take care to add these in the proper
locations of your code.  When working with machine integers, these
simply expand to no-ops.

```
INIT_NUM(a)
DESTROY_NUM(a)
```

Often times, you just need a temporary variable to do some
intermediate computations.  Why repeatedly initialize and destroy the
temporary variable when you can just stash it to a caching stack and
pull and retrieve it when required?  So, we define these macros for
working with temporary variables.

```
GET_TMP_NUM(ctx, a)
RELEASE_TMP_NUM(ctx, a)
SET_ALLOC_TMP_NUMS(ctx, n)
ADD_ALLOC_TMP_NUMS(ctx, n)
SUB_ALLOC_TMP_NUMS(ctx, n)
```

`*_ALLOC_TMP_NUMS()` macros are used to adjust the height of the
stack.  If the maximum number of temporary variables required can be
anticipated in advance, initializing them all at once can be more
efficient.  Otherwise, it is possible to dynamically grow the stack.
The stack is only shortened upon request.
