---
layout: post
title: The theory behind software test
date: 2019-03-10 19:43 -0500
author: quorten
categories: [tour-de-force, unlipic]
tags: [tour-de-force, unlipic]
---

Software test, testing, unit tests, integration tests.  Yes, these are
things that we do all the time, but most of us don't really understand
what we are doing.  What language should tests be written in?  What if
you want to implement the same software in a different programming
language?  How do you different implementations of the same software
written in different programming languages in a language-agnostic way?

Here is where a little bit of formal theory on software test can come
to the rescue.

Let's start at the very foundation of software test, and work our way
up from there: hardware test.  The fundamental definition of a modern
digital computer is that it is composed out of a discrete number of
logic components and has a discrete, finite amount of digital memory.

### Combinatorial Logic

Combinatorial logic is simply a composition of discrete logic
components that calculates and output from an input by means of
implementing a certain Boolean logic function.  Other related names
and concepts are first-order logic and propositional logic.  To
rigorously test combinatorial logic, one simply needs to iterate all
possible inputs and record all outputs.  You will get a corresponding
truth table.  Now, the means of test is simply checking if the
resulting truth table is the same as the expected truth table.  If so,
your test passes.  Otherwise, it fails.

<!-- more -->

Noteworthy in the discussion of combinatorial logic is also that of
optimization.  In general, if you generate the truth table of a
combinatorial logic function, you can use that to generate a minimal
physical gate-wise implementation of that Boolean logic function.

### Sequential Logic

Now, what about sequential logic?  At first, the idea of testing
sequential logic may sound tricky, but the trick to remember is the
foundational principles that I've mentioned about digital computers: A
modern digital computer has a discrete, finite amount of digital
memory.  Another word used to describe such systems is _finite state
automata_.  A finite state automata is a machine that can transition
to a finite number of different by certain defined rules when
processing a stream of input.  Since a modern digital computer has a
finite amount of memory, it by definition has a finite number of
states.  Specifically, the number of different states a computer has
is `2^n`, where `n` is the number of bits of rewritable memory the
computer has.  Finite state automatas, by definition of the _pumping
lemma_, will eventually cycle through all possible states if fed a
long enough and complicated enough stream of input.  Importantly, the
length of such a stream of input is itself also finite.  Because of
this, you can in fact prove that sequential logic with a finite amount
of memory is also effectively the same as combinatorial logic by a
mapping reduction.  So, to rigorously test sequential logic, simply
feed it a crafted stream of input that causes it to cycle through all
possible states.

A computer microprocessor is simply a sequential logic machine.
Intuitively, the stream data input for a computer microprocessor is
the stream of machine code instructions it processes, so a computer
microprocessor can simply be tested rigorously by running a
sufficiently crafted computer program.  Of course, I/O bus and memory
input may also need to be included too.

### Unreachable States

A noteworthy observation separating the pure theory of testing finite
state machines from practice is that of _unreachable states_ or _dead
states_.  An ideally designed finite state machine only has the
capability to encode strictly the states which are needed, and for
which transitions into such states are designed.  Any excess states in
the ideal design would imply unnecessary costs in the physical
implementation.  Therefore, excess states in the ideal design are a
focus area for the sake of optimizing sequential logic.

Worthy of note, however, is that the _de facto_ standard of digital
computer memory for state storage as a string of binary bits means
that the total number of states encoded must be rounded up to at least
a power of two, which will on average cause 50% of encodable states to
be dead states.  In practice, bits are grouped into 8-bit bytes, and
the total number of bytes is typically constrained to at least power
of two.  On top of that, typically the size chosen is not simply the
minimal size needed to implement an application, but rather the
cheapest packaged integrated circuit size available on the market,
which means there is even more overshoot in the total number of
encodable states.

Also, sometimes in the real world, systems are deliberately designed
to encompass a little bit of extra state for the sake of improving
computational efficiency.  Take for example the case where you need to
encode a 3-state variable and a 5-state variable.  In order to make
fetching the values of either variable simple in hardware, you'd
encode them as an independent 2-bit vector and a 3-bit vector, for a
total of 5 bits.  Technically speaking, you could have encoded the
same state information using only 4 bits, since the total number of
states needed is 3 * 5 = 15.  However, doing so would make extracting
the variable values much more computationally expensive to retrieve
since arithmetic multiplications and divisions would be required.

