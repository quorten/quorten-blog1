---
layout: post
title: Discussion on memory buffer implementation and network updates
author: quorten
date: 2018-06-30 10:55 -0500
categories: [unlipic, important]
tags: [unlipic, important]
---

So, about your shared memory buffer implementation?  If you have a
memory buffer you can concurrently edit across a network, how do you
extend that implementation so that it not only supports concurrent
text editing, but can actually be the back-end memory for a database?
Here's how.

First of all, the underlying concepts.  For the sake of efficiency,
you can define _segments_ in a shared memory buffer.  The alternative
would be to define separate shared memory buffers and an array
structure that points to all of them, but we'll support that built-in
right off the bat.

Each defined segment can be _locked_ so that writes cannot happen to
it until it is _unlocked_.  Similarly, a segment can be locked so that
only a single writer can make changes to it.  Even more advanced, a
single segment can be locked so that multiple writers can make changes
to it.  This could, for example, be used for access control to a
simple text buffer.  Even more advanced, multiple segments can be
locked at the same time.

Generally speaking, a database defines some internal data structure
that must be held consistent.  You can do a _consistency check_ on any
segment.  Often times a segment must be guaranteed to be consistent
before further operations can be performed, and to make this
guarantee, a segment must be locked before the consistency check can
be executed.  More advanced, you could do a consistency check on
multiple segments.

<!-- more -->

The next thing you can do: you can _dynamically_ define segments as
regions.  In practice, you need to do a consistency check on the outer
context so that you know you can parse out the dynamic region.  This
means you must lock the containing segment first, and then do the
consistency check.  This is why support for buffer segments is
built-in: otherwise, you have to lock the entire buffer and do a
consistency check across the entire buffer (or most of the buffer)
before you can lock your dynamic region.

Important!  Segments, especially dynamic ones, need to have space that
can be provisioned for _parser state_, higher-level information
obtained from a parse that may be required in order to quickly and
efficiently execute a consistency check on that segment.

Now, on second thought, it may not be necessary to lock the entire
buffer and perform consistency checks before locking regions: our
address forward-porting system may be robust enough to request region
locks without worrying about inconsistency later developing in the
absence of a whole buffer lock.

Once memory buffer regions are locked, atomic database updates can be
performed just as would be traditionally the case, an optional
consistency check can be run on the final results, and the locked
segments can be unlocked.  Mandating a final consistency check can
allow for the possibility of arbitrary expansion of operating features
and functions, including possibly buggy code.  If the code is buggy
and corrupts data format consistency, the changes can be rolled back
and the requested operation can return an error.

Suppose you have a lump buffer off the start and want to split it up
into pre-defined segments?  No worries, the dynamic segment workflow
works great here!

1. Lock the entire buffer
2. Perform a consistency check on the entire buffer (or most of it)
3. Define the formal segments
4. Unlock the entire buffer

In this case, you're simply using dynamic segments, but the buffer
system remembers and maintains them persistently rather than
forgetting them.

Of course, given the other option, splitting them off into independent
memory buffers, we should have a way to gracefully support that
dynamic transition too.

So, anyways, you get the idea.  Those are the major features and
functions on top of a basic shared memory buffer implementation needed
to support a database, possibly a quite distributed one at that.

Point in hand: The difference between segments in one buffer and
independent buffers?  The addressing semantics.

Now you can also have trees of buffers... and yeah you can make it
more complicated.  What advantage would there be to trees of buffers?
Easier locking.  Matter of fact, you could use such a system to make
multi-segment locking easier and faster, along with checking for
locks.

What if you have a writer that does not use proper locking, but
otherwise writes consistent data?  If you lock a buffer, and the
consistency check fails, you unlock it and return failure to the
writer who was attempting to lock it.  Now the writer that was
interrupted will simply continue and finish, and if the locking
operation is retried, it will continue as normal.  Of course, this
can't always work in cases where you have multiple writers that don't
properly lock the buffer, although it sometimes will still work,
especially if they have been explicitly designed such that they
support concurrent writes with each other that will result in
consistent data without locking.  Prominent example: replacing a
record of fixed length.  This only requires a single shared buffer
command: replace.  Variable-length?  Actually this can work perfectly
fine too, thanks to our forward porting address semantics, so long as
the logical boundaries are meant to be exactly the same in all cases.

