---
layout: post
title: More optimized array looping in C
author: quorten
date: 2018-06-03 20:37 -0500
categories: [unlipic]
tags: [unlipic]
---

I've realized an interesting optimization when working a more
optimized code path in a toy virtual filesystem implementation I've
created.

First, examine a "non-optimized" linear search implementation:

    unsigned i;
    FSNode **files_d = parent->data.files.d;
    unsigned files_len = parent->data.files.len;
    for (i = 0; i < files_len; i++)
    {
        if (!strcmp(name, files_d[i]->name))
            return i;
    }

Now, compare that with the optimized variant.

    unsigned i = parent->data.files.len;
    FSNode **files_d = parent->data.files.d;
    while (i > 0)
    {
        i--;
        if (!strcmp(name, files_d[i]->name))
            return i;
    }

<!-- more -->

The original intent was mainly to optimize searching for recently
created files added to the tail of the file list in a directory
structure.  However, upon a closer examination, there is another
optimizations at work here too.  The original implementation required
two variables for the loop condition: the counter variable `i` and the
limit variable `files_len`.  This backwards counting implementation
only requires the counter variable `i` because the limit is "stored"
in the counter variable at the beginning of the loop.  Hence, that's
one less register/memory operation to maintain the loop.

A related thought.  Why did Brian Kerningham and Dennis Ritchie think
that null-terminated strings were more convenient to work with than
passing around the length in a variable?  Well, let's look at it from
a low-level programming perspective.  For string processing, obviously
you only want to walk a string forwards, not backwards.  However, if
the string's length variable is your only indication of where the end
of the string is, your machine code implementation is inconvenienced
by needing another register/memory operation to maintain the loop.  By
contrast, a null-terminated string obviates this extra variable during
string processing loops, hence freeing up a processor register or
memory cycles for other uses.

As we now know today, however, the main disadvantage of not keeping
track of the string length variable is that computing a string's
length is expensive.  The best of today's string processing
implementations use a hybrid approach: both null termination and a
string length variable are used and maintained together.

Now, here's a really interesting idea.  What if you _really_ want to
use the same concept for counting forward?  Well, my hints that I
typed my length and index variables as unsigned integers may seem like
a complication to this desire, but never fear.  Two's-complement
arithmetic can handle this just as well: rather than assuming your
index variable is non-negative, you assume it is "non-positive," and
you use an array base pointer that points _just beyond the end_ of the
array rather than at the beginning.  Let's try an example, this time
with strings as our emphasis.

    unsigned i = (unsigned)-message.len;
    char *message_d = message.d[message.len];
    while (i != 0) /* (unsigned negative)i < 0 */
    {
        putchar(message_d[i]);
        i++;
    }

Not too bad, must I say myself?  Worthy of note here is that negative
array indices are allowed in C: officially, `message_d[i]` is defined
to be syntactically the same as `*(message_d + i)`.  Incidentally,
this code structure also works very well on the 6502 CPU, where doing
zero tests are easy, but greater-than and less-than comparisons are
difficult.  And yes, that's also where registers are scarce.

But wait.  There's a close second that is almost as good as the
previous implementation.  Although the following code performs slower
on a 6502 than the previous code, on modern architectures the
performance difference is negligible.  (Okay, maybe the 6502 is only
faster walking in reverse, not walking forwards.)

    char *cur_pos = message.d;
    char *end = &message.d[message.len];
    while (cur_pos != end)
        putchar(*cur_pos++);

Oh, and don't forget.  You may have noticed this from my code
implementations above.  In C, avoid extra pointer dereferencing when
you can, because the C compiler generally makes no assumptions when
dereferencing pointers, and every extra pointer dereference in a loop
will slow it down.  Yes, I know, C's syntax often times makes it
shorter to write the slower version as you do not have to define a new
variable, but keep in mind that tight inner loops are
performance-critical, so save the liberal use of the syntactic
shortcuts to code outside of tight inner loops!

----------

UPDATE 2019-12-18: Worried about running off the edge of the array
bounds, but still want to use unsigned integer arithmetic?  Here's a
nifty trick to keep in mind.  If you use an unsigned integer to
indicate the length of an array, the maximum array length is UINT_MAX,
and the maximum array index is UINT_MAX - 1.  This means that you will
always have at least one "invalid" array index, and in the case the
array is shorter, you will have a larger range of invalid array
indices.  Namely, any unsigned integer that meets or exceeds the array
length.  Armed with this knowledge, you can add additional safety to
counting forwards with negative indices from the end of the array as
follows:

    unsigned n_message_len = (unsigned)-message.len;
    unsigned i = n_message.len;
    char *message_d = message.d[message.len];
    while (i >= n_message_len) /* (unsigned negative)i < 0 */
    {
        putchar(message_d[i]);
        i++;
    }

Finally, in light of range considerations, we must also use the
"negated" `message.len` when comparing `i` so that we also preserve
the fully available range.