Another key difference between the ideal theoretic world and the real
world is that random memory errors can arise in computer hardware,
forcing the state machine through invalid state transitions and
potentially into otherwise unreachable states.  Depending on the
reliability of the computer hardware and the scale of the intended
applications, the hardware may be explicitly designed to track
redundant state that is used for the sake of _error detection and
correction_.  The goal, simply put, is to reduce the probability of
random memory errors causing an invalid state transition.

For the sake of comprehensive testing, how do you know for certain in
a sequential logic circuit if some state is dead state?

* If some extra memory for internal state is available, but is clearly
  never used, you know that comprises dead state.

* Another approach is to analyze the data flow paths for independent
  memory modules as follows.  If some internal state data is
  generated, but there is absolutely no data flow path such that the
  internal state data could affect the output state data under test,
  then that internal state data can be eliminated.

* The last and trickiest dead state cases to look for are those where
  there is memory where all bits are used, but not all permutations of
  bits are used.  An easy illustrative example is a loop where an
  8-bit counter variable is used, but it is constrained to never
  exceed the value 10.  To identify these cases, you need to take on a
  degree of rigor in proving that you've identified all valid state
  transitions, and no valid state transition will ever lead into this
  possible state.  This entails looking at some state memory in
  question, and tracing backwards to identify the input sources.

  In the simple case, you'll trace backwards and find some
  combinatorial logic that determines the value to store into the
  state.  If the combinatorial logic is wired directly to input data,
  you can simply prove all possible states by running the truth table
  on the combinatorial logic function.

  If there are sequential feedback loops with internal state, that's
  where things get more complicated.  The rigorous, but potentially
  excruciatingly complex, way to appraoch this is to build a map of
  all states that have been reached under exhaustive input and runtime
  testing.  Eventually, for all possible cases of continued runtime,
  you will reach a cycle to an already visited state, at which point
  you can stop.  Due to the pumping lemma, this guarantees your search
  will be bounded and finite.  At this poimt, you'll know clearly
  which states are reachable and unreachable.

### Key Concepts of Hardware Test

Thus far, we can describe testing as comprising the following systems
and concepts:

* The hardware design under test.  This is a discrete and finite
  hardware specification.

* The test script input.  This is a discrete and finite data
  specification of input to feed the hardware under test.

* Expected test output.  This is a discrete and finite data
  specification of expected output data to compare against the
  recorded output data.

* The test harness or the test bench.  This is a discrete and finite
  hardware specification that connects to the hardware under test and
  is responsible for feeding the script input, recording the test
  output, and comparing the expected output with the recorded output.
  The test harness may also be responsible for checking if all
  possible inputs and intermediary sequential logic states were
  covered, and if not, computing the number or proportion of states
  hit or missed.

* By definition, a test harness itself is only rigorously tested on
  the input side.  The output side is _not_ rigorously tested because
  out of all possible test failures that could happen, not all
  failures are observed during development.

### Embedded Software Test

Now, let's keep moving up the stack.  By the concepts of embedded
systems, we know that any discrete, deterministic digital logic
hardware design can also be implemented in software.  So, therefore,
all of the previously mentioned statements about hardware can also be
extended to software.

However, let's not get too ahead of ourselves at this point.  Remember
what I said about the testing of sequential logic?  In order to do a
rigorous test, you must traverse through _all_ possible states.  In
the case of computer software, this includes not only the main memory
and that software works directly with, but it also includes processor
state.  Yes, that also means _all_ register values and _all_ processor
condition code flags.  What about sub-instruction internal pipeline
registers?

Now, as you see, as we're traveling up the stack, rigorous testing is
getting more and more complicated.  As you can imagine, taken to the
extreme, rigorous testing would imply that you need to test an
impractically large number of cases.

Let's also be clear about this simplifying assumption for the
subsequent discussion: For software test of the embedded systems, all
embedded software is stored in read-only memory (ROM).  This ensures
that the software instructions do not comprise the memory of the
finite state machine that needs to be rigorously tested for the
sequential logic under test.

### Unit Testing