Actually, if a vector of primitive commands are grouped together and
are to be executed atomically, you can avoid locking under a lot of
circumstances.  But point in hand, there's a big difference between
commands coming from a human versus for software implementing a
database.

Point in hand: locking is only required if you need a
read-modify-write approach for data consistency.  By contrast, if you
can write wholly consistent data without the need to read, there is no
need to lock, so long as you have an atomic write operation.  So, for
example, if you already have your beginning and end references tied to
a buffer version, you can just write out immediately.  But if you need
to parse the references out, then you need to lock the buffer for the
reading operations required to parse out the location references.

What happens if you write out a multiple commands without bundling
them into a command vector?  That could indeed work alright, and that
would give you a "eventually consistent" database implementation.
Although... retries and back-off on consistency failures might be
required to satisfy the "eventually consistent" aspect.

----------

But, there are challenges with this approach.  First of all, let's
consider the edit-compile cycle.  Compilation via substitution
generates a derivative memory version, but so does editing from the
same base.  Now in order to do a delta recompile, you've got to in
effect do a three-way diff and merge, compile only the new source code
that's been added, then finally generate that down to machine code.
Machine code needs to be generated on a whole function basis, but
separate functions can simply be static linked together by traditional
means.

But, by far the bigger problem going on here comes from the
traditionally non-computerized world: language, culture, and
education.  Let's focus on education first.  Traditionally,
educational materials tend to be "written from scratch," from a "blank
slate."  Once they are refined, they are mass-copied.  But the point
in hand here is that even when an education material coming from a
"blank slate," that doesn't mean it is really "new."  Oh, far from it.
Chances are it's very similar to something that has already been
written before.  And this is just where the challenge comes in, even
when the data is entered via a computer: without explicit linking, how
do you know where the material originally came from?  Exactly, you
need a way to infer and get this information implicitly.

Luckily, with language, culture, and education changes, these tend to
be highly redundant and change slowly over time, so with sufficiently
high-resolution scanning, you can generate the link data autonomously.
Unfortunately, the need for digitized, frequent scan, high resolution
data is what throws this idea off.  First of all, how do you gather
that data with modern schools buying proprietary courseware systems?
The whole point of the system is to restrict the data and lock other
people out.  Second, materials of school times past are largely
analog, never created digitally.  In order to commence a computer
analysis of this data, you need to digitize it, but where is it
preserved in the world?  Many of the original copies were simply
thrown out, so hunting down preserved analog copies will prove to be a
challenge.  The same, of course, applies with modern digital too: most
of the digital data was since deleted, so hunting down preserved
digital copies of modern educational materials will prove to be a
challenge.

That being said, for all new data being entered into a computer
system, you need a way to ascertain that the data is, in fact, not
new, but merely a manual copy of something else that already was
authored in the past, or at least already digitized into the computer
system.  Always always always.  Every single time.  Alas, this
audacious goal is far from reality until we get computer technology
with enough compute power to ascertain this for any and every type of
data.

Suffice it to say, with language and culture, a similar explanation
applies to my explanation above with educational materials: regardless
of whether it is new or not, it is "entered" into computers by humans
who act as if it were new, yet in order to fully answer the question
of whether it is actually new or nor, and what it is related to, we
need a large database of past information.  Getting that information
is a challenge in both the new dimension and the old dimension.  For
the new dimension, data sourcing is the ongoing problem in light of
proprietary or private data, which ultimately gets deleted when the
owner looses interest in it rather than ceding into the public domain.
(It was never even new to begin with, so what advantage is there to
deleting it?!)  Second, for old data that predated the digital
computer era, most of it historically got thrown out, so finding
preserved copies is the ongoing challenge.  Second, there is yet
another problem with successfully being able to digitize them.
