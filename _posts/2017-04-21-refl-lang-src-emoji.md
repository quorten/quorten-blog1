---
layout: post
title: Reflection on languages, internationalization, Emoji, source code
date: 2017-04-21 21:00 -0600
author: quorten
categories: [misc]
tags: [misc]
---

About languages and internationalization.  Unicode is touted to only
cover _living languages_, not ancient languages.  Yeah, that may have
seemed reasonable at the time that Unicode was first being developed,
but now that it's an international standard, what about the future?
What about when present-day living languages become archaic languages?
Will Unicode still provide coverage over those languages, or will it
somehow deprecate the old meaning of the codes and re-assign them to
make room for new languages?  Well, this really hinges on the future
of technology.  At the time that Unicode was introduced, computers
were a very primitive technology that could barely support 16-bit
Unicode due to severe memory limitations.  Many compromises were
taken, such as Han Unification, to try to squash the full spectrum of
Unicode into computer systems that were actually too small to work
with it.  But, technology has since considerably advanced, and now we
are adding colored Emoji to the Unicode Standard!

So yes, if future computers are far more powerful than present-day
computers, it could just as well be the case that Unicode maintains
support for past languages that were a living language at times past,
but are now archaic languages.  There would be no logical reason to
say that those codes are invalid since there would be more than enough
address space for the new language characters to expand into.  The
standard might say that it is not required for conforming
implementations to render those codes, but there would be no need to
reassign them.

<!-- more -->

Now, consider a case to the contrary.  Many thousands of years into
the future, computer technology fails to appreciably advance.  In that
case, due to technological limitations, it would be necessary to
assign version numbers to the code to indicate that old characters
have been deprecated and have a different meaning in modern use.  As a
matter of fact, most modern implementations would simply fail if they
encounter an older version of Unicode, as there would be no practical
way for them to contain all the characters necessary to render in
those older versions of Unicode.

What, localization is not done in software source code?  That puts us
at odds with the rest of the world of software.  Will it be the case
that many thousands of years into the future, software source code
will be written in a highly specialized natural language that only
those with advanced education can understand?  Actually, come to think
of it, I don't think so.  Just look at the language landscape in the
present.  In the present, people are constantly rewriting known
algorithms in new programming languages.  They seem to have no problem
with this at all.  So it's conceivable to believe that in the future,
when the old natural languages of times past that were previously very
popular in the computing profession are no longer that popular at all,
people would have successfully rewritten the source code of all
important software to use the natural language of the modern
practicing population, and there would in fact be no issue at all
whatsoever.

* It kind of just rambles on in language.  Yeah, you type out a whole
  bunch of words, but it doesn't really represent a high point in
  technological development.  Not like programmer's reference
  documentation that is highly compact and conveys only the most
  important information you need to understand how something works.

  Yeah, actually, if you want to do this technical writing correctly,
  you've got to split up your documentation into sections.  You can
  have a high-level introduction to the technology (or technicality),
  examples on using the technology, the results of executing those
  samples, and the reference section that concentrates on only
  specifying facts of the implementation, including dependencies.
  Also, very high level dependencies are specified in the introductory
  material too.