So, what is a way out of the problem of excessively complex testing?
Basically, you need to make a system of assumptions that is termed as
_unit testing_.  The main idea with unit testing is to break apart the
testing of a system design into modules.  Especially in complicated
sequential logic systems, if it were mapping reduced down to an
equivalent combinatorial logic design, the duplication of identical
sub-modules throughout different branches of the combinatorial logic
would be imminent.  If you've already tested every single possible
input and output of this sub-module in one branch, do you really need
to test it again in another branch?

The primary idea with unit testing, at the outset, is to start by
focusing on only rigorously testing the lowest level modules.  Another
key tenent of unit testing is that of functional equivalence.  Say you
have two different implementations of the same functional module.  If
you can show that the same input rigorously tests both modules and
they result in the same expected output, you've proven them to be
functionally equivalent, so the two can be swapped out for each other
in a higher-level system with no change in overall system behavior.
In some cases, your alternate module may be more complicated and need
a more rigorous test to completely cover its behavior.  In that case,
you should develop the new test, then run the new test on the old
module and verify that the more rigorous test also produces identical
results on the old module.  Once the lowest-level modules are tested
and known to work, you move up the stack and start testing the
higher-level modules that make use of the lower-level modules.

Now, this is where the theory gets interesting.  How do you
efficiently test the higher-level modules without needing to
exhaustively test the lower-level modules that are included?  This is
where the concept of functional equivalence is key.  The goal is that
you want to devise a simpler module such that when it is swapped in
place when testing the higher level code, the overall test is
functionally equivalent, but simpler, faster, and more efficient to
execute.  At the outset, understanding how to correctly prove this is
tricky, but key to understanding correctly.

Look at the higher level module's internal code, and note all areas
where there is state information that would need to be rigorously
tested.  Remove the already tested state information internal to the
lower-level modules.  The state information that remains is what needs
to be rigorously tested for that particular higher-level module.
Devise tests that can run with the original module that will cover all
of thsoe possible states.  Once those tests are working, you can now
look at how the lower-level modules are used.  Chances are that you'll
see their full behavior is not exercised by the higher-level module.

In this case, you can swap out the lower-level modules with _mock_
modules.  These are simplified module implementations that are
designed to only produce identical results when used under the
specific conditions of the designed test.  You must be able to prove
that this is strictly a shortcut for using the lower-level modules.
Namely, out of the limited number of ways the lower-level module may
be used, you can swap out the original module for the mock and the
results will be identical either way.  In other words, I'm also saying
that you should write unit tests for mock modules.

Now, let's revisit what I said about testing the test harness itself.
Although you cannot rigorously test the _output side_ of a test
harness, you _can_ get complete unit test coverage the output side.

Now, don't be too surprised here.  My previous explanations thus far
might sound like they're pretty modern in terms of software test, but
to be clear, I was only talking about comprehensive test of software
written in _assembly language_ thus far, running on a simplistic,
non-pipelined CPU.

So, first of all, let's get the question of pipelined or non-pipelined
CPU out of the way.  This question can be answered by means of
rigorous testing.  First, devise a rigorous test that covers all of
the possible states of the pipelined CPU.  Now run that same test on
the non-pipelined CPU.  If the results are identical, you have proven
that the pipelined CPU is functionally identical to the non-pipelined
CPU.  This proof is key simply for the sake of making the higher-level
testing of software simpler through the means of swapping modules of
functional equivalence.  With this proof in place, you only need to
consider the state information of the simplest, equivalent CPU in
order to faithfully account for all necessary state information when
testing software written in assembly language.

### More Embedded Software Test Considerations

Second, let's take some time to discuss an additional consideration
with testing embedded software written in assembly language.
Previously, I've covered the concept of dead state, which is sometimes
a disadvantage, other times a deliberately engineered advantage.  A
special case of dead state with embedded software written in assembly
language is _dead code_.  Fundamentally, the primary _dead state_ is
the fact that the program counter of the CPU does not iterate over
every single memory address.  Analyzing deeper, of course you don't
have a single-byte instruction at every memory address.  But, out of
all potential instruction addresses that could be iterated, some may
be always skipped and never used.  This is where your dead code lies:
it is the instructions that can never be executed.  Dead code, unlike
dead state, is almost never advantageous.  The goal of a programmer
writing a well-tested program is to make sure there is no dead code
within it.

