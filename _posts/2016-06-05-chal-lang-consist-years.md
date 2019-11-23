---
layout: post
title: "Challenge of keeping natural language consistent over only a
        few years"
date: 2016-06-05 20:10 -0600
author: quorten
categories: [inven-sys]
tags: [inven-sys]
---

You know what?  This is a good idea, this is a great idea.  So great,
that I must make it in my `inven-sys` notes.  Over time, when
maintaining my notes, especially my house logs, I strive to maintain
consistency.  Unfortunately, keeping the language consistent isn't
easy, being that as humans don't have built-in knowledge of language,
it tends to drift overtime and increases the total world complexity,
even though the complexity for particular humans stays constant.  So,
what is my proposed solution?

Well, if you ask me, keeping language and vocabulary consistent is
something that is really only easy to do over at maximum a three year
period.  Information that must persist for longer than three years is
going to need a way to compensate for language drift.  That is, if you
are writing formal computer languages in which the functionality will
only work if the keywords match exactly.

<!-- more -->

So, here is my proposal, based off of long-term experience.  Try to
accumulate all synonyms for an identical concept.  This has an added
plus to it too.  One problem with human natural language is that one
word often times has more than one meaning assigned to it.  So, what
are you in effect doing when you attach synonyms?  You are attaching
multiple meanings to one concept.  So, over time, what will happen is
that even though each of those words may have one out of several
meanings, in the long run, you'll be able to use the general
definitions of all of those words to cancel out the ambiguous meanings
that are technically irrelevant and get to only a single meaning.
This is a very interesting proposition indeed.  And all you have to do
is maintain a dictionary of synonyms.  You don't even need to worry
about defining multiple meanings for one word.  In fact, over time,
you'll be able to figure that out naturally by searching for all
contexts that the word occurs in.

Why is this such a novel approach?  It is a novel approach because,
rather than relying on a complete and complex natural language
processing framework, it works with only minimal computer knowledge,
and best of all, it is easy to understand and explain to laypeople.
Compare that with trying to explain the intricacies of the English
language to laypeople.  Although an average person's brain is
sophisticated enough to interpret the complexities of the English
language directly and in real-time, if you ask people to start walking
through a metalanguage that explains the English language for the sake
of translating the rules into a format that corresponds to
machine-executable code that can intelligently act on the English
language, that gets way too complicated for people to understand, and
thus, most people "give up" by, matter of fact, not even trying to
help the computer science community build better software for
interpreting natural language.

So, what's the lesson to be learned here?  Whenever you have an
inexperienced person make queries against a computer system, the
computer system will naturally prompt the user for words to
disambiguate the query, some of which the user may not actually know.
Although this creates a steeper learning curve for humans using the
system, humans have the advantage of being able to learn new things
quickly when they do not already know them in advance, especially in
regard to language.  Given that these terms come from human natural
language, this also helps humans learn them faster, given that it is
something familiar to what most people use on a daily basis.

Okay, great idea, but how is the database of synonyms built up to
start with?  The thing is, humans are the ones who change over time.
You have to be able to have some humans to start with who change over
time, but still remember the past, build up the relations.  This is
how things will normally be tied together.