Previously I've mentioned that for sequential logic, you need to do a
fairly rigorous test coverage of the available states.  Is such a
rigorous coverage of available states also necessary for embedded
software written in assembly language?  Surely, code coverage by the
instructions is good enough, since assembly language programs will
only have significantly different behavior under branching.  As a
matter of fact, test coverage of the available states _is_ necessary
for assembly language software too.

Here is a prime example to consider.  Suppose you have a Boolean
variable that is either one or zero.  You take that variable, multiply
it by another variable, add that to an accumulator, then multiply
another variable by the complement of the Boolean value and also add
that result to the accumulator.  As a matter of fact, you've
implemented a "conditional move" instruction without any explicit
conditional or branching instructions.  If you were to further perform
an arithmetic comparison to determine whether a test passed or failed,
merely getting 100% code coverage may fail to uncover a potential
failing test case.  A similar case also applies were you to only use
bitwise operations.  So indeed, coverage of state data is also needed,
whether it be in unit testing or rigorous integration testing.  In
practice, in order to avoid needing rigorous test coverage of every
area of the code where arithmetic is performed, most software test
relies on as much of the concept of unit testing as possible for those
particular low-level operations.

Anything is possible, there is no end to the cleverness you can put
into causing conditional data flow with seemingly non-conditional
instructions.  To put the point in hand succinctly, you can simulate a
gate array design of a microprocessor using a loop with no conditional
instructions.

By modern, conventional programming standards, however, such use of
state change that results in branching behavior is considered
unnecessarily esoteric.  If arithmetic operations are performed that
result in behavioral branching, they should be done using explicit
branching instructions.  There are, of course, a few exceptions,
namely if you are writing performance-critical code or designing some
sort of programming language interpreter.  As a programmer, the best
you can and should do is to clearly document the intent of branching
and conditional behavior if you are deliberately designing your
software for such.

Suffice it to say, rigorous testing of data flow patterns and states
in modern software is a grand challenge that can, under some
circumstances, be simplified through the proper use of unit testing.
Further evaluation of this problem will be left to a later article.

### High-Level Programming Languages

Now we can move further up the stack.  What about programs written in
high-level programming languages?  Fundamentally, the simplest such
definition is that of a compiled high-level programming language.  The
software is translated from the high-level language to machine code,
so then the tenents of assembly language test can readily be applied
there.  Unfortunately, this is where we run into our primary problem.
Unlike assembly language, most high-level programming languages do not
allow full access to all processor state.  Suppose you perform an
arithmetic addition operation.  How do you handle the overflow if you
don't have access to that processor state flag?

In general, the way around the issue of inaccessible low-level
processor state when writing software in high-level programming
languages is by a method of programming in which the inaccessible
information is effectively _dead state_: either the inaccessible state
bits never get changed by the software, they can be proven to be
duplicate information that the high-level software can access by other
means, or you can simply prove the additional state information to be
irrelevant to the data flow of the high-level software.

### Machine Arithmetic Considerations

Curiously, the main stumbling block in high-level programming
languages such as C is also an equal problem when programming in
assembly language: machine arithmetic.  The default mode of machine
arithmetic that the C programming language assumes is that of
wrap-around arithmetic.  Wrap-around arithmetic is fine for some
applications, but for most applications, it produces an unexpected
discontinuity.  Namely, the following mathematical invariants are not
withheld by wraparound arithmetic.

* `a + b > a && a + b > b`

    * Adding numbers can wrap-around overflow and result in a smaller
      than expected number.

* `a > 0 && b < 0 && a - b > 0`

    * Subtraction of negative numbers can result in an addition that
      will overflow.

* `(-a) + a == 0`

    * Two's complement negation can result in wrap-around overflow.
      If sign extension to a larger integer type is subsequently used
      on the wrap-around overflow results before adding, then the
      mathematical invariant will not be withheld.

* `a > 0 && b > 0 && a * b > a && a * b > b`

    * Wrap-around overflow with multiplication.

* `a > b && b < 0 && a * b < -a && a * b < b`

    * Wrap-around overflow with multiplication.

So, what mathematical invariants are always withheld by wrap-around
arithmetic?

* `0 < a < b && b - a > 0`
* `b < a < 0 && b - a < 0`
* `!(a == INT_MIN && b == -1) && a / b`
* `a % b`

As a programmer, these mathematical invariants are more tedious to
maintain in code, but if withheld, then they will result in
mathemtaically sound arithmetic.

* `INT_MIN / 2 < a <= b <= INT_MAX / 2 && a + b`
* `INT_MIN / 2 < a <= b <= INT_MAX / 2 && a - b`
* `sqrt(INT_MIN) < a <= b <= sqrt(INT_MAX) && a * b`

In practice, the easiest way to maintain these invariants is to limit
the range of all input variables to equations to much less than
`(sqrt(INT_MIN), sqrt(INT_MAX))`.  If no multiplication will be
performed, the limits can be more generous to something much less than
`(INT_MIN / 2, INT_MAX / 2)`.  The idea is that you want to easily
detect that operands are within limits _before_ an overflow occurs, so
that an overflow can _never_ occur.

Some other modes of arithmetic that are useful for programmers, but
not the default in the C programming language, are the following:

* Saturating arithmetic
* Exception on overflow arithmetic
* Arbitrary precision arithmetic

Because of these issues, many programming languages that are
higher-level than C do not wrap-around arithmetic by default, although
this comes at a performance cost.  By far, the biggest performance
issue with arbitrary precision arithmetic is that the computational
time to perform an arithmetic operation is not bounded within a fixed
deadline time.  Exception on overflow arithmetic is the most
developer-friendly.  Saturating arithmetic is typically only used in
formally and rigorously designed algorithms.

Bitwise logic, by contrast, is typically not a stumbling point for
programmers.

### Software Test Language

Speaking of high-level programming languages, sure, the languages used
to write software are well understood, but what about the languages
used to write tests?

My previous discussion defined software as embedded software, a
special case of sequential logic hardware.  Within this framework, the
primary means of testing software was by the means of a _test script
input_ and a _test harness_.  The test script input was simply defined
to be serial communications stream of data, and the test harness was
simply responsible for feeding that into the hardware or software
under test.  Indeed, these definitions as-is can be readily extended
to software written in high-level programming languages, but typically
in _software land_, things are done differently.

In software land, software is typically written a procedure at a time.
Then, when a developer wants to test their software, they typically
approach it by doing so one procedure at a time.  Sure, in the
hardware world, combinatorial and sequential logic can be tested one
module at a time too, by connecting that one module to a test bench.
But, what makes software different is that software developers are
much less likely to think about serialized input streams when testing
software procedures.  Rather, they think exclusively in terms of the
parameters passed to the procedure through its calling conventions and
defined data structures, as set forth by the high-level programming
language.  In practice, this means that typical unit tests for
software procedures are written in the same programming language as
the software itself.  The concept of testing procedures across
different programming languages is a foreign one that does not apply
to most software unit testing.

However, there is a modern software equivalent in regard to the
traditional means of hardware and software test.  First of all,
especially for web servers and web services software, serial
communications is back in the vogue.  Once you make a TCP/IP network
socket connection to a server, your request and response follows that
of a byte stream similar to standard input and standard output on
Unix, which is ultimately based off of hardware serial communications.
Therefore, the data transmitted across this connection must be encoded
in a well-defined language.  Ultimately, this makes software test of
web services just as programming language agnostic as hardware test
and embedded software test is.

#### History Before Web Services

Before the advent of web services, there were a variety of scattered,
fragmented, but related concepts as to how to interoperate software
written in different programming languages.  Initially, the primary
focus was **not** on interoperating software written in different
programming languages, but merely interoperating software running in
different processes or on different computers.  The first foray of
this dinosaur era was that of the Remote Procedure Call (RPC).  The
concept of an RPC, as was observed in historic practice, was mainly as
a means of issuing requests to other processes, possibly running on
remote computers, with identical syntax and semantics as a standard
procedure call in the high-level programming language would be.
Following this, there was quickly an explosion of buzzwords on related
technologies: Remote Method Invocation (RMI), Component Object Model
(COM), Distributed COM (DCOM), Active Template Library COM (ATL COM),
Common Object Request Broker Architecture (CORBA), and I'll stop
there.  The point in hand was that a lot of technologies and jargon
was created, but very little of it had very much widespread
application use.

What was the purpose of creating all of that jargon and technology
that, for the most part, "failed in the market place"?  Understanding
the context of these developments is key here.  All of these
technologies were, by far and by large, exclusively the developments
of the few large enterprise software companies.  Due to their pedigree
of being developed so early in the history of computing, they had to
be.  When earlier computers were so much less featureful and so much
more expensive than today's computers, who else could afford such
large, distributed networks of such computers?  And I'm just
scratching the surface when I put forth that question.  Not only was
the available user base for the technologies small, but the practical
implementation of these technologies in their own right fails to
impress.  Unlike a respectable Internet application protocol that is
text-based, all of these earlier technologies use binary network
protocol.  What else could people imagine affording when the early
network technology was so slow?

But, the final, end-all, be-all point to make about the early context
is that of the programming languages.  With so few people involved in
computer programming in the earlier days compared to today, less
software than is available today, and less programming languages out
and about than is the case today, what other high-level programming
language would they use than C and C++?  Yeah, there were some claims
that the previously mentioned technologies helped ease the gap between
other programming languages such as Fortran and Lisp, but by far and
large, this was definitely an obscure minority use case, not a
mainstream way of using the touted technologies.  At the late end of
the early endeavors, a lot of advanced C++ programming language
features started being included in the previously mentioned
technologies, which are considered by most to be "unnecessarily
esoteric."  By contrast, other more modern programming languages
provide for a high level of interaction, without being regarded as
unnecessarily esoteric.

#### Defining Features of Web Services

Now, let's cover the modern world that _is_ massively adopted in more
detail.  What are the defining elements of modern web services
interaction?

* Web services, by definition, are implemented as HTTP requests,
  typically termed as _REST APIs_.  Typically, a text-based
  object-oriented data definition language is used to specify data in
  the request and the response, except when large multimedia data is
  required.  The most popular such format is JSON.  XML is used for
  some specialized cases.

* Procedure call abstraction is **not** paramount.  There is **not** a
  primary effort to abstract away the fact that an HTTP request must
  be made in order to effect the desired function.  Rather, these are
  steps that are made explicit to the programmer using the web service
  in question.  Either the programmer must pack up the request using
  standard HTTP request invocation code and libraries, or they must
  deliberately include a convenience wrapper library that packs up
  function-call style bindings to make the HTTP request invocations.

* It is very common to use languages other than C and C++ to implement
  the software on both ends.

* An Interface Definition Language (IDL) is not used to specify the
  semantics and calling convention of a web service.  Rather, this
  specification is provided solely by means of programmer's reference
  documentation, which is typically generated via a documentation
  generation tool such as RAML.

### Conclusion

The typical remark related to software testing is that programmers
never test their software enough.  Indeed, some of the aspects of this
analysis of totally formal and rigorous testing has shown that to be
true on a deeper level.  Current software test methodologies in
mainstream software on mass market are, at the very least, good at
testing some of the programmer's intents.  However, much of the
uncovered ground in software test is not much different from the
uncovered ground in hardware test, namely that of rigorous state
analysis.  The greatest problem that arises that makes behaviorial
testing difficult is the possibility of the machine acting as an
instruction interpreter.  When this is deliberately the case, a
comprehensive test of the system can be quite challenging.  Noteworthy
is that this can theoretically occur even when it was not the intent
of the designers.  The Spectre and Meltdown microprocessor defects are
perhaps the most illustrative in the challenges of rigorous test in
the design of complex, powerful, modern CPUs.

I have started writing this article hoping that I could provide a
completely formal and rigorous coverage of how to do software test
right, when most people seem to not fully understand it or get some
things wrong.  In the end, I have rehashed some challenges that are
_very_ hard to get right, and I will need to revisit this subject to
discuss it in more detail.

One thing that I did want to discuss in this article that I've ended
up doing quite a good job discussing is software test in high-level
programming languages.  A prime issue that I wanted to tackle was the
tendency for software tests to be specific to one programming language
and not portable to another.  I have provided an excellent explanation
for a way out of this problem, not just from a standpoint of "I have a
solution that nobody else is using," but rather by putting into
context other ways of testing that are very popular today that do
successfully sidestep this problem.  This is great if you want to
write some identical software in multiple programming languages and be
sure that you are running the same tests across all such
implementations.

Overall, hopefully this article will serve as great guidance if you
are looking for ways to improve the quality by which you develop and
run software tests.
